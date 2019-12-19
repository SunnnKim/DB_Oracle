DROP PROCEDURE Dept_Search;

CREATE OR REPLACE PROCEDURE Dept_Search
    (p_empno IN employees.employee_id%TYPE )
IS
  v_deptno employees.department_id%type;

BEGIN
  DBMS_OUTPUT.ENABLE;

  SELECT department_id
    INTO v_deptno
  FROM employees
  WHERE employee_id = p_empno;

  IF v_deptno = 30 THEN
    DBMS_OUTPUT.PUT_LINE( ' Purchasing �μ� ����Դϴ�. ' );
  ELSIF v_deptno = 40 THEN
    DBMS_OUTPUT.PUT_LINE( ' Human Resources �μ� ����Դϴ�. ' );
  ELSIF v_deptno = 50 THEN
    DBMS_OUTPUT.PUT_LINE( ' Shipping �μ� ����Դϴ�. ' );
  ELSIF v_deptno = 60 THEN
    DBMS_OUTPUT.PUT_LINE( ' IT �μ� ����Դϴ�. ' );
  ELSE
    DBMS_OUTPUT.PUT_LINE( ' 4�μ��ܿ� �ٸ� �μ��Դϴ�... ' );
  END IF;

  EXCEPTION    
  WHEN NO_DATA_FOUND  THEN  
  DBMS_OUTPUT.PUT_LINE(' �μ��� �����ϴ�... ');

END;
 /


SET SERVEROUTPUT ON ; 

-- ���ν��� ����
EXECUTE Dept_Search(178);
-- 4�μ��ܿ� �ٸ� �μ��Դϴ�...

EXECUTE Dept_Search(114);
-- Purchasing �μ� ����Դϴ�.

EXECUTE Dept_Search(207);
-- �μ��� ���׿�...

