-- Active: 1715395058611@@127.0.0.1@3306@testing_system_db
USE Testing_System_Db;
--Exercise 1: Join
---Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT A.*, D.`DepartmentName` "Phòng Ban"
FROM `account` A
INNER JOIN department D 
ON A.`DepartmentID` = D.`DepartmentID`;
---Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT *
FROM `account` 
WHERE `CreateDate` > '2010-12-20';
---Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT A.`Fullname`,A.`PositionID`, P.`PositionName`
FROM `account` A
INNER JOIN position P 
ON A.`PositionID` = P.`PositionID`;
---Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT C.`DepartmentName` AS 'Phòng ban', COUNT(C.`DepartmentID`) AS 'Số lượng'
FROM
    (SELECT D.`DepartmentName` , A.`DepartmentID` 
    FROM department D
    INNER JOIN `account` A 
    ON D.`DepartmentID` = A.`DepartmentID`) AS C
GROUP BY C.`DepartmentName`
HAVING COUNT(C.`DepartmentID`) > 3;

---Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất

SELECT      Q.*, COUNT(EQ.ExamID) AS 'SL'
FROM        question Q
INNER JOIN  examquestion EQ ON Q.QuestionID = EQ.QuestionID
GROUP BY    Q.QuestionID, Q.Content
HAVING      SL = 
                            (SELECT      MAX(MaxContent.SL)
                            FROM
                                        (SELECT      COUNT(EQ.ExamID) AS 'SL'
                                        FROM        question AS Q 
                                        INNER JOIN  examquestion EQ ON Q.QuestionID = EQ.QuestionID 
                                        GROUP BY    Q.QuestionID) AS MaxContent)



---Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question

SELECT A.CategoryName, COUNT(A.QuestionID) AS 'Quantity'
FROM    
    (SELECT C.CategoryName, Q.QuestionID
     FROM categoryquestion C
     INNER JOIN question Q
     ON C.`CategoryID` = Q.`CategoryID`) AS A
GROUP BY A.`CategoryName`;

---Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam

SELECT Q.`Content`, COUNT(E.`ExamID`)
FROM examquestion E
RIGHT JOIN question Q
ON E.`QuestionID` = Q.`QuestionID`
GROUP BY Q.`Content`;

---Question 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT Q.`Content`, COUNT(A.`QuestionID`)
FROM answer A
INNER JOIN question Q
ON A.`QuestionID` = Q.`QuestionID`
GROUP BY Q.`Content`;

---Question 9: Thống kê số lượng account trong mỗi group
SELECT G.`GroupID`, COUNT(GC.`AccountID`) AS "SL"
FROM `group` G
LEFT JOIN groupaccount GC
ON G.`GroupID` = GC.`GroupID`
GROUP BY G.`GroupID`;


---Question 10: Tìm chức vụ có ít người nhất
SELECT      P.PositionName, COUNT(A.AccountID)
FROM        position  P
INNER JOIN  account A ON A.PositionID = P.PositionID
GROUP BY    P.PositionName
HAVING      COUNT(A.AccountID) = 
                                (SELECT     MIN(MinPos.SL)
                                FROM
                                            (SELECT     COUNT(A.AccountID) AS 'SL'
                                             FROM       position P
                                             INNER JOIN `account` A
                                             ON         P.`PositionID` = A.`PositionID`
                                             GROUP BY   P.`PositionID`) AS MinPos);


---Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT      SLPB.PB, P.PositionName, COUNT(SLPB.AccountID)
FROM        position P
LEFT JOIN
            (SELECT      A.*, P.DepartmentName AS 'PB'
            FROM        department P 
            LEFT JOIN   account A ON P.DepartmentID = A.DepartmentID) AS SLPB
ON          P.PositionID = SLPB.PositionID
GROUP BY    SLPB.PB,P.PositionName; 


---Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
---question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …

SELECT      QD.QuestionID, QD.Content, QD.CategoryName, QD.TypeName, QD.FullName
FROM
            (SELECT      Q.*, CQ.CategoryName, TQ.TypeName, A.Fullname
            FROM        question Q
            INNER JOIN  categoryquestion CQ ON Q.CategoryID = CQ.CategoryID
            INNER JOIN  typequestion TQ     ON Q.TypeID = TQ.TypeID
            INNER JOIN  account A           ON Q.CreatorID  = A.AccountID) AS QD


---Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm

SELECT      TQ.TypeName AS 'Loai', COUNT(Q.QuestionID) AS 'SL'
FROM        typequestion TQ
INNER JOIN  question Q ON TQ.TypeID = Q.TypeID
GROUP BY    TQ.TypeName

---Question 14: Lấy ra group không có account nào-

SELECT      G.GroupID, GC.AccountID
FROM        `group` G
LEFT JOIN   groupaccount GC
ON          G.GroupID = GC.GroupID
WHERE GC.AccountID IS NULL

---Question 15: Lấy ra group không có account nào
---Question 16: Lấy ra question không có answer nào

SELECT      Q.QuestionID, Q.Content
FROM        question Q
LEFT JOIN   answer A ON Q.QuestionID = A.QuestionID
WHERE       A.AnswerID is NULL

