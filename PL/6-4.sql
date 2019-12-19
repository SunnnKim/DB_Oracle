DROP PROCEDURE AttrCursor_Test;

CREATE OR REPLACE PROCEDURE AttrCursor_Test   
IS
  v_empno employees.department_id%TYPE;
  v_ename employees.first_name%TYPE;
  v_sal employees.salary%TYPE;  

  CURSOR emp_list IS
    SELECT department_id, first_name, salary
    FROM employees;    
 
BEGIN
  DBMS_OUTPUT.ENABLE;

  OPEN emp_list;   

  LOOP
    FETCH emp_list INTO v_empno, v_ename, v_sal;

    -- 데이터를 찾지 못하면 빠져 나갑니다
    EXIT WHEN emp_list%NOTFOUND;
  END LOOP;    

  DBMS_OUTPUT.PUT_LINE('전체데이터 수 ' || emp_list%ROWCOUNT);
    
  CLOSE emp_list;
    
  EXCEPTION
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('ERR MESSAGE : ' || SQLERRM);
        
END; 
 / 
 
SET SERVEROUTPUT ON ; 

-- 실행 결과
EXECUTE AttrCursor_Test;
-- 전체데이터 수 107
 
