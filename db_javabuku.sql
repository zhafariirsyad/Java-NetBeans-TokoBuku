-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 22, 2018 at 07:10 AM
-- Server version: 10.1.22-MariaDB
-- PHP Version: 7.1.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_javabuku`
--

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `kd_buku` varchar(10) NOT NULL,
  `judul` varchar(50) NOT NULL,
  `jenis` varchar(10) NOT NULL,
  `penulis` varchar(50) NOT NULL,
  `penerbit` varchar(50) NOT NULL,
  `tahun` varchar(4) NOT NULL,
  `stok` int(3) NOT NULL,
  `harga_pokok` int(5) NOT NULL,
  `harga_jual` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`kd_buku`, `judul`, `jenis`, `penulis`, `penerbit`, `tahun`, `stok`, `harga_pokok`, `harga_jual`) VALUES
('K0001', 'Berjuta Rasanya', 'Novel', 'Tere Liye', 'Tere Liye', '2014', 10, 80000, 90000),
('K0002', 'Who Moved My Cheese', 'Edukasi', 'Abraham Lincoln', 'Gramedia', '2016', 16, 80000, 90000),
('K0003', 'MCI', 'Novel', 'Asma Nadia', 'Asma Nadia', '2010', 17, 100000, 150000),
('K0004', 'The Power Of Water', 'Edukasi', 'Masaru Emoto', 'Fiky Barokah', '2006', 35, 50000, 60000);

-- --------------------------------------------------------

--
-- Table structure for table `distributor`
--

CREATE TABLE `distributor` (
  `kd_distributor` varchar(10) NOT NULL,
  `nama_distributor` varchar(50) NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `telepon` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `distributor`
--

INSERT INTO `distributor` (`kd_distributor`, `nama_distributor`, `alamat`, `telepon`) VALUES
('D0001', 'Zhafari Irsyad', 'Ciawi', '081804958151'),
('D0002', 'Pramudya Saputra', 'Caringin Maseng', '0901313123332');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `nama` varchar(20) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`nama`, `username`, `password`) VALUES
('Zhafari Irsyad', 'admin', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `kd_pelanggan` varchar(10) NOT NULL,
  `nama_pelanggan` varchar(50) NOT NULL,
  `jenis_kelamin` varchar(1) NOT NULL,
  `alamat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`kd_pelanggan`, `nama_pelanggan`, `jenis_kelamin`, `alamat`) VALUES
('PL0001', 'Zhafari Irsyad', 'L', 'Ciawi'),
('PL0002', 'Pramudya Saputra', 'P', 'Caringin Maseng');

-- --------------------------------------------------------

--
-- Table structure for table `penjualan`
--

CREATE TABLE `penjualan` (
  `kd_pretransaksi` varchar(10) NOT NULL,
  `kd_transaksi` varchar(10) NOT NULL,
  `kd_pelanggan` varchar(10) NOT NULL,
  `kd_buku` varchar(10) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `sub_total` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `penjualan`
--

INSERT INTO `penjualan` (`kd_pretransaksi`, `kd_transaksi`, `kd_pelanggan`, `kd_buku`, `jumlah`, `sub_total`) VALUES
('PS0001', 'TR0001', 'PL0001', 'K0004', 2, 120000),
('PS0002', 'TR0001', 'PL0001', 'K0004', 4, 240000),
('PS0003', 'TR0001', 'PL0001', 'K0003', 2, 300000),
('PS0004', 'TR0002', 'PL0002', 'K0004', 2, 120000),
('PS0005', 'TR0002', 'PL0002', 'K0004', 2, 120000),
('PS0006', 'TR0002', 'PL0002', 'K0003', 1, 150000),
('PS0007', 'TR0003', 'PL0001', 'K0004', 3, 180000),
('PS0008', 'TR0003', 'PL0001', 'K0004', 2, 120000);

--
-- Triggers `penjualan`
--
DELIMITER $$
CREATE TRIGGER `BELI` AFTER INSERT ON `penjualan` FOR EACH ROW UPDATE buku SET
buku.stok = buku.stok - NEW.jumlah WHERE buku.kd_buku = NEW.kd_buku
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Batal` AFTER DELETE ON `penjualan` FOR EACH ROW UPDATE buku
SET stok = stok + OLD.jumlah
WHERE
kd_buku = OLD.kd_buku
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `penjualan2`
--

CREATE TABLE `penjualan2` (
  `kd_transaksi` varchar(10) NOT NULL,
  `nama_pelanggan` varchar(50) NOT NULL,
  `total` int(50) NOT NULL,
  `tanggal_beli` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `penjualan2`
--

INSERT INTO `penjualan2` (`kd_transaksi`, `nama_pelanggan`, `total`, `tanggal_beli`) VALUES
('TR0001', 'Zhafari Irsyad', 660000, '2018-02-17 06:11:36'),
('TR0002', 'Pramudya Saputra', 390000, '2018-02-17 06:13:13'),
('TR0003', 'Zhafari Irsyad', 300000, '2018-02-22 03:50:22');

-- --------------------------------------------------------

--
-- Stand-in structure for view `perbulan`
-- (See below for the actual view)
--
CREATE TABLE `perbulan` (
`kd_buku` varchar(10)
,`judul` varchar(50)
,`jenis` varchar(10)
,`jumlah` int(11)
,`tanggal_beli` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `struk`
-- (See below for the actual view)
--
CREATE TABLE `struk` (
`nama_pelanggan` varchar(50)
,`total` int(50)
,`tanggal_beli` timestamp
,`kd_transaksi` varchar(10)
,`jumlah` int(11)
,`sub_total` int(20)
,`judul` varchar(50)
);

-- --------------------------------------------------------

--
-- Structure for view `perbulan`
--
DROP TABLE IF EXISTS `perbulan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `perbulan`  AS  select `buku`.`kd_buku` AS `kd_buku`,`buku`.`judul` AS `judul`,`buku`.`jenis` AS `jenis`,`penjualan`.`jumlah` AS `jumlah`,`penjualan2`.`tanggal_beli` AS `tanggal_beli` from ((`buku` join `penjualan` on((`buku`.`kd_buku` = `penjualan`.`kd_buku`))) join `penjualan2` on((`buku`.`kd_buku` = `penjualan`.`kd_buku`))) ;

-- --------------------------------------------------------

--
-- Structure for view `struk`
--
DROP TABLE IF EXISTS `struk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `struk`  AS  select `penjualan2`.`nama_pelanggan` AS `nama_pelanggan`,`penjualan2`.`total` AS `total`,`penjualan2`.`tanggal_beli` AS `tanggal_beli`,`penjualan`.`kd_transaksi` AS `kd_transaksi`,`penjualan`.`jumlah` AS `jumlah`,`penjualan`.`sub_total` AS `sub_total`,`buku`.`judul` AS `judul` from ((`penjualan2` join `penjualan` on((`penjualan2`.`kd_transaksi` = `penjualan`.`kd_transaksi`))) join `buku` on((`penjualan`.`kd_buku` = `buku`.`kd_buku`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`kd_buku`);

--
-- Indexes for table `distributor`
--
ALTER TABLE `distributor`
  ADD PRIMARY KEY (`kd_distributor`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`kd_pelanggan`);

--
-- Indexes for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`kd_pretransaksi`);

--
-- Indexes for table `penjualan2`
--
ALTER TABLE `penjualan2`
  ADD PRIMARY KEY (`kd_transaksi`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
