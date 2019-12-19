예제1) 이름,급여,부서번호를 입력받아 EMP 테이블에 자료를 등록하는 SCRIPT를 
작성하여라. 
단 10번 부서일 경우, 입력한 급여의 20%를 추가하고 초기값이 9000부터 9999까지 
1씩 증가하는 SEQUENCE(EMP_EMPNO_SEQ)작성하여 사용하고 아래의 표를 
참고하여라.

이    름: 홍길동
급    여: 2000
부서번호: 10




-- 시퀀스 생성
CREATE SEQUENCE EMP_EMPNO_SEQ
INCREMENT BY 1
START WITH 9000
MAXVALUE 9999;

SET VERIFY OFF
ACCEPT  p_name   PROMPT  ' 이    름: '
ACCEPT  p_sal    PROMPT  ' 급    여: '
ACCEPT  p_deptno PROMPT  ' 부서번호: '
DECLARE
	v_name	VARCHAR2(10) := UPPER('&p_name');
	v_sal	NUMBER(7,2) := &p_sal;
	v_deptno	NUMBER(2) := &p_deptno;
BEGIN
	IF v_deptno = 10 THEN
		v_sal := v_sal * 1.2;
	END IF;
    
  INSERT INTO employees(employee_id, last_name, hire_date, salary, department_id, job_id, email)
      VALUES(EMP_EMPNO_SEQ.NEXTVAL, v_name, sysdate, v_sal, v_deptno, 'IT_PROG', v_name||'@naver.com');
      
--COMMIT;
END;
/
SET VERIFY ON

SELECT * FROM EMPLOYEES;
ROLLBACK;
