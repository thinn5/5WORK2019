-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2019 at 08:16 AM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `database_development`
--

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) UNSIGNED NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`session_id`, `expires`, `data`) VALUES
('2SPIPUOoCDrF7UdkXohiC_j-9U-9b4kd', 1558264279, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('3x1VTA8sUoBDjkEr_K526UOOaZz2922V', 1558332980, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('BloMlO9hYjURztkwDovGM3Cc9BWe2n_8', 1558249217, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('DgzHj6PFAHk2DMCLtugu-ppeNR_IKGX-', 1558328974, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('NkEMWF2QVdKFxj9R9l41-un121hPnRBn', 1558249217, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('QgJsYa_ChUqia6aNREn1_61Yp-tROf2l', 1558328974, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('hhqdfv_FlcoOhaaTZwz7-Y-i0VAbXrii', 1558249217, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('qWDShnzfD1ByvrB2cuBRZGnOkjpcbkKL', 1558328974, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(255) NOT NULL,
  `firstName` varchar(30) NOT NULL,
  `lastName` varchar(30) NOT NULL,
  `email` varchar(45) NOT NULL,
  `role` varchar(15) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `firstName`, `lastName`, `email`, `role`, `createdAt`, `updatedAt`) VALUES
(10, 'johny.cash', '02592233f068df792795a5556885fa33cbbf7dd148db41896952efeb5c860bafb614078c6f979ee210d0187965093495589483fde22ac24a37b2dc3864846b35', 'Johny', 'Cash', 'johny.cash@student.tafesa.edu.au', 'administrator', '2019-05-06 16:14:02', '2019-05-12 06:25:03'),
(34, 'elvis.presley', 'd6b4511002e452248857198dd20d002ee6a93369c687cf7b1fba8d4963c810e4ba9c305aad1f4937c371663390cead3b788f3b260233c33e88c7e1c4eb2d3738', 'Elvis', 'Presley', 'elvis.presley@tafesa.edu.au', 'lecturer', '2019-05-06 21:16:14', '2019-05-12 06:25:24'),
(58, 'bruce.springsteen', 'asdf', 'Bruce', 'Springsteen', 'bruce.springsteen@tafesa.edu.au', 'student', '2019-05-12 06:26:34', '2019-05-12 16:11:26'),
(88, 'asdf', 'asdf', 'asdf', 'asdf', 'asdf', 'student', '2019-05-18 18:43:01', NULL),
(89, 'qwer', 'qwer', 'qwer', 'qwer', 'qwer', 'student', '2019-05-18 18:44:17', NULL),
(90, 'zxcv', 'zxcv', 'zxcv', 'zxcv', 'zxcv', 'student', '2019-05-18 18:47:14', NULL),
(91, '1234', '1234', '1234', '1234', '1234', 'student', '2019-05-18 18:48:31', NULL),
(92, 'asdf', 'asdf', 'asdf', 'asdf', 'asdf', 'student', '2019-05-18 18:52:09', NULL),
(94, 'asdfasd', 'asdf', 'asdf', 'asdf', 'asdf', 'lecturer', '2019-05-19 15:30:01', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
