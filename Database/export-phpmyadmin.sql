-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 02, 2019 at 12:12 PM
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
-- Database: `db_tafebuddy`
--

-- -----------------------------------------------------
-- Schema db_tafebuddy
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_tafebuddy` DEFAULT CHARACTER SET utf8mb4;
USE `db_tafebuddy` ;

-- --------------------------------------------------------

--
-- Table structure for table `campus`
--

CREATE TABLE `campus` (
  `CampusCode` char(3) NOT NULL,
  `CampusName` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `competency`
--

CREATE TABLE `competency` (
  `TafeCompCode` varchar(10) NOT NULL,
  `NationalCompCode` varchar(20) NOT NULL,
  `CompetencyName` varchar(128) NOT NULL,
  `Hours` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `competency_qualification`
--

CREATE TABLE `competency_qualification` (
  `QualCode` varchar(20) NOT NULL,
  `NationalCompCode` varchar(20) NOT NULL,
  `CompTypeCode` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `competency_type`
--

CREATE TABLE `competency_type` (
  `CompTypeCode` varchar(5) NOT NULL,
  `CompTypeDescription` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `crn_detail`
--

CREATE TABLE `crn_detail` (
  `CRN` varchar(32) NOT NULL,
  `TafeCompCode` varchar(10) NOT NULL,
  `TermCodeStart` int(1) NOT NULL,
  `TermYearStart` int(4) NOT NULL,
  `TermCodeEnd` int(1) NOT NULL,
  `TermYearEnd` int(4) NOT NULL,
  `SubjectCode` varchar(32) NOT NULL,
  `CampusCode` char(3) NOT NULL,
  `UserID` varchar(9) NOT NULL,
  `DepartmentCode` varchar(10) NOT NULL,
  `FreezeDate` date NOT NULL,
  `DateCreated` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `crn_session_timetable`
--

CREATE TABLE `crn_session_timetable` (
  `CRN` varchar(32) NOT NULL,
  `TermCodeStart` int(1) NOT NULL,
  `TermYearStart` int(4) NOT NULL,
  `DayCode` int(1) NOT NULL,
  `StartTime` time NOT NULL,
  `EndTime` time NOT NULL,
  `Room` varchar(16) DEFAULT NULL,
  `Building` varchar(16) DEFAULT NULL,
  `CampusCode` char(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `day_of_week`
--

CREATE TABLE `day_of_week` (
  `DayCode` int(1) NOT NULL,
  `DayShortName` char(3) NOT NULL,
  `DayLongName` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `DepartmentCode` varchar(8) NOT NULL,
  `Department` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `lecturer`
--

CREATE TABLE `lecturer` (
  `LecturerID` char(9) NOT NULL,
  `GivenName` varchar(64) NOT NULL,
  `LastName` varchar(64) NOT NULL,
  `EmailAddress` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qualification`
--

