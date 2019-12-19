DROP PROCEDURE Insert_Test;

CREATE OR REPLACE PROCEDURE Insert_Test
  ( v_empno  IN employees.employee_id%TYPE,
    v_ename  IN employees.last_name%TYPE,
    v_deptno IN employees.department_id%TYPE,
    v_jobno IN employees.job_id%TYPE,
    v_email IN employees.email%TYPE)
IS

BEGIN
  DBMS_OUTPUT.ENABLE;
    
  INSERT INTO employees(employee_id, last_name, hire_date, department_id, job_id, email)
    VALUES(v_empno, v_ename, sysdate, v_deptno, v_jobno, v_email);
  -- COMMIT;

  DBMS_OUTPUT.PUT_LINE( '�����ȣ : ' || v_empno );
  DBMS_OUTPUT.PUT_LINE( '����̸� : ' || v_ename );
  DBMS_OUTPUT.PUT_LINE( '����μ� : ' || v_deptno );
  DBMS_OUTPUT.PUT_LINE( 'Job : ' || v_jobno );
  DBMS_OUTPUT.PUT_LINE( '�̸��� : ' || v_email );
  DBMS_OUTPUT.PUT_LINE( '������ �Է� ���� ' );

END;
 /

-- DBMS_OUTPUT.PUT_LINE�� ����ϱ� ���� ���  
SET SERVEROUTPUT ON;  

-- ���� ���
EXECUTE Insert_Test(1000, 'ȫ', 20, 'AD_VP', 'abc@naver.com');

-- Ȯ��
SELECT * FROM EMPLOYEES
-- �ǵ�����
rollback; 


