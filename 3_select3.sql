-- ORDER BY : 정렬

SELECT * FROM emp
ORDER BY sal ASC;
-- 오름차순 정렬

SELECT *
FROM emp
ORDER BY hiredate;
-- 기본(아무것도 쓰지 않으면)은 오름차순


-- ALIAS 명으로 정렬 가능
SELECT empno, ename, sal * 12 AS annsal
FROM emp
ORDER BY annsal ASC;


-- NULLS FIRST / LAST 
-- Null 값이 있는 경우의 정렬
SELECT
    *
FROM emp
ORDER BY comm NULLS FIRST;
-- NULL 값을 가장 위로 정렬하기

SELECT    *
FROM emp
ORDER BY comm NULLS FIRST;
-- NULL 값을 가장 아래로 정렬하기

-- 문자열은 알파벳(또는 가나다) 순으로 정렬
SELECT employee_id, job_id
FROM employees
ORDER BY job_id ASC;
-- 같은 값은 랜덤으로 출력

-- 정렬 대상을 2개 이상 설정할 수 있다.
SELECT employee_id, job_id, salary
FROM employees
ORDER BY job_id ASC, salary DESC;
-- job_id 를 오름차순으로, 같은 값은 두번째 정렬 대상인 salary 를 내림차순으로 정렬



-- 함수
-- 문자열을 합하는 기능
-- 1) || 사용하기
SELECT first_name || ' ' || last_name
FROM employees;

-- 2) CONCAT( )
SELECT CONCAT( first_name , last_name) -- 무조건 앞뒤문자 붙여서 나옴
FROM employees;

--MONTHS_BETWEEN : 두 날짜의 간의 월수
SELECT ROUND(MONTHS_BETWEEN('2020-05-04', '2019-12-13')) AS MONTH_BETWEEN
FROM dual;
-- 소수점이 나오기 때문에 Trunc() 나 Round를 사용하는 것이 좋음
--> 더 큰 쪽의 달을 앞에다가 두어야 함

-- add_month() : 특정 날짜 월에 정수에 더한 다음 해당 날짜를 반환
SELECT add_months('2019-12-13',3)
FROM dual;

-- 
-- 날짜 정보에서 특정한 연도, 월, 일, 시, 분, 초 를 구하기
SELECT EXTRACT(year from sysdate) AS 연도,
                 EXTRACT(month from sysdate) AS 월,
                 EXTRACT(day from sysdate) AS 일
FROM dual;
-- EXTRACT(year/month/day/... from'해당 년/월/일/시/분/초') 
-- sysdate 로 하면 오늘 날짜가 나옴


-- TO_DATE () 를 이용해서 특정 날짜나 다른 날짜형식도 입력할 수 있다.
SELECT EXTRACT(year from TO_DATE('20191001','YYYYMMDD')) AS 연도,
                 EXTRACT(month from TO_DATE('19/10/01')) AS 월,
                 EXTRACT(day from TO_DATE('19/10/01')) AS 일
FROM dual;

-- 시, 분, 초 구하기
-- CAST() 함수로 변환 : CAST( 날짜(시간)데이터 AS TIMESTAMP)
SELECT EXTRACT(HOUR from CAST(sysdate AS TIMESTAMP)) AS 시,
                 EXTRACT(MINUTE from CAST(sysdate AS TIMESTAMP)) AS 분,
                 EXTRACT(SECOND from CAST(sysdate AS TIMESTAMP)) AS 초
FROM dual;
-- sysdate가 아닌 문자열로 입력할 수 있으나, 
-- 시간정보를 입력하지 않은 날짜데이터는 현재 시간으로 나오게 된다.




-- Group By
-- 그룹으로 묶는 기능

-- 1. DISTINCT : 중복 제거함
SELECT DISTINCT department_id, employee_id
FROM employees
ORDER BY department_id ASC;

-- 2. Group By
SELECT department_id -- , employee_id(오류나는 코드)  : 그룹으로 묶어버리면 묶은 컬럼만 볼수있고 두개 이상은 묶을 수 없다.
FROM employees
GROUP BY department_id
ORDER BY department_id ASC; -- 보기 편하기 위해 정렬



/*
2.    Group 함수
    - COUNT
    - SUM
    - AVG
    - MAX
    - MIN

    - GROUP BY 와 같이 사용하는 함수임

*/

SELECT COUNT(salary), COUNT(*) ||'명' as 인원수, -- 두 방법은 동일한 결과를 출력한다.
                SUM(salary), AVG(salary)
FROM employees
WHERE job_id = 'IT_PROG';
-- 이 방법도 그룹으로 묶인다.


-- 위의 코드와 아래 코드는 똑같은 결과

SELECT COUNT(salary), COUNT(*) ||'명' as 인원수, -- 두 방법은 동일한 결과를 출력한다.
                SUM(salary) as 월급합계 , AVG(salary) as 월급평균, job_id 
FROM employees
WHERE job_id = 'IT_PROG'
GROUP BY job_id;
-- 그룹으로 묶었을 때는 묶은 그룹의 다른 컬럼도 볼 수 있지만
-- 묶지 않았을 때는 그룹 함수를 사용하지 않고는 다른 컬럼데이터를 볼 수 없다.
-- 아래 코드는 오류가 난다.

