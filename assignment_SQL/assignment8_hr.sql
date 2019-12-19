-- ����1) EMPLOYEES ���̺��� 20�� �μ��� ���� ������ �����ϴ� EMP_20 VIEW�� ���� �϶�

CREATE VIEW EMP_20(
            employee_id, 
            first_name, 
            last_name, 
            email, hire_date, 
            job_id, salary, 
            department_id
)
AS
SELECT employee_id, first_name, last_name, email, hire_date, job_id, salary, department_id
FROM employees
WHERE department_id =20;


-- ����2) EMPLOYEES ���̺��� 30�� �μ��� EMPLOYEE_ID �� emp_no ��
-- LAST_NAME�� name���� SALARY�� sal�� �ٲپ� EMP_30 VIEW�� �����϶�.

CREATE VIEW EMP_30(
        emp_no,
        name,
        sal
)
AS
SELECT employee_id, last_name,salary
FROM employees 
WHERE department_id = 30;

SELECT * FROM emp_30;

-- ����3) �μ����� �μ���,�ּ� �޿�,�ִ� �޿�,�μ��� ��� �޿��� �����ϴ�
-- DEPT_SUM VIEW�� �����Ͽ���.

CREATE VIEW DEPT_SUM(
        DEPARTMENT,
        MAX_SALARY,
        MIN_SALARY,
        AVG_SALARY
)
AS
SELECT d.department_name, MIN(e.salary) , MAX(e.salary) , ROUND(AVG(e.salary))
FROM employees e, departments d
WHERE d.department_id = e.department_id
GROUP BY d.department_name;

SELECT * FROM DEPT_SUM;

-- ����4) �տ��� ������ EMP_20,EMP_30 VIEW�� �����Ͽ���.

DROP VIEW EMP_20;
DROP VIEW EMP_30;
DROP VIEW DEPT_SUM;


-- ����������

--1. �ʱⰪ1���� �ִ밪999,999���� 1�� �����ϴ� TEST_SEQ SEQUENCE�� �����Ͽ���.

CREATE SEQUENCE TEST_SEQ
INCREMENT BY 1 
MAXVALUE 999999;

-- ����
-- NOCACHE  -- ����Ŭ ������ �̸� �Ҵ��ϰ� �����ϴ� ���θ� ���� ( NOCACHE : ������� )
-- NOCYCLE -- �ִ밪, �ּҰ��� ������ �Ŀ� ��� ���� ����(���)������ ����


-- 2. 1������ �ۼ��� SRQUENCE�� ���� ���� ��ȸ�Ͽ���.

SELECT TEST_SEQ.CURRVAL  FROM DUAL;
SELECT TEST_SEQ.NEXTVAL  FROM DUAL;
  
-- 3. CURRVAL�� NEXTVAL�� �����Ͽ���.

-- CURRVAL�� ���� ��������ȣ�� ����ϴ� �����
-- NEXTVAL�� ó�� ������ �������� ���� ���� ������ ��ȣ�� �̵��Ѵ�.

-- 4. 1������ ������ SRQUENCE�� �����Ͽ���.

DROP SEQUENCE TEST_SEQ;

