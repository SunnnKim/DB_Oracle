SET VERIFY OFF	
-- SET VERIFY ON/OFF : SQL명령어나 PL/SQL에서 &를 이용한 치환 변수등을 사용할 때 치환되기 전 후의 
-- 자세한 값을 보일 건지의 여부를 결정 한다. 기본값은 ON 이다.  

-- 입력 처리
ACCEPT  p_name   PROMPT  ' 이    름: '   
ACCEPT  p_sal    PROMPT  ' 급    여: '
ACCEPT  p_deptno PROMPT  ' 부서번호: '

DECLARE -- 선언부
	v_name	VARCHAR2(10) := UPPER('&p_name');
	v_sal	NUMBER(7,2) := &p_sal;
	v_deptno	NUMBER(2) := &p_deptno;

BEGIN  
	IF v_deptno = 30 THEN -- 입력된 부서번호가 30일 경우
		v_sal := v_sal * 1.2;
	ELSIF v_deptno = 60 THEN -- 입력된 부서번호가 60일 경우
		v_sal := v_sal * 1.1;
	END IF;
	
  INSERT INTO employees(employee_id, last_name, salary, hire_date, department_id, job_id, email)
      VALUES(EMPLOYEES_SEQ.NEXTVAL, v_name, v_sal, sysdate, v_deptno, 'IT_PROG', v_name||'@naver.com');  
--  COMMIT;
END;
/

SET VERIFY ON

SELECT * FROM EMPLOYEES;
rollback;
