-- Active: 1715395058611@@127.0.0.1@3306@testing_system_db
USE Testing_System_Db;

DROP VIEW IF EXISTS vw_sale ;
CREATE VIEW vw_sale AS
    SELECT a.*, d.DepartmentName AS 'PB'
    FROM `account` a
    INNER JOIN department d 
    ON a.DepartmentID = d.DepartmentID
    WHERE d.DepartmentID = 2;

SELECT a.*, d.DepartmentName AS 'PB'
FROM `account` a
INNER JOIN department d
ON a.DepartmentID = d.DepartmentID;