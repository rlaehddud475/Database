use cookdb;
SET @myVar1 = 5;
SET @myVar2 = 3;
SET @myVar3 = 4.25;
SET @myVar4 = 'MC 이름==> ';
SELECT @myVar1;
SELECT @myVar2 + @myVar3;
SELECT @myVar4 , userName FROM userTBL WHERE height > 180;

SET @myVar1 = 3;
PREPARE myQuery
    FROM 'SELECT userName, height FROM userTBL ORDER BY height LIMIT ?';
EXECUTE myQuery USING @myVar1;

USE cookDB;
SELECT AVG(amount) AS '평균 구매 개수' FROM buyTBL;

SELECT CAST(AVG(amount) AS SIGNED INTEGER) AS '평균 구매 개수' FROM buyTBL;
SELECT CONVERT(AVG(amount), SIGNED INTEGER) AS '평균 구매 개수' FROM buyTBL;

SELECT CAST('2027$12$12' AS DATE);
SELECT CAST('2027/12/12' AS DATE);
SELECT CAST('2027%12%12' AS DATE);
SELECT CAST('2027@12@12' AS DATE);
SELECT num, CONCAT(CAST(price AS CHAR(10)), 'X', CAST(amount AS CHAR(4)), '=') AS '단가X수량',
    price*amount AS '구매액'
FROM buyTBL;


SELECT '100' + '200'; -- 문자와 문자를 더함(정수로 변환한 후 처리)
SELECT CONCAT('100', '200'); -- 문자와 문자를 연결(문자열 그대로 처리)
SELECT CONCAT(100, '200'); -- 정수와 문자를 연결(정수를 문자로 변환하여 처리)
SELECT 1 > '3mega'; -- 정수인 3으로 변환한 후 비교
SELECT 4 > '3MEGA'; -- 정수인 3으로 변환한 후 비교
SELECT 0 = 'mega3'; -- 문자가 0으로 변환됨

-- 내장함수
SELECT IF(100 > 200, '참이다', '거짓이다');[cite: 5]
SELECT IFNULL(NULL, '널이군요'), IFNULL(100, '널이군요');[cite: 5]
SELECT NULLIF(100, 100), NULLIF(100, 200);[cite: 5]
SELECT CASE 10 
    WHEN 1 THEN '일' 
    WHEN 5 THEN '오' 
    WHEN 10 THEN '십' 
    ELSE '모름' 
END;
-- 문자열 함수
SELECT ASCII('A'), CHAR(65);
SELECT BIT_LENGTH('abc'), CHAR_LENGTH('abc'), LENGTH('abc');
SELECT BIT_LENGTH('가나다'), CHAR_LENGTH('가나다'), LENGTH('가나다');
SELECT CONCAT('대한', '민국', '2027', '01', '01');
SELECT CONCAT_WS('/', '2027', '01', '01');
SELECT ELT(2, '하나', '둘', '셋'), FIELD('둘', '하나', '둘', '셋'), FIND_IN_SET('둘', '하나,둘,셋'), INSTR('하나둘셋', '둘'), LOCATE('둘', '하나둘셋');
SELECT FORMAT(123456.123456, 4);
SELECT BIN(31), HEX(31), OCT(31);
SELECT INSERT('abcdefghi', 3, 4, '@@@@'), INSERT('abcdefghi', 3, 2, '@@@@');
SELECT LEFT('abcdefghi', 3), RIGHT('abcdefghi', 3);
SELECT LOWER('abcDEFGH'), UPPER('abcDEFGH');
SELECT LPAD('쿡북', 5, '##'), RPAD('쿡북', 5, '##');
SELECT LTRIM(' 쿡북'), RTRIM('쿡북 ');
SELECT TRIM(' 쿡북 '), TRIM(BOTH 'ㅋ' FROM 'ㅋㅋㅋ재미있어요.ㅋㅋㅋ');
SELECT REPEAT('쿡북', 3);
SELECT REPLACE('IT CookBook MySQL', '쿡북', 'CookBook');
SELECT REVERSE('MySQL');
SELECT CONCAT('IT', SPACE(10), 'CookBook MySQL');
SELECT SUBSTRING('대한민국만세', 3, 2);
SELECT SUBSTRING_INDEX('www.mysql.com', '.', 2), SUBSTRING_INDEX('www.mysql.com', '.', -2);

