DROP PROCEDURE RowType_Test;

CREATE OR REPLACE PROCEDURE RowType_Test
  ( p_empno IN employees.employee_id%TYPE )
IS
  -- %ROWTYPE ���� ����, 
  -- emp���̺��� �Ӽ��� �״�� ����� �� �ִ�. 
  v_emp   employees%ROWTYPE ;

BEGIN
  DBMS_OUTPUT.ENABLE;

  -- %ROWTYPE ���� ��� 
  SELECT employee_id, first_name, hire_date
    INTO v_emp.employee_id, v_emp.first_name, v_emp.hire_date
  FROM employees
  WHERE employee_id = p_empno;

  DBMS_OUTPUT.PUT_LINE( '�����ȣ : ' || v_emp.employee_id );
  DBMS_OUTPUT.PUT_LINE( '����̸� : ' || v_emp.first_name );
  DBMS_OUTPUT.PUT_LINE( '�� �� �� : ' || v_emp.hire_date );
END; 
 / 

SET SERVEROUTPUT ON;  

EXECUTE RowType_Test(100);

