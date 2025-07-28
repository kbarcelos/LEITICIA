CREATE DATABASE  IF NOT EXISTS `plataforma_leiticia` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `plataforma_leiticia`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: plataforma_leiticia
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` char(36) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `celular` varchar(20) DEFAULT NULL,
  `senha_hash` varchar(255) DEFAULT NULL,
  `google_id` varchar(100) DEFAULT NULL,
  `tipo_usuario` enum('doadora','receptora','profissional','gestor','admin') NOT NULL,
  `data_nascimento` date DEFAULT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `bairro` varchar(100) DEFAULT NULL,
  `genero` varchar(30) DEFAULT NULL,
  `identidade_genero` varchar(30) DEFAULT NULL,
  `raca_cor` varchar(30) DEFAULT NULL,
  `escolaridade` varchar(50) DEFAULT NULL,
  `situacao_profissional` varchar(50) DEFAULT NULL,
  `renda_familiar` varchar(30) DEFAULT NULL,
  `relacao_banco_leite` varchar(50) DEFAULT NULL,
  `aceitou_lgpd` tinyint(1) NOT NULL DEFAULT '0',
  `consentimento_dt` datetime DEFAULT NULL,
  `status` enum('ativo','inativo','aguardando_validacao') NOT NULL DEFAULT 'ativo',
  `data_criacao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_atualizacao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `google_id` (`google_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('e2f9f0e1-6ac3-11f0-9900-d85ed35b3546','Doadora Padrão','doadora@leiticia.com.br',NULL,'af6b5f61cf83fd2f9e0b711ae7aca72da86adc3c5595a84f1194fe92b4d16905',NULL,'doadora',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2025-07-27 05:30:00','ativo','2025-07-27 05:30:00','2025-07-27 05:30:00'),('e2f9f71f-6ac3-11f0-9900-d85ed35b3546','Receptora Padrão','receptora@leiticia.com.br',NULL,'93f1912dd1cea6296fe0ddae33bbc0dac2751f038b83a43db4b92d65965311be',NULL,'receptora',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2025-07-27 05:30:00','ativo','2025-07-27 05:30:00','2025-07-27 05:30:00'),('e2f9f8fe-6ac3-11f0-9900-d85ed35b3546','Profissional Padrão','profissional@leiticia.com.br',NULL,'42a5f495c6c5b2da483488c0ed3af4b9eaa00494b950ca6f0c226c8517815814',NULL,'profissional',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2025-07-27 05:30:00','ativo','2025-07-27 05:30:00','2025-07-27 05:30:00'),('e2f9fa35-6ac3-11f0-9900-d85ed35b3546','Gestor Padrão','gestor@leiticia.com.br',NULL,'0bd66e5612153f99a1a193e638fa154694de99912c0911c8e6a28dc120719e6b',NULL,'gestor',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2025-07-27 05:30:00','ativo','2025-07-27 05:30:00','2025-07-27 05:30:00'),('e2f9fba1-6ac3-11f0-9900-d85ed35b3546','Admin Padrão','admin@leiticia.com.br',NULL,'8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',NULL,'admin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2025-07-27 05:30:00','ativo','2025-07-27 05:30:00','2025-07-27 05:30:00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-27 11:22:40
