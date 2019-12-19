DROP PROCEDURE Implicit_Cursor;

CREATE OR REPLACE PROCEDURE Implicit_Cursor
    (p_empno IN employees.employee_id%TYPE)
IS
  v_sal  employees.salary%TYPE;
  v_update_row NUMBER;

BEGIN
  SELECT salary
    INTO v_sal
  FROM employees
  WHERE employee_id = p_empno;

  -- 검색된 데이터가 있을경우
  IF  SQL%FOUND THEN     
    DBMS_OUTPUT.PUT_LINE('검색한 데이터가 존재합니다 : '||v_sal);
  END IF;

  -- 해당 사원의 급여 인상
  UPDATE employees
    SET salary = salary*1.1
  WHERE employee_id = p_empno;

  -- 수정한 데이터의 카운트를 변수에 저장
  v_update_row := SQL%ROWCOUNT;
  DBMS_OUTPUT.PUT_LINE('급여가 인상된 사원 수 : '|| v_update_row);
        
  EXCEPTION    
  WHEN   NO_DATA_FOUND  THEN  
  DBMS_OUTPUT.PUT_LINE(' 검색한 데이터가 없네요... ');
        
END;
 /

SET SERVEROUTPUT ON;  

-- 프로시저 실행
EXECUTE Implicit_Cursor(101);
-- 검색한 데이터가 존재합니다 : 17000
-- 급여가 인상된 사원 수 : 1

EXECUTE Implicit_Cursor(207);
-- 검색한 데이터가 없네요

SELECT * FROM EMPLOYEES;
ROLLBACK;
