DROP PROCEDURE AttrCursor_Test;

CREATE OR REPLACE PROCEDURE AttrCursor_Test   
IS
  v_empno employees.department_id%TYPE;
  v_ename employees.first_name%TYPE;
  v_sal employees.salary%TYPE;  

  CURSOR emp_list IS
    SELECT department_id, first_name, salary
    FROM employees;    
 
BEGIN
  DBMS_OUTPUT.ENABLE;

  OPEN emp_list;   

  LOOP
    FETCH emp_list INTO v_empno, v_ename, v_sal;

    -- �����͸� ã�� ���ϸ� ���� �����ϴ�
    EXIT WHEN emp_list%NOTFOUND;
  END LOOP;    

  DBMS_OUTPUT.PUT_LINE('��ü������ �� ' || emp_list%ROWCOUNT);
    
  CLOSE emp_list;
    
  EXCEPTION
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('ERR MESSAGE : ' || SQLERRM);
        
END; 
 / 
 
SET SERVEROUTPUT ON ; 

-- ���� ���
EXECUTE AttrCursor_Test;
-- ��ü������ �� 107
 
