-- MySQL dump 10.13  Distrib 8.0.13, for Linux (x86_64)
--
-- Host: localhost    Database: dbexp
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `dbexp`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `dbexp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;

USE `dbexp`;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `class` (
  `class_id` char(7) NOT NULL,
  `counsellor_id` char(8) NOT NULL,
  `col_id` char(2) NOT NULL,
  `did` char(1) NOT NULL,
  `teacher_id` char(8) NOT NULL,
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES ('0403202','9603005','03','2','8703101'),('0603101','9503004','03','1','7703006');
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `college`
--

DROP TABLE IF EXISTS `college`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `college` (
  `col_id` char(2) NOT NULL,
  `col_name` varchar(20) NOT NULL,
  PRIMARY KEY (`col_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `college`
--

LOCK TABLES `college` WRITE;
/*!40000 ALTER TABLE `college` DISABLE KEYS */;
INSERT INTO `college` VALUES ('01','仪器科学与工程学院'),('02','能源科学与工程学院'),('03','计算机科学与技术学院'),('04','电气工程与自动化学院'),('05','电子与信息工程学院');
/*!40000 ALTER TABLE `college` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `counsellor`
--

DROP TABLE IF EXISTS `counsellor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `counsellor` (
  `sta_id` char(8) NOT NULL,
  `type` char(2) DEFAULT NULL,
  PRIMARY KEY (`sta_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counsellor`
--

LOCK TABLES `counsellor` WRITE;
/*!40000 ALTER TABLE `counsellor` DISABLE KEYS */;
INSERT INTO `counsellor` VALUES ('9503004','兼职'),('9603005','兼职');
/*!40000 ALTER TABLE `counsellor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `counsellorInfo`
--

DROP TABLE IF EXISTS `counsellorInfo`;
/*!50001 DROP VIEW IF EXISTS `counsellorInfo`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `counsellorInfo` AS SELECT 
 1 AS `col_id`,
 1 AS `sta_id`,
 1 AS `type`,
 1 AS `sta_name`,
 1 AS `sta_sex`,
 1 AS `sta_age`,
 1 AS `col_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `course` (
  `cour_id` char(6) DEFAULT NULL,
  `teacher_id` char(8) DEFAULT NULL,
  `cour_name` varchar(20) NOT NULL,
  `capacity` int(2) DEFAULT NULL,
  `credit` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES ('032001','8303201','网络安全',100,3),('032002','8303201','逆向工程',80,4),('032003','8303201','计算机系统安全',50,3),('030001','8703101','数据库系统',150,3),('030002','8703101','计算机系统',100,4),('030003','8703101','编译原理',100,4),('030004','8303201','软件工程',80,4),('030005','8303201','计算机系统',150,5);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `courseInfo`
--

DROP TABLE IF EXISTS `courseInfo`;
/*!50001 DROP VIEW IF EXISTS `courseInfo`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `courseInfo` AS SELECT 
 1 AS `course_id`,
 1 AS `course_name`,
 1 AS `teacher_id`,
 1 AS `teacher_name`,
 1 AS `capacity`,
 1 AS `selected_num`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `curricula_variable`
--

DROP TABLE IF EXISTS `curricula_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `curricula_variable` (
  `student_id` char(10) NOT NULL,
  `course_id` char(6) NOT NULL,
  `teacher_id` char(8) NOT NULL,
  `score` int(3) DEFAULT '-1',
  PRIMARY KEY (`student_id`,`course_id`,`teacher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curricula_variable`
--

LOCK TABLES `curricula_variable` WRITE;
/*!40000 ALTER TABLE `curricula_variable` DISABLE KEYS */;
INSERT INTO `curricula_variable` VALUES ('060310101','030001','8703101',33),('060310101','030002','8703101',-1),('060310101','030003','8703101',-1),('060310101','030004','8303201',-1),('060310101','032001','8303201',-1),('060310101','032002','8303201',-1),('060310101','032003','8303201',-1);
/*!40000 ALTER TABLE `curricula_variable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discipiline`
--

DROP TABLE IF EXISTS `discipiline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `discipiline` (
  `did` char(1) NOT NULL,
  `col_id` char(2) NOT NULL,
  `dis_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`did`,`col_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discipiline`
--

LOCK TABLES `discipiline` WRITE;
/*!40000 ALTER TABLE `discipiline` DISABLE KEYS */;
INSERT INTO `discipiline` VALUES ('1','01','测控技术与仪器'),('1','02','能源与动力工程'),('1','03','计算机科学与技术'),('1','04','电器工程及其自动化'),('1','05','通信工程'),('2','01','精密仪器'),('2','02','飞行器动力工程'),('2','03','信息安全'),('2','04','建筑电器与智能化'),('2','05','电子信息工程'),('3','02','核工程与核技术'),('3','03','生物信息学'),('3','05','信息对抗技术'),('4','03','物联网工程'),('4','05','遥感科学与技术'),('5','03','数据科学与大数据技术'),('5','05','电磁场与无线技术');
/*!40000 ALTER TABLE `discipiline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `postStuInfoByInstructor`
--

DROP TABLE IF EXISTS `postStuInfoByInstructor`;
/*!50001 DROP VIEW IF EXISTS `postStuInfoByInstructor`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `postStuInfoByInstructor` AS SELECT 
 1 AS `stu_id`,
 1 AS `stu_name`,
 1 AS `stu_sex`,
 1 AS `stu_age`,
 1 AS `paper_num`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `postgraduate`
--

DROP TABLE IF EXISTS `postgraduate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `postgraduate` (
  `stu_id` char(10) NOT NULL,
  `instructor_id` char(8) DEFAULT NULL,
  `paper_num` int(2) DEFAULT NULL,
  PRIMARY KEY (`stu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postgraduate`
--

LOCK TABLES `postgraduate` WRITE;
/*!40000 ALTER TABLE `postgraduate` DISABLE KEYS */;
INSERT INTO `postgraduate` VALUES ('040320201','8303201',1),('040320202','8703101',2);
/*!40000 ALTER TABLE `postgraduate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `postgraduateInfo`
--

DROP TABLE IF EXISTS `postgraduateInfo`;
/*!50001 DROP VIEW IF EXISTS `postgraduateInfo`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `postgraduateInfo` AS SELECT 
 1 AS `instructor_id`,
 1 AS `counsellor_id`,
 1 AS `teacher_id`,
 1 AS `col_id`,
 1 AS `did`,
 1 AS `stu_id`,
 1 AS `class_id`,
 1 AS `stu_name`,
 1 AS `stu_sex`,
 1 AS `stu_age`,
 1 AS `paper_num`,
 1 AS `dis_name`,
 1 AS `col_name`,
 1 AS `teacher_name`,
 1 AS `counsellor_name`,
 1 AS `instructor_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `score`
--

DROP TABLE IF EXISTS `score`;
/*!50001 DROP VIEW IF EXISTS `score`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `score` AS SELECT 
 1 AS `student_id`,
 1 AS `course_id`,
 1 AS `course_name`,
 1 AS `teacher_name`,
 1 AS `score`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `staff` (
  `sta_id` char(8) NOT NULL,
  `sta_name` char(5) DEFAULT NULL,
  `sta_sex` char(1) DEFAULT NULL,
  `col_id` char(2) DEFAULT NULL,
  `sta_age` int(2) NOT NULL,
  PRIMARY KEY (`sta_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES ('6501103','李莉','女','01',49),('7601102','何欢','男','01',40),('7703006','刘青山','女','03',44),('8303201','宋小宝','男','03',34),('8602101','王戈','男','02',30),('8703101','刘斌','男','03',34),('9503004','艾丽','女','03',22),('9603005','韩红','女','03',21);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `stuInfo`
--

DROP TABLE IF EXISTS `stuInfo`;
/*!50001 DROP VIEW IF EXISTS `stuInfo`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `stuInfo` AS SELECT 
 1 AS `col_id`,
 1 AS `did`,
 1 AS `class_id`,
 1 AS `stu_id`,
 1 AS `stu_name`,
 1 AS `stu_sex`,
 1 AS `stu_age`,
 1 AS `counsellor_id`,
 1 AS `teacher_id`,
 1 AS `col_name`,
 1 AS `dis_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `stuScore`
--

DROP TABLE IF EXISTS `stuScore`;
/*!50001 DROP VIEW IF EXISTS `stuScore`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `stuScore` AS SELECT 
 1 AS `stu_id`,
 1 AS `stu_name`,
 1 AS `averageScore`,
 1 AS `counsellor_id`,
 1 AS `class_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `student` (
  `Sid` char(10) NOT NULL,
  `Sname` varchar(4) DEFAULT NULL,
  `Sage` int(2) DEFAULT NULL,
  `Ssex` char(2) DEFAULT NULL,
  `Sclass` char(8) DEFAULT NULL,
  `Sdept` char(2) DEFAULT NULL,
  `Saddr` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('2002010101','张二',20,'男','20020101','03','吉林省长春市'),('2002010102','李四',21,'女','20020101','03','黑龙江省哈尔滨市'),('2002010103','老王',22,'男','20020101','03','隔壁'),('2002010201','张一',20,'男','20020102','03','吉林省长春市'),('2002010301','辛弃疾',19,'男','20020103','04','山东东路济南府历城县'),('2002010401','何欢',18,'女','20020104','05','黑龙江省齐齐哈尔市'),('2002010501','李清照',18,'女','20020105','05','南宋');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `students` (
  `stu_id` char(10) NOT NULL,
  `stu_name` char(5) NOT NULL,
  `stu_sex` char(1) DEFAULT NULL,
  `stu_age` int(2) DEFAULT NULL,
  `class_id` char(7) DEFAULT NULL,
  PRIMARY KEY (`stu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES ('040320201','任天堂','男',23,'0403202'),('040320202','王妃','女',22,'0403202'),('060310101','王海','男',21,'0603101'),('060310102','任千裘','男',22,'0603101'),('060310103','令狐冲','男',20,'0603101'),('060310104','小龙女','女',18,'0603101'),('060310105','黄蓉','女',19,'0603101'),('060310106','郭靖','男',19,'0603101');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `teacher` (
  `sta_id` char(8) NOT NULL,
  `job_title` char(4) NOT NULL,
  `did` char(1) DEFAULT NULL,
  PRIMARY KEY (`sta_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES ('6501103','教授','1'),('7601102','副教授','1'),('8303201','讲师','2'),('8602101','教授','1'),('8703101','教授','1');
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `teacherInfo`
--

DROP TABLE IF EXISTS `teacherInfo`;
/*!50001 DROP VIEW IF EXISTS `teacherInfo`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `teacherInfo` AS SELECT 
 1 AS `col_id`,
 1 AS `did`,
 1 AS `sta_id`,
 1 AS `job_title`,
 1 AS `sta_name`,
 1 AS `sta_sex`,
 1 AS `sta_age`,
 1 AS `dis_name`,
 1 AS `col_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `undergraduate`
--

DROP TABLE IF EXISTS `undergraduate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `undergraduate` (
  `stu_id` char(10) NOT NULL,
  `extra_credit` int(3) DEFAULT NULL,
  PRIMARY KEY (`stu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `undergraduate`
--

LOCK TABLES `undergraduate` WRITE;
/*!40000 ALTER TABLE `undergraduate` DISABLE KEYS */;
INSERT INTO `undergraduate` VALUES ('060310101',1),('060310102',2),('060310103',4),('060310104',3),('060310105',2),('060310106',2);
/*!40000 ALTER TABLE `undergraduate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `undergraduateInfo`
--

DROP TABLE IF EXISTS `undergraduateInfo`;
/*!50001 DROP VIEW IF EXISTS `undergraduateInfo`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `undergraduateInfo` AS SELECT 
 1 AS `counsellor_id`,
 1 AS `teacher_id`,
 1 AS `col_id`,
 1 AS `did`,
 1 AS `stu_id`,
 1 AS `class_id`,
 1 AS `stu_name`,
 1 AS `stu_sex`,
 1 AS `stu_age`,
 1 AS `extra_credit`,
 1 AS `dis_name`,
 1 AS `col_name`,
 1 AS `teacher_name`,
 1 AS `counsellor_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Current Database: `dbexp`
--

USE `dbexp`;

--
-- Final view structure for view `counsellorInfo`
--

/*!50001 DROP VIEW IF EXISTS `counsellorInfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dbexp`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `counsellorInfo` AS select `staff`.`col_id` AS `col_id`,`counsellor`.`sta_id` AS `sta_id`,`counsellor`.`type` AS `type`,`staff`.`sta_name` AS `sta_name`,`staff`.`sta_sex` AS `sta_sex`,`staff`.`sta_age` AS `sta_age`,`college`.`col_name` AS `col_name` from ((`counsellor` join `staff` on((`counsellor`.`sta_id` = `staff`.`sta_id`))) join `college` on((`staff`.`col_id` = `college`.`col_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `courseInfo`
--

/*!50001 DROP VIEW IF EXISTS `courseInfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dbexp`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `courseInfo` AS select `course`.`cour_id` AS `course_id`,`course`.`cour_name` AS `course_name`,`course`.`teacher_id` AS `teacher_id`,`teacher_info`.`teacher_name` AS `teacher_name`,`course`.`capacity` AS `capacity`,`course_num`.`selected_num` AS `selected_num` from ((`course` left join (select `curricula_variable`.`course_id` AS `cour_id`,`curricula_variable`.`teacher_id` AS `teacher_id`,count(0) AS `selected_num` from `curricula_variable` group by `curricula_variable`.`course_id`,`curricula_variable`.`teacher_id`) `course_num` on(((`course`.`cour_id` = `course_num`.`cour_id`) and (`course`.`teacher_id` = `course_num`.`teacher_id`)))) join (select `staff`.`sta_id` AS `teacher_id`,`staff`.`sta_name` AS `teacher_name` from `staff`) `teacher_info` on((`course`.`teacher_id` = `teacher_info`.`teacher_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `postStuInfoByInstructor`
--

/*!50001 DROP VIEW IF EXISTS `postStuInfoByInstructor`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dbexp`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `postStuInfoByInstructor` AS select `students`.`stu_id` AS `stu_id`,`students`.`stu_name` AS `stu_name`,`students`.`stu_sex` AS `stu_sex`,`students`.`stu_age` AS `stu_age`,`postgraduate`.`paper_num` AS `paper_num` from (`students` join `postgraduate` on((`students`.`stu_id` = `postgraduate`.`stu_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `postgraduateInfo`
--

/*!50001 DROP VIEW IF EXISTS `postgraduateInfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dbexp`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `postgraduateInfo` AS select `postgraduate`.`instructor_id` AS `instructor_id`,`class`.`counsellor_id` AS `counsellor_id`,`class`.`teacher_id` AS `teacher_id`,`class`.`col_id` AS `col_id`,`class`.`did` AS `did`,`students`.`stu_id` AS `stu_id`,`students`.`class_id` AS `class_id`,`students`.`stu_name` AS `stu_name`,`students`.`stu_sex` AS `stu_sex`,`students`.`stu_age` AS `stu_age`,`postgraduate`.`paper_num` AS `paper_num`,`discipiline`.`dis_name` AS `dis_name`,`college`.`col_name` AS `col_name`,`teacher`.`teacher_name` AS `teacher_name`,`counsellor`.`counsellor_name` AS `counsellor_name`,`instructor`.`instructor_name` AS `instructor_name` from (((((((`students` join `class` on((`students`.`class_id` = `class`.`class_id`))) join `postgraduate` on((`students`.`stu_id` = `postgraduate`.`stu_id`))) join `discipiline` on(((`class`.`col_id` = `discipiline`.`col_id`) and (`class`.`did` = `discipiline`.`did`)))) join `college` on((`class`.`col_id` = `college`.`col_id`))) join (select `staff`.`sta_id` AS `teacher_id`,`staff`.`sta_name` AS `teacher_name` from `staff`) `teacher` on((`class`.`teacher_id` = `teacher`.`teacher_id`))) join (select `staff`.`sta_id` AS `counsellor_id`,`staff`.`sta_name` AS `counsellor_name` from `staff`) `counsellor` on((`class`.`counsellor_id` = `counsellor`.`counsellor_id`))) join (select `staff`.`sta_id` AS `instructor_id`,`staff`.`sta_name` AS `instructor_name` from `staff`) `instructor` on((`postgraduate`.`instructor_id` = `instructor`.`instructor_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `score`
--

/*!50001 DROP VIEW IF EXISTS `score`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dbexp`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `score` AS select `curricula_variable`.`student_id` AS `student_id`,`curricula_variable`.`course_id` AS `course_id`,`course`.`course_name` AS `course_name`,`teacher`.`teacher_name` AS `teacher_name`,`curricula_variable`.`score` AS `score` from ((`curricula_variable` join (select `staff`.`sta_id` AS `teacher_id`,`staff`.`sta_name` AS `teacher_name` from `staff`) `teacher` on((`curricula_variable`.`teacher_id` = `teacher`.`teacher_id`))) join (select `course`.`cour_id` AS `course_id`,`course`.`cour_name` AS `course_name` from `course`) `course` on((`curricula_variable`.`course_id` = `course`.`course_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `stuInfo`
--

/*!50001 DROP VIEW IF EXISTS `stuInfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dbexp`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `stuInfo` AS select `class`.`col_id` AS `col_id`,`class`.`did` AS `did`,`students`.`class_id` AS `class_id`,`students`.`stu_id` AS `stu_id`,`students`.`stu_name` AS `stu_name`,`students`.`stu_sex` AS `stu_sex`,`students`.`stu_age` AS `stu_age`,`class`.`counsellor_id` AS `counsellor_id`,`class`.`teacher_id` AS `teacher_id`,`college`.`col_name` AS `col_name`,`discipiline`.`dis_name` AS `dis_name` from (((`students` join `class` on((`students`.`class_id` = `class`.`class_id`))) join `college` on((`class`.`col_id` = `college`.`col_id`))) join `discipiline` on(((`class`.`col_id` = `discipiline`.`col_id`) and (`class`.`did` = `discipiline`.`did`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `stuScore`
--

/*!50001 DROP VIEW IF EXISTS `stuScore`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dbexp`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `stuScore` AS select `courseInfo`.`stu_id` AS `stu_id`,`students`.`stu_name` AS `stu_name`,(sum(`courseInfo`.`score`) / sum(`course`.`credit`)) AS `averageScore`,`class`.`counsellor_id` AS `counsellor_id`,`class`.`class_id` AS `class_id` from ((((select `curricula_variable`.`student_id` AS `stu_id`,`curricula_variable`.`course_id` AS `cour_id`,`curricula_variable`.`teacher_id` AS `teacher_id`,`curricula_variable`.`score` AS `score` from `curricula_variable` where (`curricula_variable`.`score` <> -(1))) `courseInfo` join `course` on(((`courseInfo`.`cour_id` = `course`.`cour_id`) and (`courseInfo`.`teacher_id` = `course`.`teacher_id`)))) join (select `class`.`class_id` AS `class_id`,`class`.`counsellor_id` AS `counsellor_id` from `class`) `class`) join `students` on(((`courseInfo`.`stu_id` = `students`.`stu_id`) and (`class`.`class_id` = `students`.`class_id`)))) group by `courseInfo`.`stu_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `teacherInfo`
--

/*!50001 DROP VIEW IF EXISTS `teacherInfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dbexp`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `teacherInfo` AS select `staff`.`col_id` AS `col_id`,`teacher`.`did` AS `did`,`teacher`.`sta_id` AS `sta_id`,`teacher`.`job_title` AS `job_title`,`staff`.`sta_name` AS `sta_name`,`staff`.`sta_sex` AS `sta_sex`,`staff`.`sta_age` AS `sta_age`,`discipiline`.`dis_name` AS `dis_name`,`college`.`col_name` AS `col_name` from (((`teacher` join `staff` on((`teacher`.`sta_id` = `staff`.`sta_id`))) join `discipiline` on(((`teacher`.`did` = `discipiline`.`did`) and (`staff`.`col_id` = `discipiline`.`col_id`)))) join `college` on((`staff`.`col_id` = `college`.`col_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `undergraduateInfo`
--

/*!50001 DROP VIEW IF EXISTS `undergraduateInfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dbexp`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `undergraduateInfo` AS select `class`.`counsellor_id` AS `counsellor_id`,`class`.`teacher_id` AS `teacher_id`,`class`.`col_id` AS `col_id`,`class`.`did` AS `did`,`students`.`stu_id` AS `stu_id`,`students`.`class_id` AS `class_id`,`students`.`stu_name` AS `stu_name`,`students`.`stu_sex` AS `stu_sex`,`students`.`stu_age` AS `stu_age`,`undergraduate`.`extra_credit` AS `extra_credit`,`discipiline`.`dis_name` AS `dis_name`,`college`.`col_name` AS `col_name`,`teacher`.`teacher_name` AS `teacher_name`,`counsellor`.`counsellor_name` AS `counsellor_name` from ((((((`students` join `class` on((`students`.`class_id` = `class`.`class_id`))) join `undergraduate` on((`students`.`stu_id` = `undergraduate`.`stu_id`))) join `discipiline` on(((`class`.`col_id` = `discipiline`.`col_id`) and (`class`.`did` = `discipiline`.`did`)))) join `college` on((`class`.`col_id` = `college`.`col_id`))) join (select `staff`.`sta_id` AS `teacher_id`,`staff`.`sta_name` AS `teacher_name` from `staff`) `teacher` on((`class`.`teacher_id` = `teacher`.`teacher_id`))) join (select `staff`.`sta_id` AS `counsellor_id`,`staff`.`sta_name` AS `counsellor_name` from `staff`) `counsellor` on((`class`.`counsellor_id` = `counsellor`.`counsellor_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-11  7:36:41
