DROP PROCEDURE NonPreException_Test;

CREATE OR REPLACE PROCEDURE NonPreException_Test 
IS
  not_null_test    EXCEPTION; -- STEP 1

  /* not_null_test�� ����� ���� �̸� 
  -1400 Error ó����ȣ�� ǥ�� Oracle7 Server Error ��ȣ */
  PRAGMA EXCEPTION_INIT(not_null_test, -1400);     -- STEP 2

BEGIN
  DBMS_OUTPUT.ENABLE;

  -- employee_id �Է����� �ʾƼ� NOT NULL ���� �߻�
  INSERT INTO employees(employee_id, last_name, hire_date, department_id, job_id, email)
      VALUES(300, 'tiger', sysdate, 270, 'IT_PROG', 'tiger@naver.com');
        
  EXCEPTION
    WHEN not_null_test THEN    -- STEP 3
  DBMS_OUTPUT.PUT_LINE('not null ���� �߻� ');

END;
 /

-- DBMS_OUTPUT.PUT_LINE�� ����ϱ� ���� ���
SET SERVEROUTPUT ON; 

-- ���� ��� 
EXECUTE NonPreException_Test;
-- not null ���� �߻�

rollback;
