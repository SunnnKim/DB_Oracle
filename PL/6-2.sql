DROP PROCEDURE ExpCursor_Test;

-- Ư�� �μ��� ��ձ޿��� ������� ���..
CREATE OR REPLACE PROCEDURE ExpCursor_Test 
    (v_deptno IN  departments.department_id%TYPE)
IS
  CURSOR dept_avg IS
    SELECT b.department_name, COUNT(a.employee_id) cnt, 
      ROUND(AVG(a.salary),3) sal
    FROM employees a, departments b
    WHERE a.department_id = b.department_id
      AND b.department_id = v_deptno
    GROUP BY b.department_name;

  -- Ŀ���� ��ġ�ϱ� ���� ��� ����
  v_dname   departments.department_name%TYPE;
  emp_cnt   NUMBER;
  sal_avg   NUMBER;

BEGIN
  -- Ŀ���� ����
  OPEN dept_avg;

  -- Ŀ���� ��ġ 
  FETCH dept_avg INTO v_dname, emp_cnt, sal_avg;
  
  DBMS_OUTPUT.PUT_LINE('�μ��� : ' || v_dname);
  DBMS_OUTPUT.PUT_LINE('����� : ' || emp_cnt);
  DBMS_OUTPUT.PUT_LINE('��ձ޿� : ' || sal_avg);

  -- Ŀ���� CLOSE
  CLOSE dept_avg;      

  EXCEPTION
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(SQLERRM||'���� �߻� ');

END;
 /
 
-- DBMS_OUTPUT.PUT_LINE�� ����ϱ� ���� ���
SET SERVEROUTPUT ON ;

-- 60�� �μ�
EXECUTE ExpCursor_Test(60);
-- �μ��� : IT
-- ����� : 5
-- ��ձ޿� : 5760
 
