USE cookDB;
select * from userTBL;
select * from userTBL where userName="강호동";

select * from buyTBL;
select * from buyTBL where prodname="노트북";
select userID,userName from userTBL where birthYear>=1970 and height>=182;
select userID,userName from userTBL where birthYear>=1970 or height>=182;
select userID,userName,height,birthYear from userTBL where birthYear>=1970 or height>=182;
select userID,userName,height,birthYear from userTBL where height>=182 or birthYear>=1970;
select userName, height from userTBL where height>=180 and height<=182;
select userName, height from userTBL where height between 180 and 182;
select userName, addr from userTBL where addr='경남' or addr='충남' or addr='경북' ;
select userName, addr from userTBL where addr in('경남' ,'충남' ,'경북' );
select userName, height from userTBL where userName like '김%';
select userName, height from userTBL where userName like '_경규';

select userName, height from userTBL where height>177;
select userName, height from userTBL where height>(select height from userTBL where userName='김용만');
select userName, height from userTBL where height>=(select height from userTBL where addr='경기');
select userName, height from userTBL where height>=any(select height from userTBL where addr='경기');
select userName, height from userTBL where height=(select height from userTBL where addr='경기');
select userName, height from userTBL where height in (select height from userTBL where addr='경기');

-- order by
-- mdate 순서로 정렬
select userName,mDate From userTBL order by mDate desc;
-- 키는내림차순 이름 오름차순
select userName,height From userTBL order by height desc, userName asc;

select addr from userTBL;
-- addr 기준으로 오름차순 정렬
select addr from userTBL order by addr;
-- 중복 항목 제거 및 addr 기준으로 정렬
select Distinct addr from userTBL;

-- limit 절 사용 구문
use employees;
select emp_no,hire_date from employees order by hire_date asc;
-- emp_no,hire_date을 employees table에서 hire_date로 오름차순 정렬
select emp_no,hire_date from employees order by hire_date asc limit 5;
select emp_no,hire_date from employees order by hire_date asc limit 0,5;

select emp_no,hire_date from employees order by hire_date asc limit 3,5; -- 3,5 = 시작위치 개수
-- limit 개수 offset 위치
select emp_no,hire_date from employees order by hire_date asc limit 5 offset 5000;


use cookDB;
create table buytbl2 (select*from buytbl);
select * from buytbl2;

create table buytbl3 (select userID, prodName from buytbl);
select * from buytbl3;