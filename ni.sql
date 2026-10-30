-- join
USE cookDB;

-- 1. 기본 INNER JOIN
SELECT *
FROM buyTBL
INNER JOIN userTBL
    ON buyTBL.userID = userTBL.userID
WHERE buyTBL.userID = 'KYM';

-- 2. 조건에 일치하는 행에 조건 추출
SELECT buyTBL.userID, 
       userName, 
       prodName, 
       addr, 
       CONCAT(mobile1, mobile2) AS '연락처'
FROM buyTBL
INNER JOIN userTBL
    ON buyTBL.userID = userTBL.userID;

-- 3. 테이블 별칭(Alias)을 활용한 간결한 표현
SELECT B.userID, 
       U.userName, 
       B.prodName, 
       U.addr, 
       CONCAT(U.mobile1, U.mobile2) AS '연락처'
FROM buyTBL B
INNER JOIN userTBL U
    ON B.userID = U.userID;
    
-- 4. KYM해당하는 조건 추출
SELECT B.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
FROM buyTBL B
INNER JOIN userTBL U
    ON B.userID = U.userID
WHERE B.userID = 'KYM';


-- 5. 전체 회원이 구매한 물건 목록 전체조회
SELECT U.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
FROM userTBL U
INNER JOIN buyTBL B
    ON U.userID = B.userID
ORDER BY U.userID;


-- 6. 중복 제거 (구매한 적이 있는 회원 목록만 추출)
SELECT DISTINCT U.userID, U.userName, U.addr
FROM userTBL U
INNER JOIN buyTBL B
    ON U.userID = B.userID
ORDER BY U.userID;
