-- 프로시저의 이름은 update_sal이다 
DROP PROCEDURE update_sal;

-- update_sal 프로시저는 사번을 입력받아 급여를 인상 한다. 
-- 프로시저를 끝마칠 때에는 항상 "/"를 지정 한다.
CREATE OR REPLACE PROCEDURE update_sal (v_empno IN NUMBER)     
                                      /* IN  Parameter */          
IS      
BEGIN 
  UPDATE employees 
  SET salary = salary  * 1.1 
  WHERE employee_id = v_empno; 
  --COMMIT; 
END update_sal; 
/  
    
EXECUTE update_sal(100);
-- 100번 사원의 급여가 10% 인상 되었는지 확인해 보기 바란다.
SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;

rollback;