SELECT COUNT(salary), COUNT(*) , job_id
FROM employees
WHERE job_id = 'IT_PROG';


/*3. NVL ( ) : 대상이 되는 컬럼이 NULL이었을 때 처리해주는 함수 

1) NVL( )
-- NUMBER 자료형일 때
NVL( 대상이 되는 컬럼, 값);
대상이 되는 컬럼 != NULL ---> 대상이 되는 컬럼 출력
대상이 되는 컬럼 = NULL ---> 값

--VARCHAR2 자료형일 때
NVL( 대상이 되는 컬럼, '없음');
SELECT COUNT(salary), COUNT(*) ||'명' as 인원수, -- 두 방법은 동일한 결과를 출력한다.
                SUM(salary) as 월급합계 , AVG(salary) as 월급평균
FROM employees
WHERE job_id = 'IT_PROG'
GROUP BY job_id;

2) NVL2( ) : NULL 일 때와 아닐 때 값을 구분해서 표현
NVL2(대상이 되는 컬럼, 1, 0 )
대상이 되는 컬럼 != NULL ---> 1
대상이 되는 컬럼 = NULL ---> 0


-- 자바에서 NullPointerException 막는데 유용하다
*/

SELECT first_name, NVL(commission_pct, )
FROM employees;


SELECT first_name, NVL2(commission_pct, 'O','X' )
FROM employees;



-- 그룹함수로의 적용
SELECT department_id, SUM(salary), MAX(salary), 
                TRUNC(AVG(salary),2)
FROM employees
GROUP BY department_id
ORDER BY department_id ASC;



-- Having 
-- 조건절 
-- 무조건 group by와 같이 사용해야 함 ( 독단적으로 사용불가, 에러 뜸 )

SELECT job_id, SUM(salary)
FROM employees
GROUP BY job_id
HAVING SUM(salary) >= 100000
ORDER BY SUM(salary) DESC;



-- 급여가 5000불 이상 받는 사원만으로 합계를 내서 
-- 업무로 그룹화하여 급여 합계가 20000 불을 초과하는 업무명을 구하시오. 
SELECT job_id, COUNT(*), SUM (salary), ROUND(avg(salary))
FROM employees
WHERE salary >= 5000
GROUP BY job_id
HAVING SUM(salary)  > 20000 ;



-- < order by >

-- 과제 hr

-- 문제1) EMPLOYEES 테이블에서 입사일자 순으로 정렬하여 
-- 사원번호, 이름, 업무, 급여, 입사일자,부서번호를 출력하라.

SELECT employee_id, last_name, job_id, salary, hire_date, department_id
FROM employees
ORDER BY hire_date;



-- 문제2) EMPLOYEES 테이블에서 가장 최근에 입사한 순으로 
-- 사원번호, 이름, 업무, 급여, 입사일자,부서번호를 출력하라.


SELECT employee_id, last_name, job_id, salary, hire_date, department_id
FROM employees
ORDER BY hire_date DESC;

-- 문제3) EMPLOYEES 테이블에서 부서번호로 정렬한 후 부서번호가 같을 경우
--급여가 많은 순으로 정렬하여 사원번호, 성명, 업무, 부서번호, 급여를 출력하여라.

SELECT employee_id, last_name, job_id, department_id, salary
FROM employees
ORDER BY department_id , salary DESC;

-- 문제4) EMPLOYEES 테이블에서 첫번째 정렬은 부서번호로
--두번째 정렬은 업무로 세번째 정렬은 급여가 많은 순으로 정렬하여 
--사원번호,성명, 입사일자, 부서번호, 업무, 급여를 출력하여라.

SELECT employee_id, last_name,hire_date, department_id, job_id, salary
FROM employees
ORDER BY department_id, job_id, salary DESC;


-- 문제1) 부서별로 담당하는 업무를 한번씩 출력하여라
SELECT DISTINCT department_id, job_id
FROM employees;




-- scott 계정

-- 19) emp 테이블에서 사원번호, 사원이름, 입사일을 출력하는데 입사일이 빠른 사람순으로 정렬하시오
SELECT empno, ename, hiredate
FROM emp
ORDER BY hiredate ASC;


-- 20) emp 테이블에서 사원이름, 급여, 연봉을 구하고 연봉이 많은 순으로 정렬하시오
SELECT ename, sal,  sal * 12 as 연봉
FROM emp
ORDER BY sal DESC;

-- 21) 10번 부서와 20번 부서에서 근무하고 있는 사원의 이름과 부서번호를 출력하는데 
--          이름을 영문자순으로 표시하시오
SELECT ename, deptno
FROM emp
WHERE Deptno IN(10,20)
ORDER BY ename;

-- 22) 커미션을 받는 모든 사원의 이름, 급여 및 커미션을 기준으로 내림차순으로 정렬하여 표시하십시오.

SELECT ename, sal, comm
FROM emp
WHERE comm IS NOT NULL  AND comm  != 0
ORDER BY comm DESC; 




