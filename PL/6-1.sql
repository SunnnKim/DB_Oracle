DROP PROCEDURE Implicit_Cursor;

CREATE OR REPLACE PROCEDURE Implicit_Cursor
    (p_empno IN employees.employee_id%TYPE)
IS
  v_sal  employees.salary%TYPE;
  v_update_row NUMBER;

BEGIN
  SELECT salary
    INTO v_sal
  FROM employees
  WHERE employee_id = p_empno;

  -- �˻��� �����Ͱ� �������
  IF  SQL%FOUND THEN     
    DBMS_OUTPUT.PUT_LINE('�˻��� �����Ͱ� �����մϴ� : '||v_sal);
  END IF;

  -- �ش� ����� �޿� �λ�
  UPDATE employees
    SET salary = salary*1.1
  WHERE employee_id = p_empno;

  -- ������ �������� ī��Ʈ�� ������ ����
  v_update_row := SQL%ROWCOUNT;
  DBMS_OUTPUT.PUT_LINE('�޿��� �λ�� ��� �� : '|| v_update_row);
        
  EXCEPTION    
  WHEN   NO_DATA_FOUND  THEN  
  DBMS_OUTPUT.PUT_LINE(' �˻��� �����Ͱ� ���׿�... ');
        
END;
 /

SET SERVEROUTPUT ON;  

-- ���ν��� ����
EXECUTE Implicit_Cursor(101);
-- �˻��� �����Ͱ� �����մϴ� : 17000
-- �޿��� �λ�� ��� �� : 1

EXECUTE Implicit_Cursor(207);
-- �˻��� �����Ͱ� ���׿�

SELECT * FROM EMPLOYEES;
ROLLBACK;
