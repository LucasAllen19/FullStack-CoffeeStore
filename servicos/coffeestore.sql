-- MySQL dump 10.13  Distrib 8.0.23, for Linux (x86_64)
--
-- Host: localhost    Database: coffeestore
-- ------------------------------------------------------
-- Server version       8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comentarios`
--

DROP TABLE IF EXISTS `comentarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comentarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comentario` varchar(510) NOT NULL,
  `feed` int NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `conta` varchar(255) NOT NULL,
  `data` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_feed_idx` (`feed`),
  CONSTRAINT `fk_comentarios_feeds` FOREIGN KEY (`feed`) REFERENCES `feeds` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comentarios`
--

LOCK TABLES `comentarios` WRITE;
/*!40000 ALTER TABLE `comentarios` DISABLE KEYS */;
INSERT INTO `comentarios` VALUES (1, 'Ótimo café, sabor intenso e aroma maravilhoso!', 1, 'User_4', 'user_4@example.com', '2024-06-13T06:30:03.093498');
INSERT INTO `comentarios` VALUES (2, 'Café muito fraco, não gostei.', 1, 'User_3', 'user_3@example.com', '2024-01-07T06:30:03.093498');
INSERT INTO `comentarios` VALUES (3, 'Adorei o café, especialmente a torra média.', 1, 'User_7', 'user_7@example.com', '2024-03-16T06:30:03.093498');
INSERT INTO `comentarios` VALUES (4, 'Café muito fraco, não gostei.', 2, 'User_3', 'user_3@example.com', '2024-01-07T06:30:03.093498');
INSERT INTO `comentarios` VALUES (5, 'Adorei o café, especialmente a torra média.', 3, 'User_3', 'user_3@example.com', '2023-08-04T06:30:03.093498');
INSERT INTO `comentarios` VALUES (6, 'Adorei o café, especialmente a torra média.', 3, 'User_7', 'user_7@example.com', '2024-03-16T06:30:03.093498');
INSERT INTO `comentarios` VALUES (7, 'Adorei o café, especialmente a torra média.', 3, 'User_4', 'user_4@example.com', '2024-01-11T06:30:03.093498');
INSERT INTO `comentarios` VALUES (8, 'Café excelente, mas poderia ser um pouco mais encorpado.', 4, 'User_8', 'user_8@example.com', '2024-01-18T06:30:03.093498');
INSERT INTO `comentarios` VALUES (9, 'Gostei do café, mas achei um pouco amargo.', 5, 'User_5', 'user_5@example.com', '2024-06-01T06:30:03.093498');
INSERT INTO `comentarios` VALUES (10, 'O café tem um sabor suave e agradável, recomendo!', 6, 'User_3', 'user_3@example.com', '2023-12-26T06:30:03.093498');
INSERT INTO `comentarios` VALUES (11, 'O café tem um sabor suave e agradável, recomendo!', 6, 'User_10', 'user_10@example.com', '2023-10-07T06:30:03.093498');
INSERT INTO `comentarios` VALUES (12, 'O café tem um sabor suave e agradável, recomendo!', 6, 'User_4', 'user_4@example.com', '2023-09-22T06:30:03.093498');
INSERT INTO `comentarios` VALUES (13, 'Achei o café muito ácido para o meu gosto.', 7, 'User_8', 'user_8@example.com', '2024-06-11T06:30:03.093498');
INSERT INTO `comentarios` VALUES (14, 'Café com sabor equilibrado, perfeito para o dia a dia.', 8, 'User_6', 'user_6@example.com', '2024-05-04T06:30:03.093498');
INSERT INTO `comentarios` VALUES (15, 'Café com sabor equilibrado, perfeito para o dia a dia.', 8, 'User_9', 'user_9@example.com', '2023-11-09T06:30:03.093498');
INSERT INTO `comentarios` VALUES (16, 'Café com sabor equilibrado, perfeito para o dia a dia.', 8, 'User_5', 'user_5@example.com', '2023-10-06T06:30:03.093498');
INSERT INTO `comentarios` VALUES (17, 'Não gostei do café, achei o sabor muito forte.', 9, 'User_3', 'user_3@example.com', '2024-03-12T06:30:03.093498');
INSERT INTO `comentarios` VALUES (18, 'Não gostei do café, achei o sabor muito forte.', 9, 'User_8', 'user_8@example.com', '2023-08-09T06:30:03.093498');
INSERT INTO `comentarios` VALUES (19, 'Não gostei do café, achei o sabor muito forte.', 9, 'User_1', 'user_1@example.com', '2023-12-22T06:30:03.093498');
INSERT INTO `comentarios` VALUES (20, 'Café delicioso, vou comprar de novo com certeza!', 10, 'User_1', 'user_1@example.com', '2023-09-25T06:30:03.093498');
INSERT INTO `comentarios` VALUES (21, 'Café delicioso, vou comprar de novo com certeza!', 11, 'User_1', 'user_1@example.com', '2023-09-25T06:30:03.093498');
INSERT INTO `comentarios` VALUES (22, 'Café delicioso, vou comprar de novo com certeza!', 11, 'User_2', 'user_2@example.com', '2023-09-25T06:30:03.093498');
INSERT INTO `comentarios` VALUES (23, 'Café com sabor agradável, mas nada extraordinário.', 1, 'User_3', 'user_3@example.com', '2024-07-01T06:30:03.093498');
INSERT INTO `comentarios` VALUES (24, 'Aroma incrível, mas o sabor deixou a desejar.', 2, 'User_8', 'user_8@example.com', '2024-06-15T06:30:03.093498');
INSERT INTO `comentarios` VALUES (25, 'Ótimo café, perfeito para qualquer momento do dia.', 3, 'User_4', 'user_4@example.com', '2024-05-20T06:30:03.093498');
INSERT INTO `comentarios` VALUES (26, 'Café com sabor muito suave, poderia ser mais forte.', 4, 'User_5', 'user_5@example.com', '2024-04-18T06:30:03.093498');
INSERT INTO `comentarios` VALUES (27, 'Gostei bastante do café, recomendo a todos.', 5, 'User_1', 'user_1@example.com', '2024-03-25T06:30:03.093498');
INSERT INTO `comentarios` VALUES (28, 'Café com torra média, perfeito para o meu gosto.', 6, 'User_7', 'user_7@example.com', '2024-02-22T06:30:03.093498');
INSERT INTO `comentarios` VALUES (29, 'Sabor intenso e aroma maravilhoso, adorei!', 7, 'User_4', 'user_4@example.com', '2024-01-10T06:30:03.093498');
INSERT INTO `comentarios` VALUES (30, 'O café tem um sabor suave, mas poderia ser mais forte.', 8, 'User_6', 'user_6@example.com', '2023-12-05T06:30:03.093498');
INSERT INTO `comentarios` VALUES (31, 'Achei o café muito amargo, não é do meu gosto.', 9, 'User_3', 'user_3@example.com', '2023-11-19T06:30:03.093498');
INSERT INTO `comentarios` VALUES (32, 'Café equilibrado, ótimo para começar o dia.', 10, 'User_1', 'user_1@example.com', '2023-10-13T06:30:03.093498');
INSERT INTO `comentarios` VALUES (33, 'Aroma delicioso, mas o sabor poderia ser mais forte.', 11, 'User_2', 'user_2@example.com', '2023-09-28T06:30:03.093498');
/*!40000 ALTER TABLE `comentarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresas`
--

DROP TABLE IF EXISTS `empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresas`
--

LOCK TABLES `empresas` WRITE;
/*!40000 ALTER TABLE `empresas` DISABLE KEYS */;
INSERT INTO `empresas` VALUES (1,'Café do Ponto','cafedoponto.png');
INSERT INTO `empresas` VALUES (2, 'Café Pilão', 'cafepilao.png');
INSERT INTO `empresas` VALUES (3, 'Café Melitta', 'cafemelitta.png');
INSERT INTO `empresas` VALUES (4, 'Café 3 Corações', 'cafe3coracoes.png');
INSERT INTO `empresas` VALUES (5, 'Café Santa Clara', 'cafesantaclara.png');
INSERT INTO `empresas` VALUES (6, 'Café Delta', 'cafedelta.png');
INSERT INTO `empresas` VALUES (7, 'Café Iguaçu', 'cafeiguacu.png');
INSERT INTO `empresas` VALUES (8, 'Café Caboclo', 'cafecaboclo.png');
INSERT INTO `empresas` VALUES (9, 'Café Utam', 'cafeutam.png');
INSERT INTO `empresas` VALUES (10, 'Café Brasileiro', 'cafebrasileiro.png');
INSERT INTO `empresas` VALUES (11, 'Café Damasco', 'cafedamasco.png');
INSERT INTO `empresas` VALUES (12, 'Café Fazenda', 'cafefazenda.png');
INSERT INTO `empresas` VALUES (13, 'Café Bom Dia', 'cafebomdia.png');
INSERT INTO `empresas` VALUES (14, 'Café Mineiro', 'cafemineiro.png');
INSERT INTO `empresas` VALUES (15, 'Café Seleto', 'cafeseleto.png');
INSERT INTO `empresas` VALUES (16, 'Café União', 'cafeuniao.png');
INSERT INTO `empresas` VALUES (17, 'Café Mogiana', 'cafemogiana.png');
INSERT INTO `empresas` VALUES (18, 'Café Flor de Minas', 'cafeflordeminas.png');
INSERT INTO `empresas` VALUES (19, 'Café Barão', 'cafebarao.png');
INSERT INTO `empresas` VALUES (20, 'Café Colonial', 'cafecolonial.png');

/*!40000 ALTER TABLE `empresas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feeds`
--

DROP TABLE IF EXISTS `feeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feeds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` datetime NOT NULL,
  `cafe` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_feeds_cafes_idx` (`cafe`),
  CONSTRAINT `fk_feeds_cafes` FOREIGN KEY (`cafe`) REFERENCES `cafes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feeds`
