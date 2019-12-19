-- 문제1) EMPLOYEES 테이블에서 King의 정보를 소문자로 검색하고 
-- 사원번호,성명, 담당업무(소문자로),부서번호를 출력하라.

-- LOWER 함수 사용하기 
SELECT employee_id, last_name, Lower(job_id), department_id
FROM employees
WHERE LOWER(last_name) = 'king';




--문제2) EMPLOYEES 테이블에서 King의 정보를 대문자로 검색하고
--사원번호,성명, 담당업무(대문자로),부서번호를 출력하라.

-- UPPER 함수 사용하기 
SELECT employee_id, last_name, first_name, UPPER(job_id), department_id
FROM employees
WHERE UPPER(last_name) = 'KING';



-- 문제3) DEPARTMENTS 테이블에서 부서번호와 부서이름, 부서이름과 위치번호를 합하여 출력하도록 하라.

-- concat 함수 또는 || 연산사용
SELECT department_id, department_name, 
        CONCAT(department_id,department_name),
        CONCAT(department_name,location_id)
FROM departments;


-- 문제4) EMPLOYEES 테이블에서 이름의 첫 글자가 ‘K’ 보다 크고 ‘Y’보다 적은사원의 정보를 
-- 사원번호, 이름, 업무, 급여, 부서번호를 출력하라. 단 이름순으로 정렬하여라.

--SUBSTR
SELECT employee_id, first_name, job_id, salary, department_id
FROM employees
WHERE SUBSTR(first_name,1,1) > 'K'
      AND SUBSTR(first_name,1,1) < 'Y'
ORDER BY first_name ASC;




-- 문제5) EMPLOYEES 테이블에서 20번 부서 중 이름의 길이 및 급여의 자릿수를
--사원번호, 이름, 이름의 자릿수, 급여, 급여의 자릿수를 출력하라.

-- Length 사용
SELECT employee_id, first_name, length(first_name)"이름의 자릿수", salary, length(salary)"급여의 자릿수"
FROM employees
WHERE department_id = 20;



-- 문제6) EMPLOYEES 테이블에서 이름 중 ‘e’자의 위치를 출력하라.

-- INSTR(문자열, 찾을문자,n번째이후부터찾기,m번째찾은문자의위치)
SELECT first_name,
        INSTR( lower(first_name) , 'e',1,1) as e_1,
        INSTR( lower(first_name) , 'e',1,2) as e_2,
        INSTR( lower(first_name) , 'e',1,3) as e_3
FROM employees;




-- 문제7) 다음의 쿼리를 실행하고 결과를 분석하라.

SELECT ROUND(4567.678),ROUND(4567.678,0),
ROUND(4567.678,2),ROUND(4567.678,-2)
FROM dual;
-- ROUND(숫자):소수점 첫째자리에서 반올림
-- ROUND(숫자, 양수): 양수만큼의 소수점만 반환
-- ROUND(숫자, 음수): 음수의 절대값만큼 양의정수자리로 와서 반올림



--문제8) EMPLOYEES 테이블에서 부서번호가 80인 사람의 급여를 30으로 나눈 나머지를 구하여 출력하라.

--MOD
SELECT salary, MOD(salary,30), department_id
FROM employees
WHERE department_id = 80;



-- 문제9) EMPLOYEES 테이블에서 30번 부서 중 이름과 담당 업무를 연결하여 출력하여라. 
-- 단 담당 업무를 한 줄 아래로 출력하라.
-- ( 보이기엔 한줄처럼 보이지만 그리드를 더블 클릭하면 개행 되었다는 것을 확인할 수 있습니다.)

-- CHR(10) : 라인 피트(new line), 개행   
-- *참고: CHR(13) : 캐리지 리턴 : 현재 커서를 위치한 줄의 맨앞으로 보냄
SELECT employee_id,last_name || CHR(10)|| job_id
FROM employees
WHERE department_id = 30;



-- 문제10) EMPLOYEES 테이블에서 현재까지 근무일 수가 몇주 몇일 인가를 출력하여라. 
-- 단 근무 일수가 많은 사람 순으로 출력하여라.

SELECT  last_name, hire_date, sysdate,
        TRUNC(sysdate - hire_date) as "Total days", 
        TRUNC((sysdate - hire_date) / 7) as weeks,
        mod( (TO_DATE('19/12/01') - hire_date), 7) "남은 날 수"
FROM employees
ORDER by "Total days" DESC;



-- 문제11) EMPLOYEES 테이블에서 부서 50에서 급여 앞에 $를 삽입하고 3자리마다 ,를 출력하라