-- 수학함수 
SELECT ABS(-100);
SELECT CEILING(4.7), FLOOR(4.7), ROUND(4.7);
SELECT CONV('AA', 16, 2), CONV(100, 10, 8);
SELECT DEGREES(PI()), RADIANS(180);
SELECT MOD(157, 10), 157 % 10, 157 MOD 10;
SELECT POW(2, 3), SQRT(9);
SELECT RAND(), FLOOR(1 + (RAND() * (6-1)));
SELECT SIGN(100), SIGN(0), SIGN(-100.123);
SELECT TRUNCATE(12345.12345, 2), TRUNCATE(12345.12345, -2);

-- 날짜 시간 함수
SELECT ADDDATE('2027-01-01', INTERVAL 31 DAY), ADDDATE('2027-01-01', INTERVAL 1 MONTH);
SELECT SUBDATE('2027-01-01', INTERVAL 31 DAY), SUBDATE('2027-01-01', INTERVAL 1 MONTH);
SELECT ADDTIME('2027-01-01 23:59:59', '1:1:1'), ADDTIME('15:00:00', '2:10:10');
SELECT SUBTIME('2027-01-01 23:59:59', '1:1:1'), SUBTIME('15:00:00', '2:10:10');
SELECT YEAR(CURDATE()), MONTH(CURRENT_DATE()), DAYOFMONTH(CURRENT_DATE());
SELECT HOUR(CURTIME()), MINUTE(CURRENT_TIME()), SECOND(CURRENT_TIME()), MICROSECOND(CURRENT_TIME());
SELECT DATE(NOW()), TIME(NOW());
SELECT DATEDIFF('2030-01-01', NOW()), TIMEDIFF('23:23:59', '12:11:10');
SELECT DAYOFWEEK(CURDATE()), MONTHNAME(CURDATE()), DAYOFYEAR(CURDATE());
SELECT LAST_DAY('2027-02-01');
SELECT MAKEDATE(2027, 32);
SELECT MAKETIME(12, 11, 10);
SELECT PERIOD_ADD(202701, 11), PERIOD_DIFF(202701, 202512);
SELECT QUARTER('2027-07-07');
SELECT TIME_TO_SEC('12:11:10');
SELECT CURDATE(), CURTIME(), NOW(), SYSDATE();

-- 시스템 정보 함수 
SELECT USER(), DATABASE();
USE cookDB;
SELECT * FROM userTBL;
SELECT FOUND_ROWS();
USE cookDB;
UPDATE buyTBL SET price=price*2;
SELECT ROW_COUNT();
SELECT SLEEP(5);
SELECT '5초 후에 이게 보여요';
SELECT VERSION();

-- json
set @json='{"usertbl":[
{"name":"강호동","height":182},
{"name":"이휘재","height":180},
{"name":"남희석","height":180},
{"name":"박수홍","height":183}]}';

select json_Valid(@json) as json_valid;
SELECT JSON_SEARCH(@json, 'one', '남희석') AS JSON_SEARCH;
SELECT JSON_EXTRACT(@json, '$.userTBL[2].name') AS JSON_EXTRACT;
SELECT JSON_INSERT(@json, '$.userTBL[0].mDate', '2019-09-09') AS JSON_INSERT;
SELECT JSON_REPLACE(@json, '$.userTBL[0].name', '토마스') AS JSON_REPLACE;
SELECT JSON_REMOVE(@json, '$.userTBL[0]') AS JSON_REMOVE;