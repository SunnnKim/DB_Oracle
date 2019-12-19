DROP TRIGGER triger_test;

CREATE OR REPLACE TRIGGER triger_test
  BEFORE
    UPDATE ON departments    

BEGIN
  DBMS_OUTPUT.PUT_LINE('트리거 실행'); 
END;
 /

-- DBMS_OUTPUT.PUT_LINE을 출력
SET SERVEROUTPUT ON ; 

-- UPDATE문을 실행시키면.. 
UPDATE departments SET department_name = '개발부' WHERE department_id = 60;
-- 자동적으로 트리거가 실행되어 60번 부서명이 개발부로 변경된다

SELECT * FROM DEPARTMENTS;
ROLLBACK;