--TO_CHAR
SELECT first_name, department_id, salary,TO_CHAR(salary, '$999,999,999')
FROM employees
WHERE department_id = 50;


--문제12) 다음의 결과를 분석하여 보아라.

SELECT  EMPLOYEE_ID,LAST_NAME,JOB_ID,SALARY,
        DECODE (JOB_ID,  'IT_PROC',SALARY*1.1,
                        'ST_MAN', SALARY*1.15,
                        'SA_MAN', SALARY*1.2, 
                         SALARY) d_sal
FROM EMPLOYEES
ORDER BY SALARY DESC;
-- decode(): if-else과 비슷한 조건문
-- DECODE(JOB_ID,'IT_PROC',SALARY*1.1,'ST_MAN', SALARY*1.15,'SA_MAN', SALARY*1.2, SALARY)
-- 조건1:JOB_ID ='IT_PROC' 일때 SALARY*1.1
-- 조건2:JOB_ID ='ST_MAN' 일때 SALARY*1.15.....
-- 마지막 조건: 그 나머지 일때는 SALARY 출력

-- Employees 테이블에서 사원번호, 이름, 업무, 급여, 업무에 따른 d_sal 출력하되, 급여를 기준으로 내림차순 정렬




-- 그룹함수
--문제1) EMPLOYEES 테이블에서 모든 SALESMAN(SA_MAN)에 대하여 급여의
--평균, 최고액, 최저액, 합계를 구하여 출력하여라.

SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM employees
WHERE job_id = 'SA_MAN';
    


-- 문제2) EMPLOYEES 테이블에 등록되어 있는 인원수, 보너스가 NULL이 아닌
-- 인원수, 보너스의 평균, 등록되어 있는 부서의 수를 구하여 출력하라.


SELECT  COUNT(last_name) as 인원수, 
        COUNT(commission_pct) 보너스수,
        AVG(commission_pct) "보너스의 평균",
        COUNT(DISTINCT department_id) "부서의 수"
FROM employees;

                                                                                                                                                                                     





-- 문제3) EMPLOYEES 테이블에서 부서별로 인원수, 평균 급여, 최저급여, 최고급여, 급여의 합을 구하여 출력하라.

SELECT department_id,COUNT(salary) 인원수, AVG(salary) 평균급여, 
        MIN(salary), MAX(salary), SUM(salary)
FROM employees
GROUP BY department_id;




-- 문제4) EMPLOYEES 테이블에서 각 부서별로 인원수,급여의 평균, 최저 급여,
-- 최고 급여, 급여의 합을 구하여 급여의 합이 많은 순으로 출력하여라.
SELECT department_id,COUNT(salary) 인원수, AVG(salary) 평균급여, 
        MIN(salary), MAX(salary), SUM(salary)
FROM employees
GROUP BY department_id
ORDER BY SUM(salary) DESC;


-- 문제5) EMPLOYEES 테이블에서 부서별, 업무별 그룹하여 결과를 
-- 부서번호, 업무, 인원수, 급여의 평균, 급여의 합을 구하여 출력하여라.

-- GROUTP BY는 2가지 이상의 조건으로도 묶을 수 있다.
SELECT department_id,job_id, count(*),
        AVG(salary), SUM(salary)
FROM employees
GROUP BY department_id, job_id;




-- 문제6) EMPLOYEES 테이블에서 부서 인원이 4명보다 많은 부서의 
-- 부서번호,인원수, 급여의 합을 구하여 출력하여라.(GROUP BY, HAVING)

SELECT department_id, COUNT(*), SUM(salary)
FROM employees 
GROUP BY department_id
HAVING COUNT(*)>4;





-- 문제7) EMPLOYEES 테이블에서 급여가 최대 10000이상인 부서에 대해서 
-- 부서번호, 평균 급여, 급여의 합을 구하여 출력하여라.

SELECT department_id, AVG(salary), SUM(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 10000;




-- 문제8) EMPLOYEES 테이블에서 업무별 급여의 평균이 10000 이상인 업무에 대해서 
-- 업무명,평균 급여, 급여의 합을 구하여 출력하라.

SELECT job_id, AVG(salary), SUM(salary)
FROM employees
GROUP BY job_id
HAVING AVG(salary) >= 10000;



--문제9) EMPLOYEES 테이블에서 전체 월급이 10000을 초과하는 각 업무에 대해서 
-- 업무와 월급여 합계를 출력하라. 단 판매원은 제외하고 월 급여 합계로 정렬(내림차순)하라.(SA_)


SELECT job_id, SUM(salary)
FROM employees
WHERE job_id NOT LIKE 'SA%'
GROUP BY job_id
HAVING SUM(salary)>10000
ORDER BY SUM(salary) DESC;


