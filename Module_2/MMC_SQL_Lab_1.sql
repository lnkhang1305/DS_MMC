-- Active: 1715395058611@@127.0.0.1@3306@testing_system_db
DROP DATABASE IF EXISTS Testing_System_Db;
/*============================== CREATE TABLE=== =======================================*/
/*======================================================================================*/
CREATE DATABASE Testing_System_Db;
USE Testing_System_Db;
DROP TABLE IF EXISTS Deparment;
CREATE TABLE Department (
    DepartmentID                TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName              NVARCHAR(50)
);
DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position` (
    PositionID                  INT AUTO_INCREMENT PRIMARY KEY,
    PositionName                ENUM('Dev','Test','Scrum Master','PM') NOT NULL
);
DROP TABLE IF EXISTS Account;
CREATE TABLE Account (
    AccountID                   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email                       VARCHAR(50),
    Username                    VARCHAR(50),
    Fullname                    VARCHAR(50),
    DepartmentID                TINYINT UNSIGNED,
    PositionID                  INT,
    CreateDate                  DATETIME DEFAULT NOW(),
    CONSTRAINT fk_department_id FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID) ON DELETE CASCADE
);
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
    GroupID                     INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName                   VARCHAR(50),
    CreatorID                   INT,
    CreateDate                  DATETIME DEFAULT NOW()
);
DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount (
    GroupID                     INT UNSIGNED,
    AccountID                   INT UNSIGNED,
    JoinDate                    DATE
);
ALTER TABLE GroupAccount ADD CONSTRAINT fk_Group_GroupID FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID) ON DELETE CASCADE;
ALTER TABLE GroupAccount ADD CONSTRAINT fk_Group_AccountID FOREIGN KEY (AccountID) REFERENCES Account(AccountID) ON DELETE CASCADE;
DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion (
    TypeID                      INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName                    ENUM('Essay','Multiple-Choice') NOT NULL
);
DROP TABLE IF EXISTS CatogoryQuestion;
CREATE TABLE CategoryQuestion (
    CategoryID                  INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CategoryName                VARCHAR(50)
);
DROP TABLE IF EXISTS Question;
CREATE TABLE Question (
    QuestionID                  INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content                     VARCHAR(500),
    CategoryID                  INT UNSIGNED,
    TypeID                      INT UNSIGNED,
    CreatorID                   INT,
    CreateDate                  DATETIME DEFAULT NOW(),
    CONSTRAINT fk_category_id FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID) ON DELETE CASCADE,
    CONSTRAINT fk_type_id FOREIGN KEY (TypeID) REFERENCES TypeQuestion (TypeID) ON DELETE CASCADE
);
DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer (
    AnswerID                    INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content                     VARCHAR(500),
    QuestionID                  INT UNSIGNED,
    isCorrect                   BIT DEFAULT 1,
    CONSTRAINT fk_question_id FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID) ON DELETE CASCADE
);
DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam (
    ExamID                      INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Code                        CHAR(7),
    Title                       VARCHAR(50),
    CategoryID                  INT UNSIGNED,
    Duration                    INT,
    CreatorID                   INT,
    CreateDate                  DATETIME DEFAULT NOW(),
    CONSTRAINT fk_category_id_exam FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID) ON DELETE CASCADE
);
CREATE TABLE ExamQuestion (
    ExamID                      INT UNSIGNED,
    QuestionID                  INT UNSIGNED
);

