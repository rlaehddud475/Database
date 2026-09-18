/* 교재 197 CREATE TABLE .... SELECT */
-- ------------------------------
-- 구매테이블(buyTBL)의 모든 정보를 buyTBL2로 복사하고, 결과를 확인하시오.

create table buytbl2 (select*from buytbl);
select * from buytbl2;
-- 구매테이블(buyTBL)에서 아이디(userID)와 물품(prodName)만 가져와 buyTBL3에 복사하고, 결과를 확인하시오.
create table buytbl3 (select userID, prodName from buytbl);
select * from buytbl3;

/* 교재 199 GROUP BY .... HAVING문 */
-- ------------------------------
-- 구매테이블(buyTBL)에서 아이디(userID)마다 구매한 물품(prodName)의 개수(amount)를 조회하는 쿼리문을 작성하시오.
select userID, prodName, amount from buytbl order by userID;
select userID, prodName, sum(amount) from buytbl group by userID;
select userID, prodName, sum(amount) from buytbl group by userID;
-- 정확히나오는 쿼리
select userID, SUM(amount) from buytbl group by userID;
-- 아이디(userID)별로 구매 개수를 합치고 아이디(userID)별로 개수(amount)나타내시오.
-- 단, 조건은 GROUP BY절을 사용하고 집계함수 SUM()을 사용하시오.
select userID, SUM(amount) from buytbl group by userID;

-- '사용자 아이디', '총 구매 개수' 별칭을 사용하여 나타내시오.
select userID as '사용자 아이디' , Sum(amount) as '총 구매 개수' from buytbl group by userID;
-- 아이디(userID)별로 총 구매액을 나타내시오.
-- 구매액은 가격(price) * 수량(amount), 집계함수 SUM()을 사용하시오.
select userID , Sum(price*amount) as '총 구매액' from buytbl group by userID order by Sum(price*amount) desc;

/* 교재 201 집계함수 */
-- ------------------------------
-- 구매테이블(buyTBL)의 평균 구매 개수를 나타내시오.
-- 단, 평균 구매 개수라는 별칭을 사용하시오.

select avg(amount) as '평균 구매 개수' from buytbl group by userID;
-- 구매테이블(buyTBL)에서 회원별로 평균 구매 개수를 나타내시오.
-- 조건, GROUP BY절 사용
select userID  , avg(amount) as '평균 구매 개수' from buytbl group by userID;

-- 키가 가장 큰 회원과 키가 가장 작은 회원의 이름과 키를 나타내시오.
select userName, min(height), max(height) from usertbl group by userName;

select userName, height 
from usertbl where height=(select max(height)from usertbl) or height=(select min(height)from usertbl);

-- 위의 쿼리 문제를 GROUP BY절을 활용하여 수정하시오.
select userName, min(height), max(height) from usertbl group by userName;

-- 위의 쿼리 결과를 서브쿼리를 조합하여 수정하시오.
SELECT userName, height 
FROM usertbl 
GROUP BY userName, height 
HAVING height = (SELECT MAX(height) FROM usertbl) 
   OR height = (SELECT MIN(height) FROM usertbl);

-- 회원테이블(userTBL)에서 휴대폰이 있는 회원의 수를 조회하시오.
-- 별칭 '휴대혼이 있는 사용자'를 사용하시오. 
SELECT 
    COUNT(*) AS "휴대폰이 있는 사용자"
FROM 
    userTBL;
SELECT 
    COUNT(mobile) AS "휴대폰이 있는 사용자"
FROM 
    userTBL;
/* 교재 203 Having절 */
-- ------------------------------
-- 구매테이블(buyTBL)에서 아이디(userID)별로 총 구매액을 나타내시오.
select userID as "사용자", sum(price*amount) as "총구매액"
	from buytbl
    group by userID;


-- 총 구매액이 1000이상인 조건에 해당하는 회원만 조회하시오.

select userID as "사용자", sum(price*amount) as "총구매액"
	from buytbl
    where sum(price*amount)>1000
    group by userID;


-- 위의 쿼리 문제를 Having절을 사용하여 수정하시오.

select userID as "사용자", sum(price*amount) as "총구매액"
	from buytbl
    group by userID
	having sum(price*amount)>1000;



-- 총 구매액이 적은 회원 순서로 정렬하여 나타내시오.
select userID as "사용자", sum(price*amount) as "총구매액"
	from buytbl
    group by userID
	having sum(price*amount)>1000
    order by sum(price*amount);





/* 교재 204 WITH ROLLUP절 */
-- ------------------------------
-- 구매테이블(buyTBL)에서 GROUP BY절과 WITH ROLLUP절을 이용하여 제품 그룹별로 소합계와 총합을 나타내시오.
-- 기본키를 넣어 각 항목이 보이도록 작성하시오.

SELECT num, groupName, sum(price * amount) AS "비용"
from buytbl
group by groupName, num 
with rollup;


-- 구매테이블(buyTBL)에서 GROUP BY절과 WITH ROLLUP절을 이용하여 제품 그룹별로 소합계와 총합을 나타내시오.
-- 기본키를 넣지 않고 작성해 보시오.ALTER

SELECT groupName, sum(price * amount) AS "비용"
from buytbl
group by groupName 
with rollup;
