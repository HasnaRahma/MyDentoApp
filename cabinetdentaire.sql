-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Mer 03 Octobre 2018 à 14:32
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `cabinetdentaire`
--

-- --------------------------------------------------------

--
-- Structure de la table `acces`
--

CREATE TABLE IF NOT EXISTS `acces` (
  `Ac_id` int(11) NOT NULL AUTO_INCREMENT,
  `Admin` tinyint(1) DEFAULT NULL,
  `FicheClinique` tinyint(1) DEFAULT NULL,
  `InfosGeneral` tinyint(1) DEFAULT NULL,
  `ListePatient` tinyint(1) DEFAULT NULL,
  `FraisDepense` tinyint(1) DEFAULT NULL,
  `Parametre` tinyint(1) DEFAULT NULL,
  `HistoriqueSoin` tinyint(1) DEFAULT NULL,
  `SoinImpayes` tinyint(1) DEFAULT NULL,
  `ListeFournisseur` tinyint(1) DEFAULT NULL,
  `SalleAttente` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Ac_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `cabinet`
--

CREATE TABLE IF NOT EXISTS `cabinet` (
  `Ca_id` int(11) NOT NULL AUTO_INCREMENT,
  `Ca_nom` varchar(200) NOT NULL,
  `Ca_adr` varchar(200) NOT NULL,
  `Ca_tel` int(11) NOT NULL,
  `Ca_email` varchar(200) NOT NULL,
  `Ca_fax` bigint(20) NOT NULL,
  `Ca_spec` text NOT NULL,
  PRIMARY KEY (`Ca_id`),
  UNIQUE KEY `Ca_id` (`Ca_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Structure de la table `controles`
--

CREATE TABLE IF NOT EXISTS `controles` (
  `Co_id` int(11) NOT NULL AUTO_INCREMENT,
  `Co_date` date NOT NULL,
  `doc_id` int(11) NOT NULL,
  `Co_versement` int(11) DEFAULT NULL,
  `Co_description` text NOT NULL,
  `Odf_id` int(11) NOT NULL,
  `Co_traitement` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`Co_id`),
  KEY `doc_id` (`doc_id`,`Odf_id`),
  KEY `Odf_id` (`Odf_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `depense`
--

CREATE TABLE IF NOT EXISTS `depense` (
  `Dp_id` int(11) NOT NULL AUTO_INCREMENT,
  `Dp_titre` text NOT NULL,
  `Dp_date` date NOT NULL,
  `Dp_fournisseur` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Dp_fournisseur_adresse` text CHARACTER SET utf8 COLLATE utf8_bin,
  `Dp_fournisseur_tel` int(11) DEFAULT NULL,
  `Dp_cout` float NOT NULL,
  `Dp_versement` float NOT NULL,
  `Dp_observation` text NOT NULL,
  `Dp_type` text,
  `Dp_credit` float DEFAULT NULL,
  `Dp_soldeF` float DEFAULT NULL,
  PRIMARY KEY (`Dp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `ficheclinique`
--

CREATE TABLE IF NOT EXISTS `ficheclinique` (
  `Fc_id` int(11) NOT NULL AUTO_INCREMENT,
  `Pt_id` int(11) NOT NULL,
  `AE` text COMMENT 'Anamnèse',
  `AM` text COMMENT 'Anamnèse',
  `TOP` int(1) DEFAULT NULL COMMENT 'Anamnèse',
  `EP` int(1) DEFAULT NULL COMMENT 'Anamnèse',
  `SF` text COMMENT 'Symétrie faciale',
  `EEF` text COMMENT 'Egalité étage face',
  `PC` text,
  `CT` text,
  `CTD` text,
  `PAG` text COMMENT 'Palpation',
  `AU` text COMMENT 'Palpation',
  `DO` int(1) DEFAULT NULL COMMENT 'cinétique mandibulaire',
  `BA` int(1) DEFAULT NULL COMMENT 'cinétique mandibulaire',
  `COB` text COMMENT 'cinétique mandibulaire',
  `AO` text COMMENT 'cinétique mandibulaire',
  `HBD` text COMMENT 'examen endobuccal',
  `CD` text COMMENT 'examen endobuccal',
  `CG` text COMMENT 'examen endobuccal',
  `MD` text COMMENT 'examen endobuccal',
  `MG` text COMMENT 'examen endobuccal',
  `OB` text COMMENT 'examen endobuccal',
  `OJ` text COMMENT 'examen endobuccal',
  `DY` text COMMENT 'examen endobuccal',
  `AD` text COMMENT 'examen endobuccal',
  `AC` text COMMENT 'examen endobuccal',
  `DP` text COMMENT 'Diagnostic',
  `DE` text COMMENT 'Diagnostic',
  `DD` text COMMENT 'Diagnostic',
  `DS` text COMMENT 'Diagnostic',
  PRIMARY KEY (`Fc_id`),
  KEY `Pt_id` (`Pt_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Fiha bzzf les données je vais chercher comment les ajouter' AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Structure de la table `fournisseur`
--

CREATE TABLE IF NOT EXISTS `fournisseur` (
  `Fr_id` int(11) NOT NULL AUTO_INCREMENT,
  `Fr_nom` text,
  `Fr_adr` text,
  `Fr_tel` int(11) DEFAULT NULL,
  PRIMARY KEY (`Fr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `odf`
--

CREATE TABLE IF NOT EXISTS `odf` (
  `Odf_id` int(11) NOT NULL AUTO_INCREMENT,
  `Odf_diagnostic` text,
  `Odf_planTravail` text,
  `Odf_date` date NOT NULL,
  `Odf_coutTotal` int(11) NOT NULL,
  `Odf_verset` int(11) NOT NULL,
  `Pt_id` int(11) DEFAULT NULL COMMENT 'il faut qu''il soit unique ie : 1e seule ODF pour 1 patient',
  `Doc_id` int(11) DEFAULT NULL,
  `type` varchar(10) DEFAULT 'Odf',
  PRIMARY KEY (`Odf_id`),
  UNIQUE KEY `Pt_id_2` (`Pt_id`),
  KEY `Pt_id` (`Pt_id`),
  KEY `Doc_id` (`Doc_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

-- --------------------------------------------------------

--
-- Structure de la table `patient`
--

CREATE TABLE IF NOT EXISTS `patient` (
  `Pt_id` int(11) NOT NULL AUTO_INCREMENT,
  `Pt_nom` varchar(100) NOT NULL,
  `Pt_prenom` varchar(100) NOT NULL,
  `Pt_adr` varchar(200) NOT NULL,
  `Pt_dateN` date NOT NULL,
  `Pt_tel` int(11) NOT NULL,
  `Pt_sexe` varchar(10) NOT NULL,
  `Pt_profession` varchar(200) NOT NULL,
  `Pt_description` text NOT NULL,
  `Pt_dateE` date DEFAULT NULL,
  `Pt_dateNYear` varchar(20) NOT NULL COMMENT 'utilisée pour calculer l''age après',
  PRIMARY KEY (`Pt_id`),
  UNIQUE KEY `Pt_id` (`Pt_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=59 ;

-- --------------------------------------------------------

--
-- Structure de la table `photo`
--

CREATE TABLE IF NOT EXISTS `photo` (
  `Ph_id` int(11) NOT NULL AUTO_INCREMENT,
  `Ph_date` date DEFAULT NULL,
  `Ph_path` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Odf_id` int(11) DEFAULT NULL,
  `Pt_id` int(11) DEFAULT NULL,
  `Fc_id` int(11) DEFAULT NULL,
  `Ph_description` text CHARACTER SET utf8 COLLATE utf8_bin,
  `Rad_bool` tinyint(1) DEFAULT NULL COMMENT 'True si la photo est un Radio',
  PRIMARY KEY (`Ph_id`),
  KEY `Odf_id` (`Odf_id`,`Pt_id`,`Fc_id`),
  KEY `Pr_id` (`Pt_id`),
  KEY `Fc_id` (`Fc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `prothese`
--

CREATE TABLE IF NOT EXISTS `prothese` (
  `Pr_id` int(11) NOT NULL AUTO_INCREMENT,
  `Pr_type` text,
  `Pr_date` date NOT NULL,
  `Pr_traitement` text,
  `Pr_coutTotal` int(11) NOT NULL,
  `Pr_verset` int(11) DEFAULT NULL,
  `Doc_id` int(11) NOT NULL,
  `Pt_id` int(11) NOT NULL,
  `Prot_id` int(11) DEFAULT NULL,
  `Pr_description` text,
  `type` varchar(10) NOT NULL DEFAULT 'Prothese',
  PRIMARY KEY (`Pr_id`),
  KEY `Pr_docteur` (`Doc_id`,`Pt_id`),
  KEY `Pt_id` (`Pt_id`),
  KEY `Prot_id` (`Prot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Je vais voir comment ajouter la photo descriptive des dents après' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `prothesiste`
--

CREATE TABLE IF NOT EXISTS `prothesiste` (
  `Prot_id` int(11) NOT NULL AUTO_INCREMENT,
  `Prot_nom` varchar(200) NOT NULL,
  `Prot_prenom` varchar(200) NOT NULL,
  `Prot_adr` text NOT NULL,
  PRIMARY KEY (`Prot_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Structure de la table `rendezvous`
--

CREATE TABLE IF NOT EXISTS `rendezvous` (
  `Rdv_id` int(11) NOT NULL AUTO_INCREMENT,
  `Subject` text NOT NULL,
  `StartTime` datetime DEFAULT NULL,
  `EndTime` datetime DEFAULT NULL,
  `Description` text NOT NULL,
  `Doc_id` int(11) DEFAULT NULL,
  `Pt_id` int(11) DEFAULT NULL,
  `ImportanceColor` text NOT NULL,
  `Marker` text NOT NULL,
  PRIMARY KEY (`Rdv_id`),
  KEY `Doc_id` (`Doc_id`),
  KEY `Pt_id` (`Pt_id`),
  KEY `Doc_id_2` (`Doc_id`),
  KEY `Pt_id_2` (`Pt_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=38 ;

-- --------------------------------------------------------

--
-- Structure de la table `soin`
--

CREATE TABLE IF NOT EXISTS `soin` (
  `So_id` int(11) NOT NULL AUTO_INCREMENT,
  `So_dent` int(11) NOT NULL,
  `Doc_id` int(11) NOT NULL,
  `So_coutTotal` float NOT NULL,
  `So_verset` float DEFAULT NULL,
  `So_description` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `So_acte` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `So_traitement` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `So_date` date NOT NULL,
  `Pt_id` int(11) NOT NULL,
  `So_diagnostic` text,
  `type` varchar(10) NOT NULL DEFAULT 'Soin',
  PRIMARY KEY (`So_id`),
  KEY `So_docteur` (`Doc_id`,`Pt_id`),
  KEY `Pt_id` (`Pt_id`),
  KEY `Doc_id` (`Doc_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE IF NOT EXISTS `utilisateur` (
  `Ut_id` int(11) NOT NULL AUTO_INCREMENT,
  `Ac_id` int(11) DEFAULT NULL,
  `Ut_nom` varchar(50) DEFAULT NULL,
  `Ut_prenom` varchar(50) DEFAULT NULL,
  `Ut_fonction` varchar(200) DEFAULT NULL,
  `Ut_mdp` varchar(60) DEFAULT NULL,
  `Ut_adr` varchar(200) DEFAULT NULL,
  `Medecin` tinyint(1) NOT NULL,
  `Ut_type` text NOT NULL,
  PRIMARY KEY (`Ut_id`),
  KEY `Ac_id` (`Ac_id`),
  KEY `Ac_id_2` (`Ac_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `controles`
--
ALTER TABLE `controles`
  ADD CONSTRAINT `doc_cont_odf` FOREIGN KEY (`doc_id`) REFERENCES `utilisateur` (`Ut_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `odf_cont` FOREIGN KEY (`Odf_id`) REFERENCES `odf` (`Odf_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `ficheclinique`
--
ALTER TABLE `ficheclinique`
  ADD CONSTRAINT `fiche_patient` FOREIGN KEY (`Pt_id`) REFERENCES `patient` (`Pt_id`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `odf`
--
ALTER TABLE `odf`
  ADD CONSTRAINT `odf_patient` FOREIGN KEY (`Pt_id`) REFERENCES `patient` (`Pt_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `photo`
--
ALTER TABLE `photo`
  ADD CONSTRAINT `fiche_photo` FOREIGN KEY (`Fc_id`) REFERENCES `ficheclinique` (`Fc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `odf_photo` FOREIGN KEY (`Odf_id`) REFERENCES `odf` (`Odf_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Shema_dentaire_Pt` FOREIGN KEY (`Pt_id`) REFERENCES `patient` (`Pt_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `prothese`
--
ALTER TABLE `prothese`
  ADD CONSTRAINT `Docteur_prothèse` FOREIGN KEY (`Doc_id`) REFERENCES `utilisateur` (`Ut_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `patient_prothèse` FOREIGN KEY (`Pt_id`) REFERENCES `patient` (`Pt_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Prothesiste_prothèse` FOREIGN KEY (`Prot_id`) REFERENCES `prothesiste` (`Prot_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rendezvous`
--
ALTER TABLE `rendezvous`
  ADD CONSTRAINT `docteur_rdv` FOREIGN KEY (`Doc_id`) REFERENCES `utilisateur` (`Ut_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `patient_drv` FOREIGN KEY (`Pt_id`) REFERENCES `patient` (`Pt_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `soin`
--
ALTER TABLE `soin`
  ADD CONSTRAINT `docteur_soin` FOREIGN KEY (`Doc_id`) REFERENCES `utilisateur` (`Ut_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `patient_soin` FOREIGN KEY (`Pt_id`) REFERENCES `patient` (`Pt_id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
