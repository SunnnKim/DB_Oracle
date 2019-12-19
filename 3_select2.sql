
-- SELECT2 : WHERE 절 
-- : 자바의 IF문과 같음 ( 조건절)
/*
    표현식
  1.  비교연산자 ( >, <, >=, <=, =, !=, <> ) 
    - = : 자바와 다르게 1개로 사용 ( 자바 : == )
    - <> : 같지 않다 ( != )
    
    2. NULL, = NULL, IS NULL, IS NOT NULL
    3. ( ) (우선순위연산), NOT, AND (&&없음), OR(||없음)
  
  <WHERE 위치>  
    SELECT 
    FROM 
   ( WHERE 조건 ) -- > 생략가능

*/

-- FIRST_NAME == Julia
SELECT first_name, last_name, salary FROM employees WHERE first_name = 'Julia';
-- 대소문자 구문없으면 다른 결과 나온다
SELECT first_name, last_name, salary FROM employees WHERE first_name = 'julia';
--> 이 코드는 결과가 나오지 않음

-- 급여가 $9000 이상인 사원 찾기
SELECT first_name, salary
FROM employees
WHERE salary >= 9000;

-- 이름이 Shanta 보다 큰 이름 ( 글자의 아스키코드 값이 큰 것)
SELECT first_name, salary
FROM EMPLOYEES
WHERE first_name >= 'Shanta'; -- 모든 철자를 다 비교해서 Shanta보다 스펠이 뒤에 있는 값이 나온다

SELECT first_name, salary
FROM employees
WHERE   first_name >= 'a';
-- 소문자 a는 아무것도 안나옴 ( 첫 글자는 대문자이기 때문)

SELECT first_name, salary
FROM employees
WHERE manager_id = ' ';  ----> ' ' : 빈 문자열을 찾음, NULL 이 아님

SELECT first_name, salary
FROM employees
WHERE manager_id IS NULL;  
---->IS NULL : NULL 값을 찾음

SELECT first_name, salary
FROM employees
WHERE manager_id IS NOT NULL; 
----> IS NOT NULL : NULL이 아닌 값을 찾음

-- AND

SELECT *
FROM employees
WHERE first_name = 'Shanta'
                AND first_name = 'John';
-- 아무 것도 안나온다 (이름이 2개인 데이터가 없기 때문에)

-- OR

SELECT *
FROM employees
WHERE first_name = 'Shanta'
                OR first_name = 'John';
-- 이름이 John 이거나 Shanta 인 사람을 찾아줌



-- 이름이 John, 월급이 5000 이상인 사람 찾기
SELECT first_name, salary
FROM employees
WHERE first_name = 'John' 
                AND salary >=5000;

-- 2007년 12월 31일 이후에 입사한 사원 찾기
-- 방법1
SELECT first_name, hire_date
FROM employees
WHERE hire_date > '07/12/31';

-- 방법2 : TO_DATE 사용
SELECT first_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('20071231','YYYYMMDD'); 
--> 이 방법은 자바에서 데이터 가져왔을 때 그 형식에 맞추어 데이터 산출가능


-- ALL(=AND), ANY (=OR)

-- ALL( A, B) : A AND B
SELECT *
FROM employees
WHERE first_name = ALL('Julia', 'John');

-- ANY( A, B) : A OR B
SELECT *
FROM employees
WHERE first_name = ANY('Julia', 'John');

-- ANY의 사용법 예시

-- 연봉이 8000, 3200, 6000인 사람만 뽑기
SELECT first_name, salary
FROM employees
WHERE salary = ANY(8000,3200,6000);
-- 여러 값을 넣어둔 컬럼에 다양한 값을 한번에 가져올 때 사용

-- IN, NOT IN

-- IN
SELECT first_name, salary
FROM employees
WHERE salary IN(8000, 3200, 6000);

-- NOT IN
SELECT first_name, salary
FROM employees
WHERE salary NOT IN(8000, 3200, 6000);


SELECT first_name, salary
FROM employees
WHERE first_name IN('Julia', 'John');


-- exists
SELECT first_name, job_id
FROM  employees e -- 테이블에도 alias (별칭)을 붙일 수 있음
WHERE NOT EXISTS ( SELECT 1
                                FROM dual
                                WHERE e.job_id = 'IT_PROG' ); 
-- exists 는 1과 0 밖에 없다 (있다/없다)
-- 1이 있을 때만 출력이 되고 0은 출력이 되지 않는다
-- exists 는 Sub Query(쿼리문 안에 쿼리문)  

--NOT EXISTS
SELECT first_name, job_id
FROM  employees e -- 테이블에도 alias (별칭)을 붙일 수 있음
WHERE NOT EXISTS ( SELECT 1
                                FROM dual
                                WHERE e.job_id = 'IT_PROG' ); 
-- Sub Query문이 false인 경우면 출력한다.


SELECT first_name, job_id
FROM  employees e -- 테이블에도 alias (별칭)을 붙일 수 있음
WHERE job_id<> 'IT_PROG' ; 



-- BETWEEN : 범위 연산자

-- salary >= 3200 AND salary <= 9000
-- salary BETWEEN 3200 AND 9000
-- 위 두개의 코드는 같은 결과를 출력한다.


SELECT first_name, salary
FROM employees
WHERE salary BETWEEN 3200 AND 9000;

SELECT first_name, salary
FROM employees
WHERE salary > 3200 AND salary < 9000;

-- NOT BETWEEN
SELECT first_name, salary
FROM employees
WHERE salary NOT BETWEEN 3200 AND 9000;
-- 아래의 결과와 같다
SELECT first_name, salary
FROM employees
WHERE salary < 3200 OR salary > 9000;



-- LIKE
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'G_ra_d'; --> _는 한 개의 문자를 의미한다


SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'K%y'; --> %는 글자의 제한이 없다. 중간에 들어가는 모든 글자 + 

SELECT first_name, last_name
FROM employees
WHERE first_name LIKE '%Al%'; --> %가 앞에 붙어도 맨 앞글자가 Al인 데이터와 중간에 Al이 붙은 글자를 같이 불러온다,

SELECT first_name, last_name
FROM employees
WHERE first_name LIKE '%e%'; --> 데이터에 e(소문자) 가 들어간 모든 데이터를 불러온다
-- 위의 코드는 문자열 검색에 유용하다.

 -- %, _ 는 날짜에도 적용이 된다.
 SELECT first_name,hire_date
 FROM employees
 WHERE hire_date LIKE '0_/12%'; ---> 00~09년도 사이의 12월 입사자를 모두 찾아준다.
 




-- 과제1 ( hr 계정 )

SELECT * FROM employees;

-- 문제1) EMPLOYEES 테이블에서 급여가 3000이상인 사원의 정보를 사원번호,
-- 이름, 담당업무, 급여를 출력하라.
SELECT employee_id, job_id, salary
FROM employees
WHERE salary >= 3000;


-- 문제2) EMPLOYEES 테이블에서 담당 업무가 Manager인 사원의 정보를
-- 사원번호, 성명, 담당업무, 급여, 부서번호를 출력하라.
-- (Manager == ST_MAN)
SELECT employee_id, last_name, job_id, salary, department_id
FROM employees
WHERE job_id = 'ST_MAN';


-- 문제3) EMPLOYEES 테이블에서 입사일자가 2006년 1월 1일 이후에 입사한
-- 사원의 정보를 사원번호, 성명, 담당업무, 급여, 입사일자, 부서번호를 출력하라.
SELECT employee_id, last_name, job_id, salary, hire_date, department_id
FROM employees
WHERE hire_date > TO_DATE('20060101', 'YYYYMMDD');


-- 문제4) EMPLOYEES 테이블에서 급여가 3000에서 5000사이의 정보를 
-- 성명, 담당업무, 급여, 부서번호를 출력하라.
-- (AND만 사용, BETWEEN도 함께 사용) 
SELECT last_name, job_id, salary, department_id
FROM employees
WHERE salary BETWEEN 3000 AND 5000;


SELECT last_name, job_id, salary, department_id
FROM employees
WHERE salary >= 3000 AND salary <= 5000;


--문제5) EMPLOYEES 테이블에서 사원번호가 145,152,203인 사원의 정보를
-- 사원번호, 성명, 담당업무, 급여, 입사일자를 출력하라
-- (IN만 사용, OR만 사용)

SELECT employee_id, last_name, job_id, salary, hire_date
FROM employees
WHERE employee_id IN (145, 152, 203 );


SELECT employee_id, last_name, job_id, salary, hire_date
FROM employees
WHERE employee_id = 145 OR  employee_id =152 OR employee_id =  203 ;

-- 문제6) EMPLOYEES 테이블에서 입사일자가 05년도에 입사한 사원의 정보를
-- 사원번호, 성명, 담당업무, 급여, 입사일자, 부서번호를 출력하라.
-- (LIKE 사용)
SELECT employee_id, last_name, job_id, salary, hire_date, department_id
FROM employees
WHERE hire_date LIKE '05%';

-- 문제7) EMPLOYEES 테이블에서 보너스가 NULL인 사원의 정보를 
-- 사원번호,성명, 담당업무, 급여, 입사일자, 보너스, 부서번호를 출력하라.
-- (IS 사용)
SELECT employee_id, last_name, job_id, salary, 
                 NVL(commission_pct,0), department_id 
FROM employees
WHERE commission_pct IS NULL;


-- 문제8) EMPLOYEES 테이블에서 급여가 7000이상이고 JOB이 Manager인 사원의 정보를 
-- 사원번호, 성명, 담당업무, 급여, 입사일자, 부서번호를 출력하라
-- (AND사용, ST_MAN)
SELECT employee_id, last_name, job_id, salary, hire_date, department_id
FROM employees
WHERE salary >= 7000 AND job_id = 'ST_MAN';