--

LOCK TABLES `feeds` WRITE;
/*!40000 ALTER TABLE `feeds` DISABLE KEYS */;
INSERT INTO `feeds` VALUES (1,'2021-04-14 18:21:11',1);
INSERT INTO `feeds` VALUES (2,'2021-04-14 18:21:11',2);
INSERT INTO `feeds` VALUES (3,'2021-04-14 18:21:11',3);
INSERT INTO `feeds` VALUES (4,'2021-04-14 18:21:11',4);
INSERT INTO `feeds` VALUES (5,'2021-04-14 18:21:11',5);
INSERT INTO `feeds` VALUES (6,'2021-04-14 18:21:11',6);
INSERT INTO `feeds` VALUES (7,'2021-04-14 18:21:11',7);
INSERT INTO `feeds` VALUES (8,'2021-04-14 18:21:11',8);
INSERT INTO `feeds` VALUES (9,'2021-04-14 18:21:11',9);
INSERT INTO `feeds` VALUES (10,'2021-04-14 18:21:11',10);
INSERT INTO `feeds` VALUES (11,'2021-04-14 18:21:11',11);
INSERT INTO `feeds` VALUES (12,'2021-04-14 18:21:11',12);
INSERT INTO `feeds` VALUES (13,'2021-04-14 18:21:11',13);
INSERT INTO `feeds` VALUES (14,'2021-04-14 18:21:11',14);
INSERT INTO `feeds` VALUES (15,'2021-04-14 18:21:11',15);
INSERT INTO `feeds` VALUES (16,'2021-04-14 18:21:11',16);
INSERT INTO `feeds` VALUES (17,'2021-04-14 18:21:11',17);
INSERT INTO `feeds` VALUES (18,'2021-04-14 18:21:11',18);
INSERT INTO `feeds` VALUES (19,'2021-04-14 18:21:11',19);
INSERT INTO `feeds` VALUES (20,'2021-04-14 18:21:11',20);