CREATE TABLE `qualification` (
  `QualCode` varchar(20) NOT NULL,
  `NationalQualCode` varchar(32) NOT NULL,
  `TafeQualCode` varchar(32) NOT NULL,
  `QualName` varchar(100) NOT NULL,
  `TotalUnits` int(11) NOT NULL,
  `CoreUnits` int(11) NOT NULL,
  `ElectedUnits` int(11) NOT NULL DEFAULT '0',
  `ReqListedElectedUnits` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `student_grade`
--

CREATE TABLE `student_grade` (
  `UserID` varchar(9) NOT NULL,
  `CRN` varchar(32) NOT NULL,
  `TafeCompCode` varchar(10) NOT NULL,
  `TermCode` int(1) NOT NULL,
  `TermYear` int(4) NOT NULL,
  `Grade` varchar(2) DEFAULT NULL,
  `GradeDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `student_studyplan`
--

CREATE TABLE `student_studyplan` (
  `UserID` varchar(9) NOT NULL,
  `QualCode` varchar(20) NOT NULL,
  `TermCodeStart` int(1) NOT NULL,
  `TermYearStart` int(4) NOT NULL,
  `EnrolmentType` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `studyplan_qualification`
--

CREATE TABLE `studyplan_qualification` (
  `StudyPlanCode` varchar(20) NOT NULL,
  `QualCode` varchar(20) NOT NULL,
  `Priority` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `studyplan_subject`
--

CREATE TABLE `studyplan_subject` (
  `StudyPlanCode` varchar(20) NOT NULL,
  `SubjectCode` varchar(32) NOT NULL,
  `TimingSemester` int(11) NOT NULL DEFAULT '1',
  `TimingSemesterTerm` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `SubjectCode` varchar(32) NOT NULL,
  `SubjectDescription` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `subject_competency`
--

CREATE TABLE `subject_competency` (
  `SubjectCode` varchar(32) NOT NULL,
  `TafeCompCode` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `subject_qualification`
--

CREATE TABLE `subject_qualification` (
  `QualCode` varchar(20) NOT NULL,
  `SubjectCode` varchar(32) NOT NULL,
  `UsageType` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `term_datetime`
--

CREATE TABLE `term_datetime` (
  `TermCode` int(1) NOT NULL,
  `TermYear` int(4) NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL,
  `SemesterCode` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `UserID` varchar(9) NOT NULL,
  `GivenName` varchar(64) NOT NULL,
  `LastName` varchar(64) NOT NULL,
  `EmailAddress` varchar(64) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Role` varchar(15) NOT NULL,
  `CreatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `campus`
--
ALTER TABLE `campus`
  ADD PRIMARY KEY (`CampusCode`);

--
-- Indexes for table `competency`
--
ALTER TABLE `competency`
  ADD PRIMARY KEY (`TafeCompCode`),
  ADD KEY `NationalCompCode` (`NationalCompCode`);

--
-- Indexes for table `competency_qualification`
--
ALTER TABLE `competency_qualification`
  ADD PRIMARY KEY (`QualCode`,`NationalCompCode`),
  ADD KEY `fk_competency_qualification_competency_type1_idx` (`CompTypeCode`),
  ADD KEY `fk_competency_qualification_competency1_idx` (`NationalCompCode`);

--
-- Indexes for table `competency_type`
--
ALTER TABLE `competency_type`
  ADD PRIMARY KEY (`CompTypeCode`);

--
-- Indexes for table `crn_detail`
--
ALTER TABLE `crn_detail`
  ADD PRIMARY KEY (`CRN`,`TermCodeStart`,`TermYearStart`),
  ADD KEY `FK_CRNDetail_SubjectCode` (`SubjectCode`),
  ADD KEY `FK_CRNDetail_TafeCompCode` (`TafeCompCode`),
  ADD KEY `FK_CRNDetail_TermStart` (`TermCodeStart`,`TermYearStart`),
  ADD KEY `FK_CRNDetail_CampusCode` (`CampusCode`),
  ADD KEY `FK_CRNDetail_UserID` (`UserID`),
  ADD KEY `FK_CRNDetail_DepartmentCode` (`DepartmentCode`);

--
-- Indexes for table `crn_session_timetable`
--
ALTER TABLE `crn_session_timetable`
  ADD PRIMARY KEY (`CRN`,`DayCode`,`StartTime`),
  ADD KEY `FK_Session_CRN` (`CRN`,`TermCodeStart`,`TermYearStart`),
  ADD KEY `FK_Session_TermStart` (`TermCodeStart`,`TermYearStart`),
  ADD KEY `FK_Session_DayCode` (`DayCode`),
  ADD KEY `FK_Session_CampusCode` (`CampusCode`);

--
-- Indexes for table `day_of_week`
--
ALTER TABLE `day_of_week`
  ADD PRIMARY KEY (`DayCode`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`DepartmentCode`);

--
-- Indexes for table `lecturer`
--
ALTER TABLE `lecturer`
  ADD PRIMARY KEY (`LecturerID`);

--
-- Indexes for table `qualification`
--
ALTER TABLE `qualification`
  ADD PRIMARY KEY (`QualCode`);

--
-- Indexes for table `student_grade`
--
ALTER TABLE `student_grade`
  ADD PRIMARY KEY (`UserID`,`CRN`,`TermCode`,`TermYear`),
  ADD KEY `FK_StudentGrade_CRN` (`CRN`,`TermCode`,`TermYear`),
  ADD KEY `FK_StudentGrade_TermStart` (`TermCode`,`TermYear`);

--
-- Indexes for table `student_studyplan`
--
ALTER TABLE `student_studyplan`
  ADD PRIMARY KEY (`UserID`,`QualCode`),
  ADD KEY `FK_StudentStudyplan_QualCode` (`QualCode`),
  ADD KEY `FK_StudentStudyplan_TermStart` (`TermCodeStart`,`TermYearStart`);

--
-- Indexes for table `studyplan_qualification`
--
ALTER TABLE `studyplan_qualification`
  ADD PRIMARY KEY (`StudyPlanCode`),
  ADD KEY `FK_StudyPlanQual_QualCode` (`QualCode`);

--
-- Indexes for table `studyplan_subject`
--
ALTER TABLE `studyplan_subject`
  ADD PRIMARY KEY (`StudyPlanCode`,`SubjectCode`),
  ADD KEY `FK_StudyPlanSubject_SubjectCode` (`SubjectCode`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`SubjectCode`);

--
-- Indexes for table `subject_competency`
--
ALTER TABLE `subject_competency`
  ADD PRIMARY KEY (`SubjectCode`,`TafeCompCode`),
  ADD KEY `FK_SubjComp_TafeCompCode` (`TafeCompCode`);

--
-- Indexes for table `subject_qualification`
--
ALTER TABLE `subject_qualification`
  ADD PRIMARY KEY (`QualCode`,`SubjectCode`),
  ADD KEY `FK_SubjQual_SubjectCode` (`SubjectCode`);

--
-- Indexes for table `term_datetime`
--
ALTER TABLE `term_datetime`
  ADD PRIMARY KEY (`TermCode`,`TermYear`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`UserID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `competency_qualification`
--
ALTER TABLE `competency_qualification`
  ADD CONSTRAINT `fk_competency_qualification_competency1` FOREIGN KEY (`NationalCompCode`) REFERENCES `competency` (`NationalCompCode`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_competency_qualification_competency_type1` FOREIGN KEY (`CompTypeCode`) REFERENCES `competency_type` (`CompTypeCode`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `crn_detail`
--
ALTER TABLE `crn_detail`
  ADD CONSTRAINT `FK_CRNDetail_CampusCode` FOREIGN KEY (`CampusCode`) REFERENCES `campus` (`CampusCode`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CRNDetail_DepartmentCode` FOREIGN KEY (`DepartmentCode`) REFERENCES `department` (`DepartmentCode`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CRNDetail_SubjectCode` FOREIGN KEY (`SubjectCode`) REFERENCES `subject` (`SubjectCode`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CRNDetail_TafeCompCode` FOREIGN KEY (`TafeCompCode`) REFERENCES `competency` (`TafeCompCode`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CRNDetail_TermStart` FOREIGN KEY (`TermCodeStart`,`TermYearStart`) REFERENCES `term_datetime` (`TermCode`, `TermYear`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CRNDetail_UserID` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`) ON UPDATE CASCADE;

--
-- Constraints for table `crn_session_timetable`
--
ALTER TABLE `crn_session_timetable`
  ADD CONSTRAINT `FK_Session_CRN` FOREIGN KEY (`CRN`,`TermCodeStart`,`TermYearStart`) REFERENCES `crn_detail` (`CRN`, `TermCodeStart`, `TermYearStart`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Session_CampusCode` FOREIGN KEY (`CampusCode`) REFERENCES `campus` (`CampusCode`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Session_DayCode` FOREIGN KEY (`DayCode`) REFERENCES `day_of_week` (`DayCode`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Session_TermStart` FOREIGN KEY (`TermCodeStart`,`TermYearStart`) REFERENCES `term_datetime` (`TermCode`, `TermYear`) ON UPDATE CASCADE;

--
-- Constraints for table `student_grade`
--
ALTER TABLE `student_grade`
  ADD CONSTRAINT `FK_StudentGrade_CRN` FOREIGN KEY (`CRN`,`TermCode`,`TermYear`) REFERENCES `crn_detail` (`CRN`, `TermCodeStart`, `TermYearStart`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_StudentGrade_Student` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_StudentGrade_TermStart` FOREIGN KEY (`TermCode`,`TermYear`) REFERENCES `term_datetime` (`TermCode`, `TermYear`) ON UPDATE CASCADE;

--
-- Constraints for table `student_studyplan`
--
ALTER TABLE `student_studyplan`
  ADD CONSTRAINT `FK_StudentStudyplan_QualCode` FOREIGN KEY (`QualCode`) REFERENCES `qualification` (`QualCode`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_StudentStudyplan_TermStart` FOREIGN KEY (`TermCodeStart`,`TermYearStart`) REFERENCES `term_datetime` (`TermCode`, `TermYear`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_StudentStudyplan_UserID` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`);

--
-- Constraints for table `studyplan_qualification`
--
ALTER TABLE `studyplan_qualification`
  ADD CONSTRAINT `FK_StudyPlanQual_QualCode` FOREIGN KEY (`QualCode`) REFERENCES `qualification` (`QualCode`) ON UPDATE CASCADE;

--
-- Constraints for table `studyplan_subject`
--
ALTER TABLE `studyplan_subject`
  ADD CONSTRAINT `FK_StudyPlanSubject_StudyPlanCode` FOREIGN KEY (`StudyPlanCode`) REFERENCES `studyplan_qualification` (`StudyPlanCode`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_StudyPlanSubject_SubjectCode` FOREIGN KEY (`SubjectCode`) REFERENCES `subject` (`SubjectCode`) ON UPDATE CASCADE;

--
-- Constraints for table `subject_competency`
--
ALTER TABLE `subject_competency`
  ADD CONSTRAINT `FK_SubjComp_SubjectCode` FOREIGN KEY (`SubjectCode`) REFERENCES `subject` (`SubjectCode`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SubjComp_TafeCompCode` FOREIGN KEY (`TafeCompCode`) REFERENCES `competency` (`TafeCompCode`) ON UPDATE CASCADE;

--
-- Constraints for table `subject_qualification`
--
ALTER TABLE `subject_qualification`
  ADD CONSTRAINT `FK_SubjQual_QualCode` FOREIGN KEY (`QualCode`) REFERENCES `qualification` (`QualCode`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SubjQual_SubjectCode` FOREIGN KEY (`SubjectCode`) REFERENCES `subject` (`SubjectCode`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
