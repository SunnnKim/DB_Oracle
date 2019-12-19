SET VERIFY OFF
SET SERVEROUTPUT ON -- 프로시저 결과를 화면에 출력하고 싶을때 사용

ACCEPT p_deptno PROMPT '부서번호를 입력하시오(급여의 합을 구함) : '
DECLARE
	v_sal_total	NUMBER;
BEGIN
	SELECT SUM(salary)
		INTO v_sal_total
	FROM employees
	WHERE department_id = &p_deptno;
	
	DBMS_OUTPUT.PUT_LINE(&p_deptno || '번 부서 급여의 합 : ' ||
		TO_CHAR(v_sal_total,'$99,999,999'));
END;
/
SET VERIFY ON
SET SERVEROUTPUT OFF


