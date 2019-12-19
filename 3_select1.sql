-- DML insert, delete, select, update : 데이터를 다루는 명령 
-- SELECT가 차지하는 비중이 90%일 정도로 기능이 많고 중요
-- PL (Procedure language) 
-- QUERY 문 (질의)


-- SELECT
/*  SELECT 구조

    SELECT 
        (값, 문자, COLUMN, 함수, SUB QUERY) 
    FROM
        (TABLE명, SUB QUERY); 
        
*/

SELECT 1 FROM DUAL; ---> 가상의 테이블에 1을 넣어라

-- 현재 계정의 모든 테이블을 명세
SELECT * FROM TAB;  ----> 현재 계정에 저장된 테이블을 모두 가져옴

-- 해당 테이블에 대한 모든 값을 불러옴 ( 모든 컬럼과 테이블 보여줌 )
SELECT * FROM EMP;

-- 특정 테이블에서 원하는 컬럼의 값만을 불러오기 : SELECT 뒤에 컬럼명 써준다
SELECT EMPNO FROM EMP;
-- 원하는 컬럼은 ,을 통해 모두 불러올 수 있음
SELECT EMPNO, ENAME, SAL FROM EMP;

-- 연산한 컬럼의 값도 출력할 수 있음

-- + 연산
SELECT ENAME, SAL, SAL + 300 FROM EMP;
-- * 연산
SELECT EMPNO, SAL, SAL*12 FROM EMP;


-- ALIAS (AS) : 
-- alias : int alias [] = array;     alias[0] = 12;

-- AS : 생략이 가능, 별명( 출력시 컬럼명 바꿔줌)
SELECT EMPNO AS 사원번호, SAL 월급, SAL*12 "일년치 연봉" 
FROM EMP;
-- 항목명에 사원번호로 적혀있다.
-- " " 는 컬럼명이 스페이스바로 띄워져 있을때 사용
-- 붙어있는 문자열은 "" 없어도 바로 적용이 가능하다


-- 연결 연산자 + ||
-- "ABC" + "DEF" (자바) : 자바에서 문자열 연결은 +
-- 'ABC' || 'DEF' (데이터베이스) : DB에서 문자열 연결은 ||
SELECT ENAME || ' has $' || SAL AS 월급 FROM EMP;



-- distinct : 중복행의 삭제  -----> 참고 : group by
-- 값의 종류를 보려고 할 때 사용
SELECT DISTINCT DEPTNO FROM EMP;

-- desc : table의 column의 자료형을 명세
-- ( 참고 : order by - 정렬 )
DESC EMP;
DESC DEPT; 


-- 과제 5문제
-- 1. EMP 테이블에서 사원번호, 사원이름, 월급 출력
SELECT EMPNO , ENAME , SAL   FROM EMP;

-- 2. EMP테이블에서 사원이름과 월급을 출력하는데 컬럼명은 이름, 월 급으로 바꿔서 출력하시오
SELECT ENAME AS "이 름", SAL "월 급"  FROM EMP;

-- 3. EMP 테이블에서 사원번호, 사원이름, 월급, 연봉을 구하고 각각 컬럼명을 
-- 사원번호, 사원이름, 월급, 연봉으로 출력
SELECT EMPNO 사원번호, ENAME 사원이름, SAL 월급, SAL*12 연봉 FROM EMP;

-- 4. EMP 테이블의 업무를 중복되지 않게 표시
SELECT DISTINCT JOB FROM EMP;

-- 5. EMP테이블의 사원명과 업무로 연결 (SMITH, CLERK)해서 표시하고 
-- 컬럼명은 Employee and Job으로 표시하시오.
SELECT '(' || ENAME || ', ' || JOB || ')' AS "Employee and Job" FROM EMP;


-- 과제 2 

-- 문제1) EMPLOYEES Table의 모든 자료를 출력하여라
SELECT * FROM employees;

-- 문제2) EMPLOYEES Table의 컬럼들을 모두 출력하여라
 DESC employees;
 
 -- 문제3) EMPLOYEES Table에서 사원 번호, 이름, 급여, 담당업무를 출력하여라.
 SELECT employee_id, FIRST_NAME, SALARY, JOB_ID FROM EMPLOYEES;

-- 문제4) 모든 종업원의 급여를 $300증가 시키기 위 해서 덧셈 연산자를
-- 사용하고 결과에 SALARY+300을 디스플레이 합니다
 SELECT FIRST_NAME, SALARY, SALARY+300 FROM EMPLOYEES;

-- 문제5) EMP 테이블에서 사원번호, 이름, 급여, 보너스, 보너스 금액을 출력하여라.
-- (참고로 보너스는 월급 + (월급*커미션))
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, 
                NVL(commission_pct * SALARY, 0) AS "보너스" , 
                NVL(SALARY + ( commission_pct * SALARY), 0 ) AS "보너스+월급"
FROM EMPLOYEES;
-- NVL ( 컬럼명, 앞의 컬럼이 값이 NULL일 경우 나타낼 값 );
-- NVL(commission_pct * SALARY, 0); ===> NULL일 때 0으로



-- 문제6) EMPLOYEES 테이블에서 LAST_NAME을 이름으로 SALARY을 급여로 출력하여라.
SELECT LAST_NAME AS 이름, SALARY 급여 FROM EMPLOYEES;


-- 문제7) EMPLOYEES 테이블에서 LAST_NAME을 Name으로, SALARY *12를 Annual Salary(연봉)로 출력하여라
SELECT LAST_NAME AS "Name", SALARY * 12 AS "Annual Salary" FROM EMPLOYEES; 


-- 문제9) EMPLOYEES 테이블에서 이름과 업무를 연결하여 출력하여라.
SELECT FIRST_NAME || ' ' || REPLACE(JOB_ID,' ','_') AS "Employees" FROM EMPLOYEES;

-- 문제10) EMPLOYEES 테이블에서 이름과 업무를
-- “KING is a PRESIDENT” 형식으로 출력하여라. 
SELECT FIRST_NAME || ' is a ' || JOB_ID AS "Employees Detail" FROM EMPLOYEES;


-- 문제11) EMPLOYEES 테이블에서 이름과 연봉을
--“KING: 1 Year salary = 60000” 형식으로 출력하여라
SELECT LAST_NAME || ': 1 Year salary = ' ||  SALARY *12 AS MONTHLY FROM EMPLOYEES; 


-- 문제12) EMPLOYEES 테이블에서 JOB을 모두 출력하라.
SELECT DISTINCT JOB_ID FROM EMPLOYEES;







