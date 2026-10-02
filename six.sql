-- 데이터 삽입, 수정 삭제
use cookdb;
create table testtbl1
(id int ,
userName char(3),
age int);

insert into testtbl1 values(1, '뽀로로', 16);

insert into testtbl1 values(2, '크롱');
insert into testtbl1 (userName, age,id)values( '루피', 14,3);

create table testtbl2
(id int auto_increment primary key ,
userName char(3),
age int);

insert into testtbl2 values(null, '에디', 15);
insert into testtbl2 values(null, '포비', 12);
insert into testtbl2 values(null, '통통이', 11);

alter table testtbl2 auto_increment=100;
insert into testtbl2 values(null, '패티', 13);
insert into testtbl2 values(null, '크롱', 15);
select * from testtbl2;

create table testtbl3
(id int auto_increment primary key ,
userName char(3),
age int);
-- drop table testtbl3;

alter table testtbl3 auto_increment =1000;
set @@auto_increment_increment=3;
insert into testtbl3 values(null, '에디', 15);
insert into testtbl3 values(null, '포비', 12);
insert into testtbl3 values(null, '통통이', 11);

insert into testtbl3 values(null, '패티', 13);
insert into testtbl3 values(null, '크롱', 15);
-- insert into testtbl3 values(null, '우디', 20);
-- insert into testtbl3 values(null, '버즈', 18);
-- insert into testtbl3 values(null, '제시', 19);
select * from testtbl3;

create table testtbl4(id int, Fname varchar(50),Lname Varchar(50));
insert into testtbl4 select emp_no,first_name,last_name from employees.employees;

create table testtbl5(select  emp_no,first_name,last_name from employees.employees); -- 197페이지에서 실행해본 쿼리
select * from testtbl5 limit 3;
create table testtbl6(select  emp_no as id ,first_name as Fname,last_name as Lname from employees.employees);
select * from testtbl5 limit 3;

-- update문
select * from texttbl4 where Fname="Kyoichi";
update testtbl4
set Lname = "없음"
where Fname = "Kyoichi";
select * from testtbl4 where Fname="Kyoichi";

-- delete 문
select * from testtbl4 where Fname="Aamer";
Delete from testtbl4 where Fname='Aamer' limit 5;
select * from testtbl4 where Fname="Aamer";
drop table bigTBL1;
create table bigTBL1(select  * from employees.employees);
create table bigTBL2(select  * from employees.employees);
create table bigTBL3(select  * from employees.employees);
delete from bigTBL1;
Drop table bigTBL2;
Truncate table bigTBL3;
CREATE TABLE memberTBL (SELECT userID, userName, addr FROM userTBL LIMIT 3);

ALTER TABLE memberTBL
    ADD CONSTRAINT pk_memberTBL PRIMARY KEY (userID); -- 기본키 지정

SELECT * FROM memberTBL;
INSERT INTO memberTBL VALUES ('KHD', '강후덜', '미국'); -- 기본키 중복 임의
INSERT INTO memberTBL VALUES ('LSM', '이상민', '서울');
INSERT INTO memberTBL VALUES ('KSJ', '김성주', '경기');

SELECT * FROM memberTBL;
INSERT IGNORE INTO memberTBL VALUES ('KHD', '강후덜', '미국');
INSERT IGNORE INTO memberTBL VALUES ('LSM', '이상민', '서울');
INSERT IGNORE INTO memberTBL VALUES ('KSJ', '김성주', '경기');

SELECT * FROM memberTBL;
INSERT INTO memberTBL VALUES ('KHD', '강후덜', '미국')
    ON DUPLICATE KEY UPDATE userName='강후덜', addr='미국';
INSERT INTO memberTBL VALUES ('DJM', '동파룡', '일본')
    ON DUPLICATE KEY UPDATE userName='동파룡', addr='일본';

SELECT * FROM memberTBL;
-- 순위 함수

