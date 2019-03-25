-- 5WORK_buddy --

-- author: Marcus Kettner
-- version: 0.05 (2019-03-01)

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'TRADITIONAL,ALLOW_INVALID_DATES';

USE `5WORK_buddy`;

INSERT INTO campus
VALUES ('ADL', 'Adelaide City'),
       ('BER', 'Berri'),
       ('BVA', 'Barossa Valley'),
       ('ELZ', 'Elizabeth'),
       ('EXT', 'External'),
       ('GAW', 'Gawler'),
       ('KAD', 'Kadina'),
       ('MTB', 'Mount Barker'),
       ('MTG', 'Mount Gambier'),
       ('NOA', 'Noarlunga'),
       ('PAG', 'Port Augusta'),
       ('PPI', 'Port Pirie'),
       ('PTL', 'Port Lincoln'),
       ('TTG', 'Tea Tree Gully');

INSERT INTO competency
VALUES ('TAAFA', 'ICTDBS403', 'Create basic databases', 40);

INSERT INTO qualification
VALUES ('D_SD15', 'ICT50715', 'TP00750', 'Diploma of Software Development', 16, 10, 16, 3);

INSERT INTO competency_type
VALUES ('LE', 'Listed Elective');

INSERT INTO day_of_week
VALUES (1, 'Mon', 'Monday'),
       (2, 'Tue', 'Tuesday'),
       (3, 'Wed', 'Wednesday'),
       (4, 'Thu', 'Thursday'),
       (5, 'Fri', 'Friday'),
       (6, 'Sat', 'Saturday'),
       (7, 'Sun', 'Sunday');

INSERT INTO term_datetime
VALUES  (2016, 1, '2016-02-15', '2016-04-10', 1),
        (2016, 2, '2016-04-11', '2016-06-17', 1),
        (2016, 3, '2016-08-01', '2016-09-23', 2),
        (2016, 4, '2016-10-15', '2016-12-09', 2),
        (2017, 1, '2017-02-13', '2017-04-07', 1),
        (2017, 2, '2017-04-10', '2017-06-16', 1),
        (2017, 3, '2017-07-31', '2017-09-22', 2),
        (2017, 4, '2017-10-16', '2017-12-08', 2),
        (2018, 1, '2018-02-12', '2018-04-06', 1),
        (2018, 2, '2018-04-09', '2018-06-15', 1),
        (2018, 3, '2018-07-30', '2018-09-21', 2),
        (2018, 4, '2018-10-15', '2018-12-07', 2);


INSERT INTO lecturer
VALUES ('000010581', 'Santi', 'Ruiz', 'santi.ruiz@tafesa.edu.au');

INSERT INTO student
VALUES ('000724247', 'Martin', 'Perez', 'm_perez@hotmail.com');

INSERT INTO subject
VALUES ('4JSB', 'Javascript Basics');

INSERT INTO department
VALUES ('KJ','Information Technology');

INSERT INTO crn_detail
VALUES ('13077','TAAFA',1,2016,2,2016,'4JSB','ADL','000010581','KJ','2018-08-16','2018-06-06');

INSERT INTO crn_session_timetable
VALUES ('13077', 1, 2016, 1, '9:00', '11:00', 'A.103', 'ADL-A', 'ADL');

INSERT INTO studyplan_qualification
VALUES ('SD5AS', 'D_SD15', 1);

INSERT INTO studyplan_subject
VALUES ('SD5AS', '4JSB', 2, 2);

INSERT INTO subject_qualification
VALUES ('4JSB', 'D_SD15', 'LE');

INSERT INTO subject_competency
VALUES ('4JSB','TAAFA');

INSERT INTO student_studyplan
VALUES ('000724247', 'D_SD15', 1, 2016, 'Trainee');

INSERT INTO student_grade
VALUES ('000724247', '13077', 1, 2016, 'P', '2016-04-12');


