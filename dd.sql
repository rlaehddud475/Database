use cookDB;
Drop procedure if exists userProc2;
Delimiter $$
Create procedure userProc2(In userBirth int, in userHeight int)
begin
	select *from usertbl
		where birthyear>userBirth and height>userHeight;
End $$

call userProc2(1960,170);



Drop procedure if exists userProc3;
Delimiter $$
Create procedure userProc3(In txtValue char(10), out outValue int)
begin
insert into outTBL Values(null, txtValue);
select Max(id) into outValue from outTBL;
End $$
Create table if not exists outTBL(
id int auto_increment primary key,
txt char(10)
);
CALL userProc3('입력값', @myValue);
CALL userProc3('입력값', @myValue);
CALL userProc3('입력값', @myValue);
select concat("id 값 --> ",@myValue);

DROP PROCEDURE IF EXISTS ifelseProc;
DELIMITER $$
CREATE PROCEDURE ifelseProc(
    IN uName VARCHAR(10)
)
BEGIN
    DECLARE bYear INT; 
    SELECT birthYear into bYear FROM userTBL
        WHERE userName= uName;
    IF (bYear >= 1970) THEN
            SELECT '아직 젊군요..';
    ELSE
            SELECT '나이가 지긋하네요..';
    END IF;
END $$
DELIMITER ;

CALL ifelseProc ('김국진');


DROP PROCEDURE IF EXISTS caseProc;
DELIMITER $$
CREATE PROCEDURE caseProc(
    IN uName VARCHAR(10)
)
BEGIN
    DECLARE bYear INT; 
    DECLARE tti  CHAR(3);-- 띠
    SELECT birthYear INTO bYear FROM userTBL
        WHERE userName= uName;
    CASE 
        WHEN ( bYear%12 = 0) THEN    SET tti = '원숭이';
        WHEN ( bYear%12 = 1) THEN    SET tti = '닭';
        WHEN ( bYear%12 = 2) THEN    SET tti = '개';
        WHEN ( bYear%12 = 3) THEN    SET tti = '돼지';
        WHEN ( bYear%12 = 4) THEN    SET tti = '쥐';
        WHEN ( bYear%12 = 5) THEN    SET tti = '소';
        WHEN ( bYear%12 = 6) THEN    SET tti = '호랑이';
        WHEN ( bYear%12 = 7) THEN    SET tti = '토끼';
        WHEN ( bYear%12 = 8) THEN    SET tti = '용';
        WHEN ( bYear%12 = 9) THEN    SET tti = '뱀';
        WHEN ( bYear%12 = 10) THEN    SET tti = '말';
        ELSE SET tti = '양';
    END CASE;
    SELECT CONCAT(uName, '의 띠 ==>', tti);
END $$
DELIMITER ;

CALL caseProc ('박수홍');


DROP TABLE IF EXISTS guguTBL;
CREATE TABLE guguTBL (txt VARCHAR(100)); -- 구구단 저장용 테이블

DROP PROCEDURE IF EXISTS whileProc;
DELIMITER $$
CREATE PROCEDURE whileProc()
BEGIN
    DECLARE str VARCHAR(100); -- 각 단을 문자열로 저장
    DECLARE i INT; -- 구구단 앞자리
    DECLARE k INT; -- 구구단 뒷자리
    SET i = 2; -- 2단부터 계산
    
    WHILE (i < 10) DO  -- 바깥 반복문. 2단~9단까지.
        SET str = ''; -- 각 단의 결과를 저장할 문자열 초기화
        SET k = 1; -- 구구단 뒷자리는 항상 1부터 9까지.
        WHILE (k < 10) DO
            SET str = CONCAT(str, '  ', i, 'x', k, '=', i*k); -- 문자열 만들기
            SET k = k + 1; -- 뒷자리 증가
        END WHILE;
        SET i = i + 1; -- 앞자리 증가
        INSERT INTO guguTBL VALUES(str); -- 각 단의 결과를 테이블에 입력.
    END WHILE;
END $$
DELIMITER ;

CALL whileProc();
SELECT * FROM guguTBL;


DROP PROCEDURE IF EXISTS errorProc;
DELIMITER $$
CREATE PROCEDURE errorProc()
BEGIN
    DECLARE i INT; -- 1씩 증가하는 값
    DECLARE hap INT; -- 합계 (정수형) 오버플로 발생시킬 예정
    DECLARE saveHap INT; -- 합계 (정수형) 오버플로 직전의 값을 저장

    DECLARE EXIT HANDLER FOR 1264 -- INT형 오버플로가 발생하면 이 부분 수행
    BEGIN
        SELECT CONCAT('INT 오버플로 직전의 합계 --> ', saveHap);
        SELECT CONCAT('1+2+3+4+...+',i ,'=오버플로');
    END;
    
    SET i = 1; -- 1부터 증가
    SET hap = 0; -- 합계를 누적
    
    WHILE (TRUE) DO  -- 무한 루프.
        SET saveHap = hap; -- 오버플로 직전의 합계를 저장
        SET hap = hap + i;  -- 오버플로가 나면 11, 12행을 수행함
        SET i = i + 1; 
    END WHILE;
END $$
DELIMITER ;

CALL errorProc();

DROP PROCEDURE IF EXISTS nameProc;
DELIMITER $$
CREATE PROCEDURE nameProc(
    IN tableName VARCHAR(20)
)
BEGIN
    SELECT * FROM tableName;
END $$
DELIMITER ;

CALL nameProc('userTBL');




DROP PROCEDURE IF EXISTS nameProc;
DELIMITER $$
CREATE PROCEDURE nameProc(
    IN tableName VARCHAR(20)
)
BEGIN
    SET @sqlQuery = CONCAT('SELECT * FROM ', tableName);
    PREPARE myQuery FROM @sqlQuery;
    EXECUTE myQuery;
    DEALLOCATE PREPARE myQuery;
END $$
DELIMITER ;

CALL nameProc('userTBL');



set global log_bin_trust_function_creators=1;

DROP FUNCTION IF EXISTS userFunc;
DELIMITER $$
CREATE FUNCTION userFunc(value1 INT, value2 INT)
RETURNS INT
BEGIN
    RETURN value1 + value2;
END $$
DELIMITER ;

SELECT userFunc(100, 200);














DROP FUNCTION IF EXISTS getAgeFunc;
SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER $$
CREATE FUNCTION getAgeFunc(bYear INT)
RETURNS INT
BEGIN
    DECLARE age INT;
    SET age = YEAR(CURDATE()) - bYear;
    RETURN age;
END $$
DELIMITER ;

SELECT getAgeFunc(1979);