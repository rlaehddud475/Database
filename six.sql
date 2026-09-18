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

alter table testtbl3 auto_increment =1000;
set @@auto_increment_increment=3;
insert into testtbl3 values(null, '우디', 20);
insert into testtbl3 values(null, '버즈', 18);
insert into testtbl3 values(null, '제시', 19);
select * from testtbl3;



