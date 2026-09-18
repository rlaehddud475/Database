show Databases;
 USE employees;
 show TABLES;
DESC employees;
select first_name,gender FROM employees LIMIT 10;
Create database cookDB;
USE cookDB;
create table userTBL(
userID char(8) not null primary key,
userName varchar(10) not null,
birthYear int not null,
addr char(2) not null,
mobile1 char(3),
mobile2 char(8),
height smallint,
mDate date);
create table buyTBL(
num Int auto_increment not null primary key,
userID char(8) not null,
prodName char(6) not null,
groupName char(4),
price int not null,
amount smallint not null,
foreign key(userID)references userTBL(userID)
);
insert into userTBL VALUES ('YJS','유재석',1972,'서울','010','11111111',178,'2008-8-8');
insert into userTBL VALUES ('KHD','강호동',1970,'경북','011','22222222',182,'2007-7-7');
insert into userTBL VALUES ('KKJ','김국진',1965,'서울','019','33333333',171,'2009-9-9');
insert into userTBL VALUES ('KYM','김용만',1967,'서울','010','44444444',177,'2015-5-5');
insert into userTBL VALUES ('KJD','김제동',1974,'경남',null,null,173,'2013-3-3');
insert into userTBL VALUES ('NHS','남희석',1971,'충남','016','66666666',180,'2017-4-4');
insert into userTBL VALUES ('SDY','신동엽',1971,'경기',null,null,176,'2008-10-10');
insert into userTBL VALUES ('LHJ','이휘재',1972,'경기','011','88888888',180,'2006-4-4');
insert into userTBL VALUES ('LKK','이경규',1960,'경남','018','99999999',170,'2004-12-12');
insert into userTBL VALUES ('PSH','박수홍',1970,'서울','010','00000000',183,'2012-5-5');

SELECT * FROM userTBL;

INSERT INTO buyTBL valueS(NULL,'KHD','운동화',NULL,30,2);
INSERT INTO buyTBL valueS(NULL,'KHD','노트북','전자',1000,1);
INSERT INTO buyTBL valueS(NULL,'KYM','모니터','전자',200,1);
INSERT INTO buyTBL valueS(NULL,'PSH','모니터','전자',200,5);
INSERT INTO buyTBL valueS(NULL,'KHD','청바지','의류',50,3);
INSERT INTO buyTBL valueS(NULL,'PSH','메모리','전자',80,10);
INSERT INTO buyTBL valueS(NULL,'KJD','책','서적',15,5);
INSERT INTO buyTBL valueS(NULL,'LHJ','책','서적',15,2);
INSERT INTO buyTBL valueS(NULL,'LHJ','청바지','의류',50,1);
INSERT INTO buyTBL valueS(NULL,'PSH','운동화',NULL,30,2);
INSERT INTO buyTBL valueS(NULL,'LHJ','책','서적',15,1);
INSERT INTO buyTBL valueS(NULL,'PSH','운동화',NULL,30,2);

SELECT * FROM buyTBL;