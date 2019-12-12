
-- SELECT2 : WHERE �� 
-- : �ڹ��� IF���� ���� ( ������)
/*
    ǥ����
  1.  �񱳿����� ( >, <, >=, <=, =, !=, <> ) 
    - = : �ڹٿ� �ٸ��� 1���� ��� ( �ڹ� : == )
    - <> : ���� �ʴ� ( != )
    
    2. NULL, = NULL, IS NULL, IS NOT NULL
    3. ( ) (�켱��������), NOT, AND (&&����), OR(||����)
  
  <WHERE ��ġ>  
    SELECT 
    FROM 
   ( WHERE ���� ) -- > ��������

*/

-- FIRST_NAME == Julia
SELECT first_name, last_name, salary FROM employees WHERE first_name = 'Julia';
-- ��ҹ��� ���������� �ٸ� ��� ���´�
SELECT first_name, last_name, salary FROM employees WHERE first_name = 'julia';
--> �� �ڵ�� ����� ������ ����

-- �޿��� $9000 �̻��� ��� ã��
SELECT first_name, salary
FROM employees
WHERE salary >= 9000;

-- �̸��� Shanta ���� ū �̸� ( ������ �ƽ�Ű�ڵ� ���� ū ��)
SELECT first_name, salary
FROM EMPLOYEES
WHERE first_name >= 'Shanta'; -- ��� ö�ڸ� �� ���ؼ� Shanta���� ������ �ڿ� �ִ� ���� ���´�

SELECT first_name, salary
FROM employees
WHERE   first_name >= 'a';
-- �ҹ��� a�� �ƹ��͵� �ȳ��� ( ù ���ڴ� �빮���̱� ����)

SELECT first_name, salary
FROM employees
WHERE manager_id = ' ';  ----> ' ' : �� ���ڿ��� ã��, NULL �� �ƴ�

SELECT first_name, salary
FROM employees
WHERE manager_id IS NULL;  
---->IS NULL : NULL ���� ã��

SELECT first_name, salary
FROM employees
WHERE manager_id IS NOT NULL; 
----> IS NOT NULL : NULL�� �ƴ� ���� ã��

-- AND

SELECT *
FROM employees
WHERE first_name = 'Shanta'
                AND first_name = 'John';
-- �ƹ� �͵� �ȳ��´� (�̸��� 2���� �����Ͱ� ���� ������)

-- OR

SELECT *
FROM employees
WHERE first_name = 'Shanta'
                OR first_name = 'John';
-- �̸��� John �̰ų� Shanta �� ����� ã����



-- �̸��� John, ������ 5000 �̻��� ��� ã��
SELECT first_name, salary
FROM employees
WHERE first_name = 'John' 
                AND salary >=5000;

-- 2007�� 12�� 31�� ���Ŀ� �Ի��� ��� ã��
-- ���1
SELECT first_name, hire_date
FROM employees
WHERE hire_date > '07/12/31';

-- ���2 : TO_DATE ���
SELECT first_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('20071231','YYYYMMDD'); 
--> �� ����� �ڹٿ��� ������ �������� �� �� ���Ŀ� ���߾� ������ ���Ⱑ��


-- ALL(=AND), ANY (=OR)

-- ALL( A, B) : A AND B
SELECT *
FROM employees
WHERE first_name = ALL('Julia', 'John');

-- ANY( A, B) : A OR B
SELECT *
FROM employees
WHERE first_name = ANY('Julia', 'John');

-- ANY�� ���� ����

-- ������ 8000, 3200, 6000�� ����� �̱�
SELECT first_name, salary
FROM employees
WHERE salary = ANY(8000,3200,6000);
-- ���� ���� �־�� �÷��� �پ��� ���� �ѹ��� ������ �� ���

-- IN, NOT IN

-- IN
SELECT first_name, salary
FROM employees
WHERE salary IN(8000, 3200, 6000);

