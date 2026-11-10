/*  SQL 프로그램을 작성하시오.
employees 데이터베이스의 employees테이블에서 입사일(hireDATE)열을 이용하여
직원의 입사일이 5년 넘었는지 확인하려고 한다.
입사일부터 현재까지의 날짜를 계산하고, 
입사일이 5년 넘었으면 계산된 날짜와 "축하합니다." 라는 메세지를 출력하고
5년이 넘지 않았으면 계산된 날짜와 같이 "열심히 일하세요. "메세지를 출력하시오.

기본 요구사항
1. if~ else~ end if구문을 사용하여 비교 판단하시오.
2. 날짜 계산은 DATEDIFF( )함수를 사용하시오.
    오늘 날짜를 알기 위해서는 CURRENT_DATE()함수를 사용하시오.
3. 10001번 직원을 선택하여 날짜를 계산하시오.
4. 
*/

DROP PROCEDURE IF EXISTS ifProc2; 
USE employees;

DELIMITER $$
CREATE PROCEDURE ifProc2()
BEGIN
	DECLARE hireDATE DATE; -- 입사일을 저장하기 위한 변수와 데이터 타입 선언
	DECLARE curDATE DATE; -- 오늘날짜를 저장하기 위한 변수와 데이터 타입 선언
	DECLARE days INT; -- 근무한 일수를 계산하기 위한 변수와 데이터 타입 선언 

-- 10001번 직원번호(emp_no = 10001)를 조건으로 입사일(hire_date)열 정보를 가지고 와서 입사일(hireDATE) 변수에 저장
	SELECT hire_date INTO hireDate FROM employees.employees WHERE emp_no = 10001;
-- 10001번 직원의 입사일을 알기 위한 쿼리는?
 
 
	SET curDATE = CURRENT_DATE(); -- CURRENT_DATE()를 사용하여 알아낸 오늘 날짜 정보를 위에서 선언한 curDATE 변수에 저장
-- 오늘 날짜를 출력하시오.
	SET days =  DATEDIFF(curDATE, hireDATE); -- DATEDIFF( ) 함수를 이용하여 오늘날짜에서 입사일을 빼고 변수days)에 저장

	IF (days/365) >= 5 THEN -- 5년이 지났다면
		  SELECT CONCAT('입사한지 ', days, '일이나 지났습니다. 축하합니다!') AS '메시지';
	ELSE
		  SELECT '입사한지 ' + days + '일밖에 안되었네요. 열심히 일하세요.' AS '메시지';
	END IF;
END $$
DELIMITER ;
CALL ifProc2();


-- 다중분기 작성
DROP PROCEDURE IF EXISTS ifProc3; 
DELIMITER $$
CREATE PROCEDURE ifProc3()
BEGIN
    DECLARE point INT ;
    DECLARE credit CHAR(1);
    SET point = 77 ;
    
    IF point >= 90 THEN
		SET credit = 'A';
    ELSEIF point >= 80 THEN
		SET credit = 'B';
    ELSEIF point >= 70 THEN
		SET credit = 'C';
    ELSEIF point >= 60 THEN
		SET credit = 'D';
    ELSE
		SET credit = 'F';
    END IF;
    SELECT CONCAT('취득점수==>', point), CONCAT('학점==>', credit);
END $$
DELIMITER ;
CALL ifProc3();


-- if문을 case문으로 변경
DROP PROCEDURE IF EXISTS caseProc; 
DELIMITER $$
CREATE PROCEDURE caseProc()
BEGIN
    DECLARE point INT ;
    DECLARE credit CHAR(1);
    SET point = 77 ;
    
    CASE 
		WHEN point >= 90 THEN
			SET credit = 'A';
		WHEN point >= 80 THEN
			SET credit = 'B';
		WHEN point >= 70 THEN
			SET credit = 'C';
		WHEN point >= 60 THEN
			SET credit = 'D';
		ELSE
			SET credit = 'F';
    END CASE;
    SELECT CONCAT('취득점수==>', point), CONCAT('학점==>', credit);
END $$
DELIMITER ;
CALL caseProc();


-- <실습 8-4> CASE 문을 활용하여 SQL 프로그래밍하기
/* 구매테이블에서 구매액(price*amount)이 1500 이상인 고객은 '최우수고객',
1000이상인 고객은 '우수고객', 1원 이상인 고객은 '일반고객', 
구매실적이 없는 고객은 '유령고객'을 나타내는 SQL 프로그래밍을 하시오.
CASE 구문을 이용하여 비교 판단문을 작성하시오.
*/

USE cookDB;
-- 2.1 구매액이 높은 순으로 정렬 필요 
-- 구매테이블(buyTBL)에서 구매액(price*amount)을 회원아이디(userID)별로 묶고 구매액이 높은 순으로 정렬
SELECT userID, SUM(price*amount) AS '총구매액'
   FROM buyTBL
   GROUP BY userID
   ORDER BY SUM(price*amount) DESC;

-- 2.2 구매금액별 고객 정보 필요 ==> 회원테이블과 구매테이블 조인필요
-- 회원테이블(userTBL)과 조인하여 회원 이름(userID)과 총구매액(price*amount)을 같이 나타냄
SELECT B.userID, U.userName, SUM(price*amount) AS '총구매액'
   FROM buyTBL B
      INNER JOIN userTBL U
         ON B.userID = U.userID
   GROUP BY B.userID, U.userName
   ORDER BY SUM(price*amount) DESC;

-- 2.4 구매실적이 없는 고객까지 포함하여 나타내시오.
-- ==> 회원테이블과 구매테이블 외부 조인필요
-- 회원이름이 기준이 되도록 조인합니다.
SELECT U.userID, U.userName, SUM(price*amount) AS '총구매액'
   FROM buyTBL B
      RIGHT OUTER JOIN userTBL U
         ON B.userID = U.userID
   GROUP BY U.userID, U.userName
   ORDER BY SUM(price*amount) DESC ;

-- 2.6 CASE 구믄을 SELECT절에 추가하여 최종 쿼리문을 작성하시오.
SELECT U.userID, U.userName, SUM(price*amount) AS '총구매액',
CASE
    WHEN (SUM(price*amount) >= 1500) THEN '최우수고객'
    WHEN (SUM(price*amount) >= 1000) THEN '우수고객'
    WHEN (SUM(price*amount) >= 1) THEN '일반고객'
    ELSE '유령고객'
END AS '고객등급'
FROM buyTBL B
RIGHT OUTER JOIN userTBL U
ON B.userID = U.userID
GROUP BY U.userID, U.userName
ORDER BY sum(price*amount) DESC;
-- </실습 8-4> 



DROP PROCEDURE IF EXISTS whileProc; 
DELIMITER $$
CREATE PROCEDURE whileProc()
BEGIN
	DECLARE i INT; -- 1에서 100까지 증가할 변수
	DECLARE hap INT; -- 더한 값을 누적할 변수
    SET i = 1;
    SET hap = 0;

	WHILE (i <= 100) DO
		SET hap = hap + i;  -- hap의 원래의 값에 i를 더해서 다시 hap에 넣으라는 의미
		SET i = i + 1;      -- i의 원래의 값에 1을 더해서 다시 i에 넣으라는 의미
	END WHILE;

	SELECT hap;   
END $$
DELIMITER ;
CALL whileProc();



DROP PROCEDURE IF EXISTS whileProc2; 
DELIMITER $$
CREATE PROCEDURE whileProc2()
BEGIN
    DECLARE i INT; -- 1에서 100까지 증가할 변수
    DECLARE hap INT; -- 더한 값을 누적할 변수
    SET i = 1;
    SET hap = 0;

    myWhile: WHILE (i <= 100) DO  -- While문에 label을 지정
	IF (i%7 = 0) THEN
		SET i = i + 1;     
		ITERATE myWhile; -- 지정한 label문으로 가서 계속 진행
	END IF;
        
        SET hap = hap + i; 
        IF (hap > 1000) THEN 
		LEAVE myWhile; -- 지정한 label문을 떠남. 즉, While 종료.
	END IF;
        SET i = i + 1;
    END WHILE;

    SELECT hap;   
END $$
DELIMITER ;
CALL whileProc2();



DROP PROCEDURE IF EXISTS errorProc; 
DELIMITER $$
CREATE PROCEDURE errorProc()
BEGIN
    DECLARE CONTINUE HANDLER FOR 1146 SELECT '테이블이 없어요ㅠㅠ' AS '메시지';
    SELECT * FROM noTable;  -- noTable은 없음.  
END $$
DELIMITER ;
CALL errorProc();



DROP PROCEDURE IF EXISTS errorProc2; 
DELIMITER $$
CREATE PROCEDURE errorProc2()
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN
	SHOW ERRORS; -- 오류 메시지를 보여 준다.
	SELECT '오류가 발생했네요. 작업은 취소시켰습니다.' AS '메시지'; 
	ROLLBACK; -- 오류 발생시 작업을 롤백시킨다.
    END;
    INSERT INTO userTBL VALUES('YJS', '윤정수', 1988, '서울', NULL, 
		NULL, 170, CURRENT_DATE()); -- 중복되는 아이디이므로 오류 발생
END $$
DELIMITER ;
CALL errorProc2();



use cookDB;
PREPARE myQuery FROM 'SELECT * FROM userTBL WHERE userID = "NHS"';
EXECUTE myQuery;
DEALLOCATE PREPARE myQuery;



USE cookDB;
DROP TABLE IF EXISTS myTable;
CREATE TABLE myTable (id INT AUTO_INCREMENT PRIMARY KEY, mDate DATETIME);

SET @curDATE = CURRENT_TIMESTAMP(); -- 현재 날짜와 시간

PREPARE myQuery FROM 'INSERT INTO myTable VALUES(NULL, ?)';
EXECUTE myQuery USING @curDATE;
DEALLOCATE PREPARE myQuery;

SELECT * FROM myTable;

