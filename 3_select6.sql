-- Ư�� Query
-- CASE / DECODE
-- 1. Case
-- ����Ŭ���� ����ϴ� ����ġ ��
SELECT employee_id, first_name, phone_number,
          CASE SUBSTR(phone_number, 1, 3)
                    WHEN '515' THEN '����'   
                    WHEN '590' THEN '�λ�'
                    WHEN '659' THEN '����'
                    WHEN '603' THEN '����'
                    ELSE '��Ÿ'
        END AS "����"
FROM employees;
-- Alias �Ƚᵵ ������ �÷��� �ʹ� ������ϱ� �����ϵ��� ��
-- �Ǵ�  
SELECT employee_id, first_name, phone_number,
                CASE 
                            WHEN  SUBSTR(phone_number, 1, 3 ) = '515' THEN '����'
                            WHEN  SUBSTR(phone_number, 1, 3 ) = '590' THEN '�λ�'
                            WHEN  SUBSTR(phone_number, 1, 3 ) = '659' THEN '����'
                            WHEN  SUBSTR(phone_number, 1, 3 ) = '603' THEN '�뱸'
                            ELSE '��Ÿ'
                END AS 
FROM employees;





-- 2. DECODE
SELECT employee_id, first_name, phone_number,
                 DECODE( SUBSTR ( phone_number, 1, 3 ),
                                    '515' ,  '����',
                                    '590' ,  '�λ�',
                                    '659' ,  '����',
                                    '603' ,  '����',
                                    '��Ÿ'  ) AS ����
FROM employees;

-- CASE�� DECODE�� �뵵�� �����ϹǷ� ���ϴ� ������ ã�Ƽ� ���� �ȴ�.



-- �м� �Լ�
-- 1. RANK ( ) : ���� �����ϴ� �Լ�
-- �ߺ� ������ ���� ��� : 
-- RANK() :                  1 2 3 3 5 6
-- DANSE_RANK() :   1 2 3 3 4 5
-- ROW_NUMBER() : 1 2 3 4 5 6
-- ROWNUM 

-- OVER (  PARTITION BY ORDER BY ) : ��ȣ�� ������ �� �ִ� ������
-- Group by�� ����� ����� �Ѵ�.
SELECT job_id, COUNT(*) OVER()
FROM employees;
-- ��ü �� ī��Ʈ

SELECT job_id, COUNT (*) OVER( PARTITION BY job_id)
FROM employees;
-- job_id �� �������� ī��Ʈ ��

SELECT job_id, salary, COUNT(*) OVER ( ORDER BY salary DESC)
FROM employees;
-- ���� ī��Ʈ�� ���� �������� ī��Ʈ�� ����


-- RANK() / DENSE_RANK() / ROW_NUMBER() �Լ�
SELECT first_name, salary, job_id,
                RANK ( ) OVER (ORDER BY salary DESC) as rank
               --, DENSE_RANK ( ) OVER (  ORDER BY salary DESC) as dense_rank
               --, ROW_NUMBER () OVER ( ORDER BY salary desc) as row_number
FROM employees;




-- ROWNUM : 
-- 10���� ROW���� �����ϴ� ��� : ���ȣ 
SELECT ROWNUM, employee_id, first_name, last_name
FROM employees;

--10�� ������ �ҷ�����
SELECT ROWNUM, employee_id, first_name, last_name
FROM employees
WHERE ROWNUM <= 10;

-- 11��°~20��° ���� �ҷ�����
SELECT ROWNUM, employee_id, first_name, last_name
FROM employees
WHERE ROWNUM > 10 AND ROWNUM <= 20;
-- ���� ����� �ȵ�
-- ��������� WHERE ���� 1��, �״����� ROWNUM�� ���̱� ������ �ƹ��͵� ������ �ʴ´�

-- ����
-- 1. ����
-- 2. ROWNUM �ϼ�
-- 3. ���� ����

-- ** �߿� **
SELECT RNUM, employee_id, first_name, salary
FROM    (SELECT ROWNUM as RNUM, employee_id, first_name, salary  -- 2. ROWNUM �ٿ��ֱ�
                 FROM    ( SELECT employee_id, first_name, salary -- 1. ������ ���� : ���ϴ� �����ͷ� ���ı��� ���ش�
                                      FROM   employees
                                      ORDER BY salary DESC) -- ���⼭�� �޿� ������ ������ �� ROWNUM�� ��������
                )
WHERE RNUM >10 AND RNUM <=20;



-- ����

/*
������ : UNION
- Full outer join 
������ : INTERSECT
- Inner join
������ : MINUS
- Outer join ( left join..)
* Join�� �� ���� ����

*/

-- UNION
SELECT job_id
FROM employees
WHERE job_id  IN ( 'AD_VP', 'FI_ACCOUNT' )
UNION 
SELECT job_id
FROM jobs
WHERE job_id  IN ( 'AD_VP', 'IT_PROG' );
-- �� ���̺��� �����Ͱ� �������� ����
-- �ڵ������� sorting�� ��


-- INTERSECT
SELECT employee_id
FROM employees
INTERSECT 
SELECT manager_id
FROM employees;
-- ���� �ڵ�� DISTINCT �� ������� ���� ����� ����
SELECT DISTINCT manager_id
FROM employees;

-- JOIN���� ǥ���ϱ�
SELECT DISTINCT b.employee_id
FROM employees a, employees b
WHERE a.manager_id = b.employee_id;



-- MINUS
SELECT employee_id
FROM employees
MINUS
SELECT manager_id 
FROM employees;
-- ���� �ڵ�� �Ŵ����� �ƴ� ����� ���


/*

-- SELECT �� ����
SELECT �÷� or �Լ� or �׷��Լ� or SubQuery (������,�����÷��� ���) or OVER()
FROM ���̺�� or SubQuery(������, �����÷�) 
[ WHERE ] : ������ IN AND OR AND ALL ANY LIKE < > <> != = SubQuery(������, �����÷�)  
[ GROUP BY ] �÷� (�׷����� ���� �� �ִ� �÷�)
[ HAVING ] : Grouping�� ������, ������ ���� �� ����
[ ORDER BY ] : ���� ASC(�ø�) / DESC (����)
[ START BY ] : ������
[ CONNECT BY ] : ����, PRIOR (����, ����)
-- [ ]�� ����������


JOIN
- INNER
- OUTTER
- SELF JOIN


SUBQUERY 


OVER
RANK()
ROW_NUMBER() -- over ������� ��
ROWNUM


*/