-- NOT IN
SELECT first_name, salary
FROM employees
WHERE salary NOT IN(8000, 3200, 6000);


SELECT first_name, salary
FROM employees
WHERE first_name IN('Julia', 'John');


-- exists
SELECT first_name, job_id
FROM  employees e -- ���̺��� alias (��Ī)�� ���� �� ����
WHERE NOT EXISTS ( SELECT 1
                                FROM dual
                                WHERE e.job_id = 'IT_PROG' ); 
-- exists �� 1�� 0 �ۿ� ���� (�ִ�/����)
-- 1�� ���� ���� ����� �ǰ� 0�� ����� ���� �ʴ´�
-- exists �� Sub Query(������ �ȿ� ������)  

--NOT EXISTS
SELECT first_name, job_id
FROM  employees e -- ���̺��� alias (��Ī)�� ���� �� ����
WHERE NOT EXISTS ( SELECT 1
                                FROM dual
                                WHERE e.job_id = 'IT_PROG' ); 
-- Sub Query���� false�� ���� ����Ѵ�.


SELECT first_name, job_id
FROM  employees e -- ���̺��� alias (��Ī)�� ���� �� ����
WHERE job_id<> 'IT_PROG' ; 



-- BETWEEN : ���� ������

-- salary >= 3200 AND salary <= 9000
-- salary BETWEEN 3200 AND 9000
-- �� �ΰ��� �ڵ�� ���� ����� ����Ѵ�.


SELECT first_name, salary
FROM employees
WHERE salary BETWEEN 3200 AND 9000;

SELECT first_name, salary
FROM employees
WHERE salary > 3200 AND salary < 9000;

-- NOT BETWEEN
SELECT first_name, salary
FROM employees
WHERE salary NOT BETWEEN 3200 AND 9000;
-- �Ʒ��� ����� ����
SELECT first_name, salary
FROM employees
WHERE salary < 3200 OR salary > 9000;



-- LIKE
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'G_ra_d'; --> _�� �� ���� ���ڸ� �ǹ��Ѵ�


SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'K%y'; --> %�� ������ ������ ����. �߰��� ���� ��� ���� + 

SELECT first_name, last_name
FROM employees
WHERE first_name LIKE '%Al%'; --> %�� �տ� �پ �� �ձ��ڰ� Al�� �����Ϳ� �߰��� Al�� ���� ���ڸ� ���� �ҷ��´�,

SELECT first_name, last_name
FROM employees
WHERE first_name LIKE '%e%'; --> �����Ϳ� e(�ҹ���) �� �� ��� �����͸� �ҷ��´�
-- ���� �ڵ�� ���ڿ� �˻��� �����ϴ�.

 -- %, _ �� ��¥���� ������ �ȴ�.
 SELECT first_name,hire_date
 FROM employees
 WHERE hire_date LIKE '0_/12%'; ---> 00~09�⵵ ������ 12�� �Ի��ڸ� ��� ã���ش�.
 




-- ����1 ( hr ���� )

SELECT * FROM employees;

-- ����1) EMPLOYEES ���̺��� �޿��� 3000�̻��� ����� ������ �����ȣ,
-- �̸�, ������, �޿��� ����϶�.
SELECT employee_id, job_id, salary
FROM employees
WHERE salary >= 3000;


-- ����2) EMPLOYEES ���̺��� ��� ������ Manager�� ����� ������
-- �����ȣ, ����, ������, �޿�, �μ���ȣ�� ����϶�.
-- (Manager == ST_MAN)
SELECT employee_id, last_name, job_id, salary, department_id
FROM employees
WHERE job_id = 'ST_MAN';


-- ����3) EMPLOYEES ���̺��� �Ի����ڰ� 2006�� 1�� 1�� ���Ŀ� �Ի���
-- ����� ������ �����ȣ, ����, ������, �޿�, �Ի�����, �μ���ȣ�� ����϶�.
SELECT employee_id, last_name, job_id, salary, hire_date, department_id
FROM employees
WHERE hire_date > TO_DATE('20060101', 'YYYYMMDD');


