DROP PROCEDURE NonPreException_Test;

CREATE OR REPLACE PROCEDURE NonPreException_Test 
IS
  not_null_test    EXCEPTION; -- STEP 1

  /* not_null_test는 선언된 예외 이름 
  -1400 Error 처리번호는 표준 Oracle7 Server Error 번호 */
  PRAGMA EXCEPTION_INIT(not_null_test, -1400);     -- STEP 2

BEGIN
  DBMS_OUTPUT.ENABLE;

  -- employee_id 입력하지 않아서 NOT NULL 에러 발생
  INSERT INTO employees(employee_id, last_name, hire_date, department_id, job_id, email)
      VALUES(300, 'tiger', sysdate, 270, 'IT_PROG', 'tiger@naver.com');
        
  EXCEPTION
    WHEN not_null_test THEN    -- STEP 3
  DBMS_OUTPUT.PUT_LINE('not null 에러 발생 ');

END;
 /

-- DBMS_OUTPUT.PUT_LINE을 출력하기 위해 사용
SET SERVEROUTPUT ON; 

-- 실행 결과 
EXECUTE NonPreException_Test;
-- not null 에러 발생

rollback;