-- 문제9) EMPLOYEES 테이블에서 급여가 10000이상이거나 JOB이 Manager인
-- 사원의 정보를 사원번호, 성명, 담당업무, 급여, 입사일자, 부서번호를 출력하라 
-- (OR사용, ST_MAN)
SELECT employee_id, last_name, job_id, salary, hire_date, department_id
FROM employees
WHERE salary >= 10000 OR job_id = 'ST_MAN';


-- 문제10) EMPLOYEES 테이블에서 급여가 JOB이 ST_MAN, SA_MAN, SA_REP가 아닌 사원의 정보를 
-- 사원번호, 성명, 담당업무, 급여, 부서번호를 출력하라
-- (NOT IN 사용)
SELECT employee_id, last_name, job_id, salary, department_id
FROM employees
WHERE job_id NOT IN('ST_MAN', 'SA_MAN','SA_REP');



-- 문제11) 업무가 PRESIDENT이고 급여가 12000이상이거나 업무가 SALESMAN인 사원의 정보를 
-- 사원번호, 이름, 업무, 급여를 출력하라.

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE (job_id LIKE'%PRE%' AND salary >= 12000) OR ( job_id = 'SA_MAN');


-- 문제12) 업무가 PRESIDENT또는 SALESMAN이고 급여가 12000이상인
-- 사원의 정보를 사원번호, 이름, 업무, 급여를 출력하라.
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE job_id LIKE'%PRE%' OR  ( job_id = 'SA_MAN'  AND salary >12000);



-- 과제2 : scott

SELECT * FROM emp;

-- 6) emp 테이블에서 사원번호가 7698 인 사원의 이름, 업무, 급여를 출력하시오.
SELECT ename, job, sal
FROM emp
WHERE empno = 7698;

-- 7) emp 테이블에서 사원이름이 SMITH인 사람의 이름과 월급, 부서번호를 구하시오.
SELECT ename, sal, deptno
FROM emp
WHERE ename = 'SMITH';

-- 8) 월급이 2500이상 3500미만인 사원의 이름, 입사일, 월급을 구하시오.
SELECT ename, hiredate, sal
FROM emp
WHERE sal >=2500 AND sal < 3500;

-- 9) 급여가 2000에서 3000사이에 포함되지 않는 사원의 이름, 업무, 급여를 출력하시오.
SELECT ename, job, sal
FROM emp
WHERE sal NOT BETWEEN 2000 AND 3000;


-- 10) 81년05월01일과 81년12월03일 사이에 입사한 사원의 이름, 급여, 입사일을 출력하시오.
SELECT ename, sal, hiredate
FROM emp
WHERE hiredate BETWEEN '81/05/01' AND '81/12/03';

-- 11) emp테이블에서 사원번호가 7566,7782,7934인 사원을 제외한 사람들의 사원번호,이름,
--    월급을 출력하시오.

SELECT empno, ename, sal
FROM emp
WHERE empno  NOT IN ( 7566, 7782, 7934 );

-- 12) 부서번호 30(deptno)에서 근무하며 
-- 월 2,000달러 이하를 받는 
-- 81년05월01일 이전에 
--- 입사한 사원의 이름, 급여, 부서번호, 입사일을 출력하시오.
SELECT ename, sal, deptno, hiredate
FROM emp
WHERE deptno = 30 AND sal <=2000  AND hiredate <  '81/05/01';


-- 13) emp테이블에서 급여가 2,000와 5,000 사이고 
-- 부서번호가 10 또는 30인 사원의 
-- 이름과 급여,부서번호를 나열하시오.
SELECT ename, sal, deptno
FROM emp
WHERE (sal BETWEEN 2000 AND 5000 ) AND deptno IN (10,30);

-- 14) 업무가 SALESMAN 또는 MANAGER이면서 
-- 급여가 1,600, 2,975 또는 2,850이 아닌
-- 모든 사원의 이름, 업무 및 급여를 표시하시오.
SELECT ename, job, sal
FROM emp
WHERE job = ANY('SALESMAN', 'MANAGER')
                AND sal NOT IN(1600,2975,2850);



-- 15) emp테이블에서 사원이름 중 S가 포함되지 않은 사람들 중 
-- 부서번호가 20인 사원들의 
-- 이름과 부서번호를 출력하시오.
SELECT ename, deptno
FROM emp
WHERE ename NOT LIKE '%S%' 
                AND deptno = 20;


-- 16) emp테이블에서 이름에 A와 E가 있는 모든 사원의 이름을 표시하시오.
SELECT ename
FROM emp
WHERE ename LIKE '%A%' and ename LIKE '%E%';

-- 17) emp테이블에서 관리자가 없는 모든 사원의 이름과 업무를 표시하시오.
SELECT ename, job
FROM emp
WHERE mgr IS NULL;


-- 18) emp테이블에서 커미션 항목이 입력된 사원들의 이름과 급여, 커미션을 구하시오.
SELECT ename, sal, comm
FROM emp
WHERE comm IS NOT NULL;


 