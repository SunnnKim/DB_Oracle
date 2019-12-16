-- SUB QUERY 
-- 쿼리문 안에 쿼리문
-- 한 개의 행(row)에서 결과 값이 반환되는 Query

-- < Sub Query를 사용할 수 있는 경우와 없는 경우 >
-- SELECT               단일행(ROW) , 단일컬럼(COLUMN)만 가능( 값이 2개 이상이면 안됨) , 나오는 데이터가 한개, 컬럼 한개
--                                   : SELECT FIRST_NAME, SALARY FROM EMP <- 이렇게 사용 못한다.
-- FROM                  다중 ROW, 다중 COLUMN
-- WHERE               다중 ROW, 다중 COLUMN            ---> 제일 많이 사용



-- 아래는 안되는 예 : 다중 컬럼은 사용 불가능
SELECT EMPLOYEE_ID, (SELECT FIRST_NAME, LAST_NAME FROM employees) FROM employees;
-- 다중 ROW 도 사용 불가능
SELECT EMPLOYEE_ID, (SELECT FIRST_NAME FROM employees) FROM employees;

-- SELECT절에서 사용할 수 있는 서브 쿼리 예
SELECT employee_id, first_name, 
                 (SELECT salary FROM employees WHERE employee_id = 100) 
FROM employees;
-- 위의 코드는 컬럼 데이터가 딱 1개 나오기 때문에 서브쿼리를 사용가능하다
SELECT employee_id, first_name, 
                 (SELECT SUM(salary) FROM employees) 
FROM employees;
-- 그룹함수도 사용할 수 있다: 값이 1개만 나오기 때문



-- FROM절에서 Sub Query 사용하는 경우
SELECT employee_id, first_name, department_id 
FROM ( SELECT   employee_id, first_name, department_id
                FROM employees
                WHERE department_id = 20);

-- 부서번호가 20번, 급여가 6000이상의 사원
SELECT e.employee_id, e.salary
FROM ( SELECT
                        *
                FROM employees
                WHERE department_id = 20) e
WHERE salary > 6000;


-- 예제2
SELECT a.employee_id, a.first_name, 
                a.job_id, b.job_id,
                b.급여합계, b.인원수
FROM employees a, (SELECT job_id, sum(salary) as 급여합계, COUNT(*) 인원수
                                        FROM employees
                                        GROUP BY job_id ) b
WHERE a.job_id = b.job_id;




-- WHERE절에서 Sub Query 사용하기
-- 가장 많이 사용됨

-- 예제 : 평균 월급보다 많이 받는 사람 구하기
SELECT first_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary)
                                FROM employees);

-- in 함수 안에 서브쿼리 넣을 수 있다
SELECT first_name, job_id, department_id
FROM employees
WHERE job_id IN (SELECT  job_id
                                FROM employees
                                WHERE department_id  = 90);



-- 복습 문제
-- 1. 부서별로 가장 급여를 적게 받는 사원과 같은 급여를 받는 사원들 출력

                                    
SELECT first_name, last_name,job_id, department_id,salary
FROM employees
WHERE salary IN ( SELECT MIN(salary)
                                FROM employees
                                GROUP BY department_id)
ORDER BY salary;


-- 2. 부서별로 가장 급여를 적게 받는 사원의 정보


SELECT department_id, first_name, last_name, job_id, salary
FROM employees
WHERE ( salary, department_id ) IN (SELECT MIN(salary), department_id
                                                              FROM employees
                                                              GROUP BY department_id)
ORDER BY department_id;

