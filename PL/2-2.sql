DROP FUNCTION FC_update_sal;

CREATE OR REPLACE FUNCTION FC_update_sal(v_empno IN NUMBER)

  -- 리턴되는 변수의 데이터타입을 꼭 정의해야 합니다
  RETURN  NUMBER
IS    
    -- %type 변수가 사용(스칼라 데이터 타입 참고)
    v_sal  employees.salary%type;
    
BEGIN
  SELECT salary * 1.1
    INTO v_sal
  FROM employees
  WHERE employee_id = v_empno;

  -- 리턴문이 꼭 존재해야 합니다
  RETURN v_sal;
END;   
/


-- 변수를 사용
VAR salary NUMBER; 
-- EXECUTE 문을 이용해 함수를 실행합니다.
EXECUTE :salary := FC_update_sal(100); 
-- PRINT문을 사용하여 출력
PRINT salary;


-- SELECT문장에서도 사용 할 수 있다. 
SELECT first_name, FC_update_sal(100) 
FROM employees
where employee_id = 100;





 
 



