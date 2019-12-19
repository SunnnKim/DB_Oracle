-- ����1) EMPLOYEES ���̺��� �μ����� �ο���,��� �޿�,�޿��� ��,�ּ� �޿�, �ִ� �޿��� �����ϴ� 
-- EMP_DEPTNO ���̺��� �����϶�.
CREATE TABLE EMP_DEPTNO
AS
SELECT COUNT(department_id) AS "�ο���", AVG(salary)"��ձ޿�", SUM(salary) "�޿�����", MIN(salary) "�ּұ޿�", MAX(salary) "�ִ�޿�" 
FROM employees
GROUP BY department_id;

-- ���2
CREATE TABLE EMP_DEPTNO(
            "�μ���ȣ",
            "�ο���",
            "��� �޿�",
            "�޿��� ��",
            "�ּ� �޿�",
            "�ִ� �޿�"
) 
AS 
SELECT department_id, COUNT(department_id), ROUND(AVG(salary)),SUM(salary),
                MIN(salary), MAX(salary)
FROM employees
GROUP BY department_id;
SELECT
    *
FROM emp_deptno;

-- ����2) EMP_DEPTNO ���̺� ETC COLUMN�� �߰��϶�.
-- �� �ڷ����� VARCHAR2(50) ����϶�.

ALTER TABLE EMP_DEPTNO
ADD 
ETC_COLUMN VARCHAR2(50);




-- ����3) EMP_DEPTNO ���̺� ETC COLUMN�� �����϶�.
-- �ڷ� ���� VARCHAR2(15)�� �϶�.

ALTER TABLE EMP_DEPTNO
MODIFY ETC_COLUMN VARCHAR2(15);



-- ����4) EMP_DEPTNO ���̺� �ִ� ETC �� �����ϰ� Ȯ���϶�.

ALTER TABLE EMP_DEPTNO
DROP COLUMN ETC_COLUMN;


-- ����5) ������ ������ EMP_DEPTNO ���̺��� �̸��� EMP_DEPT�� �����϶�.
ALTER TABLE EMP_DEPTNO
RENAME TO EMP_DEPT;

-- Ȥ��
RENAME EMP_DEPTNO 
TO EMP_DEPT;

-- ����6) EMP_DEPT ���̺��� �����϶�.
DROP TABLE EMP_DEPT
CASCADE CONSTRAINTS;


-- ����7) EMPLOYEES ���̺��� EMP ���̺��� �����ϰ� �����ϵ��� �϶�.(������ ����)
CREATE TABLE EMP
AS
SELECT *
FROM employees;



-- ����8) EMP ���̺� row�� �߰��� ���ϴ�.
-- �ٸ�, �ݵ�� �����͸� ������ ���ص� �Ǹ�, NULL�� �����ϵ��� �Ѵ�.

INSERT INTO EMP ( EMPLOYEE_ID, FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE, JOB_ID
                                    ,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID)
VALUES ('','','AAA','aaa@bbb.com','',SYSDATE, 'IT_PROG','','','','');



-- ����9) EMPLOYEES ���̺��� EMPNO,ENAME,SAL,HIREDATE�� COLUMN��
-- �����Ͽ� EMP_10 ���̺��� ����(������ ������)�� �� 10�� �μ��� �����Ͽ�
-- �̿� �����ϴ� ���� EMP_10���̺� �Է��϶�.

CREATE TABLE EMP_10
AS
SELECT employee_id, first_name, last_name, email, salary, hire_date
FROM employees
WHERE 1=2;

INSERT INTO EMP_10(employee_id, first_name, last_name, email, salary, hire_date)
    SELECT employee_id, first_name, last_name, email, salary, hire_date
    FROM employees
    WHERE department_id = 10;


-- ����10) EMPLOYEES ���̺��� ��� ��ȣ�� 107�� ����� �μ��� 10������
-- �����Ͽ���.
UPDATE EMP
SET department_id = 10
WHERE employee_id = 107;

-- ����11) EMPLOYEES ���̺��� ��� ��ȣ�� 180�� ����� �μ��� 20, �޿���
-- 3500���� �����Ͽ���.

UPDATE emp
SET department_id = 20, salary = 3500
WHERE employee_id = 180;


-- ����12) EMPLOYEES ���̺��� Smith�� ������ �޿��� Hall�� ������ �޿���
-- ��ġ�ϵ��� �����϶�.

UPDATE EMP
SET job_id = (SELECT job_id FROM emp WHERE last_name='Hall'),
        salary =  (SELECT salary FROM emp WHERE last_name='Hall') 
WHERE last_name = 'Smith';









