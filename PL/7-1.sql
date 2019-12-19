DROP PROCEDURE PreException_test;

CREATE OR REPLACE PROCEDURE PreException_test
    (v_deptno IN employees.department_id%TYPE)    
IS
  v_emp employees%ROWTYPE;

BEGIN
  DBMS_OUTPUT.ENABLE;

  SELECT employee_id, first_name, department_id
    INTO v_emp.employee_id, v_emp.first_name, v_emp.department_id
  FROM employees
  WHERE department_id = v_deptno;

  DBMS_OUTPUT.PUT_LINE('��� : ' || v_emp.employee_id);
  DBMS_OUTPUT.PUT_LINE('�̸� : ' || v_emp.first_name);
  DBMS_OUTPUT.PUT_LINE('�μ���ȣ : ' || v_emp.department_id);

/*
  FOR  emp_list  IN
      (SELECT employee_id, first_name, department_id
       FROM employees
       WHERE department_id = v_deptno)   LOOP

      DBMS_OUTPUT.PUT_LINE('��� : ' || emp_list.employee_id);
      DBMS_OUTPUT.PUT_LINE('�̸� : ' || emp_list.first_name);
      DBMS_OUTPUT.PUT_LINE('�μ���ȣ : ' || emp_list.department_id);
  END LOOP;
*/
  EXCEPTION
    WHEN   DUP_VAL_ON_INDEX   THEN
      DBMS_OUTPUT.PUT_LINE('�����Ͱ� ���� �մϴ�.');
      DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX ���� �߻�');
    WHEN   TOO_MANY_ROWS   THEN  
      DBMS_OUTPUT.PUT_LINE('TOO_MANY_ROWS���� �߻�');
    WHEN   NO_DATA_FOUND   THEN  
      DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND���� �߻�');
    WHEN OTHERS THEN 
      DBMS_OUTPUT.PUT_LINE('��Ÿ ���� �߻�');
END;
 / 
 
 
 
SET SERVEROUTPUT ON ;  

-- ���ν��� ����
EXECUTE PreException_Test(20);
--TOO_MANY_ROWS���� �߻�

EXECUTE PreException_Test(1);
-- NO_DATA_FOUND���� �߻�


-- TOO_MANY_ROWS ������ �߻��ϴ� ����?
-- SELECT���� ����� 1�� �̻��� ���� �����ϱ� �����̴�..
-- TOO_MANY_ROWS�� ���ϱ� ���ؼ��� FOR���̳� LOOP������ SELECT���� ó���ؾ� �Ѵ�.


--�Ʒ��� ���� �����ϸ� ������ �߻����� �ʴ´�.

FOR  emp_list  IN
  (SELECT employee_id, first_name, department_id
  FROM employees
  WHERE department_id = v_deptno)   LOOP

  DBMS_OUTPUT.PUT_LINE('��� : ' || emp_list.employee_id);
  DBMS_OUTPUT.PUT_LINE('�̸� : ' || emp_list.first_name);
  DBMS_OUTPUT.PUT_LINE('�μ���ȣ : ' || emp_list.department_id);
END LOOP;
 
 
 
