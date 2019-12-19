SET VERIFY OFF
SET SERVEROUTPUT ON -- 프로시저 결과를 화면에 출력하고 싶을때 사용

DECLARE
	v_sal	employees.salary%TYPE := 1000;
BEGIN
	UPDATE employees
	SET salary = salary + v_sal
	WHERE employee_id = 101;
END;
/
SET VERIFY ON
SET SERVEROUTPUT OFF

ROLLBACK;
SELECT * FROM EMPLOYEES;