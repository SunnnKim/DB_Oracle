-- ���ν����� �̸��� update_sal�̴� 
DROP PROCEDURE update_sal;

-- update_sal ���ν����� ����� �Է¹޾� �޿��� �λ� �Ѵ�. 
-- ���ν����� ����ĥ ������ �׻� "/"�� ���� �Ѵ�.
CREATE OR REPLACE PROCEDURE update_sal (v_empno IN NUMBER)     
                                      /* IN  Parameter */          
IS      
BEGIN 
  UPDATE employees 
  SET salary = salary  * 1.1 
  WHERE employee_id = v_empno; 
  --COMMIT; 
END update_sal; 
/  
    
EXECUTE update_sal(100);
-- 100�� ����� �޿��� 10% �λ� �Ǿ����� Ȯ���� ���� �ٶ���.
SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;

rollback;