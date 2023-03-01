-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 01 mars 2023 à 15:31
-- Version du serveur : 8.0.31
-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `genealogimac`
--

-- --------------------------------------------------------

--
-- Structure de la table `promotions`
--

DROP TABLE IF EXISTS `promotions`;
CREATE TABLE IF NOT EXISTS `promotions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `year` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `promotions`
--

INSERT INTO `promotions` (`id`, `year`) VALUES
(1, 2020),
(2, 2021),
(3, 2022),
(4, 2023);

-- --------------------------------------------------------

--
-- Structure de la table `students`
--

DROP TABLE IF EXISTS `students`;
CREATE TABLE IF NOT EXISTS `students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(30) NOT NULL,
  `lastName` varchar(30) NOT NULL,
  `birthDate` date DEFAULT NULL,
  `promotionId` int DEFAULT NULL,
  `godFatherId` int DEFAULT NULL,
  `isVisible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `promotionId_FK` (`promotionId`),
  KEY `godFatherId_FK` (`godFatherId`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `students`
--

INSERT INTO `students` (`id`, `firstName`, `lastName`, `birthDate`, `promotionId`, `godFatherId`, `isVisible`) VALUES
(1, 'Elena', 'Armand', '1997-12-23', 1, NULL, 1),
(2, 'Eric', 'Trivot', '1997-07-23', 1, NULL, 1),
(3, 'Aurore', 'Claudie', '1997-05-20', 1, NULL, 1),
(4, 'Daphné', 'Marthe', '1997-11-05', 1, NULL, 1),
(5, 'Ronan', 'Marin', '1997-01-25', 1, NULL, 1),
(6, 'Marylène', 'Lazare', '1997-12-29', 1, NULL, 1),
(7, 'Mattéo', 'Florimond', '1997-04-16', 1, NULL, 1),
(8, 'Grégoire', 'Josse', '1997-03-28', 1, NULL, 1),
(9, 'Louis', 'Mendes', '1997-05-06', 1, NULL, 1),
(10, 'Anaïs', 'Briand', '1997-10-23', 1, NULL, 1),
(11, 'Amélie', 'Tessier', '1998-02-21', 2, 4, 1),
(12, 'Antoine', 'Hector', '1998-06-23', 2, 6, 1),
(13, 'Amandine', 'Le Nouveau', '1998-08-08', 2, 10, 1),
(14, 'Sarah', 'Paris', '1998-08-05', 2, 5, 1),
(15, 'Margaux', 'Ramos', '1998-03-19', 2, 7, 1),
(16, 'Pierre', 'Yveton', '1998-11-15', 2, 3, 1),
(17, 'Antonin', 'Sharpet', '1998-01-17', 2, 2, 1),
(18, 'Jules', 'Bonnet', '1997-09-23', 2, 1, 1),
(19, 'Loïc', 'Renou', '1998-02-16', 2, 9, 1),
(20, 'Isaac', 'Grandis', '1998-04-02', 2, 8, 1),
(21, 'Julien', 'Marceau', '1999-09-21', 3, 16, 1),
(22, 'Lorraine', 'Boivin', '1999-07-20', 3, 12, 1),
(23, 'Agate', 'Campano', '1999-02-12', 3, 11, 1),
(24, 'Bruno', 'Brousse', '1999-09-18', 3, 13, 1),
(25, 'Marie', 'Covillon', '1999-03-30', 3, 20, 1),
(26, 'David', 'Sarrazin', '1999-06-14', 3, 19, 1),
(27, 'Lucas', 'Dona', '1999-04-10', 3, 14, 1),
(28, 'Amélie', 'Fadili', '1999-06-27', 3, 15, 1),
(29, 'Guillaume', 'Priot', '1999-01-05', 3, 18, 1),
(30, 'Noemie', 'Ange', '1999-03-11', 3, 17, 1);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `godFatherId_FK` FOREIGN KEY (`godFatherId`) REFERENCES `students` (`id`),
  ADD CONSTRAINT `promotionId_FK` FOREIGN KEY (`promotionId`) REFERENCES `promotions` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
