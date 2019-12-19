-- ����6: hr 

-- ����1) EMPLOYEES ���̺��� Kochhar�� �޿����� ���� ����� ������
-- �����ȣ,�̸�,������,�޿��� ����϶�.
SELECT employee_id, first_name, last_name, job_id, salary
FROM employees
WHERE salary > ( SELECT e.salary 
                                    FROM employees e
                                    WHERE last_name = 'Kochhar');


-- ����2) EMPLOYEES ���̺��� �޿��� ��պ��� ���� ����� ������ 
--�����ȣ, �̸�,������,�޿�,�μ���ȣ�� ����Ͽ���.

SELECT employee_id, first_name, last_name, job_id, salary, department_id
FROM employees
WHERE salary < ( SELECT AVG(salary)
                              FROM employees );

-- ����3) EMPLOYEES ���̺��� 100�� �μ��� �ּ� �޿����� �ּ� �޿��� ���� �ٸ� ��� �μ��� ����϶�

SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING   MIN(salary) > (SELECT MIN(salary)
                                            FROM employees
                                            WHERE department_id = 100);
                                            
-- ����4) �������� �ּ� �޿��� �޴� ����� ������ 
-- �����ȣ,�̸�,����,�μ���ȣ�� ����Ͽ���. �� �������� �����Ͽ���.

SELECT e.employee_id, e.last_name, e.job_id, e.salary, e.department_id
FROM employees e,  (SELECT job_id, MIN(salary) min
                                    FROM employees
                                    GROUP BY job_id )  b
WHERE e.salary = b.min AND e.job_id = b.job_id
ORDER BY job_id;

-- �ٸ� ���

SELECT employee_id, last_name, job_id, department_id, salary
FROM employees 
WHERE (job_id, salary) IN ( SELECT job_id, MIN(salary)
                                                FROM employees
                                                GROUP BY job_id)
ORDER BY job_id ASC;

    
    
--����5) EMPLOYEES �� DEPARTMENTS ���̺��� ������ ���ϵ�� ����� ������ 
-- �̸�,����,�μ���,�ٹ����� ����϶�.

-- Sub Query
SELECT last_name, job_id, d.department_name,d.location_id
FROM departments d, (SELECT last_name, job_id, department_id
                                        FROM employees
                                        WHERE  job_id ='SA_MAN' ) e
WHERE d.department_id = e.department_id;

-- Join
SELECT first_name, job_id, d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
                AND e.job_id = 'SA_MAN';



-- ����6) EMPLOYEES ���̺��� ���� ���� ����� ���� MANAGER�� �����ȣ�� ����϶�.
SELECT c.manager_id, c.count
FROM (SELECT ROWNUM,b.manager_id, b.count
            FROM  (SELECT manager_id, COUNT(*) as count
                           FROM employees
                           GROUP BY manager_id 
                           ORDER BY COUNT(*) DESC )b) c  
WHERE ROWNUM = 1;

-- ����� ��
 SELECT manager_id
                                        FROM employees 
                                        GROUP BY manager_id
                                        HAVING COUNT(manager_id) = ( SELECT MAX( COUNT(*))
                                                                                                    FROM employees 
                                                                                                    GROUP BY manager_id);



-- ����7) EMPLOYEES ���̺��� ���� ���� ����� �����ִ� �μ���ȣ�� ������� ����϶�.
SELECT a.department_id �μ���ȣ, a.count as �����
FROM ( SELECT ROWNUM, department_id, count
                FROM (  SELECT department_id, COUNT(*) as count
                                FROM employees
                                GROUP BY department_id
                                ORDER BY COUNT(*) DESC)) a
WHERE ROWNUM =1;


-- ����� ��
SELECT department_id, count(*)
FROM employees
GROUP BY department_id
HAVING COUNT (department_id) = (SELECT MAX(COUNT(*))
                                                                FROM employees 
                                                                GROUP BY department_id);



-- ����8) EMPLOYEES ���̺��� �����ȣ�� 123�� ����� ������ ����
--�����ȣ�� 192�� ����� �޿�(SAL)���� ���� ����� 
--�����ȣ, �̸�, ����, �޿��� ����϶�.

SELECT employee_id, first_name, last_name, job_id,salary
FROM employees
WHERE  job_id = (SELECT job_id
                                FROM employees
                                WHERE employee_id = 123) AND
                salary > (SELECT salary
                                FROM employees
                                WHERE employee_id = 192);



-- ����9) ����(JOB)���� �ּ� �޿��� �޴� ����� ������ �����ȣ, �̸�, ����, �μ����� ����϶�.
-- ����1 : �������� �������� ����


SELECT employee_id, last_name, job_id, d.department_name
FROM employees, departments d
WHERE  d.department_id = employees.department_id AND
                salary IN (SELECT MIN(salary) min
                                    FROM employees
                                    GROUP BY job_id) 
ORDER BY job_id DESC;



-- ����10) EMPLOYEES ���̺��� �������� �ּ� �޿��� �޴� ����� ������ 
--�����ȣ,�̸�,����,�Ի�����,�޿�,�μ���ȣ�� ����϶�

SELECT a.employee_id, a.last_name, a.job_id, a.hire_date,a.salary, a.department_id
FROM employees a, (SELECT job_id, MIN(salary) min
                                    FROM employees
                                    GROUP BY job_id) b
WHERE a.job_id = b.job_id 
                AND a.salary = b.min
ORDER BY job_id ;
                     




-- ����11) EMPLOYEES ���̺��� 50�� �μ��� �ּ� �޿��� �޴� ��� ���� ���� �޿��� �޴� ����� ������ 
--�����ȣ,�̸�,����,�Ի�����,�޿�,�μ���ȣ�� ����϶�. �� 50���� ����

SELECT employee_id, last_name, job_id, hire_date, salary, department_id
FROM employees
WHERE department_id != 50 AND
                salary > (SELECT MIN(salary)
                                FROM employees
                                WHERE department_id = 50);




--����12) EMPLOYEES ���̺��� 50�� �μ��� �ְ� �޿��� �޴� ��� ���� ���� �޿��� �޴� ����� ������ 
-- �����ȣ,�̸�,����,�Ի�����,�޿�,�μ���ȣ������϶�. ��50���� ����

SELECT employee_id, last_name, job_id, hire_date, salary, department_id
FROM employees
WHERE department_id != 50 AND
                salary > (SELECT MAX(salary)
                                FROM employees
                                WHERE department_id = 50);


-- ����13) �ֱ� �Ի��� ��� ������ �ۼ��ؼ� 1 ~ 10��°, 11 ~ 20 ����� ������ ����Ͻÿ�
SELECT  employee_id, first_name, last_name, hire_date, salary , job_id, department_id
FROM ( SELECT ROWNUM rnum, employee_id, first_name, last_name, hire_date, salary , job_id, department_id
               FROM    (SELECT employee_id, first_name, last_name, hire_date, salary , job_id, department_id
                                FROM employees 
                                ORDER BY hire_date DESC))
WHERE rnum <=10;




SELECT  employee_id, first_name, last_name, hire_date, salary , job_id, department_id
FROM ( SELECT ROWNUM rnum, employee_id, first_name, last_name, hire_date, salary , job_id, department_id
               FROM    (SELECT employee_id, first_name, last_name, hire_date, salary , job_id, department_id
                                FROM employees 
                                ORDER BY hire_date DESC))
WHERE rnum >10 AND rnum <= 20;


