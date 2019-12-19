DROP TRIGGER triger_test;

CREATE OR REPLACE TRIGGER triger_test
  BEFORE
    UPDATE ON departments
    FOR EACH ROW

BEGIN
  DBMS_OUTPUT.PUT_LINE('변경 전 컬럼 값 : ' || :old.department_name); -- 창이 뜨면 그냥 enter로 넘어가자
  DBMS_OUTPUT.PUT_LINE('변경 후 컬럼 값 : ' || :new.department_name);
END;
 /

-- DBMS_OUTPUT.PUT_LINE을 출력
SET SERVEROUTPUT ON ; 

-- UPDATE문을 실행시키면.. 
UPDATE departments SET department_name = '개발부' WHERE department_id = 60;
-- 자동적으로 트리거가 실행되어 60번 부서명이 개발부로 변경된다

SELECT * FROM DEPARTMENTS;
ROLLBACK;