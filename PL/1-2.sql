SET VERIFY OFF	
-- SET VERIFY ON/OFF : SQL��ɾ PL/SQL���� &�� �̿��� ġȯ �������� ����� �� ġȯ�Ǳ� �� ���� 
-- �ڼ��� ���� ���� ������ ���θ� ���� �Ѵ�. �⺻���� ON �̴�.  

-- �Է� ó��
ACCEPT  p_name   PROMPT  ' ��    ��: '   
ACCEPT  p_sal    PROMPT  ' ��    ��: '
ACCEPT  p_deptno PROMPT  ' �μ���ȣ: '

DECLARE -- �����
	v_name	VARCHAR2(10) := UPPER('&p_name');
	v_sal	NUMBER(7,2) := &p_sal;
	v_deptno	NUMBER(2) := &p_deptno;

BEGIN  
	IF v_deptno = 30 THEN -- �Էµ� �μ���ȣ�� 30�� ���
		v_sal := v_sal * 1.2;
	ELSIF v_deptno = 60 THEN -- �Էµ� �μ���ȣ�� 60�� ���
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
