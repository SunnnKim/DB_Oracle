-- FUCTION
/*
        �Ű�����, RETURN���� �ݵ�� ����
        SELECT�������� ���� �����
        
*/
CREATE OR REPLACE FUNCTION func( p_val IN NUMBER)
        RETURN NUMBER
        -- �����ϴ� �κ�
IS
        v_val NUMBER;
BEGIN
        v_val := p_val *2;
        RETURN v_val;
END;
/
-- �Լ��� EXEC�� ȣ�� ���ϰ� select������ ��밡��
SELECT  func(10) FROM DUAL;


set SERVEROUTPUT ON;
-- �������ϴ� �Լ�
CREATE OR REPLACE FUNCTION tax(p_val IN NUMBER) RETURN NUMBER
IS

BEGIN
            RETURN (p_val * 0.15);
END;
/
-- DUAL ���̺�� Ȯ���ϱ�
SELECT tax(1000) FROM DUAL;




-- �޿��� Ŀ�̼��� ���ļ� ������ ���
CREATE OR REPLACE FUNCTION tax2 (p_sal IN employees.salary%TYPE, p_bonus IN employees.commission_pct%TYPE)
        RETURN  NUMBER
IS
BEGIN
            RETURN ( (p_sal + NVL(p_bonus,0) * p_sal) *0.15) ;
END;
/

SELECT first_name, salary + salary * NVL(commission_pct,0) �Ǳ޿�,
                tax2 ( salary, commission_pct) ����
FROM employees;


-- �����ȣ�� �Է��ϸ� �������� ����� �� �ִ� �Լ�
CREATE OR REPLACE FUNCTION getJobName ( p_empno IN employees.employee_id%TYPE)
                RETURN VARCHAR2
IS
                v_jobname jobs.job_title%TYPE;
BEGIN
                SELECT j.job_title INTO v_jobname
                FROM employees E, jobs J
                WHERE e.job_id = j.job_id
                                AND p_empno = e.employee_id;
                
                RETURN v_jobname;
END;
/

SELECT getjobname(100)
FROM DUAL;


-- ���� ����� ����غ���

VAR name VARCHAR2(20);
EXECUTE :name := getjobname(100);
PRINT name;
-- : (�ݷ�)�� ���� �տ��� ���� �����۵��ȴ�.

-- ���ϴ� ���(�����͸�) ���� �� ���� �� �� �ִ� ����� �Լ� (Function)
