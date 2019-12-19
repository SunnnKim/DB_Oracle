DROP FUNCTION FC_update_sal;

CREATE OR REPLACE FUNCTION FC_update_sal(v_empno IN NUMBER)

  -- ���ϵǴ� ������ ������Ÿ���� �� �����ؾ� �մϴ�
  RETURN  NUMBER
IS    
    -- %type ������ ���(��Į�� ������ Ÿ�� ����)
    v_sal  employees.salary%type;
    
BEGIN
  SELECT salary * 1.1
    INTO v_sal
  FROM employees
  WHERE employee_id = v_empno;

  -- ���Ϲ��� �� �����ؾ� �մϴ�
  RETURN v_sal;
END;   
/


-- ������ ���
VAR salary NUMBER; 
-- EXECUTE ���� �̿��� �Լ��� �����մϴ�.
EXECUTE :salary := FC_update_sal(100); 
-- PRINT���� ����Ͽ� ���
PRINT salary;


-- SELECT���忡���� ��� �� �� �ִ�. 
SELECT first_name, FC_update_sal(100) 
FROM employees
where employee_id = 100;





 
 



