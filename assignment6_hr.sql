-- 과제6: hr 

-- 문제1) EMPLOYEES 테이블에서 Kochhar의 급여보다 많은 사원의 정보를
-- 사원번호,이름,담당업무,급여를 출력하라.
SELECT employee_id, first_name, last_name, job_id, salary
FROM employees
WHERE salary > ( SELECT e.salary 
                                    FROM employees e
                                    WHERE last_name = 'Kochhar');


-- 문제2) EMPLOYEES 테이블에서 급여의 평균보다 적은 사원의 정보를 
--사원번호, 이름,담당업무,급여,부서번호를 출력하여라.

SELECT employee_id, first_name, last_name, job_id, salary, department_id
FROM employees
WHERE salary < ( SELECT AVG(salary)
                              FROM employees );

-- 문제3) EMPLOYEES 테이블에서 100번 부서의 최소 급여보다 최소 급여가 많은 다른 모든 부서를 출력하라

SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING   MIN(salary) > (SELECT MIN(salary)
                                            FROM employees
                                            WHERE department_id = 100);
                                            
-- 문제4) 업무별로 최소 급여를 받는 사원의 정보를 
-- 사원번호,이름,업무,부서번호를 출력하여라. 단 업무별로 정렬하여라.

SELECT e.employee_id, e.last_name, e.job_id, e.salary, e.department_id
FROM employees e,  (SELECT job_id, MIN(salary) min
                                    FROM employees
                                    GROUP BY job_id )  b
WHERE e.salary = b.min AND e.job_id = b.job_id
ORDER BY job_id;

-- 다른 방식

SELECT employee_id, last_name, job_id, department_id, salary
FROM employees 
WHERE (job_id, salary) IN ( SELECT job_id, MIN(salary)
                                                FROM employees
                                                GROUP BY job_id)
ORDER BY job_id ASC;

    
    
--문제5) EMPLOYEES 과 DEPARTMENTS 테이블에서 업무가 세일드맨 사원의 정보를 
-- 이름,업무,부서명,근무지를 출력하라.

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



-- 문제6) EMPLOYEES 테이블에서 가장 많은 사원을 갖는 MANAGER의 사원번호를 출력하라.
SELECT c.manager_id, c.count
FROM (SELECT ROWNUM,b.manager_id, b.count
            FROM  (SELECT manager_id, COUNT(*) as count
                           FROM employees
                           GROUP BY manager_id 
                           ORDER BY COUNT(*) DESC )b) c  
WHERE ROWNUM = 1;

-- 강사님 답
 SELECT manager_id
                                        FROM employees 
                                        GROUP BY manager_id
                                        HAVING COUNT(manager_id) = ( SELECT MAX( COUNT(*))
                                                                                                    FROM employees 
                                                                                                    GROUP BY manager_id);



-- 문제7) EMPLOYEES 테이블에서 가장 많은 사원이 속해있는 부서번호와 사원수를 출력하라.
SELECT a.department_id 부서번호, a.count as 사원수
FROM ( SELECT ROWNUM, department_id, count
                FROM (  SELECT department_id, COUNT(*) as count
                                FROM employees
                                GROUP BY department_id
                                ORDER BY COUNT(*) DESC)) a
WHERE ROWNUM =1;


-- 강사님 답
SELECT department_id, count(*)
FROM employees
GROUP BY department_id
HAVING COUNT (department_id) = (SELECT MAX(COUNT(*))
                                                                FROM employees 
                                                                GROUP BY department_id);



-- 문제8) EMPLOYEES 테이블에서 사원번호가 123인 사원의 직업과 같고
--사원번호가 192인 사원의 급여(SAL)보다 많은 사원의 
--사원번호, 이름, 직업, 급여를 출력하라.

SELECT employee_id, first_name, last_name, job_id,salary
FROM employees
WHERE  job_id = (SELECT job_id
                                FROM employees
                                WHERE employee_id = 123) AND
                salary > (SELECT salary
                                FROM employees
                                WHERE employee_id = 192);



-- 문제9) 직업(JOB)별로 최소 급여를 받는 사원의 정보를 사원번호, 이름, 업무, 부서명을 출력하라.
-- 조건1 : 직업별로 내림차순 정렬


SELECT employee_id, last_name, job_id, d.department_name
FROM employees, departments d
WHERE  d.department_id = employees.department_id AND
                salary IN (SELECT MIN(salary) min
                                    FROM employees
                                    GROUP BY job_id) 
ORDER BY job_id DESC;



-- 문제10) EMPLOYEES 테이블에서 업무별로 최소 급여를 받는 사원의 정보를 
--사원번호,이름,업무,입사일자,급여,부서번호를 출력하라

SELECT a.employee_id, a.last_name, a.job_id, a.hire_date,a.salary, a.department_id
FROM employees a, (SELECT job_id, MIN(salary) min
                                    FROM employees
                                    GROUP BY job_id) b
WHERE a.job_id = b.job_id 
                AND a.salary = b.min
ORDER BY job_id ;
                     




-- 문제11) EMPLOYEES 테이블에서 50번 부서의 최소 급여를 받는 사원 보다 많은 급여를 받는 사원의 정보를 
--사원번호,이름,업무,입사일자,급여,부서번호를 출력하라. 단 50번은 제외

SELECT employee_id, last_name, job_id, hire_date, salary, department_id
FROM employees
WHERE department_id != 50 AND
                salary > (SELECT MIN(salary)
                                FROM employees
                                WHERE department_id = 50);




--문제12) EMPLOYEES 테이블에서 50번 부서의 최고 급여를 받는 사원 보다 많은 급여를 받는 사원의 정보를 
-- 사원번호,이름,업무,입사일자,급여,부서번호를출력하라. 단50번은 제외

SELECT employee_id, last_name, job_id, hire_date, salary, department_id
FROM employees
WHERE department_id != 50 AND
                salary > (SELECT MAX(salary)
                                FROM employees
                                WHERE department_id = 50);


-- 문제13) 최근 입사한 사원 순으로 작성해서 1 ~ 10번째, 11 ~ 20 사원의 정보를 출력하시오
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


