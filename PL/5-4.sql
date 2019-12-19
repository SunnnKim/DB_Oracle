DROP PROCEDURE Dept_Search;

CREATE OR REPLACE PROCEDURE Dept_Search
    (p_empno IN employees.employee_id%TYPE )
IS
  v_deptno employees.department_id%type;

BEGIN
  DBMS_OUTPUT.ENABLE;

  SELECT department_id
    INTO v_deptno
  FROM employees
  WHERE employee_id = p_empno;

  IF v_deptno = 30 THEN
    DBMS_OUTPUT.PUT_LINE( ' Purchasing 부서 사원입니다. ' );
  ELSIF v_deptno = 40 THEN
    DBMS_OUTPUT.PUT_LINE( ' Human Resources 부서 사원입니다. ' );
  ELSIF v_deptno = 50 THEN
    DBMS_OUTPUT.PUT_LINE( ' Shipping 부서 사원입니다. ' );
  ELSIF v_deptno = 60 THEN
    DBMS_OUTPUT.PUT_LINE( ' IT 부서 사원입니다. ' );
  ELSE
    DBMS_OUTPUT.PUT_LINE( ' 4부서외에 다른 부서입니다... ' );
  END IF;

  EXCEPTION    
  WHEN NO_DATA_FOUND  THEN  
  DBMS_OUTPUT.PUT_LINE(' 부서가 없습니다... ');

END;
 /


SET SERVEROUTPUT ON ; 

-- 프로시저 실행
EXECUTE Dept_Search(178);
-- 4부서외에 다른 부서입니다...

EXECUTE Dept_Search(114);
-- Purchasing 부서 사원입니다.

EXECUTE Dept_Search(207);
-- 부서가 없네요...

