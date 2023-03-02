-- phpMyAdmin SQL Dump
-- version 4.6.6deb4+deb9u2
-- https://www.phpmyadmin.net/
--
-- Client :  sqletud.u-pem.fr
-- Généré le :  Jeu 02 Mars 2023 à 01:05
-- Version du serveur :  5.7.30-log
-- Version de PHP :  7.0.33-0+deb9u12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `lucie.godard_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `promotions`
--

CREATE TABLE `promotions` (
  `id` int(11) NOT NULL,
  `year` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `promotions`
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

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `firstName` varchar(30) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `lastName` varchar(30) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `birthDate` date DEFAULT NULL,
  `promotionId` int(11) DEFAULT NULL,
  `godFatherId` int(11) DEFAULT NULL,
  `isVisible` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `students`
--

INSERT INTO `students` (`id`, `firstName`, `lastName`, `birthDate`, `promotionId`, `godFatherId`, `isVisible`) VALUES
(1, 'Elena', 'Armand', '1997-12-23', 1, NULL, 1),
(2, 'Eric', 'Trivot', '1997-07-23', 1, NULL, 1),
(3, 'Aurore', 'Claudie', '1997-05-20', 1, NULL, 1),
(4, 'DaphnÃ©', 'Marthe', '1997-11-05', 1, NULL, 1),
(5, 'Ronan', 'Marin', '1997-01-25', 1, NULL, 1),
(6, 'MarylÃ¨ne', 'Lazare', '1997-12-29', 1, NULL, 1),
(7, 'MattÃ©o', 'Florimond', '1997-04-16', 1, NULL, 1),
(8, 'GrÃ©goire', 'Josse', '1997-03-28', 1, NULL, 1),
(9, 'Louis', 'Mendes', '1997-05-06', 1, NULL, 1),
(10, 'AnaÃ¯s', 'Briand', '1997-10-23', 1, NULL, 1),
(11, 'AmÃ©lie', 'Tessier', '1998-02-21', 2, 4, 1),
(12, 'Antoine', 'Hector', '1998-06-23', 2, 6, 1),
(13, 'Amandine', 'Le Nouveau', '1998-08-08', 2, 10, 1),
(14, 'Sarah', 'Paris', '1998-08-05', 2, 5, 1),
(15, 'Margaux', 'Ramos', '1998-03-19', 2, 7, 1),
(16, 'Pierre', 'Yveton', '1998-11-15', 2, 3, 1),
(17, 'Antonin', 'Sharpet', '1998-01-17', 2, 2, 1),
(18, 'Jules', 'Bonnet', '1997-09-23', 2, 1, 1),
(19, 'LoÃ¯c', 'Renou', '1998-02-16', 2, 9, 1),
(20, 'Isaac', 'Grandis', '1998-04-02', 2, 8, 1),
(21, 'Julien', 'Marceau', '1999-09-21', 3, 16, 1),
(22, 'Lorraine', 'Boivin', '1999-07-20', 3, 12, 1),
(23, 'Agate', 'Campano', '1999-02-12', 3, 11, 1),
(24, 'Bruno', 'Brousse', '1999-09-18', 3, 13, 1),
(25, 'Marie', 'Covillon', '1999-03-30', 3, 20, 1),
(26, 'David', 'Sarrazin', '1999-06-14', 3, 19, 1),
(27, 'Lucas', 'Dona', '1999-04-10', 3, 14, 1),
(28, 'AmÃ©lie', 'Fadili', '1999-06-27', 3, 15, 1),
(29, 'Guillaume', 'Priot', '1999-01-05', 3, 18, 1),
(30, 'NoÃ©mie', 'Ange', '1999-03-11', 3, 17, 1);

--
-- Index pour les tables exportées
--

--
-- Index pour la table `promotions`
--
ALTER TABLE `promotions`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD KEY `promotionId_FK` (`promotionId`),
  ADD KEY `godFatherId_FK` (`godFatherId`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `promotions`
--
ALTER TABLE `promotions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT pour la table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `godFatherId_FK` FOREIGN KEY (`godFatherId`) REFERENCES `students` (`id`),
  ADD CONSTRAINT `promotionId_FK` FOREIGN KEY (`promotionId`) REFERENCES `promotions` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
