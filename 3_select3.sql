-- ORDER BY : ����

SELECT * FROM emp
ORDER BY sal ASC;
-- �������� ����

SELECT *
FROM emp
ORDER BY hiredate;
-- �⺻(�ƹ��͵� ���� ������)�� ��������


-- ALIAS ������ ���� ����
SELECT empno, ename, sal * 12 AS annsal
FROM emp
ORDER BY annsal ASC;


-- NULLS FIRST / LAST 
-- Null ���� �ִ� ����� ����
SELECT
    *
FROM emp
ORDER BY comm NULLS FIRST;
-- NULL ���� ���� ���� �����ϱ�

SELECT    *
FROM emp
ORDER BY comm NULLS FIRST;
-- NULL ���� ���� �Ʒ��� �����ϱ�

-- ���ڿ��� ���ĺ�(�Ǵ� ������) ������ ����
SELECT employee_id, job_id
FROM employees
ORDER BY job_id ASC;
-- ���� ���� �������� ���

-- ���� ����� 2�� �̻� ������ �� �ִ�.
SELECT employee_id, job_id, salary
FROM employees
ORDER BY job_id ASC, salary DESC;
-- job_id �� ������������, ���� ���� �ι�° ���� ����� salary �� ������������ ����



-- �Լ�
-- ���ڿ��� ���ϴ� ���
-- 1) || ����ϱ�
SELECT first_name || ' ' || last_name
FROM employees;

-- 2) CONCAT( )
SELECT CONCAT( first_name , last_name) -- ������ �յڹ��� �ٿ��� ����
FROM employees;

--MONTHS_BETWEEN : �� ��¥�� ���� ����
SELECT ROUND(MONTHS_BETWEEN('2020-05-04', '2019-12-13')) AS MONTH_BETWEEN
FROM dual;
-- �Ҽ����� ������ ������ Trunc() �� Round�� ����ϴ� ���� ����
--> �� ū ���� ���� �տ��ٰ� �ξ�� ��

-- add_month() : Ư�� ��¥ ���� ������ ���� ���� �ش� ��¥�� ��ȯ
SELECT add_months('2019-12-13',3)
FROM dual;

-- 
-- ��¥ �������� Ư���� ����, ��, ��, ��, ��, �� �� ���ϱ�
SELECT EXTRACT(year from sysdate) AS ����,
                 EXTRACT(month from sysdate) AS ��,
                 EXTRACT(day from sysdate) AS ��
FROM dual;
-- EXTRACT(year/month/day/... from'�ش� ��/��/��/��/��/��') 
-- sysdate �� �ϸ� ���� ��¥�� ����


-- TO_DATE () �� �̿��ؼ� Ư�� ��¥�� �ٸ� ��¥���ĵ� �Է��� �� �ִ�.
SELECT EXTRACT(year from TO_DATE('20191001','YYYYMMDD')) AS ����,
                 EXTRACT(month from TO_DATE('19/10/01')) AS ��,
                 EXTRACT(day from TO_DATE('19/10/01')) AS ��
FROM dual;

-- ��, ��, �� ���ϱ�
-- CAST() �Լ��� ��ȯ : CAST( ��¥(�ð�)������ AS TIMESTAMP)
SELECT EXTRACT(HOUR from CAST(sysdate AS TIMESTAMP)) AS ��,
                 EXTRACT(MINUTE from CAST(sysdate AS TIMESTAMP)) AS ��,
                 EXTRACT(SECOND from CAST(sysdate AS TIMESTAMP)) AS ��
FROM dual;
-- sysdate�� �ƴ� ���ڿ��� �Է��� �� ������, 
-- �ð������� �Է����� ���� ��¥�����ʹ� ���� �ð����� ������ �ȴ�.




-- Group By
-- �׷����� ���� ���

-- 1. DISTINCT : �ߺ� ������
SELECT DISTINCT department_id, employee_id
FROM employees
ORDER BY department_id ASC;

-- 2. Group By
SELECT department_id -- , employee_id(�������� �ڵ�)  : �׷����� ��������� ���� �÷��� �����ְ� �ΰ� �̻��� ���� �� ����.
FROM employees
GROUP BY department_id
ORDER BY department_id ASC; -- ���� ���ϱ� ���� ����



/*
2.    Group �Լ�
    - COUNT
    - SUM
    - AVG
    - MAX
    - MIN

    - GROUP BY �� ���� ����ϴ� �Լ���

*/

SELECT COUNT(salary), COUNT(*) ||'��' as �ο���, -- �� ����� ������ ����� ����Ѵ�.
                SUM(salary), AVG(salary)
FROM employees
WHERE job_id = 'IT_PROG';
-- �� ����� �׷����� ���δ�.


-- ���� �ڵ�� �Ʒ� �ڵ�� �Ȱ��� ���

SELECT COUNT(salary), COUNT(*) ||'��' as �ο���, -- �� ����� ������ ����� ����Ѵ�.
                SUM(salary) as �����հ� , AVG(salary) as �������, job_id 
FROM employees
WHERE job_id = 'IT_PROG'
GROUP BY job_id;
-- �׷����� ������ ���� ���� �׷��� �ٸ� �÷��� �� �� ������
-- ���� �ʾ��� ���� �׷� �Լ��� ������� �ʰ�� �ٸ� �÷������͸� �� �� ����.
-- �Ʒ� �ڵ�� ������ ����.

