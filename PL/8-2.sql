DROP TRIGGER sum_trigger;

CREATE OR REPLACE TRIGGER sum_trigger
  BEFORE
    INSERT OR UPDATE ON employees
    FOR EACH ROW

DECLARE
  -- 변수를 선언할 때는 DECLARE문을 사용해야 한다 
  avg_sal NUMBER;
	
BEGIN
  SELECT ROUND(AVG(salary),3)
    INTO avg_sal
  FROM employees;

  DBMS_OUTPUT.PUT_LINE('급여 평균 : ' || avg_sal);
	
END; 
 /

-- DBMS_OUTPUT.PUT_LINE을 출력
SET SERVEROUTPUT ON ;

-- INSERT문을 실행해보자.
INSERT INTO employees(employee_id, last_name, hire_date, department_id, job_id, salary, email)
      VALUES(300, 'tiger', sysdate, 60, 'IT_PROG', 10000, 'tiger@naver.com');
-- INSERT문을 실행되기 전까지의 급여 평균이 출력된다. 
-- 급여 평균 : 6461.832

-- 전체 급여의 평균
SELECT ROUND(AVG(salary),3)
FROM employees;
-- 6461.832 --> 6494.593

-- 확인
SELECT * FROM EMPLOYEES;
ROLLBACK;
      