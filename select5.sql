-- SUB QUERY 
-- ������ �ȿ� ������
-- �� ���� ��(row)���� ��� ���� ��ȯ�Ǵ� Query

-- < Sub Query�� ����� �� �ִ� ���� ���� ��� >
-- SELECT               ������(ROW) , �����÷�(COLUMN)�� ����( ���� 2�� �̻��̸� �ȵ�) , ������ �����Ͱ� �Ѱ�, �÷� �Ѱ�
--                                   : SELECT FIRST_NAME, SALARY FROM EMP <- �̷��� ��� ���Ѵ�.
-- FROM                  ���� ROW, ���� COLUMN
-- WHERE               ���� ROW, ���� COLUMN            ---> ���� ���� ���



-- �Ʒ��� �ȵǴ� �� : ���� �÷��� ��� �Ұ���
SELECT EMPLOYEE_ID, (SELECT FIRST_NAME, LAST_NAME FROM employees) FROM employees;
-- ���� ROW �� ��� �Ұ���
SELECT EMPLOYEE_ID, (SELECT FIRST_NAME FROM employees) FROM employees;

-- SELECT������ ����� �� �ִ� ���� ���� ��
SELECT employee_id, first_name, 
                 (SELECT salary FROM employees WHERE employee_id = 100) 
FROM employees;
-- ���� �ڵ�� �÷� �����Ͱ� �� 1�� ������ ������ ���������� ��밡���ϴ�
SELECT employee_id, first_name, 
                 (SELECT SUM(salary) FROM employees) 
FROM employees;
-- �׷��Լ��� ����� �� �ִ�: ���� 1���� ������ ����



-- FROM������ Sub Query ����ϴ� ���
SELECT employee_id, first_name, department_id 
FROM ( SELECT   employee_id, first_name, department_id
                FROM employees
                WHERE department_id = 20);

-- �μ���ȣ�� 20��, �޿��� 6000�̻��� ���
SELECT e.employee_id, e.salary
FROM ( SELECT
                        *
                FROM employees
                WHERE department_id = 20) e
WHERE salary > 6000;


-- ����2
SELECT a.employee_id, a.first_name, 
                a.job_id, b.job_id,
                b.�޿��հ�, b.�ο���
FROM employees a, (SELECT job_id, sum(salary) as �޿��հ�, COUNT(*) �ο���
                                        FROM employees
                                        GROUP BY job_id ) b
WHERE a.job_id = b.job_id;




-- WHERE������ Sub Query ����ϱ�
-- ���� ���� ����

-- ���� : ��� ���޺��� ���� �޴� ��� ���ϱ�
SELECT first_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary)
                                FROM employees);

-- in �Լ� �ȿ� �������� ���� �� �ִ�
SELECT first_name, job_id, department_id
FROM employees
WHERE job_id IN (SELECT  job_id
                                FROM employees
                                WHERE department_id  = 90);



-- ���� ����
-- 1. �μ����� ���� �޿��� ���� �޴� ����� ���� �޿��� �޴� ����� ���

                                    
SELECT first_name, last_name,job_id, department_id,salary
FROM employees
WHERE salary IN ( SELECT MIN(salary)
                                FROM employees
                                GROUP BY department_id)
ORDER BY salary;


-- 2. �μ����� ���� �޿��� ���� �޴� ����� ����


SELECT department_id, first_name, last_name, job_id, salary
FROM employees
WHERE ( salary, department_id ) IN (SELECT MIN(salary), department_id
                                                              FROM employees
                                                              GROUP BY department_id)
ORDER BY department_id;

