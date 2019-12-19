DROP PROCEDURE Update_Test;

CREATE OR REPLACE PROCEDURE Update_Test
  ( v_empno  IN   employees.employee_id%TYPE,    -- �޿��� ������ ����� ���
    v_rate   IN   NUMBER )           -- �޿��� �λ�/������
IS
  -- ���� �����͸� Ȯ���ϱ� ���� ���� ����
  v_emp  employees%ROWTYPE ;

BEGIN
  DBMS_OUTPUT.ENABLE;

  UPDATE employees
    SET salary = salary+(salary * (v_rate/100))   -- �޿��� ���
  WHERE employee_id = v_empno ;
  -- COMMIT;
		
  DBMS_OUTPUT.PUT_LINE('������ ���� ���� ');

  -- ������ ������ Ȯ���ϱ� ���� �˻� 
  SELECT employee_id, first_name, salary
    INTO v_emp.employee_id, v_emp.first_name, v_emp.salary
  FROM employees
  WHERE employee_id = v_empno;

  DBMS_OUTPUT.PUT_LINE( ' **** �� �� Ȯ �� **** ');
  DBMS_OUTPUT.PUT_LINE( '�����ȣ : ' || v_emp.employee_id );
  DBMS_OUTPUT.PUT_LINE( '����̸� : ' || v_emp.first_name );
  DBMS_OUTPUT.PUT_LINE( '����޿� : ' || v_emp.salary );

END;
 /
 
-- DBMS_OUTPUT.PUT_LINE�� ����ϱ� ���� ���
SET SERVEROUTPUT ON;  

-- 101�� ����� �޿��� 10% ���� �Ѵ�.
EXECUTE Update_Test(101, -10);

-- Ȯ��
SELECT * FROM EMPLOYEES;
-- �ǵ���
rollback;


 