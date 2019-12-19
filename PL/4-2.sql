DROP PROCEDURE Update_Test;

CREATE OR REPLACE PROCEDURE Update_Test
  ( v_empno  IN   employees.employee_id%TYPE,    -- 급여를 수정한 사원의 사번
    v_rate   IN   NUMBER )           -- 급여의 인상/인하율
IS
  -- 수정 데이터를 확인하기 위한 변수 선언
  v_emp  employees%ROWTYPE ;

BEGIN
  DBMS_OUTPUT.ENABLE;

  UPDATE employees
    SET salary = salary+(salary * (v_rate/100))   -- 급여를 계산
  WHERE employee_id = v_empno ;
  -- COMMIT;
		
  DBMS_OUTPUT.PUT_LINE('데이터 수정 성공 ');

  -- 수정된 데이터 확인하기 위해 검색 
  SELECT employee_id, first_name, salary
    INTO v_emp.employee_id, v_emp.first_name, v_emp.salary
  FROM employees
  WHERE employee_id = v_empno;

  DBMS_OUTPUT.PUT_LINE( ' **** 수 정 확 인 **** ');
  DBMS_OUTPUT.PUT_LINE( '사원번호 : ' || v_emp.employee_id );
  DBMS_OUTPUT.PUT_LINE( '사원이름 : ' || v_emp.first_name );
  DBMS_OUTPUT.PUT_LINE( '사원급여 : ' || v_emp.salary );

END;
 /
 
-- DBMS_OUTPUT.PUT_LINE을 출력하기 위해 사용
SET SERVEROUTPUT ON;  

-- 101번 사원의 급여를 10% 인하 한다.
EXECUTE Update_Test(101, -10);

-- 확인
SELECT * FROM EMPLOYEES;
-- 되돌림
rollback;


 