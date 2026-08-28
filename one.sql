USE shopdb; 
DROP TABLE IF EXISTS shopdb.producTBL;
create table shopdb.memberTBL(memberID varChar(8) not null Primary key, memberName varchar(8) not null, memberAddress varchar(20));
create table shopdb.productTBL(productName varChar(4) not null Primary key, cost int not null, makeDate date, company varchar(5), amount int not null);
insert into memberTBL Values('aa','애드워드','서울 은평구 증산동');
insert into memberTBL Values('gg','고든','경기 성남시 분당구');
insert into memberTBL Values('hh','핸리','인천 남구 주안동');
insert into memberTBL Values('tt','토마스','경기도 부천시 중동');
insert into productTBL Values('냉장고',10,'2019-07-01','삼성',17);
insert into productTBL Values('컴퓨터',10,'2020-03-01','LG',3);
insert into productTBL Values('모니터',5,'2021-09-01','롯데',22);
select * from productTBL;
USE employees;
select * from memberTBL;
create table indexTBL(first_name varchar(14), last_name varchar(16),hire_date date);
insert into indexTBL(select first_name,last_name,hire_date from employees.employees LIMIT 500);
select * from indexTBL where first_name='Mary';
create index idx_indexTBL_firstname On indexTBL(first_name);
select * from indexTBL where first_name='Mary';

DELIMITER //
create procedure myProc() 
begin 
	select * from memberTBL where memberName='토마스';
	select * from productTBL where productName='냉장고';
	select * from productTBL;
    select * from memberTBL;

END //
DELIMITER ;
call myProc;
Create table deletedMemberTBL
(
memberID char(8),
memberName char(5),
memberAddress char(20),
deletedDate date);

insert into memberTBL Values('Soccer','흥민','서울시 서대문구 북가좌동');
Delete from memberTBL WHERE memberName='흥민';
DELIMITER //
create trigger trg_deletedMemberTBL
AFTER DELETE
ON memberTBL
for EACH ROW
begin
insert into deletedMemberTBL
	values(OLD.memberID,OLD.memberName,OLD.memberAddress, CURDATE());
    end //
    DELIMITER ;
    
    select*from deleteMemberTBL;