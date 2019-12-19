DROP PROCEDURE PreException_test;

CREATE OR REPLACE PROCEDURE PreException_test
    (v_deptno IN employees.department_id%TYPE)    
IS
  v_emp employees%ROWTYPE;

BEGIN
  DBMS_OUTPUT.ENABLE;

  SELECT employee_id, first_name, department_id
    INTO v_emp.employee_id, v_emp.first_name, v_emp.department_id
  FROM employees
  WHERE department_id = v_deptno;

  DBMS_OUTPUT.PUT_LINE('사번 : ' || v_emp.employee_id);
  DBMS_OUTPUT.PUT_LINE('이름 : ' || v_emp.first_name);
  DBMS_OUTPUT.PUT_LINE('부서번호 : ' || v_emp.department_id);

/*
  FOR  emp_list  IN
      (SELECT employee_id, first_name, department_id
       FROM employees
       WHERE department_id = v_deptno)   LOOP

      DBMS_OUTPUT.PUT_LINE('사번 : ' || emp_list.employee_id);
      DBMS_OUTPUT.PUT_LINE('이름 : ' || emp_list.first_name);
      DBMS_OUTPUT.PUT_LINE('부서번호 : ' || emp_list.department_id);
  END LOOP;
*/
  EXCEPTION
    WHEN   DUP_VAL_ON_INDEX   THEN
      DBMS_OUTPUT.PUT_LINE('데이터가 존재 합니다.');
      DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX 에러 발생');
    WHEN   TOO_MANY_ROWS   THEN  
      DBMS_OUTPUT.PUT_LINE('TOO_MANY_ROWS에러 발생');
    WHEN   NO_DATA_FOUND   THEN  
      DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND에러 발생');
    WHEN OTHERS THEN 
      DBMS_OUTPUT.PUT_LINE('기타 에러 발생');
END;
 / 
 
 
 
SET SERVEROUTPUT ON ;  

-- 프로시저 실행
EXECUTE PreException_Test(20);
--TOO_MANY_ROWS에러 발생

EXECUTE PreException_Test(1);
-- NO_DATA_FOUND에러 발생


-- TOO_MANY_ROWS 에러가 발생하는 이유?
-- SELECT문의 결과가 1개 이상의 행을 리턴하기 때문이다..
-- TOO_MANY_ROWS를 피하기 위해서는 FOR문이나 LOOP문으로 SELECT문을 처리해야 한다.


--아래와 같이 변경하면 에러가 발생하지 않는다.

FOR  emp_list  IN
  (SELECT employee_id, first_name, department_id
  FROM employees
  WHERE department_id = v_deptno)   LOOP

  DBMS_OUTPUT.PUT_LINE('사번 : ' || emp_list.employee_id);
  DBMS_OUTPUT.PUT_LINE('이름 : ' || emp_list.first_name);
  DBMS_OUTPUT.PUT_LINE('부서번호 : ' || emp_list.department_id);
END LOOP;
 
 
 
