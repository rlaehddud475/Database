-- ifProc()
DROP PROCEDURE IF EXISTS ifProc;
DELIMITER $$
CREATE PROCEDURE ifProc()
BEGIN
    DECLARE var1 INT;
    SET var1 = 100;

    IF var1 = 100 THEN
        SELECT '100입니다.';
    ELSE
        SELECT '100이 아닙니다.';
    END IF;
END $$
DELIMITER ;
CALL ifProc();

-- ifProc2()
DROP PROCEDURE IF EXISTS ifProc2;
DELIMITER $$
CREATE PROCEDURE ifProc2()
BEGIN
    DECLARE hireDATE DATE;
    DECLARE curDATE DATE;
    DECLARE days INT;

    SELECT hire_date INTO hireDATE
      FROM employees.employees
     WHERE emp_no = 10001;

    SET curDATE = CURRENT_DATE();
    SET days = DATEDIFF(curDATE, hireDATE);

    IF (days/365) >= 5 THEN
        SELECT CONCAT('입사한 지 ', days, '일이나 지났습니다. 축하합니다!') AS '메시지';
    ELSE
        SELECT CONCAT('입사한 지 ', days, '일밖에 안 되었네요. 열심히 일하세요.') AS '메시지';
    END IF;
END $$
DELIMITER ;

CALL ifProc2();