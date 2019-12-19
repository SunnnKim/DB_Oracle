DROP PROCEDURE RowType_Test;

CREATE OR REPLACE PROCEDURE RowType_Test
  ( p_empno IN employees.employee_id%TYPE )
IS
  -- %ROWTYPE 변수 선언, 
  -- emp테이블의 속성을 그대로 사용할 수 있다. 
  v_emp   employees%ROWTYPE ;

BEGIN
  DBMS_OUTPUT.ENABLE;

  -- %ROWTYPE 변수 사용 
  SELECT employee_id, first_name, hire_date
    INTO v_emp.employee_id, v_emp.first_name, v_emp.hire_date
  FROM employees
  WHERE employee_id = p_empno;

  DBMS_OUTPUT.PUT_LINE( '사원번호 : ' || v_emp.employee_id );
  DBMS_OUTPUT.PUT_LINE( '사원이름 : ' || v_emp.first_name );
  DBMS_OUTPUT.PUT_LINE( '입 사 일 : ' || v_emp.hire_date );
END; 
 / 

SET SERVEROUTPUT ON;  

EXECUTE RowType_Test(100);

