-- JOIN
/*
        JOIN
        : �ΰ� �̻��� ���̺��� �����ؼ� �����͸� �˻��ϴ� ���
          ���� �ΰ� �̻��� �� (row)���� ����� �� primary key (�⺻Ű), 
          Foreign Key (�ܷ�Ű) ���� ����ؼ� ����
          
          Primary Key (�⺻Ű) : ���̺��� �ߺ��� ���� �ʴ� Ű
          Foreign Key (�ܷ�Ű) : �ٸ� ���̺��� Primary Key, Unique Key �� ���ɼ��� ŭ
          
          join�� ����
          1) inner join ***** : ���� ���� ����, ������
          2) cross join : X(�߾Ⱦ�)
          3) outer join : ���� ����
                - left *** 
                - right ***
          4) self join ***** : ���� ����
*/

-- inner join 

-- 1. Ansi SQL

SELECT e.employee_id, first_name,
                d.department_name, d.department_id
FROM employees e INNER JOIN departments d
            on e.department_id = d.department_id; 
-- ���̺� ��� �ִ� �����͸� ��ü�� ��������

-- 2. Oracle

SELECT e.employee_id, first_name,
                d.department_name, d.department_id
FROM employees e, departments d
WHERE e.department_id = d.department_id; 


-- Shanta �� ������ ã�� (inner join)
SELECT e.employee_id, e.first_name,
                e.job_id as "Employees Table", j.job_id as "Job Table",
                j.job_title
FROM employees e, jobs j
WHERE e.job_id = j.job_id 
                AND e.first_name = 'Shanta';


-- 147�� ����� �μ���, ������ ���ϱ�
SELECT e.employee_id, e.first_name,
                e.department_id, d.department_id,
                e.job_id, j.job_id,
                d.department_name, j.job_title
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
               AND e.job_id = j.job_id
               AND e.employee_id = 147;


-- cross Join : ���� �� ���� ���ٰ� ����
-- Ansi
SELECT e.employee_id, e.first_name,
                e.department_id, d.department_id,
                d.department_name
FROM employees e CROSS  JOIN departments d;

-- Oracle
SELECT e.employee_id, e.first_name,
                e.department_id, d.department_id,
                d.department_name
FROM employees e, departments d;


-- full outer Join
-- ansi
SELECT e.employee_id, e.first_name,
                e.department_id, d.department_id,
                d.department_name
FROM employees e Full Outer Join departments d
            on e.department_id = d.department_id;
            
-- ���ܵ� �κи� �̱�
SELECT e.employee_id, e.first_name,
                e.department_id, d.department_id,
                d.department_name
FROM employees e Full Outer Join departments d
            on e.department_id = d.department_id
WHERE e.department_id IS NULL  OR d.department_id IS NULL;
-- �������� ������ �κи� ����� �ȴ�.
            
            
-- outer Join
-- left  / right
-- Ansi
SELECT e.employee_id, e.first_name,
                e.department_id, d.department_id
FROM employees e LEFT OUTER JOIN departments d
            on e.department_id = d.department_id;
-- employee�� ���� �������̰� ���� �ڵ�� 

-- oracle
SELECT e.employee_id, e.first_name,
                e.department_id, d.department_id
FROM employees e,  departments d
WHERE e.department_id = d.department_id(+);
-- (+) ��ȣ�� �ִ� �ʿ��� ���� ������ ���εȴٰ� �����ϸ� ��



-- self Join : ������ ���̺��� Join
-- ansi
SELECT a.employee_id, a.first_name,
                a.manager_id, b.employee_id,
                b.first_name 
FROM employees a, employees b
WHERE a.manager_id = b.employee_id;
-- a : ���
-- b : a ����� ���� �Ŵ��� ������


-- ������ ����
-- ������ / ������
-- �������ڴ� ���� �� ���� ����

SELECT a.employee_id, a.first_name as "���",
                b.manager_id as "����� ���",
                a.employee_id, 
                b.first_name as "���"
FROM employees a, employees b
WHERE a.manager_id = b.employee_id(+)

--CONNECT BY PRIOR  a.manager_id = a.employee_id; -- �����
 CONNECT BY   a.manager_id = PRIOR a.employee_id; -- �����
 

-- PRIOR��  �տ� �÷��� �θ� ����� ǥ��
--  PRIOR��  �ڿ� �÷��� �θ� ����� ǥ��


