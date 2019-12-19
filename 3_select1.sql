-- DML insert, delete, select, update : �����͸� �ٷ�� ��� 
-- SELECT�� �����ϴ� ������ 90%�� ������ ����� ���� �߿�
-- PL (Procedure language) 
-- QUERY �� (����)


-- SELECT
/*  SELECT ����

    SELECT 
        (��, ����, COLUMN, �Լ�, SUB QUERY) 
    FROM
        (TABLE��, SUB QUERY); 
        
*/

SELECT 1 FROM DUAL; ---> ������ ���̺� 1�� �־��

-- ���� ������ ��� ���̺��� ��
SELECT * FROM TAB;  ----> ���� ������ ����� ���̺��� ��� ������

-- �ش� ���̺� ���� ��� ���� �ҷ��� ( ��� �÷��� ���̺� ������ )
SELECT * FROM EMP;

-- Ư�� ���̺��� ���ϴ� �÷��� ������ �ҷ����� : SELECT �ڿ� �÷��� ���ش�
SELECT EMPNO FROM EMP;
-- ���ϴ� �÷��� ,�� ���� ��� �ҷ��� �� ����
SELECT EMPNO, ENAME, SAL FROM EMP;

-- ������ �÷��� ���� ����� �� ����

-- + ����
SELECT ENAME, SAL, SAL + 300 FROM EMP;
-- * ����
SELECT EMPNO, SAL, SAL*12 FROM EMP;


-- ALIAS (AS) : 
-- alias : int alias [] = array;     alias[0] = 12;

-- AS : ������ ����, ����( ��½� �÷��� �ٲ���)
SELECT EMPNO AS �����ȣ, SAL ����, SAL*12 "�ϳ�ġ ����" 
FROM EMP;
-- �׸�� �����ȣ�� �����ִ�.
-- " " �� �÷����� �����̽��ٷ� ����� ������ ���
-- �پ��ִ� ���ڿ��� "" ��� �ٷ� ������ �����ϴ�


-- ���� ������ + ||
-- "ABC" + "DEF" (�ڹ�) : �ڹٿ��� ���ڿ� ������ +
-- 'ABC' || 'DEF' (�����ͺ��̽�) : DB���� ���ڿ� ������ ||
SELECT ENAME || ' has $' || SAL AS ���� FROM EMP;



-- distinct : �ߺ����� ����  -----> ���� : group by
-- ���� ������ ������ �� �� ���
SELECT DISTINCT DEPTNO FROM EMP;

-- desc : table�� column�� �ڷ����� ��
-- ( ���� : order by - ���� )
DESC EMP;
DESC DEPT; 


-- ���� 5����
-- 1. EMP ���̺��� �����ȣ, ����̸�, ���� ���
SELECT EMPNO , ENAME , SAL   FROM EMP;

-- 2. EMP���̺��� ����̸��� ������ ����ϴµ� �÷����� �̸�, �� ������ �ٲ㼭 ����Ͻÿ�
SELECT ENAME AS "�� ��", SAL "�� ��"  FROM EMP;

-- 3. EMP ���̺��� �����ȣ, ����̸�, ����, ������ ���ϰ� ���� �÷����� 
-- �����ȣ, ����̸�, ����, �������� ���
SELECT EMPNO �����ȣ, ENAME ����̸�, SAL ����, SAL*12 ���� FROM EMP;

-- 4. EMP ���̺��� ������ �ߺ����� �ʰ� ǥ��
SELECT DISTINCT JOB FROM EMP;

-- 5. EMP���̺��� ������ ������ ���� (SMITH, CLERK)�ؼ� ǥ���ϰ� 
-- �÷����� Employee and Job���� ǥ���Ͻÿ�.
SELECT '(' || ENAME || ', ' || JOB || ')' AS "Employee and Job" FROM EMP;


-- ���� 2 

-- ����1) EMPLOYEES Table�� ��� �ڷḦ ����Ͽ���
SELECT * FROM employees;

-- ����2) EMPLOYEES Table�� �÷����� ��� ����Ͽ���
 DESC employees;
 
 -- ����3) EMPLOYEES Table���� ��� ��ȣ, �̸�, �޿�, �������� ����Ͽ���.
 SELECT employee_id, FIRST_NAME, SALARY, JOB_ID FROM EMPLOYEES;

-- ����4) ��� �������� �޿��� $300���� ��Ű�� �� �ؼ� ���� �����ڸ�
-- ����ϰ� ����� SALARY+300�� ���÷��� �մϴ�
 SELECT FIRST_NAME, SALARY, SALARY+300 FROM EMPLOYEES;

-- ����5) EMP ���̺��� �����ȣ, �̸�, �޿�, ���ʽ�, ���ʽ� �ݾ��� ����Ͽ���.
-- (����� ���ʽ��� ���� + (����*Ŀ�̼�))
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, 
                NVL(commission_pct * SALARY, 0) AS "���ʽ�" , 
                NVL(SALARY + ( commission_pct * SALARY), 0 ) AS "���ʽ�+����"
FROM EMPLOYEES;
-- NVL ( �÷���, ���� �÷��� ���� NULL�� ��� ��Ÿ�� �� );
-- NVL(commission_pct * SALARY, 0); ===> NULL�� �� 0����



-- ����6) EMPLOYEES ���̺��� LAST_NAME�� �̸����� SALARY�� �޿��� ����Ͽ���.
SELECT LAST_NAME AS �̸�, SALARY �޿� FROM EMPLOYEES;


-- ����7) EMPLOYEES ���̺��� LAST_NAME�� Name����, SALARY *12�� Annual Salary(����)�� ����Ͽ���
SELECT LAST_NAME AS "Name", SALARY * 12 AS "Annual Salary" FROM EMPLOYEES; 


-- ����9) EMPLOYEES ���̺��� �̸��� ������ �����Ͽ� ����Ͽ���.
SELECT FIRST_NAME || ' ' || REPLACE(JOB_ID,' ','_') AS "Employees" FROM EMPLOYEES;

-- ����10) EMPLOYEES ���̺��� �̸��� ������
-- ��KING is a PRESIDENT�� �������� ����Ͽ���. 
SELECT FIRST_NAME || ' is a ' || JOB_ID AS "Employees Detail" FROM EMPLOYEES;


-- ����11) EMPLOYEES ���̺��� �̸��� ������
--��KING: 1 Year salary = 60000�� �������� ����Ͽ���
SELECT LAST_NAME || ': 1 Year salary = ' ||  SALARY *12 AS MONTHLY FROM EMPLOYEES; 


-- ����12) EMPLOYEES ���̺��� JOB�� ��� ����϶�.
SELECT DISTINCT JOB_ID FROM EMPLOYEES;







