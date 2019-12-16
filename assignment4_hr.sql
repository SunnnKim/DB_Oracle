-- ����1) EMPLOYEES ���̺��� King�� ������ �ҹ��ڷ� �˻��ϰ� 
-- �����ȣ,����, ������(�ҹ��ڷ�),�μ���ȣ�� ����϶�.

-- LOWER �Լ� ����ϱ� 
SELECT employee_id, last_name, Lower(job_id), department_id
FROM employees
WHERE LOWER(last_name) = 'king';




--����2) EMPLOYEES ���̺��� King�� ������ �빮�ڷ� �˻��ϰ�
--�����ȣ,����, ������(�빮�ڷ�),�μ���ȣ�� ����϶�.

-- UPPER �Լ� ����ϱ� 
SELECT employee_id, last_name, first_name, UPPER(job_id), department_id
FROM employees
WHERE UPPER(last_name) = 'KING';



-- ����3) DEPARTMENTS ���̺��� �μ���ȣ�� �μ��̸�, �μ��̸��� ��ġ��ȣ�� ���Ͽ� ����ϵ��� �϶�.

-- concat �Լ� �Ǵ� || ������
SELECT department_id, department_name, 
        CONCAT(department_id,department_name),
        CONCAT(department_name,location_id)
FROM departments;


-- ����4) EMPLOYEES ���̺��� �̸��� ù ���ڰ� ��K�� ���� ũ�� ��Y������ ��������� ������ 
-- �����ȣ, �̸�, ����, �޿�, �μ���ȣ�� ����϶�. �� �̸������� �����Ͽ���.

--SUBSTR
SELECT employee_id, first_name, job_id, salary, department_id
FROM employees
WHERE SUBSTR(first_name,1,1) > 'K'
      AND SUBSTR(first_name,1,1) < 'Y'
ORDER BY first_name ASC;




-- ����5) EMPLOYEES ���̺��� 20�� �μ� �� �̸��� ���� �� �޿��� �ڸ�����
--�����ȣ, �̸�, �̸��� �ڸ���, �޿�, �޿��� �ڸ����� ����϶�.

-- Length ���
SELECT employee_id, first_name, length(first_name)"�̸��� �ڸ���", salary, length(salary)"�޿��� �ڸ���"
FROM employees
WHERE department_id = 20;



-- ����6) EMPLOYEES ���̺��� �̸� �� ��e������ ��ġ�� ����϶�.

-- INSTR(���ڿ�, ã������,n��°���ĺ���ã��,m��°ã����������ġ)
SELECT first_name,
        INSTR( lower(first_name) , 'e',1,1) as e_1,
        INSTR( lower(first_name) , 'e',1,2) as e_2,
        INSTR( lower(first_name) , 'e',1,3) as e_3
FROM employees;




-- ����7) ������ ������ �����ϰ� ����� �м��϶�.

SELECT ROUND(4567.678),ROUND(4567.678,0),
ROUND(4567.678,2),ROUND(4567.678,-2)
FROM dual;
-- ROUND(����):�Ҽ��� ù°�ڸ����� �ݿø�
-- ROUND(����, ���): �����ŭ�� �Ҽ����� ��ȯ
-- ROUND(����, ����): ������ ���밪��ŭ ���������ڸ��� �ͼ� �ݿø�



--����8) EMPLOYEES ���̺��� �μ���ȣ�� 80�� ����� �޿��� 30���� ���� �������� ���Ͽ� ����϶�.

--MOD
SELECT salary, MOD(salary,30), department_id
FROM employees
WHERE department_id = 80;



-- ����9) EMPLOYEES ���̺��� 30�� �μ� �� �̸��� ��� ������ �����Ͽ� ����Ͽ���. 
-- �� ��� ������ �� �� �Ʒ��� ����϶�.
-- ( ���̱⿣ ����ó�� �������� �׸��带 ���� Ŭ���ϸ� ���� �Ǿ��ٴ� ���� Ȯ���� �� �ֽ��ϴ�.)

-- CHR(10) : ���� ��Ʈ(new line), ����   
-- *����: CHR(13) : ĳ���� ���� : ���� Ŀ���� ��ġ�� ���� �Ǿ����� ����
SELECT employee_id,last_name || CHR(10)|| job_id
FROM employees
WHERE department_id = 30;



-- ����10) EMPLOYEES ���̺��� ������� �ٹ��� ���� ���� ���� �ΰ��� ����Ͽ���. 
-- �� �ٹ� �ϼ��� ���� ��� ������ ����Ͽ���.

SELECT  last_name, hire_date, sysdate,
        TRUNC(sysdate - hire_date) as "Total days", 
        TRUNC((sysdate - hire_date) / 7) as weeks,
        mod( (TO_DATE('19/12/01') - hire_date), 7) "���� �� ��"
FROM employees
ORDER by "Total days" DESC;



-- ����11) EMPLOYEES ���̺��� �μ� 50���� �޿� �տ� $�� �����ϰ� 3�ڸ����� ,�� ����϶�

--TO_CHAR
SELECT first_name, department_id, salary,TO_CHAR(salary, '$999,999,999')
FROM employees
WHERE department_id = 50;


--����12) ������ ����� �м��Ͽ� ���ƶ�.

SELECT  EMPLOYEE_ID,LAST_NAME,JOB_ID,SALARY,
        DECODE (JOB_ID,  'IT_PROC',SALARY*1.1,
                        'ST_MAN', SALARY*1.15,
                        'SA_MAN', SALARY*1.2, 
                         SALARY) d_sal
FROM EMPLOYEES
ORDER BY SALARY DESC;
-- decode(): if-else�� ����� ���ǹ�
-- DECODE(JOB_ID,'IT_PROC',SALARY*1.1,'ST_MAN', SALARY*1.15,'SA_MAN', SALARY*1.2, SALARY)
-- ����1:JOB_ID ='IT_PROC' �϶� SALARY*1.1
-- ����2:JOB_ID ='ST_MAN' �϶� SALARY*1.15.....
-- ������ ����: �� ������ �϶��� SALARY ���

-- Employees ���̺��� �����ȣ, �̸�, ����, �޿�, ������ ���� d_sal ����ϵ�, �޿��� �������� �������� ����




-- �׷��Լ�
--����1) EMPLOYEES ���̺��� ��� SALESMAN(SA_MAN)�� ���Ͽ� �޿���
--���, �ְ��, ������, �հ踦 ���Ͽ� ����Ͽ���.

SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM employees
WHERE job_id = 'SA_MAN';
    


-- ����2) EMPLOYEES ���̺� ��ϵǾ� �ִ� �ο���, ���ʽ��� NULL�� �ƴ�
-- �ο���, ���ʽ��� ���, ��ϵǾ� �ִ� �μ��� ���� ���Ͽ� ����϶�.


SELECT  COUNT(last_name) as �ο���, 
        COUNT(commission_pct) ���ʽ���,
        AVG(commission_pct) "���ʽ��� ���",
        COUNT(DISTINCT department_id) "�μ��� ��"
FROM employees;

                                                                                                                                                                                     





-- ����3) EMPLOYEES ���̺��� �μ����� �ο���, ��� �޿�, �����޿�, �ְ�޿�, �޿��� ���� ���Ͽ� ����϶�.

SELECT department_id,COUNT(salary) �ο���, AVG(salary) ��ձ޿�, 
        MIN(salary), MAX(salary), SUM(salary)
FROM employees
GROUP BY department_id;




-- ����4) EMPLOYEES ���̺��� �� �μ����� �ο���,�޿��� ���, ���� �޿�,
-- �ְ� �޿�, �޿��� ���� ���Ͽ� �޿��� ���� ���� ������ ����Ͽ���.
SELECT department_id,COUNT(salary) �ο���, AVG(salary) ��ձ޿�, 
        MIN(salary), MAX(salary), SUM(salary)
FROM employees
GROUP BY department_id
ORDER BY SUM(salary) DESC;


-- ����5) EMPLOYEES ���̺��� �μ���, ������ �׷��Ͽ� ����� 
-- �μ���ȣ, ����, �ο���, �޿��� ���, �޿��� ���� ���Ͽ� ����Ͽ���.

-- GROUTP BY�� 2���� �̻��� �������ε� ���� �� �ִ�.
SELECT department_id,job_id, count(*),
        AVG(salary), SUM(salary)
FROM employees
GROUP BY department_id, job_id;




-- ����6) EMPLOYEES ���̺��� �μ� �ο��� 4���� ���� �μ��� 
-- �μ���ȣ,�ο���, �޿��� ���� ���Ͽ� ����Ͽ���.(GROUP BY, HAVING)

SELECT department_id, COUNT(*), SUM(salary)
FROM employees 
GROUP BY department_id
HAVING COUNT(*)>4;





-- ����7) EMPLOYEES ���̺��� �޿��� �ִ� 10000�̻��� �μ��� ���ؼ� 
-- �μ���ȣ, ��� �޿�, �޿��� ���� ���Ͽ� ����Ͽ���.

SELECT department_id, AVG(salary), SUM(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 10000;




-- ����8) EMPLOYEES ���̺��� ������ �޿��� ����� 10000 �̻��� ������ ���ؼ� 
-- ������,��� �޿�, �޿��� ���� ���Ͽ� ����϶�.

SELECT job_id, AVG(salary), SUM(salary)
FROM employees
GROUP BY job_id
HAVING AVG(salary) >= 10000;



--����9) EMPLOYEES ���̺��� ��ü ������ 10000�� �ʰ��ϴ� �� ������ ���ؼ� 
-- ������ ���޿� �հ踦 ����϶�. �� �Ǹſ��� �����ϰ� �� �޿� �հ�� ����(��������)�϶�.(SA_)


SELECT job_id, SUM(salary)
FROM employees
WHERE job_id NOT LIKE 'SA%'
GROUP BY job_id
HAVING SUM(salary)>10000
ORDER BY SUM(salary) DESC;


