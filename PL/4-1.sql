DROP PROCEDURE Insert_Test;

CREATE OR REPLACE PROCEDURE Insert_Test
  ( v_empno  IN employees.employee_id%TYPE,
    v_ename  IN employees.last_name%TYPE,
    v_deptno IN employees.department_id%TYPE,
    v_jobno IN employees.job_id%TYPE,
    v_email IN employees.email%TYPE)
IS

BEGIN
  DBMS_OUTPUT.ENABLE;
    
  INSERT INTO employees(employee_id, last_name, hire_date, department_id, job_id, email)
    VALUES(v_empno, v_ename, sysdate, v_deptno, v_jobno, v_email);
  -- COMMIT;

  DBMS_OUTPUT.PUT_LINE( '사원번호 : ' || v_empno );
  DBMS_OUTPUT.PUT_LINE( '사원이름 : ' || v_ename );
  DBMS_OUTPUT.PUT_LINE( '사원부서 : ' || v_deptno );
  DBMS_OUTPUT.PUT_LINE( 'Job : ' || v_jobno );
  DBMS_OUTPUT.PUT_LINE( '이메일 : ' || v_email );
  DBMS_OUTPUT.PUT_LINE( '데이터 입력 성공 ' );

END;
 /

-- DBMS_OUTPUT.PUT_LINE을 출력하기 위해 사용  
SET SERVEROUTPUT ON;  

-- 실행 결과
EXECUTE Insert_Test(1000, '홍', 20, 'AD_VP', 'abc@naver.com');

-- 확인
SELECT * FROM EMPLOYEES
-- 되돌리기
rollback; 


