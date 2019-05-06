CREATE DATABASE database_develop;

USE database_develop;

CREATE TABLE users (
  id int(11) NOT NULL UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  username varchar(30) NOT NULL,
  password varchar(255) NOT NULL,
  firstname varchar(30) NOT NULL,
  lastname varchar(30) NOT NULL,
  email varchar(45) NOT NULL,
  createdat datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updatedat datetime DEFAULT NULL
)

SHOW TABLES;

DESCRIBE users;
--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `firstname`, `lastname`, `email`, `createdat`, `updatedat`) VALUES
(1, 'student', 'student', 'Johny', 'Cash', 'johny.cash@student.tafesa.edu.', '2019-05-05 10:51:32', '0000-00-00 00:00:00');