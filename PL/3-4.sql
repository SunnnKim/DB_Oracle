DROP PROCEDURE Record_Test;

CREATE OR REPLACE PROCEDURE Record_Test
  ( p_empno IN employees.employee_id%TYPE )
IS
  -- �ϳ��� ���ڵ��� �������� ����Ÿ�� ���� 
  TYPE emp_record IS RECORD
    (v_empno    NUMBER,
    v_ename    VARCHAR2(30),
    v_hiredate  DATE );

  emp_rec   emp_record;

BEGIN
  DBMS_OUTPUT.ENABLE;

  -- ���ڵ��� ��� 
  SELECT employee_id, first_name, hire_date
    INTO emp_rec.v_empno, emp_rec.v_ename, emp_rec.v_hiredate
  FROM employees
  WHERE employee_id = p_empno;

  DBMS_OUTPUT.PUT_LINE( '�����ȣ : ' || emp_rec.v_empno );
  DBMS_OUTPUT.PUT_LINE( '����̸� : ' || emp_rec.v_ename );
  DBMS_OUTPUT.PUT_LINE( '�� �� �� : ' || emp_rec.v_hiredate);

END;
 / 

SET SERVEROUTPUT ON;  

EXECUTE Record_Test(101);


