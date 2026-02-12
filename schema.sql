CREATE DATABASE Takalo;
USE Takalo;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO users (nom, email, password, role)
VALUES ('Admin', 'admin@takalo.com', 'admin123', 'admin');


CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO categories (nom) VALUES
('Vêtement'),
('CD'),
('Légume'),
('Fruit'),
('Électronique');


CREATE TABLE produits (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(150) NOT NULL,
    description TEXT,
    prix DECIMAL(10,2) NOT NULL,
    quantite INT DEFAULT 0,

    user_id INT NOT NULL,
    categorie_id INT NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_produit_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_produit_categorie
        FOREIGN KEY (categorie_id)
        REFERENCES categories(id)
        ON DELETE CASCADE
);
INSERT INTO produits (nom, description, prix, quantite, user_id, categorie_id)
VALUES (
    'T-shirt noir',
    'T-shirt coton taille M',
    25000,
    10,
    1,
    1
);

ALTER TABLE produits ADD photo TEXT AFTER prix;

CREATE TABLE echanges (
    id INT AUTO_INCREMENT PRIMARY KEY,

    produit_demande_id INT NOT NULL,     -- produit que je veux
    produit_propose_id INT NOT NULL,     -- mon produit que j’envoie

    sender_id INT NOT NULL,              -- celui qui propose
    receiver_id INT NOT NULL,            -- propriétaire du produit demandé

    statut ENUM('en_attente','accepte','refuse') 
           DEFAULT 'en_attente',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (produit_demande_id) REFERENCES produits(id) ON DELETE CASCADE,
    FOREIGN KEY (produit_propose_id) REFERENCES produits(id) ON DELETE CASCADE,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE
);
