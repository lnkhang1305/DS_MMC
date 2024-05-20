-- Active: 1715395058611@@127.0.0.1@3306@testing_system_db
USE Testing_System_Db;


-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
DROP VIEW IF EXISTS vw_sale ;
CREATE VIEW vw_sale AS
    SELECT a.*, d.DepartmentName AS 'PB'
    FROM `account` a
    INNER JOIN department d 
    ON a.DepartmentID = d.DepartmentID
    WHERE d.DepartmentID = 2;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
DROP VIEW IF EXISTS vw_inmanygroups;
CREATE VIEW vw_inmanygroups AS
WITH cte_groupcount (AccountID, SL) AS(
        SELECT      A.AccountID , COUNT(GA.GroupID) AS "SL"
        FROM        groupaccount GA
        INNER JOIN  account A
        ON          GA.AccountID = A.AccountID
        GROUP BY    A.AccountID
)
SELECT      A.*
FROM        account A
INNER JOIN  cte_groupcount GC ON A.AccountID = GC.AccountID
WHERE       GC.SL = 
                    (SELECT      MAX(SL)
                    FROM        cte_groupcount)
-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ
-- được coi là quá dài) và xóa nó đi

DROP VIEW IF EXISTS vw_longcontent;
CREATE VIEW vw_longcontent AS
SELECT      QuestionID, CHARACTER_LENGTH(Content)--SUM(LENGTH(Content) - LENGTH(REPLACE(Content,' ',"")) + 1) AS 'NumOfWords'
FROM        question
GROUP BY    QuestionID


DELETE FROM         question
WHERE               QuestionID IN (SELECT        QuestionID
                                  FROM          vw_longcontent
                                  WHERE         NumOfWords >= 300);

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
DROP VIEW IF EXISTS vw_dpMaxAcc;
CREATE VIEW vw_dpMaxAcc AS
WITH cte_departmentaccount(PB, SLNV) AS(
    SELECT      D.DepartmentName AS 'PB', COUNT(A.AccountID) AS 'SLNV'
    FROM        department D
    LEFT JOIN   account A
    ON          D.DepartmentID = A.DepartmentID
    GROUP BY    D.DepartmentName
)
SELECT      DepartmentID, DepartmentName
FROM        department D
INNER JOIN  cte_departmentaccount DA ON D.DepartmentName = DA.PB
WHERE       DA.SLNV = (SELECT MAX(SLNV) FROM cte_departmentaccount);


-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
DROP VIEW IF EXISTS vw_questionnguyen;
CREATE VIEW vw_questionnguyen AS
WITH cte_questionname (QuestionID, Creator) AS(
    SELECT      Q.QuestionID, A.FullName
    FROM        question Q
    INNER JOIN  account A ON Q.CreatorID = A.AccountID
    WHERE       A.Fullname LIKE N'Nguyễn%'
)
SELECT          Q.*, QN.Creator
FROM            question Q 
INNER JOIN      cte_questionname QN ON Q.QuestionID = QN.QuestionID;


