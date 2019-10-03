-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema db_tafebuddy
-- -----------------------------------------------------
DROP DATABASE if exists db_tafebuddy;
-- -----------------------------------------------------
-- Schema db_tafebuddy
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_tafebuddy` DEFAULT CHARACTER SET utf8mb4;
USE `db_tafebuddy` ;

-- -----------------------------------------------------
-- Table `db_tafebuddy`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tafebuddy`.`user` (
  `UserID` VARCHAR(9) NOT NULL,
  `GivenName` VARCHAR(64) NOT NULL,
  `LastName` VARCHAR(64) NOT NULL,
  `EmailAddress` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`UserID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `db_tafebuddy`.`campus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tafebuddy`.`campus` (
  `CampusCode` CHAR(3) NOT NULL,
  `CampusName` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`CampusCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `db_tafebuddy`.`competency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tafebuddy`.`competency` (
  `TafeCompCode` VARCHAR(10) NOT NULL,
  `NationalCompCode` VARCHAR(20) NOT NULL,
  `CompetencyName` VARCHAR(128) NOT NULL,
  `Hours` INT(11) NOT NULL,
  PRIMARY KEY (`TafeCompCode`),
  INDEX `NationalCompCode` (`NationalCompCode` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `db_tafebuddy`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tafebuddy`.`department` (
  `DepartmentCode` VARCHAR(8) NOT NULL,
  `Department` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`DepartmentCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_tafebuddy`.`lecturer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tafebuddy`.`lecturer` (
  `LecturerID` CHAR(9) NOT NULL,
  `GivenName` VARCHAR(64) NOT NULL,
  `LastName` VARCHAR(64) NOT NULL,
  `EmailAddress` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`LecturerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_tafebuddy`.`subject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tafebuddy`.`subject` (
  `SubjectCode` VARCHAR(32) NOT NULL,
  `SubjectDescription` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`SubjectCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_tafebuddy`.`term_datetime`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tafebuddy`.`term_datetime` (
  `TermCode` INT(1) NOT NULL,
  `TermYear` INT(4) NOT NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NOT NULL,
  `SemesterCode` INT(1) NOT NULL,
  PRIMARY KEY (`TermCode`, `TermYear`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_tafebuddy`.`crn_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tafebuddy`.`crn_detail` (
  `CRN` VARCHAR(32) NOT NULL,
  `TafeCompCode` VARCHAR(10) NOT NULL,
  `TermCodeStart` INT(1) NOT NULL,
  `TermYearStart` INT(4) NOT NULL,
  `TermCodeEnd` INT(1) NOT NULL,
  `TermYearEnd` INT(4) NOT NULL,
  `SubjectCode` VARCHAR(32) NOT NULL,
  `CampusCode` CHAR(3) NOT NULL,
  `UserID` VARCHAR(9) NOT NULL,
  `DepartmentCode` VARCHAR(10) NOT NULL,
  `FreezeDate` DATE NOT NULL,
  `DateCreated` DATE NOT NULL,
  PRIMARY KEY (`CRN`, `TermCodeStart`, `TermYearStart`),
  INDEX `FK_CRNDetail_SubjectCode` (`SubjectCode` ASC),
  INDEX `FK_CRNDetail_TafeCompCode` (`TafeCompCode` ASC),
  INDEX `FK_CRNDetail_TermStart` (`TermCodeStart` ASC, `TermYearStart` ASC),
  INDEX `FK_CRNDetail_CampusCode` (`CampusCode` ASC),
  INDEX `FK_CRNDetail_UserID` (`UserID` ASC),
  INDEX `FK_CRNDetail_DepartmentCode` (`DepartmentCode` ASC),
  CONSTRAINT `FK_CRNDetail_CampusCode`
    FOREIGN KEY (`CampusCode`)
    REFERENCES `db_tafebuddy`.`campus` (`CampusCode`)
    ON UPDATE CASCADE,
  CONSTRAINT `FK_CRNDetail_DepartmentCode`
    FOREIGN KEY (`DepartmentCode`)
    REFERENCES `db_tafebuddy`.`department` (`DepartmentCode`)
    ON UPDATE CASCADE,
  CONSTRAINT `FK_CRNDetail_UserID`
    FOREIGN KEY (`UserID`)
    REFERENCES `db_tafebuddy`.`user` (`UserID`)
    ON UPDATE CASCADE,
  CONSTRAINT `FK_CRNDetail_SubjectCode`
    FOREIGN KEY (`SubjectCode`)
    REFERENCES `db_tafebuddy`.`subject` (`SubjectCode`)
    ON UPDATE CASCADE,
  CONSTRAINT `FK_CRNDetail_TafeCompCode`
    FOREIGN KEY (`TafeCompCode`)
    REFERENCES `db_tafebuddy`.`competency` (`TafeCompCode`)
    ON UPDATE CASCADE,
  CONSTRAINT `FK_CRNDetail_TermStart`
    FOREIGN KEY (`TermCodeStart` , `TermYearStart`)
    REFERENCES `db_tafebuddy`.`term_datetime` (`TermCode` , `TermYear`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `db_tafebuddy`.`day_of_week`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tafebuddy`.`day_of_week` (
  `DayCode` INT(1) NOT NULL,
  `DayShortName` CHAR(3) NOT NULL,
  `DayLongName` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`DayCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `db_tafebuddy`.`crn_session_timetable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tafebuddy`.`crn_session_timetable` (
  `CRN` VARCHAR(32) NOT NULL,
  `TermCodeStart` INT(1) NOT NULL,
  `TermYearStart` INT(4) NOT NULL,
  `DayCode` INT(1) NOT NULL,
  `StartTime` TIME NOT NULL,
  `EndTime` TIME NOT NULL,
  `Room` VARCHAR(16) NULL DEFAULT NULL,
  `Building` VARCHAR(16) NULL DEFAULT NULL,
  `CampusCode` CHAR(3) NOT NULL,
  PRIMARY KEY (`CRN`, `DayCode`, `StartTime`),
  INDEX `FK_Session_CRN` (`CRN` ASC, `TermCodeStart` ASC, `TermYearStart` ASC),
  INDEX `FK_Session_TermStart` (`TermCodeStart` ASC, `TermYearStart` ASC),
  INDEX `FK_Session_DayCode` (`DayCode` ASC),
  INDEX `FK_Session_CampusCode` (`CampusCode` ASC),
  CONSTRAINT `FK_Session_CRN`
    FOREIGN KEY (`CRN` , `TermCodeStart` , `TermYearStart`)
    REFERENCES `db_tafebuddy`.`crn_detail` (`CRN` , `TermCodeStart` , `TermYearStart`)
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Session_CampusCode`
    FOREIGN KEY (`CampusCode`)
    REFERENCES `db_tafebuddy`.`campus` (`CampusCode`)
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Session_DayCode`
    FOREIGN KEY (`DayCode`)
    REFERENCES `db_tafebuddy`.`day_of_week` (`DayCode`)
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Session_TermStart`
    FOREIGN KEY (`TermCodeStart` , `TermYearStart`)
    REFERENCES `db_tafebuddy`.`term_datetime` (`TermCode` , `TermYear`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;



-- -----------------------------------------------------
-- Table `db_tafebuddy`.`qualification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tafebuddy`.`qualification` (
  `QualCode` VARCHAR(20) NOT NULL,
  `NationalQualCode` VARCHAR(32) NOT NULL,
  `TafeQualCode` VARCHAR(32) NOT NULL,
  `QualName` VARCHAR(100) NOT NULL,
  `TotalUnits` INT(11) NOT NULL,
  `CoreUnits` INT(11) NOT NULL,
  `ElectedUnits` INT(11) NOT NULL DEFAULT '0',
  `ReqListedElectedUnits` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`QualCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;




-- -----------------------------------------------------
-- Table `db_tafebuddy`.`student_grade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tafebuddy`.`student_grade` (
  `UserID` VARCHAR(9) NOT NULL,
  `CRN` VARCHAR(32) NOT NULL,
  `TafeCompCode` VARCHAR (10) NOT NULL,
  `TermCode` INT(1) NOT NULL,
  `TermYear` INT(4) NOT NULL,
  `Grade` VARCHAR(2) NULL DEFAULT NULL,
  `GradeDate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`UserID`, `CRN`, `TermCode`, `TermYear`),
  INDEX `FK_StudentGrade_CRN` (`CRN` ASC, `TermCode` ASC, `TermYear` ASC),
  INDEX `FK_StudentGrade_TermStart` (`TermCode` ASC, `TermYear` ASC),
  CONSTRAINT `FK_StudentGrade_CRN`
    FOREIGN KEY (`CRN` , `TermCode` , `TermYear`)
    REFERENCES `db_tafebuddy`.`crn_detail` (`CRN` , `TermCodeStart` , `TermYearStart`)
    ON UPDATE CASCADE,
  CONSTRAINT `FK_StudentGrade_Student`
    FOREIGN KEY (`UserID`)
    REFERENCES `db_tafebuddy`.`user` (`UserID`)
    ON UPDATE CASCADE,
  CONSTRAINT `FK_StudentGrade_TermStart`
    FOREIGN KEY (`TermCode` , `TermYear`)
    REFERENCES `db_tafebuddy`.`term_datetime` (`TermCode` , `TermYear`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_tafebuddy`.`student_studyplan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tafebuddy`.`student_studyplan` (
  `UserID` VARCHAR(9) NOT NULL,
  `QualCode` VARCHAR(20) NOT NULL,
  `TermCodeStart` INT(1) NOT NULL,
  `TermYearStart` INT(4) NOT NULL,
  `EnrolmentType` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`UserID`, `QualCode`),
  INDEX `FK_StudentStudyplan_QualCode` (`QualCode` ASC),
  INDEX `FK_StudentStudyplan_TermStart` (`TermCodeStart` ASC, `TermYearStart` ASC),
  CONSTRAINT `FK_StudentStudyplan_QualCode`
    FOREIGN KEY (`QualCode`)
    REFERENCES `db_tafebuddy`.`qualification` (`QualCode`)
    ON UPDATE CASCADE,
  CONSTRAINT `FK_StudentStudyplan_UserID`
    FOREIGN KEY (`UserID`)
    REFERENCES `db_tafebuddy`.`user` (`UserID`),
  CONSTRAINT `FK_StudentStudyplan_TermStart`
    FOREIGN KEY (`TermCodeStart` , `TermYearStart`)
    REFERENCES `db_tafebuddy`.`term_datetime` (`TermCode` , `TermYear`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;



-- -----------------------------------------------------
-- Table `db_tafebuddy`.`studyplan_qualification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tafebuddy`.`studyplan_qualification` (
  `StudyPlanCode` VARCHAR(20) NOT NULL,
  `QualCode` VARCHAR(20) NOT NULL,
  `Priority` INT(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`StudyPlanCode`),
  INDEX `FK_StudyPlanQual_QualCode` (`QualCode` ASC),
  CONSTRAINT `FK_StudyPlanQual_QualCode`
    FOREIGN KEY (`QualCode`)
    REFERENCES `db_tafebuddy`.`qualification` (`QualCode`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `db_tafebuddy`.`studyplan_subject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tafebuddy`.`studyplan_subject` (
  `StudyPlanCode` VARCHAR(20) NOT NULL,
  `SubjectCode` VARCHAR(32) NOT NULL,
  `TimingSemester` INT(11) NOT NULL DEFAULT '1',
  `TimingSemesterTerm` INT(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`StudyPlanCode`, `SubjectCode`),
  INDEX `FK_StudyPlanSubject_SubjectCode` (`SubjectCode` ASC),
  CONSTRAINT `FK_StudyPlanSubject_StudyPlanCode`
    FOREIGN KEY (`StudyPlanCode`)
    REFERENCES `db_tafebuddy`.`studyplan_qualification` (`StudyPlanCode`)
    ON UPDATE CASCADE,
  CONSTRAINT `FK_StudyPlanSubject_SubjectCode`
    FOREIGN KEY (`SubjectCode`)
    REFERENCES `db_tafebuddy`.`subject` (`SubjectCode`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `db_tafebuddy`.`subject_competency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tafebuddy`.`subject_competency` (
  `SubjectCode` VARCHAR(32) NOT NULL,
  `TafeCompCode` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`SubjectCode`, `TafeCompCode`),
  INDEX `FK_SubjComp_TafeCompCode` (`TafeCompCode` ASC),
  CONSTRAINT `FK_SubjComp_SubjectCode`
    FOREIGN KEY (`SubjectCode`)
    REFERENCES `db_tafebuddy`.`subject` (`SubjectCode`)
    ON UPDATE CASCADE,
  CONSTRAINT `FK_SubjComp_TafeCompCode`
    FOREIGN KEY (`TafeCompCode`)
    REFERENCES `db_tafebuddy`.`competency` (`TafeCompCode`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_tafebuddy`.`subject_qualification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tafebuddy`.`subject_qualification` (
  `QualCode` VARCHAR(20) NOT NULL,
  `SubjectCode` VARCHAR(32) NOT NULL,
  `UsageType` VARCHAR(20) NULL,
  PRIMARY KEY (`QualCode`, `SubjectCode`),
  INDEX `FK_SubjQual_SubjectCode` (`SubjectCode` ASC),
  CONSTRAINT `FK_SubjQual_QualCode`
    FOREIGN KEY (`QualCode`)
    REFERENCES `db_tafebuddy`.`qualification` (`QualCode`)
    ON UPDATE CASCADE,
  CONSTRAINT `FK_SubjQual_SubjectCode`
    FOREIGN KEY (`SubjectCode`)
    REFERENCES `db_tafebuddy`.`subject` (`SubjectCode`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;



-- -----------------------------------------------------
-- Table `db_tafebuddy`.`competency_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tafebuddy`.`competency_type` (
  `CompTypeCode` VARCHAR(5) NOT NULL,
  `CompTypeDescription` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`CompTypeCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `db_tafebuddy`.`competency_qualification`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `db_tafebuddy`.`competency_qualification` (
  `QualCode` VARCHAR(20) NOT NULL,
  `NationalCompCode` VARCHAR(20) NOT NULL,
  `CompTypeCode` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`QualCode`, `NationalCompCode`),
  INDEX `fk_competency_qualification_competency_type1_idx` (`CompTypeCode` ASC),
  INDEX `fk_competency_qualification_competency1_idx` (`NationalCompCode` ASC),
  CONSTRAINT `fk_competency_qualification_competency_type1`
    FOREIGN KEY (`CompTypeCode`)
    REFERENCES `db_tafebuddy`.`competency_type` (`CompTypeCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_competency_qualification_competency1`
    FOREIGN KEY (`NationalCompCode`)
    REFERENCES `db_tafebuddy`.`competency` (`NationalCompCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;




SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
