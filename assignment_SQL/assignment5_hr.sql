/*
        Join : 다른 테이블에 저장되어 있는 데이터를 산출하기 위함
        employees 테이블에서 department_id (외래키) 뽑을 수 있음
        department_id 를 통해 departments 테이블에서 department_name 에 접근할 수 있음
        < 예시 >
        Blank 라는 이름을 가진 직원의 department_name?
        employees 테이블에서 dapartment_id을 가지고  departments 테이블에 접근 
        -> departments.department_name을 가지고 옴
*/

-- 문제 ) IT부서에서 근무하고 있는 사람들을 출력하라
SELECT e.first_name, e.last_name,
                e.department_id,d.department_name, salary
FROM employees e, departments d
WHERE e.department_id = d.department_id
                AND d.department_name = 'IT';



--문제1) EMPLOYEES 테이블과 DEPARTMENTS 테이블을 
--Cartesian Product(모든 가능한 행들의 Join)하여 사원번호,이름,업무,부서번호,부서명, 근무지를 출력하여라. 

-- Cartesian Product : Cross Join
SELECT  e.employee_id, e.last_name, e.job_id,
        e.department_id "EMPLOYEE.ID", d.department_id as "DEPARTMENT.ID",
        d.department_name, d.location_id
FROM employees e, departments d;


--문제2) EMPLOYEES 테이블에서 사원번호,이름,업무, EMPLOYEES 테이블의 부서번호, 
--DEPARTMENTS 테이블의 부서번호,부서명,근무지를 출력하여라. 

-- inner join
SELECT  e.employee_id, e.last_name, e.job_id,
        e.department_id, d.department_id,
        d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id;



--문제3) Alexander Hunold 의 부서명을 출력하라. 
SELECT e.first_name||' ' || e.last_name "Name", d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
    AND e.last_name='Hunold';


--문제4) 세일즈 부서에서 근무하고 있는 사람들을 출력하라. 
SELECT  e.employee_id, e.last_name,
        d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id  
      AND d.department_name = 'Sales';


--문제5) EMPLOYEES 테이블과 DEPARTMENTS 테이블의 부서번호를 조인하고 
--SA_MAN 사원만의 사원번호,이름,급여,부서명,근무지를 출력하라. (Alias를 사용) 
SELECT e.employee_id 사원번호, e.last_name 이름, e.salary 급여,
       d.department_name 부서명, d.location_id 근무지번호
FROM employees e, departments d
WHERE e.department_id = d.department_id AND
      e.job_id = 'SA_MAN';



--문제6) EMPLOYEES 테이블과 DEPARTMENTS 테이블에서 DEPARTMENTS 테이블에 있는 모든 자료를 
--사원번호,이름,업무, EMPLOYEES 테이블의 부서번 호, 
--DEPARTMENTS 테이블의 부서번호,부서명,근무지를 출력하여라 (Outer Join) 

-- department쪽 outer join
SELECT e.employee_id, e.last_name,e.job_id,
       e.department_id, d.department_id,
       d.department_name, d.location_id
FROM departments d,  employees e
WHERE d.department_id = e.department_id(+);



--문제7) EMPLOYEES 테이블에서 Self join하여 관리자(매니저)를 출력하여라. 
SELECT a.employee_id, a.last_name,
       b.employee_id"Manager Id", b.last_name "Manager Name"
FROM employees a, employees b
WHERE a.manager_id = b.employee_id;


--문제8) EMPLOYEES 테이블에서 left join하여 관리자(매니저)를 출력하고 
--매니저 아이디가 없는 사람은 배제하고 하향식으로 하며, 급여는 역순으로 출력하라. 

SELECT a.employee_id, a.first_name||' '||a.last_name,
       a.manager_id, b.employee_id, 
       b.last_name, a.salary
       
FROM employees a, employees b

WHERE a.manager_id = b.employee_id(+) 
START WITH a.manager_id IS NOT NULL  
CONNECT BY a.manager_id = PRIOR a.employee_id
ORDER BY salary DESC;



--문제9) EMPLOYEES 테이블에서 right join하여 
--관리자(매니저)가 108번 상향식으로 급여는 역순으로 출력하라. 

SELECT a.employee_id, a.last_name,a.manager_id,
       b.employee_id, b.last_name, a.salary 
FROM employees a, employees b
WHERE a.manager_id(+) = b.employee_id
        AND a.MANAGER_ID = '108'
CONNECT BY PRIOR a.manager_id = a.employee_id
ORDER BY a.salary DESC;

