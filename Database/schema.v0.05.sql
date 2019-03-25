-- 5WORK_buddy --

-- author: Marcus Kettner
-- version: 0.05 (2019-03-01)

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `5WORK_buddy`;
CREATE SCHEMA IF NOT EXISTS `5WORK_buddy` DEFAULT CHARACTER SET utf8 ;
USE `5WORK_buddy`;

-- ------------------- BASE TABLES ---------------------

-- -----------------------------------------------------
-- Table `campus`
-- 
-- key: description (example)
-- ----------------
-- CampusCode:      3 letter campus code                  ('ADL')
-- CampusName:      name of the campus                    ('Adelaide City')
-- -----------------------------------------------------
DROP TABLE IF EXISTS campus;
CREATE TABLE IF NOT EXISTS campus (
  CampusCode        CHAR(3)       PRIMARY KEY NOT NULL,
  CampusName        VARCHAR(32)   NOT NULL
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `competency`
-- 
-- key: description (example)
-- ----------------
-- TafeCompCode:      local TafeSA competency code        ('TAAFA')
-- NationalCompCode:  national competency code            ('ICTDBS403')
-- CompetencyName:    official competency name            ('Create basic databases')
-- Hours:             amount of required contact hours    (40)
-- -----------------------------------------------------
DROP TABLE IF EXISTS competency;
CREATE TABLE IF NOT EXISTS competency (
  TafeCompCode        VARCHAR(64)   PRIMARY KEY NOT NULL,
  NationalCompCode    VARCHAR(64)   NOT NULL,
  CompetencyName      VARCHAR(128)  NOT NULL,
  Hours               INT           NOT NULL
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `qualification`
--
-- key: description (example)
-- QualCode:              IT internal code for the qualification    ('D_SD15')
-- NationalQualCode:      National qualification code               ('ICT50715')
-- TafeQualCode:          Tafe qualification code                   ('TP00750')
-- QualName:              full name for qualification               ('Diploma of Software Development')
-- TotalUnits:            total number of units                     (16)
-- CoreUnits:             number of core units                      (10)
-- ElectedUnits:          number of electives                       (16)
-- ReqListedElectedUnits: number of electives from listed electives (3)
-- ----------------
DROP TABLE IF EXISTS qualification;
CREATE TABLE IF NOT EXISTS qualification (
  QualCode              VARCHAR(20)     PRIMARY KEY NOT NULL,
  NationalQualCode      VARCHAR(32)     NOT NULL,
  TafeQualCode          VARCHAR(32)     NOT NULL,
  QualName              VARCHAR(100)    NOT NULL,
  TotalUnits            INT             NOT NULL,
  CoreUnits             INT             NOT NULL,
  ElectedUnits          INT             NOT NULL DEFAULT 0,
  ReqListedElectedUnits INT             NOT NULL DEFAULT 0
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `competency_type`
--
-- key: description (example)
-- ----------------
-- CompTypeCode:        type code for the competency usage    ('LE')
-- CompTypeDescription: description for competency usage type ('Listed Elective')
-- -----------------------------------------------------
DROP TABLE IF EXISTS competency_type;
CREATE TABLE IF NOT EXISTS competency_type (
  CompTypeCode          VARCHAR(5)      PRIMARY KEY NOT NULL,
  CompTypeDescription   VARCHAR(128)    NOT NULL
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `day_of_week`
-- 
-- key: description (example)
-- ----------------
-- DayCode:       Number of the weekday (Mon:=1, Sun:=7)  (1)
-- DayShortName:  3 letter abbreviation for the weekday   ('Mon')
-- DayLongName:   Full name of for the weekday            ('Monday')
-- -----------------------------------------------------
DROP TABLE IF EXISTS day_of_week;
CREATE TABLE IF NOT EXISTS day_of_week (
  DayCode         INT(1)      PRIMARY KEY NOT NULL,
  DayShortName    CHAR(3)     NOT NULL,
  DayLongName     VARCHAR(9)  NOT NULL
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `term_datetime`
-- 
-- key: description (example)
-- ----------------
-- TermCode:        Number of the term [1-4]              (1)
-- TermYear:        Year the term is                      (2016)
-- StartDate:       Start date of the term                (2016-02-15) 
-- EndDate:         End date of the term                  (2016-04-10)
-- SemesterCode:    Number of the Semester [1-1]          (1)
-- -----------------------------------------------------
DROP TABLE IF EXISTS term_datetime;
CREATE TABLE IF NOT EXISTS term_datetime (
  TermCode          INT(1)      NOT NULL,
  TermYear          INT(4)      NOT NULL,
  StartDate         DATE        NOT NULL,
  EndDate           DATE        NOT NULL,
  SemesterCode      INT(1)      NOT NULL,
  PRIMARY KEY (TermCode, TermYear)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `lecturer`
-- 
-- key: description (example)
-- ----------------
-- LecturerID:      9-digit identifier for a lecturer     ('000010581')
-- GivenName:       Lecturer's given names                ('Santi')
-- LastName:        Lecturer's last names                 ('Ruiz')
-- EmailAddress:    Lecturer's email address              ('santi.ruiz@tafesa.edu.au')
-- -----------------------------------------------------
DROP TABLE IF EXISTS lecturer;
CREATE TABLE IF NOT EXISTS lecturer (
  LecturerID          CHAR(9)         PRIMARY KEY NOT NULL,
  GivenName           VARCHAR(64)     NOT NULL,
  LastName            VARCHAR(64)     NOT NULL,
  EmailAddress        VARCHAR(64)     NOT NULL
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `student`
--
-- key: description (example)
-- ----------------
-- StudentID:       9-digit identifier for a student      ('000724247')
-- GivenName:       Lecturer's given names                ('Martin')
-- LastName:        Lecturer's last names                 ('Perez')
-- EmailAddress:    Lecturer's email address              ('m_perez@hotmail.com')
-- -----------------------------------------------------
DROP TABLE IF EXISTS student;
CREATE TABLE IF NOT EXISTS student (
  StudentID           CHAR(9)         PRIMARY KEY NOT NULL,
  GivenName           VARCHAR(64)     NOT NULL,
  LastName            VARCHAR(64)     NOT NULL,
  EmailAddress        VARCHAR(64)     NOT NULL
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `subject`
--
-- key: description (example)
-- ----------------
-- SubjectCode:         Code describing the subject             ('4JSB')
-- SubjectDescription:  Detailed name of the subject            ('Javascript Basics')
-- -----------------------------------------------------
DROP TABLE IF EXISTS subject;
CREATE TABLE IF NOT EXISTS subject (
  SubjectCode         VARCHAR(32)     NOT NULL PRIMARY KEY,
  SubjectDescription  VARCHAR(256)    NOT NULL
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `department`
-- 
-- key:             description                         ('example')
-- DepartmentCode:  Code for the department             ('KJ')
-- Department:      Department name                     ('Information Technology')
-- ----------------
DROP TABLE IF EXISTS department;
CREATE TABLE IF NOT EXISTS department (
  DepartmentCode      VARCHAR(8)  PRIMARY KEY NOT NULL,
  Department          VARCHAR(64) NOT NULL
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


-- ------------ Connected Tables -----------------------

-- -----------------------------------------------------
-- Table `studyplan_qualification`
--
-- key: description (example)
-- ----------------
-- StudyPlanCode          Code describing the study plan                            ('SD5AS')
-- QualCode:              Code describing the Qualification                         ('D_SD15')
-- Priority:              priority of the plan [the lower the higher the priority]  (1)
-- -----------------------------------------------------
DROP TABLE IF EXISTS studyplan_qualification;
CREATE TABLE IF NOT EXISTS studyplan_qualification (
    StudyPlanCode   VARCHAR(20)     NOT NULL PRIMARY KEY,
    QualCode        VARCHAR(20)     NOT NULL,
    Priority        INT             NOT NULL DEFAULT 1,
    CONSTRAINT `FK_StudyPlanQual_QualCode`
      FOREIGN KEY (QualCode)
      REFERENCES qualification (QualCode)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `crn_detail`
-- 
-- key: description (example)
-- ----------------
-- CRN:             course registration Number          ('13077')
-- TafeCompCode:    local TafeSA competency code        ('TAAFA')
-- TermCodeStart:   Number of the term CRN start[1-4]   (1)
-- TermYearStart:   Year the CRN starts                 (2016)
-- TermCodeEnd:     Number of the term CRN end[1-4]     (2)
-- TermYearEnd:     Year the CRN ends                   (2016)
-- SubjectCode:     Code describing the subject         ('4JSB')
-- CampusCode:      3 letter campus code                ('ADL')
-- LecturerID:      9-digit identifier for a lecturer   ('000010581')
-- DepartmentCode:  Code for the department             ('KJ')
-- FreezeDate:      Date the enrolments are frozen      ('2018-08-16')
-- DateCreated:     Date this CRN was imported          ('2018-06-06')
-- -----------------------------------------------------
DROP TABLE IF EXISTS crn_detail;
CREATE TABLE IF NOT EXISTS crn_detail (
  CRN                 VARCHAR(32) NOT NULL,
  TafeCompCode        VARCHAR(64) NOT NULL,
  TermCodeStart       INT(1)      NOT NULL,
  TermYearStart       INT(4)      NOT NULL,
  TermCodeEnd         INT(1)      NOT NULL,
  TermYearEnd         INT(4)      NOT NULL,
  SubjectCode         VARCHAR(32) NOT NULL,
  CampusCode          CHAR(3)     NOT NULL,
  LecturerID          VARCHAR(10) NOT NULL,
  DepartmentCode      VARCHAR(10) NOT NULL,
  FreezeDate          DATE        NOT NULL,
  DateCreated         DATE        NOT NULL,
  PRIMARY KEY (CRN, TermCodeStart, TermYearStart),
  CONSTRAINT `FK_CRNDetail_SubjectCode`
    FOREIGN KEY (SubjectCode)
    REFERENCES subject (SubjectCode)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT `FK_CRNDetail_TafeCompCode`
    FOREIGN KEY (TafeCompCode)
    REFERENCES competency (TafeCompCode)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT `FK_CRNDetail_TermStart`
    FOREIGN KEY (TermCodeStart, TermYearStart)
    REFERENCES term_datetime (TermCode, TermYear)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT `FK_CRNDetail_CampusCode`
    FOREIGN KEY (CampusCode)
    REFERENCES campus (CampusCode)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT `FK_CRNDetail_LecturerID`
    FOREIGN KEY (LecturerID)
    REFERENCES lecturer (LecturerID)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT `FK_CRNDetail_DepartmentCode`
    FOREIGN KEY (DepartmentCode)
    REFERENCES department (DepartmentCode)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `crn_session_timetable`
-- 
-- key: description (example)
-- ----------------
-- CRN:             course registration Number              ('13077')
-- TermCodeStart:   Number of the term CRN start[1-4]       (1)
-- TermYearStart:   Year the CRN starts                     (2016)
-- DayCode:         Number of the weekday (Mon:=1, Sun:=7)  (1)
-- StartTime:       Time the session starts                 ('9:00')
-- EndTime:         Time the session ends                   ('11:00')
-- Room:            Room description                        ('A.103')
-- Building         Building description                    ('ADL-A')
-- CampusCode:      3 letter campus code                    ('ADL')
-- -----------------------------------------------------
DROP TABLE IF EXISTS crn_session_timetable;
CREATE TABLE IF NOT EXISTS crn_session_timetable (
  CRN             VARCHAR(32)     NOT NULL,
  TermCodeStart   INT(1)          NOT NULL,
  TermYearStart   INT(4)          NOT NULL,
  DayCode         INT(1)          NOT NULL,
  StartTime       TIME            NOT NULL,
  EndTime         TIME            NOT NULL,
  Room            VARCHAR(16)     NULL,
  Building        VARCHAR(16)     NULL,
  CampusCode      CHAR(3)         NOT NULL,
  PRIMARY KEY (CRN, DayCode, StartTime),
  CONSTRAINT `FK_Session_CRN`
    FOREIGN KEY (CRN, TermCodeStart, TermYearStart)
    REFERENCES crn_detail(CRN, TermCodeStart, TermYearStart)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT `FK_Session_TermStart`
    FOREIGN KEY (TermCodeStart, TermYearStart)
    REFERENCES term_datetime (TermCode, TermYear)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT `FK_Session_DayCode`
    FOREIGN KEY (DayCode)
    REFERENCES day_of_week(DayCode)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT `FK_Session_CampusCode`
    FOREIGN KEY (CampusCode)
    REFERENCES campus (CampusCode)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `studyplan_subject`
--
-- key: description (example)
-- ----------------
-- StudyPlanCode          Code describing the study plan                                        ('SD5AS')
-- SubjectCode:           Code describing the subject                                           ('4JSB')
-- TimingSemester:        The ideal semester this subject should be taught                      (2)
-- TimingSemesterTerm:    The ideal term of the semester this subject should be taught [1 or 2] (2)
-- -----------------------------------------------------

DROP TABLE IF EXISTS studyplan_subject;
CREATE TABLE IF NOT EXISTS studyplan_subject (
    StudyPlanCode       VARCHAR(20)     NOT NULL,
    SubjectCode         VARCHAR(32)     NOT NULL,
    TimingSemester      INT             NOT NULL DEFAULT 1,
    TimingSemesterTerm  INT             NOT NULL DEFAULT 1,
    PRIMARY KEY (StudyPlanCode, SubjectCode),
    CONSTRAINT `FK_StudyPlanSubject_StudyPlanCode`
      FOREIGN KEY (StudyPlanCode)
      REFERENCES studyplan_qualification (StudyPlanCode)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,
    CONSTRAINT `FK_StudyPlanSubject_SubjectCode`
      FOREIGN KEY (SubjectCode)
      REFERENCES subject (SubjectCode)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `subject_qualification`
--
-- key: description (example)
-- ----------------
-- SubjectCode:         Code describing the subject           ('4JSB')
-- QualCode:            Code describing the Qualification     ('D_SD15')
-- CompTypeCode:        type code for the competency usage    ('LE')
-- -----------------------------------------------------
DROP TABLE IF EXISTS subject_qualification;
CREATE TABLE IF NOT EXISTS subject_qualification (
  QualCode              VARCHAR(20)     NOT NULL,
  SubjectCode           VARCHAR(32)     NOT NULL,
  CompTypeCode          VARCHAR(5)      NOT NULL,
  PRIMARY KEY (QualCode, SubjectCode),
  CONSTRAINT `FK_SubjQual_SubjectCode`
    FOREIGN KEY (SubjectCode)
    REFERENCES subject (SubjectCode)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT `FK_SubjQual_QualCode`
    FOREIGN KEY (QualCode)
    REFERENCES qualification (QualCode)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT `FK_SubjQual_CompTypeCode`
    FOREIGN KEY (CompTypeCode)
    REFERENCES competency_type (CompTypeCode)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `subject_competency`
--
-- key: description (example)
-- ----------------
-- SubjectCode:         Code describing the subject           ('4JSB')
-- TafeCompCode:        local TafeSA competency code          ('TAAFA')
-- -----------------------------------------------------
DROP TABLE IF EXISTS subject_competency;
CREATE TABLE IF NOT EXISTS subject_competency (
  SubjectCode           VARCHAR(32)      NOT NULL,
  TafeCompCode          VARCHAR(64)      NOT NULL,
  PRIMARY KEY (SubjectCode, TafeCompCode),
  CONSTRAINT `FK_SubjComp_SubjectCode`
    FOREIGN KEY (SubjectCode)
    REFERENCES subject (SubjectCode)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT `FK_SubjComp_TafeCompCode`
    FOREIGN KEY (TafeCompCode)
    REFERENCES competency (TafeCompCode)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `student_studyplan`
--
-- key: description (example)
-- ----------------
-- StudentID:       9-digit identifier for a student          ('000724247')
-- QualCode:        IT internal code for the qualification    ('D_SD15')
-- TermCodeStart:   Number of the term [1-4]                  (1)
-- TermYearStart:   Year the term is                          (2016)
-- EnrolmentType:   Type of enrolment                         ('Trainee')
DROP TABLE IF EXISTS student_studyplan;
CREATE TABLE IF NOT EXISTS student_studyplan (
  StudentID       VARCHAR(9)      NOT NULL,
  QualCode        VARCHAR(20)     NOT NULL,
  TermCodeStart   INT(1)          NOT NULL,
  TermYearStart   INT(4)          NOT NULL,
  EnrolmentType   VARCHAR(20)     NOT NULL,
  PRIMARY KEY (StudentID, QualCode),
  CONSTRAINT `FK_StudentStudyplan_StudentID`
    FOREIGN KEY (StudentID)
    REFERENCES student (StudentID),
  CONSTRAINT `FK_StudentStudyplan_QualCode`
    FOREIGN KEY (QualCode)
    REFERENCES qualification (QualCode)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT `FK_StudentStudyplan_TermStart`
    FOREIGN KEY (TermCodeStart, TermYearStart)
    REFERENCES term_datetime (TermCode, TermYear)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;



-- -----------------------------------------------------
-- Table `student_grade`
--
-- key: description (example)
-- ----------------
-- StudentID:       9-digit identifier for a student      ('000724247')
-- CRN:             course registration Number            ('13077')
-- TermCode:        Number of the term CRN start[1-4]     (1)
-- TermYear:        Year the CRN starts                   (2016)
-- Grade:           Grade the student got for the CRN     ('P')
-- GradeDate:       Date when the grade was awarded       ('2016-04-12')
  -- -----------------------------------------------------
DROP TABLE IF EXISTS student_grade;
CREATE TABLE IF NOT EXISTS student_grade (
    StudentID       VARCHAR(9)      NOT NULL,
    CRN             VARCHAR(32)     NOT NULL,
    TermCode        INT(1)          NOT NULL,
    TermYear        INT(4)          NOT NULL,
    Grade           VARCHAR(2)      DEFAULT NULL,
    GradeDate       DATE            DEFAULT NULL,
    PRIMARY KEY (StudentID, CRN, TermCode, TermYear),
    CONSTRAINT `FK_StudentGrade_Student`
      FOREIGN KEY (StudentID)
      REFERENCES student (StudentID)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,
    CONSTRAINT `FK_StudentGrade_CRN`
      FOREIGN KEY (CRN, TermCode, TermYear)
      REFERENCES crn_detail (CRN, TermCodeStart, TermYearStart)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,
    CONSTRAINT `FK_StudentGrade_TermStart`
      FOREIGN KEY (TermCode, TermYear)
      REFERENCES term_datetime (TermCode, TermYear)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