SELECT COUNT(salary), COUNT(*) , job_id
FROM employees
WHERE job_id = 'IT_PROG';


/*3. NVL ( ) : ����� �Ǵ� �÷��� NULL�̾��� �� ó�����ִ� �Լ� 

1) NVL( )
-- NUMBER �ڷ����� ��
NVL( ����� �Ǵ� �÷�, ��);
����� �Ǵ� �÷� != NULL ---> ����� �Ǵ� �÷� ���
����� �Ǵ� �÷� = NULL ---> ��

--VARCHAR2 �ڷ����� ��
NVL( ����� �Ǵ� �÷�, '����');
SELECT COUNT(salary), COUNT(*) ||'��' as �ο���, -- �� ����� ������ ����� ����Ѵ�.
                SUM(salary) as �����հ� , AVG(salary) as �������
FROM employees
WHERE job_id = 'IT_PROG'
GROUP BY job_id;

2) NVL2( ) : NULL �� ���� �ƴ� �� ���� �����ؼ� ǥ��
NVL2(����� �Ǵ� �÷�, 1, 0 )
����� �Ǵ� �÷� != NULL ---> 1
����� �Ǵ� �÷� = NULL ---> 0


-- �ڹٿ��� NullPointerException ���µ� �����ϴ�
*/

SELECT first_name, NVL(commission_pct, )
FROM employees;


SELECT first_name, NVL2(commission_pct, 'O','X' )
FROM employees;



-- �׷��Լ����� ����
SELECT department_id, SUM(salary), MAX(salary), 
                TRUNC(AVG(salary),2)
FROM employees
GROUP BY department_id
ORDER BY department_id ASC;



-- Having 
-- ������ 
-- ������ group by�� ���� ����ؾ� �� ( ���������� ���Ұ�, ���� �� )

SELECT job_id, SUM(salary)
FROM employees
GROUP BY job_id
HAVING SUM(salary) >= 100000
ORDER BY SUM(salary) DESC;



-- �޿��� 5000�� �̻� �޴� ��������� �հ踦 ���� 
-- ������ �׷�ȭ�Ͽ� �޿� �հ谡 20000 ���� �ʰ��ϴ� �������� ���Ͻÿ�. 
SELECT job_id, COUNT(*), SUM (salary), ROUND(avg(salary))
FROM employees
WHERE salary >= 5000
GROUP BY job_id
HAVING SUM(salary)  > 20000 ;



-- < order by >

-- ���� hr

-- ����1) EMPLOYEES ���̺��� �Ի����� ������ �����Ͽ� 
-- �����ȣ, �̸�, ����, �޿�, �Ի�����,�μ���ȣ�� ����϶�.

SELECT employee_id, last_name, job_id, salary, hire_date, department_id
FROM employees
ORDER BY hire_date;



-- ����2) EMPLOYEES ���̺��� ���� �ֱٿ� �Ի��� ������ 
-- �����ȣ, �̸�, ����, �޿�, �Ի�����,�μ���ȣ�� ����϶�.


SELECT employee_id, last_name, job_id, salary, hire_date, department_id
FROM employees
ORDER BY hire_date DESC;

-- ����3) EMPLOYEES ���̺��� �μ���ȣ�� ������ �� �μ���ȣ�� ���� ���
--�޿��� ���� ������ �����Ͽ� �����ȣ, ����, ����, �μ���ȣ, �޿��� ����Ͽ���.

SELECT employee_id, last_name, job_id, department_id, salary
FROM employees
ORDER BY department_id , salary DESC;

-- ����4) EMPLOYEES ���̺��� ù��° ������ �μ���ȣ��
--�ι�° ������ ������ ����° ������ �޿��� ���� ������ �����Ͽ� 
--�����ȣ,����, �Ի�����, �μ���ȣ, ����, �޿��� ����Ͽ���.

SELECT employee_id, last_name,hire_date, department_id, job_id, salary
FROM employees
ORDER BY department_id, job_id, salary DESC;


-- ����1) �μ����� ����ϴ� ������ �ѹ��� ����Ͽ���
SELECT DISTINCT department_id, job_id
FROM employees;




-- scott ����

-- 19) emp ���̺��� �����ȣ, ����̸�, �Ի����� ����ϴµ� �Ի����� ���� ��������� �����Ͻÿ�
SELECT empno, ename, hiredate
FROM emp
ORDER BY hiredate ASC;


-- 20) emp ���̺��� ����̸�, �޿�, ������ ���ϰ� ������ ���� ������ �����Ͻÿ�
SELECT ename, sal,  sal * 12 as ����
FROM emp
ORDER BY sal DESC;

-- 21) 10�� �μ��� 20�� �μ����� �ٹ��ϰ� �ִ� ����� �̸��� �μ���ȣ�� ����ϴµ� 
--          �̸��� �����ڼ����� ǥ���Ͻÿ�
SELECT ename, deptno
FROM emp
WHERE Deptno IN(10,20)
ORDER BY ename;

-- 22) Ŀ�̼��� �޴� ��� ����� �̸�, �޿� �� Ŀ�̼��� �������� ������������ �����Ͽ� ǥ���Ͻʽÿ�.

SELECT ename, sal, comm
FROM emp
WHERE comm IS NOT NULL  AND comm  != 0
ORDER BY comm DESC; 




