-- Active: 1714637042800@@127.0.0.1@3306@testing_system_db
CREATE DATABASE Testing_System_Db;
USE Testing_System_Db;
CREATE TABLE Department (
    DepartmentID                INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName              VARCHAR(50)
);
CREATE TABLE `Position` (
    PositionID                  INT AUTO_INCREMENT PRIMARY KEY,
    PositionName               VARCHAR(50)
);
CREATE TABLE Account (
    AccountID                   INT AUTO_INCREMENT PRIMARY KEY,
    Email                       VARCHAR(50),
    Username                    VARCHAR(50),
    Fullname                    VARCHAR(50),
    DepartmentID                INT,
    PositionID                  INT,
    CreateDate                  DATE
);
CREATE TABLE `Group` (
    GroupID                     INT AUTO_INCREMENT PRIMARY KEY,
    GroupName                   VARCHAR(50),
    CreatorID                   INT,
    CreateDate                  DATE
);
CREATE TABLE GroupAccount (
    GroupID                     INT,
    AccountID                   INT,
    JoinDate                    DATE
);
CREATE TABLE TypeQuestion (
    TypeID                      INT AUTO_INCREMENT PRIMARY KEY,
    TypeName                    VARCHAR(50)
);
CREATE TABLE CategoryQuestion (
    CategoryID                  INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName                VARCHAR(50)
);
CREATE TABLE Question (
    QuestionID                  INt AUTO_INCREMENT PRIMARY KEY,
    Content                     VARCHAR(500),
    CategoryID                  INT,
    TypeID                      INT,
    CreatorID                   INT,
    CreateDate                  DATE    
);
CREATE TABLE Answer (
    AnswerID                    INT AUTO_INCREMENT PRIMARY KEY,
    Content                     VARCHAR(500),
    QuestionID                  INT,
    isCorrect                   VARCHAR(3)
);
CREATE TABLE Exam (
    ExamID                      INT AUTO_INCREMENT PRIMARY KEY,
    Code                        VARCHAR(6),
    Title                       VARCHAR(50),
    CategoryID                  INT,
    Duration                    INT,
    CreatorID                   INT,
    CreateDate                  DATE
);
CREATE TABLE ExamQuestion (
    ExamID                      INT,
    QuestionID                  INT
);