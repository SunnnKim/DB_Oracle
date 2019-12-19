DROP PROCEDURE User_Exception;

CREATE OR REPLACE PROCEDURE User_Exception 
    (v_deptno IN employees.department_id%type ) 
IS
  -- ������ �̸��� ����
  user_define_error EXCEPTION;     -- STEP 1
  cnt NUMBER;

BEGIN
  DBMS_OUTPUT.ENABLE;   

  SELECT COUNT(employee_id) 
    INTO cnt
  FROM employees
  WHERE department_id = v_deptno;

  IF cnt < 5 THEN
    -- RAISE���� ����Ͽ� ���������� ���ܸ� �߻���Ų��
    RAISE user_define_error;         -- STEP 2
  END IF;

  EXCEPTION
  -- ���ܰ� �߻��� ��� �ش� ���ܸ� �����Ѵ�.
  WHEN user_define_error THEN      -- STEP 3
    RAISE_APPLICATION_ERROR(-20001, '�μ��� ����� ��� �ȵǳ׿�..');

END; 
 /
 
-- DBMS_OUTPUT.PUT_LINE�� ����ϱ� ���� ��� 
SET SERVEROUTPUT ON; 

-- 10�μ��� ����� 5���� ���� ������ ����� ���� ���ܰ� �߻�.
EXECUTE user_exception(10);
/*
BEGIN user_exception(10); END;
 *
1�࿡ ����:
ORA-20001: �μ��� ����� ��� �ȵǳ׿�..
ORA-06512: at "HR.USER_EXCEPTION", line 24
ORA-06512: at line 1
*/
-- 60�μ��� ������ �ϸ� ������ �߻����� �ʴ� �� �� �� �� �ִ�.
EXECUTE user_exception(60);
-- PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
 
