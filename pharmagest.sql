-- Création de la table Utilisateur
CREATE TABLE Utilisateur (
    id_utilisateur SERIAL PRIMARY KEY,
    Nom_utilisateur VARCHAR(50),
    Prenom_utilisateur VARCHAR(50),
    annif_utilisateur DATE,
    adresse_utilisateur VARCHAR(100),
    tel_utilisateur BIGINT,
    Identifiant VARCHAR(50),
    mot_de_passe VARCHAR(50),
    role VARCHAR(50),
    actif BOOLEAN,
    bloquer BOOLEAN
);
 
-- Création de la table Fournisseur
CREATE TABLE Fournisseur (
    id_fournisseur SERIAL PRIMARY KEY,
    Nom_fournisseur VARCHAR(100),
    adresse_fournisseur VARCHAR(100),
    Tel_fournisseur BIGINT
);
 
-- Création de la table Medicament
CREATE TABLE Medicament (
    id_medicament SERIAL PRIMARY KEY,
    nom_medicament VARCHAR(100),
    Famille VARCHAR(100),
    ordonnance BOOLEAN,
    prix_vente DECIMAL(10, 2),
    qt_stock INT,
    qt_min INT,
    qt_max INT,
    seuil_commande INT,
    unite VARCHAR(20),
    id_fournisseur INT,
    FOREIGN KEY (id_fournisseur) REFERENCES Fournisseur(id_fournisseur)
);
 
-- Création de la table Vente
CREATE TABLE Vente (
    id_vente SERIAL PRIMARY KEY,
    date_vente DATE,
    prix_total DECIMAL(10, 2),
    payer BOOLEAN,
    id_prescription INT
);
 
-- Création de la table LigneVente
CREATE TABLE LigneVente (
    id_vente INT,
    id_medicament INT,
    qt INT,
    PRIMARY KEY (id_vente, id_medicament),
    FOREIGN KEY (id_vente) REFERENCES Vente(id_vente),
    FOREIGN KEY (id_medicament) REFERENCES Medicament(id_medicament)
);
 
-- Création de la table ListePrix
CREATE TABLE ListePrix (
    id_fournisseur INT,
    id_medicament INT,
    prix_unitaire DECIMAL(10, 2),
    qt INT,
    prix_vente DECIMAL(10, 2),
    PRIMARY KEY (id_fournisseur, id_medicament),
    FOREIGN KEY (id_fournisseur) REFERENCES Fournisseur(id_fournisseur),
    FOREIGN KEY (id_medicament) REFERENCES Medicament(id_medicament)
);
 
-- Création de la table Prescription
CREATE TABLE Prescription (
    id_prescription SERIAL PRIMARY KEY,
    Nom_medecin VARCHAR(100),
    date_prescription DATE,
    Nom_patient VARCHAR(25)
);
 
-- Création de la table Commande
CREATE TABLE Commande (
    id_commande SERIAL PRIMARY KEY,
    date_commande DATE,
    prix_total DECIMAL(10, 2),
    id_fournisseur INT,
    prix_payer DECIMAL(10, 2) DEFAULT 0.0,
    statut VARCHAR(50) DEFAULT 'En cours',
    FOREIGN KEY (id_fournisseur) REFERENCES Fournisseur(id_fournisseur)
);
 
-- Création de la table LigneCommande
CREATE TABLE LigneCommande (
    id_medicament INT,
    id_commande INT,
    qt_vente INT,
    qt_recu DECIMAL(10, 2) DEFAULT 0.0,
    PRIMARY KEY (id_medicament, id_commande),
    FOREIGN KEY (id_medicament) REFERENCES Medicament(id_medicament),
    FOREIGN KEY (id_commande) REFERENCES Commande(id_commande)
);
 
-- Insertion d'un utilisateur pharmacien
INSERT INTO Utilisateur (Nom_utilisateur, Prenom_utilisateur, Identifiant, mot_de_passe, role, actif, bloquer)
VALUES ('Pharmacien', 'Admin', 'admin', 'admin', 'Pharmacien', true, false);
 
-- Insertion d'un fournisseur
INSERT INTO Fournisseur (Nom_fournisseur, adresse_fournisseur, Tel_fournisseur)
VALUES ('Nom_Fournisseur', 'Adresse_Fournisseur', 1234567890);
 
-- Insertion d'un médicament
INSERT INTO Medicament (nom_medicament, Famille, ordonnance, prix_vente, qt_stock, qt_min, qt_max, seuil_commande, unite, id_fournisseur)
VALUES ('Nom_Medicament', 'Famille_Medicament', false, 10.00, 100, 10, 200, 50, 'Unité', 1);