/* 1. cookDB의 회원테이블(userTBL)에서 국번(mobile1)을 조회하는 SQL을 작성하시오. 단, 중복을 없애고 내림차순으로 정렬하여 출력하시오.
-- 예시, 019, 018, ……
*/
select distinct mobile1 from usertbl order by mobile1 desc;

/* 2. cookDB의 회원테이블(userTBL)에서 이름(username)을 조회하는 SQL을 작성하시오. 
단, 가입일이 빠른 순서로 정렬하고 세번째 가입한 사람부터 2명만 출력하시오.
예시, 강호동, 유재석, 
*/
select userName from usertbl order by mdate limit 2,2;

/* 3. cookDB의 구매 테이블(buyTBL)에서 다음과 같이 출력되도록 SQL문을 작성하시오. */
select userID as '시용자ID' ,sum(amount) as "총구매개수" from buytbl group by userID order by userID desc;
/* 4. cookDB의 구매 테이블(buyTBL)에서 다음과 같이 평균 구매 개수가         
   2 이상인 사용자만 출력하도록 SQL 문을 작성하시오. */
select userID as '시용자ID' , avg(amount) as '평균구매개수' from buytbl  group by userID having avg(amount)>=2 order by avg(amount) desc;



