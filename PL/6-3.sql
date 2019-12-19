DROP PROCEDURE ForCursor_Test;

CREATE OR REPLACE PROCEDURE ForCursor_Test
IS
  -- Cursor 선언
  CURSOR dept_sum IS
    SELECT b.department_name, COUNT(a.employee_id) cnt, SUM(a.salary) sal
    FROM employees a, departments b
    WHERE a.department_id = b.department_id
    GROUP BY b.department_name;

BEGIN
  -- Cursor를 FOR문에서 실행시킨다
  FOR emp_list IN dept_sum LOOP
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || emp_list.department_name);
    DBMS_OUTPUT.PUT_LINE('사원수 : ' || emp_list.cnt);
    DBMS_OUTPUT.PUT_LINE('급여합계 : ' || emp_list.sal);
  END LOOP;

  EXCEPTION
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생 ');

END;
 /
 
SET SERVEROUTPUT ON ; 

EXECUTE ForCursor_Test;
 
