DECLARE
    -- 사원 이름을 출력하기 위한 PL/SQL 테이블 선언 
    TYPE ename_table IS TABLE OF employees.first_name%TYPE
    INDEX BY BINARY_INTEGER;
	
    -- 사원 급여를 출력하기 위한 PL/SQL 테이블 선언 
    TYPE sal_table IS TABLE OF employees.salary%TYPE
    INDEX BY BINARY_INTEGER;
	
    ename_tab    ename_table;
    sal_tab      sal_table;
	
    i BINARY_INTEGER := 0;

BEGIN
    DBMS_OUTPUT.ENABLE;
	
    FOR emp_list IN  (SELECT first_name, salary 
	                  FROM employees 
	                  WHERE department_id = 20) LOOP
        i := i +1;
	
        -- 테이블에 상품 이름을 저장
        ename_tab(i) := emp_list.first_name;
	        
        -- 테이블에 상품 가격을 저장 
        sal_tab(i)   := emp_list.salary;
        
    END LOOP;
	
    --  화면에 출력
    FOR cnt IN  1..i   LOOP
        DBMS_OUTPUT.PUT_LINE('사원이름 : ' || ename_tab(cnt)); 
        DBMS_OUTPUT.PUT_LINE('사원급여 : ' || sal_tab(cnt));
    END LOOP;
END;
 / 