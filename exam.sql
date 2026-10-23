-- 지역별로 가입일에 따른 순위를 알려주는 쿼리
select addr, row_number() over(partition by addr order by mDate asc) "지역별로 가입일 따를 순위", userName,mDate from usertbl;
select addr, dense_rank() over(partition by addr order by mDate asc) "지역별로 가입일 따를 순위", userName,mDate from usertbl;

-- cookdb의 회원 테이블 에서 가입일이 빠른순서대로 정렬한후 다음 사람과의 가입일자 차이를 알려주는 쿼리
select userName, addr, mDate as "가입일",
datediff((lead(mDate,1,0) over (order By mDate)),mDate)
as '다른 사람과 가입일자 차이'
from usertbl;
-- 3. 왼쪽 테이블을 오른쪽 테이블이 되도록 피벗 테이블의 쿼리를 작성하시오.
SELECT season,
       SUM(CASE WHEN uName='유재석' THEN amount END) AS '유재석',
       SUM(CASE WHEN uName='강호동' THEN amount END) AS '강호동'
FROM pivotTest
GROUP BY season;

/* 4. CTE를 이용하여 총구매액이 많은 사용자 순으로 정렬하는 쿼리를 작성하시오.
      단, CTE테이블이름은 myTBL로 하시오. */
WITH myTBL(uid, total)
AS
(SELECT userid, SUM(price*amount) FROM buyTBL GROUP BY userid)
SELECT uid, total FROM myTBL ORDER BY total DESC;