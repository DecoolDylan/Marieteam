
--
-- Base de données : `marieteam`
--
CREATE DATABASE IF NOT EXISTS `marieteam` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `marieteam`;

-- --------------------------------------------------------

--
-- Structure de la table `bateau`
--

DROP TABLE IF EXISTS `bateau`;
CREATE TABLE IF NOT EXISTS `bateau` (
  `id_bateau` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(80) CHARACTER SET utf8mb4 NOT NULL,
  `longueur` float NOT NULL,
  `largeur` float NOT NULL,
  `image` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
  `vitesse` float NOT NULL,
  `equipements` varchar(80) CHARACTER SET utf8mb4 NOT NULL,
  PRIMARY KEY (`id_bateau`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE IF NOT EXISTS `categorie` (
  `lettre_categorie` char(5) CHARACTER SET utf8mb4 NOT NULL,
  `libelle` varchar(80) CHARACTER SET utf8mb4 NOT NULL,
  PRIMARY KEY (`lettre_categorie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `contenir`
--

DROP TABLE IF EXISTS `contenir`;
CREATE TABLE IF NOT EXISTS `contenir` (
  `lettre_categorie` char(5) CHARACTER SET utf8mb4 NOT NULL,
  `id_bateau` int(11) NOT NULL,
  `capaciteMax` int(11) NOT NULL,
  PRIMARY KEY (`lettre_categorie`,`id_bateau`),
  KEY `CONTENIR_BATEAU0_FK` (`id_bateau`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `liaison`
--

DROP TABLE IF EXISTS `liaison`;
CREATE TABLE IF NOT EXISTS `liaison` (
  `code_liaison` int(11) NOT NULL,
  `nom` varchar(80) CHARACTER SET utf8mb4 NOT NULL,
  `distance_miles` float NOT NULL,
  `id_secteur` int(11) NOT NULL,
  `port_depart` int(11) NOT NULL,
  `port_arrivee` int(11) NOT NULL,
  PRIMARY KEY (`code_liaison`),
  KEY `LIAISON_SECTEUR_FK` (`id_secteur`),
  KEY `LIAISON_PORT0_FK` (`port_depart`),
  KEY `LIAISON_PORT1_FK` (`port_arrivee`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `periode`
--

DROP TABLE IF EXISTS `periode`;
CREATE TABLE IF NOT EXISTS `periode` (
  `dateDeb` date NOT NULL,
  `dateFin` date NOT NULL,
  PRIMARY KEY (`dateDeb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `port`
--

DROP TABLE IF EXISTS `port`;
CREATE TABLE IF NOT EXISTS `port` (
  `id_port` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(80) CHARACTER SET utf8mb4 NOT NULL,
  PRIMARY KEY (`id_port`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `num_reservation` int(11) NOT NULL AUTO_INCREMENT,
  `num_traversee` int(11) NOT NULL,
  `id_utilisateurs` int(11) NOT NULL,
  `quantiteAdulte` int(11) NOT NULL,
  `quantiteJunior` int(11) NOT NULL,
  `quantiteEnfant` int(11) NOT NULL,
  `quantiteVoitureInf4m` int(11) NOT NULL,
  `quantiteVoitureInf5m` int(11) NOT NULL,
  `quantiteFourgon` int(11) NOT NULL,
  `quantiteCampingCar` int(11) NOT NULL,
  `quantiteCamion` int(11) NOT NULL,
  `prix` float NOT NULL,
  `reduction` float NOT NULL,
  `etat` int(11) NOT NULL,
  PRIMARY KEY (`num_reservation`),
  KEY `RESERVATION_TRAVERSEE_FK` (`num_traversee`),
  KEY `id_utilisateurs` (`id_utilisateurs`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `secteur`
--

DROP TABLE IF EXISTS `secteur`;
CREATE TABLE IF NOT EXISTS `secteur` (
  `id_secteur` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(80) CHARACTER SET utf8mb4 NOT NULL,
  PRIMARY KEY (`id_secteur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `tarifer`
--

DROP TABLE IF EXISTS `tarifer`;
CREATE TABLE IF NOT EXISTS `tarifer` (
  `dateDeb` date NOT NULL,
  `code_liaison` int(11) NOT NULL,
  `num_type` int(11) NOT NULL,
  `tarif` float NOT NULL,
  PRIMARY KEY (`dateDeb`,`code_liaison`,`num_type`),
  KEY `TARIFER_LIAISON0_FK` (`code_liaison`),
  KEY `TARIFER_TYPE1_FK` (`num_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `traversee`
--

DROP TABLE IF EXISTS `traversee`;
CREATE TABLE IF NOT EXISTS `traversee` (
  `num_traversee` int(11) NOT NULL,
  `date` date NOT NULL,
  `heure` time NOT NULL,
  `code_liaison` int(11) NOT NULL,
  `id_bateau` int(11) NOT NULL,
  PRIMARY KEY (`num_traversee`),
  KEY `TRAVERSEE_LIAISON_FK` (`code_liaison`),
  KEY `TRAVERSEE_BATEAU0_FK` (`id_bateau`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `type`
--

DROP TABLE IF EXISTS `type`;
CREATE TABLE IF NOT EXISTS `type` (
  `num_type` int(11) NOT NULL,
  `libelle` varchar(80) CHARACTER SET utf8mb4 NOT NULL,
  `lettre_categorie` char(5) CHARACTER SET utf8mb4 NOT NULL,
  PRIMARY KEY (`num_type`),
  KEY `TYPE_CATEGORIE_FK` (`lettre_categorie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `mail` varchar(150) NOT NULL,
  `mot_de_passe` varchar(60) NOT NULL,
  `adresse` varchar(100) NOT NULL,
  `code_postal` int(5) NOT NULL,
  `ville` varchar(50) NOT NULL,
  `point_fidelite` int(11) NOT NULL,
  `grade` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `contenir`
--
ALTER TABLE `contenir`
  ADD CONSTRAINT `CONTENIR_BATEAU0_FK` FOREIGN KEY (`id_bateau`) REFERENCES `bateau` (`id_bateau`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `CONTENIR_CATEGORIE_FK` FOREIGN KEY (`lettre_categorie`) REFERENCES `categorie` (`lettre_categorie`);

--
-- Contraintes pour la table `liaison`
--
ALTER TABLE `liaison`
  ADD CONSTRAINT `LIAISON_PORT0_FK` FOREIGN KEY (`port_depart`) REFERENCES `port` (`id_port`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `LIAISON_PORT1_FK` FOREIGN KEY (`port_arrivee`) REFERENCES `port` (`id_port`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `LIAISON_SECTEUR_FK` FOREIGN KEY (`id_secteur`) REFERENCES `secteur` (`id_secteur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `RESERVATION_TRAVERSEE_FK` FOREIGN KEY (`num_traversee`) REFERENCES `traversee` (`num_traversee`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`id_utilisateurs`) REFERENCES `utilisateurs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `tarifer`
--
ALTER TABLE `tarifer`
  ADD CONSTRAINT `TARIFER_LIAISON0_FK` FOREIGN KEY (`code_liaison`) REFERENCES `liaison` (`code_liaison`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `TARIFER_PERIODE_FK` FOREIGN KEY (`dateDeb`) REFERENCES `periode` (`dateDeb`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `TARIFER_TYPE1_FK` FOREIGN KEY (`num_type`) REFERENCES `type` (`num_type`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `traversee`
--
ALTER TABLE `traversee`
  ADD CONSTRAINT `TRAVERSEE_BATEAU0_FK` FOREIGN KEY (`id_bateau`) REFERENCES `bateau` (`id_bateau`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `TRAVERSEE_LIAISON_FK` FOREIGN KEY (`code_liaison`) REFERENCES `liaison` (`code_liaison`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `type`
--
ALTER TABLE `type`
  ADD CONSTRAINT `TYPE_CATEGORIE_FK` FOREIGN KEY (`lettre_categorie`) REFERENCES `categorie` (`lettre_categorie`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

