--����1) EMPLOYEES ���̺�� DEPARTMENTS ���̺��� 
--Cartesian Product(��� ������ ����� Join)�Ͽ� �����ȣ,�̸�,����,�μ���ȣ,�μ���, �ٹ����� ����Ͽ���. 

-- Cartesian Product : Cross Join
SELECT  e.employee_id, e.last_name, e.job_id,
        e.department_id "EMPLOYEE.ID", d.department_id as "DEPARTMENT.ID",
        d.department_name, d.location_id
FROM employees e, departments d;


--����2) EMPLOYEES ���̺��� �����ȣ,�̸�,����, EMPLOYEES ���̺��� �μ���ȣ, 
--DEPARTMENTS ���̺��� �μ���ȣ,�μ���,�ٹ����� ����Ͽ���. 
SELECT  e.employee_id, e.last_name, e.job_id,
        e.employee_id, d.department_id,
        d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id;



--����3) Alexander Hunold �� �μ����� ����϶�. 
SELECT e.first_name||' ' || e.last_name "Name", d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
    AND e.last_name='Hunold';


--����4) ������ �μ����� �ٹ��ϰ� �ִ� ������� ����϶�. 
SELECT  e.employee_id, e.last_name,
        d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id  
      AND d.department_name = 'Sales';


--����5) EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� 
--SA_MAN ������� �����ȣ,�̸�,�޿�,�μ���,�ٹ����� ����϶�. (Alias�� ���) 
SELECT e.employee_id, e.last_name, e.salary,
       d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id AND
      e.job_id = 'SA_MAN';



--����6) EMPLOYEES ���̺�� DEPARTMENTS ���̺��� DEPARTMENTS ���̺� �ִ� ��� �ڷḦ 
--�����ȣ,�̸�,����, EMPLOYEES ���̺��� �μ��� ȣ, 
--DEPARTMENTS ���̺��� �μ���ȣ,�μ���,�ٹ����� ����Ͽ��� (Outer Join) 

-- department�� outer join
SELECT e.employee_id, e.last_name,e.job_id,
       e.department_id, d.department_id,
       d.department_name, d.location_id
FROM employees e, departments d
WHERE d.department_id = e.department_id(+);


--employee�� outer join
SELECT e.employee_id, e.last_name,e.job_id,
       e.department_id, d.department_id,
       d.department_name, d.location_id
FROM employees e, departments d
WHERE d.department_id(+) = e.department_id;



--����7) EMPLOYEES ���̺��� Self join�Ͽ� ������(�Ŵ���)�� ����Ͽ���. 
SELECT a.employee_id, a.last_name,
       b.employee_id"Manager Id", b.last_name "Manager Name"
FROM employees a, employees b
WHERE a.manager_id = b.employee_id;


--����8) EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)�� ����ϰ� 
--�Ŵ��� ���̵� ���� ����� �����ϰ� ��������� �ϸ�, �޿��� �������� ����϶�. 

SELECT a.employee_id, a.first_name||' '||a.last_name,
       a.manager_id, b.employee_id, 
       b.last_name, a.salary
       
FROM employees a, employees b

WHERE a.manager_id = b.employee_id(+) 
START WITH a.manager_id IS NOT NULL  
CONNECT BY a.manager_id = PRIOR a.employee_id
ORDER BY salary DESC;



--����9) EMPLOYEES ���̺��� right join�Ͽ� 
--������(�Ŵ���)�� 108�� ��������� �޿��� �������� ����϶�. 

SELECT a.employee_id, a.last_name,a.manager_id,
       b.employee_id, b.last_name, a.salary 
FROM employees a, employees b
WHERE a.manager_id(+) = b.employee_id
        AND a.MANAGER_ID = '108'
CONNECT BY PRIOR a.manager_id = a.employee_id
ORDER BY a.salary DESC;