-- row_number()함수
SELECT ROW_NUMBER() OVER(ORDER BY height DESC) "키큰순위", userName, addr, height
FROM userTBL;
-- row_number()함수 동 순위는 이름으로 오름차순
SELECT ROW_NUMBER() OVER(ORDER BY height DESC, userName ASC) "키큰순위", userName, addr, height
FROM userTBL;
-- row_number()함수 partition by 지역과 열 번호 반환 지역으로 그룹을 묶음
SELECT addr, ROW_NUMBER() OVER(PARTITION BY addr ORDER BY height DESC) "지역별키큰순위", userName, height
FROM userTBL;
-- DENSE_RANK() 동 순위를 동일한 순위로 처리
SELECT DENSE_RANK() OVER(ORDER BY height DESC) "키큰순위", userName, addr, height
FROM userTBL;
-- RANK() 동 순위 동일한 등수로 처리하지만 그만큼 순위가 밀림
SELECT RANK() OVER(ORDER BY height DESC) "키큰순위", userName, addr, height
FROM userTBL;
--  NTILE() 2개 그룹 분리
SELECT NTILE(2) OVER(ORDER BY height DESC) "반번호", userName, addr, height
FROM userTBL;
--  NTILE() 4개 그룹으로 분리
SELECT NTILE(4) OVER(ORDER BY height DESC) "반번호", userName, addr, height
FROM userTBL;










-- 분석함수

-- Lead(열이름,다음행 위치, 다음행없을시 출력되는것)
SELECT userName, addr, height AS "키",
       height - (LEAD(height, 1, 0) OVER (ORDER BY height DESC)) AS "다음 사람과 키 차이"
FROM userTBL;

-- 지역별로 분리해서 지열별 최대 키 밎 차이를 구하는 쿼리
SELECT addr, userName, height AS "키",
       height - (FIRST_VALUE(height) OVER (PARTITION BY addr ORDER BY height DESC))
           AS "지역별 최대키와 차이"
FROM userTBL;
-- 누적 백분율 구하기
SELECT addr, userName, height AS "키",
       (CUME_DIST() OVER (PARTITION BY addr ORDER BY height DESC)) * 100 AS "누적인원 백분율%"
FROM userTBL;

-- 피벗 여러값을 여러 열로 변환하여 출력하고 필요하면 집계까지하는것(주로 엑셀에서하는 것)
CREATE TABLE pivotTest
(
    uName CHAR(3),
    season CHAR(2),
    amount INT
);

INSERT INTO pivotTest VALUES ('유재석', '겨울', 10);
INSERT INTO pivotTest VALUES ('강호동', '여름', 15);
INSERT INTO pivotTest VALUES ('유재석', '가을', 25);
INSERT INTO pivotTest VALUES ('유재석', '봄', 3);
INSERT INTO pivotTest VALUES ('유재석', '봄', 37);
INSERT INTO pivotTest VALUES ('강호동', '겨울', 40);
INSERT INTO pivotTest VALUES ('유재석', '여름', 14);
INSERT INTO pivotTest VALUES ('유재석', '겨울', 22);
INSERT INTO pivotTest VALUES ('강호동', '여름', 64);
select * from pivotTest;

SELECT uName, 
    SUM(CASE WHEN season='봄' THEN amount END) AS '봄', 
    SUM(CASE WHEN season='여름' THEN amount END) AS '여름', 
    SUM(CASE WHEN season='가을' THEN amount END) AS '가을', 
    SUM(CASE WHEN season='겨울' THEN amount END) AS '겨울' 
FROM pivotTest 
GROUP BY uName;




SELECT userid AS '사용자', SUM(price*amount) AS '총구매액'
FROM buyTBL GROUP BY userid;
WITH abc(userid, total)
AS
(SELECT userid, SUM(price*amount)
   FROM buyTBL GROUP BY userid)
SELECT * FROM abc ORDER BY total DESC;









