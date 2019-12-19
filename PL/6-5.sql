DROP PROCEDURE ParamCursor_Test;

CREATE OR REPLACE PROCEDURE ParamCursor_Test
    (param_deptno employees.department_id%TYPE) 
IS
  v_ename employees.first_name%TYPE;

  -- Parameter가 있는 커서의 선언
  CURSOR emp_list(v_deptno employees.department_id%TYPE) IS
    SELECT first_name 
    FROM employees
    WHERE department_id = v_deptno;

BEGIN
  DBMS_OUTPUT.ENABLE;

  DBMS_OUTPUT.PUT_LINE(' ****** 입력한 부서에 해당하는 사람들 ****** ');              
      
  -- Parameter변수의 값을 전달(OPEN될 때 값을 전달한다)
  FOR emplst IN emp_list(param_deptno) LOOP    
    DBMS_OUTPUT.PUT_LINE('이름 : ' || emplst.first_name);
  END LOOP;    

  EXCEPTION  
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('ERR MESSAGE : ' || SQLERRM);
END; 
 /
 
SET SERVEROUTPUT ON; 

-- 실행 결과
EXECUTE ParamCursor_Test(60);
/*
 ****** 입력한 부서에 해당하는 사람들 ****** 
이름 : Alexander
이름 : Bruce
이름 : David
이름 : Valli
이름 : Diana
*/