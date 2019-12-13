-- JOIN
/*
        JOIN
        : 두개 이상의 테이블을 연결해서 데이터를 검색하는 방법
          보통 두개 이상의 행 (row)들의 공통된 값 primary key (기본키), 
          Foreign Key (외래키) 값을 사용해서 조인
          
          Primary Key (기본키) : 테이블에서 중복이 되지 않는 키
          Foreign Key (외래키) : 다른 테이블에서 Primary Key, Unique Key 일 가능성이 큼
          
          join의 종류
          1) inner join ***** : 가장 많이 쓰임, 교집합
          2) cross join : X(잘안씀)
          3) outer join : 많이 쓰임
                - left *** 
                - right ***
          4) self join ***** : 많이 쓰임
*/

-- inner join 

-- 1. Ansi SQL

SELECT e.employee_id, first_name,
                d.department_name, d.department_id
FROM employees e INNER JOIN departments d
            on e.department_id = d.department_id; 
-- 데이블에 모두 있는 데이터면 객체명 생략가능

-- 2. Oracle

SELECT e.employee_id, first_name,
                d.department_name, d.department_id
FROM employees e, departments d
WHERE e.department_id = d.department_id; 


-- Shanta 의 업무명 찾기 (inner join)
SELECT e.employee_id, e.first_name,
                e.job_id as "Employees Table", j.job_id as "Job Table",
                j.job_title
FROM employees e, jobs j
WHERE e.job_id = j.job_id 
                AND e.first_name = 'Shanta';


-- 147번 사원의 부서명, 업무명 구하기
SELECT e.employee_id, e.first_name,
                e.department_id, d.department_id,
                e.job_id, j.job_id,
                d.department_name, j.job_title
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
               AND e.job_id = j.job_id
               AND e.employee_id = 147;


-- cross Join : 거의 쓸 일이 없다고 본다
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
            
-- 제외된 부분만 뽑기
SELECT e.employee_id, e.first_name,
                e.department_id, d.department_id,
                d.department_name
FROM employees e Full Outer Join departments d
            on e.department_id = d.department_id
WHERE e.department_id IS NULL  OR d.department_id IS NULL;
-- 교집합을 제외한 부분만 출력이 된다.
            
            
-- outer Join
-- left  / right
-- Ansi
SELECT e.employee_id, e.first_name,
                e.department_id, d.department_id
FROM employees e LEFT OUTER JOIN departments d
            on e.department_id = d.department_id;
-- employee가 왼쪽 데이터이고 위의 코드는 

-- oracle
SELECT e.employee_id, e.first_name,
                e.department_id, d.department_id
FROM employees e,  departments d
WHERE e.department_id = d.department_id(+);
-- (+) 기호가 있는 쪽에서 없는 쪽으로 조인된다고 생각하면 됨



-- self Join : 동일한 테이블을 Join
-- ansi
SELECT a.employee_id, a.first_name,
                a.manager_id, b.employee_id,
                b.first_name 
FROM employees a, employees b
WHERE a.manager_id = b.employee_id;
-- a : 사원
-- b : a 사원에 대한 매니저 데이터


-- 계층형 구조
-- 오름형 / 내림형
-- 웹개발자는 많이 쓸 일이 없다

SELECT a.employee_id, a.first_name as "사원",
                b.manager_id as "사원의 상사",
                a.employee_id, 
                b.first_name as "상사"
FROM employees a, employees b
WHERE a.manager_id = b.employee_id(+)

--CONNECT BY PRIOR  a.manager_id = a.employee_id; -- 상향식
 CONNECT BY   a.manager_id = PRIOR a.employee_id; -- 하향식
 

-- PRIOR을  앞에 컬럼에 두면 상향식 표현
--  PRIOR을  뒤에 컬럼에 두면 하향식 표현


