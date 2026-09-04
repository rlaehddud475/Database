-- 5장
/*use mysql;
select * from employees;

use employees;
select * from employees;
*/	
use shopdb;
select * from employees.employees;
use employees;
select first_name from employees;
select first_name, last_name, gender from employees;

show databases;
select first_name as 이름, last_name as 성, gender as 성별 from employees;