/*!40000 ALTER TABLE `feeds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `feed` int NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_likes_feeds_idx` (`feed`),
  CONSTRAINT `fk_likes_feeds` FOREIGN KEY (`feed`) REFERENCES `feeds` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,1,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (2,1,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (3,1,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (4,1,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (5,1,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (6,2,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (7,2,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (8,2,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (9,3,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (10,3,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (11,5,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (12,5,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (13,5,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (14,5,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (15,6,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (16,6,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (17,8,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (18,8,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (19,8,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (20,9,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (21,9,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (22,10,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (23,10,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (24,10,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (25,10,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (26,11,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (27,11,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (28,12,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (29,12,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (30,13,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (31,13,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (33,14,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (34,14,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (35,15,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (36,15,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (37,15,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (38,15,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (39,16,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (40,16,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (41,16,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (42,17,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (43,17,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (44,17,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (45,18,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (46,18,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (47,19,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (48,19,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (49,20,'luispscarvalho@gmail.com');
INSERT INTO `likes` VALUES (50,20,'luispscarvalho@gmail.com');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cafes`
--

DROP TABLE IF EXISTS `cafes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cafes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` varchar(510) NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `url` varchar(1020) NOT NULL,
  `imagem1` varchar(255) NOT NULL,
  `imagem2` varchar(255) DEFAULT NULL,
  `imagem3` varchar(255) DEFAULT NULL,
  `empresa` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cafes_empesas_idx` (`empresa`),
  CONSTRAINT `fk_cafes_empesas` FOREIGN KEY (`empresa`) REFERENCES `empresas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cafes`
--

LOCK TABLES `cafes` WRITE;
/*!40000 ALTER TABLE `cafes` DISABLE KEYS */;
INSERT INTO `cafes` VALUES (1,'Café Tradicional','Café do Ponto Tradicional é um café com sabor encorpado e marcante, ideal para qualquer momento do dia.',10.0,'https://cafedoponto.com.br/','cafe1.jpeg','cafe2.jpeg','cafe3.jpeg',1);
INSERT INTO `cafes` VALUES (2,'Café Extra Forte','Café Pilão Extra Forte é um café intenso e encorpado, para quem gosta de um sabor mais forte.',12.0,'https://cafepilao.com.br/','cafe2.jpeg','cafe3.jpeg','cafe4.jpeg',2);
INSERT INTO `cafes` VALUES (3,'Café Gourmet','Café Melitta Gourmet é um café de alta qualidade, com grãos selecionados e um sabor suave e agradável.',15.0,'https://melitta.com.br/','cafe3.jpeg','cafe4.jpeg','cafe5.jpeg',3);
INSERT INTO `cafes` VALUES (4,'"Café Espresso','Café 3 Corações Espresso é um café encorpado e aromático, perfeito para preparar um espresso em casa."',18.0,'https://3coracoes.com.br/','cafe4.jpeg','cafe5.jpeg','cafe6.jpeg',4);
INSERT INTO `cafes` VALUES (5,'Café Orgânico','Café Santa Clara Orgânico é cultivado sem agrotóxicos, oferecendo um sabor puro e natural.',20.0,'https://cafesantaclara.com.br/','cafe5.jpeg','cafe6.jpeg','cafe7.jpeg',5);
INSERT INTO `cafes` VALUES (6,'Café Moído','Café Delta Moído é um café com moagem fina, ideal para métodos de preparo como coador e cafeteira.',11.0,'https://cafedelta.com.br/','cafe6.jpeg','cafe7.jpeg','cafe8.jpeg',6);
INSERT INTO `cafes` VALUES (7,'Café Solúvel','Café Iguaçu Solúvel é prático e rápido de preparar, mantendo o sabor e aroma do café tradicional.',9.0,'https://cafeiguacu.com.br/','cafe7.jpeg','cafe8.jpeg','cafe9.jpeg',7);
INSERT INTO `cafes` VALUES (8,'Café Torrado','Café Caboclo Torrado é um café tradicional brasileiro, com sabor equilibrado e marcante.',8.0,'https://cafecaboclo.com.br/','cafe8.jpeg','cafe9.jpeg','cafe10.jpeg',8);
INSERT INTO `cafes` VALUES (9,'Café Superior','Café Utam Superior é um café de alta qualidade, com sabor encorpado e aroma intenso.',14.0,'https://cafeutam.com.br/','cafe9.jpeg','cafe10.jpeg','cafe1.jpeg',9);
INSERT INTO `cafes` VALUES (10,'Café Extra Forte','Café Brasileiro Extra Forte é um café com sabor intenso e marcante, perfeito para quem gosta de café forte.',10.0,'https://cafebrasileiro.com.br/','cafe10.jpeg','cafe1.jpeg','cafe2.jpeg',10);
INSERT INTO `cafes` VALUES (11,'Café Tradicional','Café Damasco Tradicional é um café com sabor suave e agradável, ideal para o dia a dia.',10.0,'https://cafedamasco.com.br/','cafe1.jpeg','cafe2.jpeg','cafe3.jpeg',11);
INSERT INTO `cafes` VALUES (12,'Café Especial','Café Fazenda Especial é um café de alta qualidade, com grãos selecionados e sabor marcante.',20.0,'https://cafefazenda.com.br/','cafe2.jpeg','cafe3.jpeg','cafe4.jpeg',12);
INSERT INTO `cafes` VALUES (13,'Café Matinal','Café Bom Dia Matinal é perfeito para começar o dia, com sabor suave e agradável.',8.0,'https://cafebomdia.com.br/','cafe3.jpeg','cafe4.jpeg','cafe5.jpeg',13);
INSERT INTO `cafes` VALUES (14,'Café Gourmet','Café Mineiro Gourmet é um café de alta qualidade, com sabor encorpado e aroma intenso',15.0,'https://cafemineiro.com.br/','cafe4.jpeg','cafe5.jpeg','cafe6.jpeg',14);
INSERT INTO `cafes` VALUES (15,'Café Extra Forte','Café Seleto Extra Forte é um café intenso e encorpado, ideal para quem gosta de um sabor mais forte.',12.0,'https://cafeseleto.com.br/','cafe5.jpeg','cafe6.jpeg','cafe7.jpeg',15);
INSERT INTO `cafes` VALUES (16,'Café Tradicional','Café União Tradicional é um café com sabor equilibrado e marcante, perfeito para qualquer momento do dia.',10.0,'https://cafeuniao.com.br/','cafe6.jpeg','cafe7.jpeg','cafe8.jpeg',16);
INSERT INTO `cafes` VALUES (17,'Café Superior','Café Mogiana Superior é um café de alta qualidade, com sabor encorpado e aroma intenso.',14.0,'https://cafemogiana.com.br/','cafe7.jpeg','cafe8.jpeg','cafe9.jpeg',17);
INSERT INTO `cafes` VALUES (18,'Café Orgânico','Café Flor de Minas Orgânico é cultivado sem agrotóxicos, oferecendo um sabor puro e natural.',20.0,'https://cafeflordeminas.com.br/','cafe8.jpeg','cafe9.jpeg','cafe10.jpeg',18);
INSERT INTO `cafes` VALUES (19,'Café Especial','Café Barão Especial é um café de alta qualidade, com grãos selecionados e sabor marcante.',20.0,'https://cafebarao.com.br/','cafe9.jpeg','cafe10.jpeg','cafe1.jpeg',19);
INSERT INTO `cafes` VALUES (20,'Café Tradicional','Café Colonial Tradicional é um café com sabor equilibrado e marcante, perfeito para qualquer momento do dia.',10.0,'https://cafecolonial.com.br/','cafe10.jpeg','cafe1.jpeg','cafe2.jpeg',20);

/*!40000 ALTER TABLE `cafes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-16 21:48:40
