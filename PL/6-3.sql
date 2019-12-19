DROP PROCEDURE ForCursor_Test;

CREATE OR REPLACE PROCEDURE ForCursor_Test
IS
  -- Cursor ����
  CURSOR dept_sum IS
    SELECT b.department_name, COUNT(a.employee_id) cnt, SUM(a.salary) sal
    FROM employees a, departments b
    WHERE a.department_id = b.department_id
    GROUP BY b.department_name;

BEGIN
  -- Cursor�� FOR������ �����Ų��
  FOR emp_list IN dept_sum LOOP
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || emp_list.department_name);
    DBMS_OUTPUT.PUT_LINE('����� : ' || emp_list.cnt);
    DBMS_OUTPUT.PUT_LINE('�޿��հ� : ' || emp_list.sal);
  END LOOP;

  EXCEPTION
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(SQLERRM||'���� �߻� ');

END;
 /
 
SET SERVEROUTPUT ON ; 

EXECUTE ForCursor_Test;
 
