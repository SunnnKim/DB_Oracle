DROP PROCEDURE Emp_Info;

CREATE OR REPLACE PROCEDURE Emp_Info
  -- IN Parameter 
  ( p_empno IN employees.employee_id%TYPE )

IS
  -- %TYPE 데이터형 변수 선언 
  v_empno employees.employee_id%TYPE; 
  v_ename employees.first_name%TYPE;
  v_sal   employees.salary%TYPE;

BEGIN
  DBMS_OUTPUT.ENABLE;
  /*
  프로시져내부 시작시점에 버퍼를 초기화 한다.
  DBMS_OUTPUT.DISABLE;
  DBMS_OUTPUT.ENABLE;
  */

  -- %TYPE 데이터형 변수 사용 
  SELECT employee_id, first_name, salary
    INTO v_empno, v_ename, v_sal  
  FROM employees
  WHERE employee_id = p_empno ;

  -- 결과값 출력 
  DBMS_OUTPUT.PUT_LINE( '사원번호 : ' || v_empno ); 
  DBMS_OUTPUT.PUT_LINE( '사원이름 : ' || v_ename );
  DBMS_OUTPUT.PUT_LINE( '사원급여 : ' || v_sal );
END;
 /

-- DBMS_OUTPUT 결과값을 화면에 출력 하기위해
SET SERVEROUTPUT ON;  
   
-- 실행 결과 
EXECUTE Emp_Info(100); 
