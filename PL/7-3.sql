DROP PROCEDURE User_Exception;

CREATE OR REPLACE PROCEDURE User_Exception 
    (v_deptno IN employees.department_id%type ) 
IS
  -- 예외의 이름을 선언
  user_define_error EXCEPTION;     -- STEP 1
  cnt NUMBER;

BEGIN
  DBMS_OUTPUT.ENABLE;   

  SELECT COUNT(employee_id) 
    INTO cnt
  FROM employees
  WHERE department_id = v_deptno;

  IF cnt < 5 THEN
    -- RAISE문을 사용하여 직접적으로 예외를 발생시킨다
    RAISE user_define_error;         -- STEP 2
  END IF;

  EXCEPTION
  -- 예외가 발생할 경우 해당 예외를 참조한다.
  WHEN user_define_error THEN      -- STEP 3
    RAISE_APPLICATION_ERROR(-20001, '부서에 사원이 몇명 안되네요..');

END; 
 /
 
-- DBMS_OUTPUT.PUT_LINE을 출력하기 위해 사용 
SET SERVEROUTPUT ON; 

-- 10부서의 사원이 5보다 적기 때문에 사용자 정의 예외가 발생.
EXECUTE user_exception(10);
/*
BEGIN user_exception(10); END;
 *
1행에 오류:
ORA-20001: 부서에 사원이 몇명 안되네요..
ORA-06512: at "HR.USER_EXCEPTION", line 24
ORA-06512: at line 1
*/
-- 60부서로 실행을 하면 에러가 발생하지 않는 것 을 알 수 있다.
EXECUTE user_exception(60);
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.
 