-- ����4) EMPLOYEES ���̺��� �޿��� 3000���� 5000������ ������ 
-- ����, ������, �޿�, �μ���ȣ�� ����϶�.
-- (AND�� ���, BETWEEN�� �Բ� ���) 
SELECT last_name, job_id, salary, department_id
FROM employees
WHERE salary BETWEEN 3000 AND 5000;


SELECT last_name, job_id, salary, department_id
FROM employees
WHERE salary >= 3000 AND salary <= 5000;


--����5) EMPLOYEES ���̺��� �����ȣ�� 145,152,203�� ����� ������
-- �����ȣ, ����, ������, �޿�, �Ի����ڸ� ����϶�
-- (IN�� ���, OR�� ���)

SELECT employee_id, last_name, job_id, salary, hire_date
FROM employees
WHERE employee_id IN (145, 152, 203 );


SELECT employee_id, last_name, job_id, salary, hire_date
FROM employees
WHERE employee_id = 145 OR  employee_id =152 OR employee_id =  203 ;

-- ����6) EMPLOYEES ���̺��� �Ի����ڰ� 05�⵵�� �Ի��� ����� ������
-- �����ȣ, ����, ������, �޿�, �Ի�����, �μ���ȣ�� ����϶�.
-- (LIKE ���)
SELECT employee_id, last_name, job_id, salary, hire_date, department_id
FROM employees
WHERE hire_date LIKE '05%';

-- ����7) EMPLOYEES ���̺��� ���ʽ��� NULL�� ����� ������ 
-- �����ȣ,����, ������, �޿�, �Ի�����, ���ʽ�, �μ���ȣ�� ����϶�.
-- (IS ���)
SELECT employee_id, last_name, job_id, salary, 
                 NVL(commission_pct,0), department_id 
FROM employees
WHERE commission_pct IS NULL;


-- ����8) EMPLOYEES ���̺��� �޿��� 7000�̻��̰� JOB�� Manager�� ����� ������ 
-- �����ȣ, ����, ������, �޿�, �Ի�����, �μ���ȣ�� ����϶�
-- (AND���, ST_MAN)
SELECT employee_id, last_name, job_id, salary, hire_date, department_id
FROM employees
WHERE salary >= 7000 AND job_id = 'ST_MAN';



-- ����9) EMPLOYEES ���̺��� �޿��� 10000�̻��̰ų� JOB�� Manager��
-- ����� ������ �����ȣ, ����, ������, �޿�, �Ի�����, �μ���ȣ�� ����϶� 
-- (OR���, ST_MAN)
SELECT employee_id, last_name, job_id, salary, hire_date, department_id
FROM employees
WHERE salary >= 10000 OR job_id = 'ST_MAN';


-- ����10) EMPLOYEES ���̺��� �޿��� JOB�� ST_MAN, SA_MAN, SA_REP�� �ƴ� ����� ������ 
-- �����ȣ, ����, ������, �޿�, �μ���ȣ�� ����϶�
-- (NOT IN ���)
SELECT employee_id, last_name, job_id, salary, department_id
FROM employees
WHERE job_id NOT IN('ST_MAN', 'SA_MAN','SA_REP');



-- ����11) ������ PRESIDENT�̰� �޿��� 12000�̻��̰ų� ������ SALESMAN�� ����� ������ 
-- �����ȣ, �̸�, ����, �޿��� ����϶�.

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE (job_id LIKE'%PRE%' AND salary >= 12000) OR ( job_id = 'SA_MAN');


-- ����12) ������ PRESIDENT�Ǵ� SALESMAN�̰� �޿��� 12000�̻���
-- ����� ������ �����ȣ, �̸�, ����, �޿��� ����϶�.
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE job_id LIKE'%PRE%' OR  ( job_id = 'SA_MAN'  AND salary >12000);



-- ����2 : scott

