DROP PROCEDURE Emp_Info;

CREATE OR REPLACE PROCEDURE Emp_Info
  -- IN Parameter 
  ( p_empno IN employees.employee_id%TYPE )

IS
  -- %TYPE �������� ���� ���� 
  v_empno employees.employee_id%TYPE; 
  v_ename employees.first_name%TYPE;
  v_sal   employees.salary%TYPE;

BEGIN
  DBMS_OUTPUT.ENABLE;
  /*
  ���ν������� ���۽����� ���۸� �ʱ�ȭ �Ѵ�.
  DBMS_OUTPUT.DISABLE;
  DBMS_OUTPUT.ENABLE;
  */

  -- %TYPE �������� ���� ��� 
  SELECT employee_id, first_name, salary
    INTO v_empno, v_ename, v_sal  
  FROM employees
  WHERE employee_id = p_empno ;

  -- ����� ��� 
  DBMS_OUTPUT.PUT_LINE( '�����ȣ : ' || v_empno ); 
  DBMS_OUTPUT.PUT_LINE( '����̸� : ' || v_ename );
  DBMS_OUTPUT.PUT_LINE( '����޿� : ' || v_sal );
END;
 /

-- DBMS_OUTPUT ������� ȭ�鿡 ��� �ϱ�����
SET SERVEROUTPUT ON;  
   
-- ���� ��� 
EXECUTE Emp_Info(100); 
