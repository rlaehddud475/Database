/* 실습 8-1 3개의 테이블 내부 조인하기 */
USE cookDB;
-- 1. 학생테이블, 동아리 테이블, 학생_동아리 테이블을 생성하시오.
Create table stdTBL(stdName varchar(10) not null primary key,
addr char(4) not null);
create table clubTBL(clubName varchar(10) not null primary key,
roomNo char(4) not null);
create table stdclubTBL(num int auto_increment  not null primary key, 
stdName varchar(10) not null,
clubName varchar(10) not null,
foreign key(stdName)references stdTBL(stdName),
foreign key(clubName)references clubTBL(clubName));

-- 2. 학생데이터, 동아리 데이터, 학생_동아리 데이터 입력하시오.
insert into stdTBL values('강호동','경북'),('김제동','경남'),('김용만','서울'),('이휘재','경기'),('박수홍','서울');
insert into clubTBL values('수영','101호'),('바둑','102호'),('축구','103호'),('봉사','104호');
insert into stdclubTBL values(null,'강호동','바둑'),(null,'강호동','축구'),(null,'김용만','축구'),(null,'이휘재','축구'),(null,'이휘재','봉사'),(null,'박수홍','봉사');
-- 3. 학생데이터, 동아리 데이터, 학생_동아리 데이터를 나타내시오. 
select * from stdTBL;
select * from clubTBL;
select * from stdclubTBL;
-- 4. 학생_동아리 테이블과 학생테이블의 일대다 관계를 내부 조인하고, 
--    학생_동아리 테이블과 동아리 테이블의 일대다 관계를 내부 조인하시오.
select S.stdName, S.addr, C.clubName, C.roomNo from stdTBL S 
inner Join stdclubTBL sc
on S.stdName=sc.stdName
inner join clubTBL C
on sc.clubName=C.clubName
order by S.stdName;

-- 5. 동아리를 기준으로 가입한 학생의 목록을 출력하시오.
select C.clubName, C.roomNo,S.stdName, S.addr from stdTBL S 
inner Join stdclubTBL sc
on S.stdName=sc.stdName
inner join clubTBL C
on sc.clubName=C.clubName
order by C.clubName;
/* 외부조인 */
-- 6. 전체 회원의 구매 기록을 출력하되, 구매 기록이 없는 회원도 출력하시오.
--     Left outer join을 이용하시오.
select U.userID,U.userName, B.prodName, U.addr, concat(U.mobile1,U.mobile2) as '연락처'
from usertbl U
Left outer join buytbl B
on U.userID=B.userID
order by U.userID;

-- 7. 전체 회원의 구매 기록을 출력하되, 구매 기록이 없는 회원도 출력하시오.
--     right outer join을 이용하시오.
select U.userID,U.userName, B.prodName, U.addr, concat(U.mobile1,U.mobile2) as '연락처'
from buytbl B 
right outer join usertbl U
on U.userID=B.userID
order by U.userID;
-- 8. 물건을 한번도 구매한 적이 없는 회원의 목록을 출력하시오.
select U.userID,U.userName, B.prodName, U.addr, concat(U.mobile1,U.mobile2) as '연락처'
from usertbl U
Left outer join buytbl B
on U.userID=B.userID
Where B.prodName is null
order by U.userID;
/* 실습 8-2 왼쪽/오른쪽 외부 조인하기 */
-- 9. 외부 조인을 수행하여 동아리게 가입하지 않은 학생도 출력하시오.
select S.stdName, S.addr, C.clubName, C.roomNo from stdTBL S 
left outer Join stdclubTBL sc
on S.stdName=sc.stdName
left outer join clubTBL C
on sc.clubName=C.clubName
order by S.stdName;
-- 10. 동아리를 기준으로 가입 학생을 출력하되, 가입 학생이 한명도 없는 동아리도 출력하시오.
select C.clubName, C.roomNo,S.stdName, S.addr from stdTBL S 
left outer Join stdclubTBL sc
on S.stdName=sc.stdName
right outer join clubTBL C
on sc.clubName=C.clubName
order by C.clubName;
-- 11. 동아리에 가입하지 않는 학생도 출력하고, 학생이 한명도 없는 동아리도 출력하시오.
select S.stdName, S.addr, C.clubName, C.roomNo from stdTBL S 
left outer Join stdclubTBL sc
on S.stdName=sc.stdName
left outer join clubTBL C
on sc.clubName=C.clubName
union
select C.clubName, C.roomNo,S.stdName, S.addr from stdTBL S 
left outer Join stdclubTBL sc
on S.stdName=sc.stdName
right outer join clubTBL C
on sc.clubName=C.clubName;
-- 12. 회원테이블과 구매 테이블을 상호조인하시오.
select * from buytbl cross join usertbl;
/* 실습 8-3 자체 조인 */

USE cookDB;
CREATE TABLE empTBL(emp CHAR(3), manager CHAR(3), empTel VARCHAR(8));

INSERT INTO empTBL VALUES ('나사장', NULL, '0000');
INSERT INTO empTBL VALUES ('김재무', '나사장', '2222');
INSERT INTO empTBL VALUES ('김부장', '김재무', '2222-1');
INSERT INTO empTBL VALUES ('이부장', '김재무', '2222-2');
INSERT INTO empTBL VALUES ('우대리', '이부장', '2222-2-1');
INSERT INTO empTBL VALUES ('지사원', '이부장', '2222-2-2');
INSERT INTO empTBL VALUES ('이영업', '나사장', '1111');
INSERT INTO empTBL VALUES ('한과장', '이영업', '1111-1');
INSERT INTO empTBL VALUES ('최정보', '나사장', '3333');
INSERT INTO empTBL VALUES ('윤차장', '최정보', '3333-1');
INSERT INTO empTBL VALUES ('이주임', '윤차장', '3333-1-1');

SELECT * FROM empTBL;

-- 13. 우대리 상관의 구내 번호를 나타내시오.
select A.emp as '부하직원', B.emp as '직속상관', B.empTel As'직속상관연락처'
from empTBL A
inner join empTBL B
on A.manager=B.emp
where A.emp='우대리';
-- 14. cookDB의 사용자를 모두 출력하되 전화번호가 없는 사람을 제외하시오.
SELECT userName, CONCAT(mobile1, '-', mobile2) AS '전화번호' FROM userTBL
WHERE userName NOT IN (SELECT userName FROM userTBL WHERE mobile1 IS NULL);
-- 15. 전화번호가 없는 사람만 조회하시오.
SELECT userName, CONCAT(mobile1, mobile2) AS '전화번호' FROM userTBL
WHERE userName IN (SELECT userName FROM userTBL WHERE mobile1 IS NULL);