SELECT * FROM emp;

-- 6) emp ���̺��� �����ȣ�� 7698 �� ����� �̸�, ����, �޿��� ����Ͻÿ�.
SELECT ename, job, sal
FROM emp
WHERE empno = 7698;

-- 7) emp ���̺��� ����̸��� SMITH�� ����� �̸��� ����, �μ���ȣ�� ���Ͻÿ�.
SELECT ename, sal, deptno
FROM emp
WHERE ename = 'SMITH';

-- 8) ������ 2500�̻� 3500�̸��� ����� �̸�, �Ի���, ������ ���Ͻÿ�.
SELECT ename, hiredate, sal
FROM emp
WHERE sal >=2500 AND sal < 3500;

-- 9) �޿��� 2000���� 3000���̿� ���Ե��� �ʴ� ����� �̸�, ����, �޿��� ����Ͻÿ�.
SELECT ename, job, sal
FROM emp
WHERE sal NOT BETWEEN 2000 AND 3000;


-- 10) 81��05��01�ϰ� 81��12��03�� ���̿� �Ի��� ����� �̸�, �޿�, �Ի����� ����Ͻÿ�.
SELECT ename, sal, hiredate
FROM emp
WHERE hiredate BETWEEN '81/05/01' AND '81/12/03';

-- 11) emp���̺��� �����ȣ�� 7566,7782,7934�� ����� ������ ������� �����ȣ,�̸�,
--    ������ ����Ͻÿ�.

SELECT empno, ename, sal
FROM emp
WHERE empno  NOT IN ( 7566, 7782, 7934 );

-- 12) �μ���ȣ 30(deptno)���� �ٹ��ϸ� 
-- �� 2,000�޷� ���ϸ� �޴� 
-- 81��05��01�� ������ 
--- �Ի��� ����� �̸�, �޿�, �μ���ȣ, �Ի����� ����Ͻÿ�.
SELECT ename, sal, deptno, hiredate
FROM emp
WHERE deptno = 30 AND sal <=2000  AND hiredate <  '81/05/01';


-- 13) emp���̺��� �޿��� 2,000�� 5,000 ���̰� 
-- �μ���ȣ�� 10 �Ǵ� 30�� ����� 
-- �̸��� �޿�,�μ���ȣ�� �����Ͻÿ�.
SELECT ename, sal, deptno
FROM emp
WHERE (sal BETWEEN 2000 AND 5000 ) AND deptno IN (10,30);

-- 14) ������ SALESMAN �Ǵ� MANAGER�̸鼭 
-- �޿��� 1,600, 2,975 �Ǵ� 2,850�� �ƴ�
-- ��� ����� �̸�, ���� �� �޿��� ǥ���Ͻÿ�.
SELECT ename, job, sal
FROM emp
WHERE job = ANY('SALESMAN', 'MANAGER')
                AND sal NOT IN(1600,2975,2850);



-- 15) emp���̺��� ����̸� �� S�� ���Ե��� ���� ����� �� 
-- �μ���ȣ�� 20�� ������� 
-- �̸��� �μ���ȣ�� ����Ͻÿ�.
SELECT ename, deptno
FROM emp
WHERE ename NOT LIKE '%S%' 
                AND deptno = 20;


-- 16) emp���̺��� �̸��� A�� E�� �ִ� ��� ����� �̸��� ǥ���Ͻÿ�.
SELECT ename
FROM emp
WHERE ename LIKE '%A%' and ename LIKE '%E%';

-- 17) emp���̺��� �����ڰ� ���� ��� ����� �̸��� ������ ǥ���Ͻÿ�.
SELECT ename, job
FROM emp
WHERE mgr IS NULL;


-- 18) emp���̺��� Ŀ�̼� �׸��� �Էµ� ������� �̸��� �޿�, Ŀ�̼��� ���Ͻÿ�.
SELECT ename, sal, comm
FROM emp
WHERE comm IS NOT NULL;


 