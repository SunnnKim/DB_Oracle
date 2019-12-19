DROP TRIGGER sum_trigger;

CREATE OR REPLACE TRIGGER sum_trigger
  BEFORE
    INSERT OR UPDATE ON employees
    FOR EACH ROW

DECLARE
  -- ������ ������ ���� DECLARE���� ����ؾ� �Ѵ� 
  avg_sal NUMBER;
	
BEGIN
  SELECT ROUND(AVG(salary),3)
    INTO avg_sal
  FROM employees;

  DBMS_OUTPUT.PUT_LINE('�޿� ��� : ' || avg_sal);
	
END; 
 /

-- DBMS_OUTPUT.PUT_LINE�� ���
SET SERVEROUTPUT ON ;

-- INSERT���� �����غ���.
INSERT INTO employees(employee_id, last_name, hire_date, department_id, job_id, salary, email)
      VALUES(300, 'tiger', sysdate, 60, 'IT_PROG', 10000, 'tiger@naver.com');
-- INSERT���� ����Ǳ� �������� �޿� ����� ��µȴ�. 
-- �޿� ��� : 6461.832

-- ��ü �޿��� ���
SELECT ROUND(AVG(salary),3)
FROM employees;
-- 6461.832 --> 6494.593

-- Ȯ��
SELECT * FROM EMPLOYEES;
ROLLBACK;
      