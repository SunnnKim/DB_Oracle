SET VERIFY OFF
SET SERVEROUTPUT ON -- ���ν��� ����� ȭ�鿡 ����ϰ� ������ ���

ACCEPT p_deptno PROMPT '�μ���ȣ�� �Է��Ͻÿ�(�޿��� ���� ����) : '
DECLARE
	v_sal_total	NUMBER;
BEGIN
	SELECT SUM(salary)
		INTO v_sal_total
	FROM employees
	WHERE department_id = &p_deptno;
	
	DBMS_OUTPUT.PUT_LINE(&p_deptno || '�� �μ� �޿��� �� : ' ||
		TO_CHAR(v_sal_total,'$99,999,999'));
END;
/
SET VERIFY ON
SET SERVEROUTPUT OFF


