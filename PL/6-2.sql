DROP PROCEDURE ExpCursor_Test;

-- 특정 부서의 평균급여와 사원수를 출력..
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

  -- 커서를 패치하기 위한 편수 선언
  v_dname   departments.department_name%TYPE;
  emp_cnt   NUMBER;
  sal_avg   NUMBER;

BEGIN
  -- 커서의 오픈
  OPEN dept_avg;

  -- 커서의 패치 
  FETCH dept_avg INTO v_dname, emp_cnt, sal_avg;
  
  DBMS_OUTPUT.PUT_LINE('부서명 : ' || v_dname);
  DBMS_OUTPUT.PUT_LINE('사원수 : ' || emp_cnt);
  DBMS_OUTPUT.PUT_LINE('평균급여 : ' || sal_avg);

  -- 커서의 CLOSE
  CLOSE dept_avg;      

  EXCEPTION
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생 ');

END;
 /
 
-- DBMS_OUTPUT.PUT_LINE을 출력하기 위해 사용
SET SERVEROUTPUT ON ;

-- 60번 부서
EXECUTE ExpCursor_Test(60);
-- 부서명 : IT
-- 사원수 : 5
-- 평균급여 : 5760
 
