-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.33 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE USER 'admin_inventory'@'localhost' IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON db_inventory. * TO 'admin_inventory'@'localhost';


-- Dumping database structure for db_inventory
CREATE DATABASE IF NOT EXISTS `db_inventory` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `db_inventory`;

-- Dumping structure for table db_inventory.barang
CREATE TABLE IF NOT EXISTS `barang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `spesifikasi` varchar(50) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL,
  `lokasi` varchar(50) DEFAULT NULL,
  `kategori_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kategori_id` (`kategori_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table db_inventory.barang: ~3 rows (approximately)
/*!40000 ALTER TABLE `barang` DISABLE KEYS */;
INSERT INTO `barang` (`id`, `spesifikasi`, `stok`, `lokasi`, `kategori_id`) VALUES
	(1, '4gb', 357, 'gudang timur', 1),
	(2, '8gb', 2, 'gudang utara', 1),
	(3, 'ds', 12, 'bangsal', 1);
/*!40000 ALTER TABLE `barang` ENABLE KEYS */;

-- Dumping structure for table db_inventory.barangkeluar
CREATE TABLE IF NOT EXISTS `barangkeluar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tgl_keluar` date DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `barang_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `barang_id` (`barang_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table db_inventory.barangkeluar: ~2 rows (approximately)
/*!40000 ALTER TABLE `barangkeluar` DISABLE KEYS */;
INSERT INTO `barangkeluar` (`id`, `tgl_keluar`, `jumlah`, `barang_id`) VALUES
	(1, '2022-11-28', 13, 2),
	(2, '2022-11-27', 7, 2),
	(3, '2022-11-16', 4, 1);
/*!40000 ALTER TABLE `barangkeluar` ENABLE KEYS */;

-- Dumping structure for table db_inventory.barangmasuk
CREATE TABLE IF NOT EXISTS `barangmasuk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tgl_masuk` date DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `barang_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `barang_id` (`barang_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table db_inventory.barangmasuk: ~0 rows (approximately)
/*!40000 ALTER TABLE `barangmasuk` DISABLE KEYS */;
INSERT INTO `barangmasuk` (`id`, `tgl_masuk`, `jumlah`, `barang_id`) VALUES
	(1, '2022-11-27', 11, 1),
	(2, '2022-02-01', 22, 1);
/*!40000 ALTER TABLE `barangmasuk` ENABLE KEYS */;

-- Dumping structure for table db_inventory.kategori
CREATE TABLE IF NOT EXISTS `kategori` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kategori` varchar(50) DEFAULT NULL,
  `keterangan` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table db_inventory.kategori: ~2 rows (approximately)
/*!40000 ALTER TABLE `kategori` DISABLE KEYS */;
INSERT INTO `kategori` (`id`, `kategori`, `keterangan`) VALUES
	(1, 'ram', 'baru'),
	(2, 'rom', 'bekas');
/*!40000 ALTER TABLE `kategori` ENABLE KEYS */;

-- Dumping structure for trigger db_inventory.stok_masuk
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER stok_masuk
AFTER INSERT  ON barangmasuk
FOR EACH ROW  
UPDATE barang SET stok = stok + NEW.jumlah WHERE id = NEW.barang_id//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger db_inventory.stok_turun
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER stok_turun
AFTER INSERT  ON barangkeluar
FOR EACH ROW  
UPDATE barang SET stok = stok - NEW.jumlah WHERE id = NEW.barang_id//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
