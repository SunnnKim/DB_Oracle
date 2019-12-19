DROP PROCEDURE ParamCursor_Test;

CREATE OR REPLACE PROCEDURE ParamCursor_Test
    (param_deptno employees.department_id%TYPE) 
IS
  v_ename employees.first_name%TYPE;

  -- Parameter�� �ִ� Ŀ���� ����
  CURSOR emp_list(v_deptno employees.department_id%TYPE) IS
    SELECT first_name 
    FROM employees
    WHERE department_id = v_deptno;

BEGIN
  DBMS_OUTPUT.ENABLE;

  DBMS_OUTPUT.PUT_LINE(' ****** �Է��� �μ��� �ش��ϴ� ����� ****** ');              
      
  -- Parameter������ ���� ����(OPEN�� �� ���� �����Ѵ�)
  FOR emplst IN emp_list(param_deptno) LOOP    
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || emplst.first_name);
  END LOOP;    

  EXCEPTION  
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('ERR MESSAGE : ' || SQLERRM);
END; 
 /
 
SET SERVEROUTPUT ON; 

-- ���� ���
EXECUTE ParamCursor_Test(60);
/*
 ****** �Է��� �μ��� �ش��ϴ� ����� ****** 
�̸� : Alexander
�̸� : Bruce
�̸� : David
�̸� : Valli
�̸� : Diana
*/