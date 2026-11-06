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