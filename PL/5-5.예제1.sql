����1) �̸�,�޿�,�μ���ȣ�� �Է¹޾� EMP ���̺� �ڷḦ ����ϴ� SCRIPT�� 
�ۼ��Ͽ���. 
�� 10�� �μ��� ���, �Է��� �޿��� 20%�� �߰��ϰ� �ʱⰪ�� 9000���� 9999���� 
1�� �����ϴ� SEQUENCE(EMP_EMPNO_SEQ)�ۼ��Ͽ� ����ϰ� �Ʒ��� ǥ�� 
�����Ͽ���.

��    ��: ȫ�浿
��    ��: 2000
�μ���ȣ: 10




-- ������ ����
CREATE SEQUENCE EMP_EMPNO_SEQ
INCREMENT BY 1
START WITH 9000
MAXVALUE 9999;

SET VERIFY OFF
ACCEPT  p_name   PROMPT  ' ��    ��: '
ACCEPT  p_sal    PROMPT  ' ��    ��: '
ACCEPT  p_deptno PROMPT  ' �μ���ȣ: '
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
