DROP PROCEDURE Errcode_Exception;

CREATE OR REPLACE PROCEDURE Errcode_Exception 
    (v_deptno IN employees.department_id%type ) 
IS
  v_emp employees%ROWTYPE ;  

BEGIN  
  DBMS_OUTPUT.ENABLE;

  -- ERROR발생 for문을 돌려야 됨
  SELECT * 
    INTO v_emp
  FROM employees
  WHERE department_id = v_deptno;
      
  DBMS_OUTPUT.PUT_LINE('사번 : ' || v_emp.employee_id);    
  DBMS_OUTPUT.PUT_LINE('이름 : ' || v_emp.first_name);    
          
  EXCEPTION
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('에러 코드 : ' || TO_CHAR(SQLCODE));
  DBMS_OUTPUT.PUT_LINE('에러 메시지 : ' || SQLERRM);

END;  
 /

-- DBMS_OUTPUT.PUT_LINE을 출력하기 위해 사용
SET SERVEROUTPUT ON; 

-- 실행예제
EXECUTE Errcode_Exception(30);
--에러 코드 : -1422
--에러 메시지 : ORA-01422: 실제 인출은 요구된 것보다 많은 수의 행을 추출합니다


