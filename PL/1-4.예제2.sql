SET VERIFY OFF
SET SERVEROUTPUT ON -- ���ν��� ����� ȭ�鿡 ����ϰ� ������ ���

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