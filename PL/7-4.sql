DROP PROCEDURE Errcode_Exception;

CREATE OR REPLACE PROCEDURE Errcode_Exception 
    (v_deptno IN employees.department_id%type ) 
IS
  v_emp employees%ROWTYPE ;  

BEGIN  
  DBMS_OUTPUT.ENABLE;

  -- ERROR�߻� for���� ������ ��
  SELECT * 
    INTO v_emp
  FROM employees
  WHERE department_id = v_deptno;
      
  DBMS_OUTPUT.PUT_LINE('��� : ' || v_emp.employee_id);    
  DBMS_OUTPUT.PUT_LINE('�̸� : ' || v_emp.first_name);    
          
  EXCEPTION
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('���� �ڵ� : ' || TO_CHAR(SQLCODE));
  DBMS_OUTPUT.PUT_LINE('���� �޽��� : ' || SQLERRM);

END;  
 /

-- DBMS_OUTPUT.PUT_LINE�� ����ϱ� ���� ���
SET SERVEROUTPUT ON; 

-- ���࿹��
EXECUTE Errcode_Exception(30);
--���� �ڵ� : -1422
--���� �޽��� : ORA-01422: ���� ������ �䱸�� �ͺ��� ���� ���� ���� �����մϴ�


