-- 문제1) EMPLOYEES 테이블에서 부서별로 인원수,평균 급여,급여의 합,최소 급여, 최대 급여를 포함하는 
-- EMP_DEPTNO 테이블을 생성하라.
CREATE TABLE EMP_DEPTNO
AS
SELECT COUNT(department_id) AS "인원수", AVG(salary)"평균급여", SUM(salary) "급여의합", MIN(salary) "최소급여", MAX(salary) "최대급여" 
FROM employees
GROUP BY department_id;

-- 방법2
CREATE TABLE EMP_DEPTNO(
            "부서번호",
            "인원수",
            "평균 급여",
            "급여의 합",
            "최소 급여",
            "최대 급여"
) 
AS 
SELECT department_id, COUNT(department_id), ROUND(AVG(salary)),SUM(salary),
                MIN(salary), MAX(salary)
FROM employees
GROUP BY department_id;
SELECT
    *
FROM emp_deptno;

-- 문제2) EMP_DEPTNO 테이블에 ETC COLUMN을 추가하라.
-- 단 자료형은 VARCHAR2(50) 사용하라.

ALTER TABLE EMP_DEPTNO
ADD 
ETC_COLUMN VARCHAR2(50);




-- 문제3) EMP_DEPTNO 테이블에 ETC COLUMN을 수정하라.
-- 자료 형은 VARCHAR2(15)로 하라.

ALTER TABLE EMP_DEPTNO
MODIFY ETC_COLUMN VARCHAR2(15);



-- 문제4) EMP_DEPTNO 테이블에 있는 ETC 을 삭제하고 확인하라.

ALTER TABLE EMP_DEPTNO
DROP COLUMN ETC_COLUMN;


-- 문제5) 이전에 생성한 EMP_DEPTNO 테이블의 이름을 EMP_DEPT로 변경하라.
ALTER TABLE EMP_DEPTNO
RENAME TO EMP_DEPT;

-- 혹은
RENAME EMP_DEPTNO 
TO EMP_DEPT;

-- 문제6) EMP_DEPT 테이블을 삭제하라.
DROP TABLE EMP_DEPT
CASCADE CONSTRAINTS;


-- 문제7) EMPLOYEES 테이블을 EMP 테이블을 생성하고 복제하도록 하라.(데이터 포함)
CREATE TABLE EMP
AS
SELECT *
FROM employees;



-- 문제8) EMP 테이블에 row를 추가해 봅니다.
-- 다만, 반드시 데이터를 기입을 안해도 되면, NULL로 설정하도록 한다.

INSERT INTO EMP ( EMPLOYEE_ID, FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE, JOB_ID
                                    ,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID)
VALUES ('','','AAA','aaa@bbb.com','',SYSDATE, 'IT_PROG','','','','');



-- 문제9) EMPLOYEES 테이블에서 EMPNO,ENAME,SAL,HIREDATE의 COLUMN만
-- 선택하여 EMP_10 테이블을 생성(데이터 미포함)한 후 10번 부서만 선택하여
-- 이에 대응하는 값을 EMP_10테이블에 입력하라.

CREATE TABLE EMP_10
AS
SELECT employee_id, first_name, last_name, email, salary, hire_date
FROM employees
WHERE 1=2;

INSERT INTO EMP_10(employee_id, first_name, last_name, email, salary, hire_date)
    SELECT employee_id, first_name, last_name, email, salary, hire_date
    FROM employees
    WHERE department_id = 10;


-- 문제10) EMPLOYEES 테이블에서 사원 번호가 107인 사원의 부서를 10번으로
-- 변경하여라.
UPDATE EMP
SET department_id = 10
WHERE employee_id = 107;

-- 문제11) EMPLOYEES 테이블에서 사원 번호가 180인 사원의 부서를 20, 급여를
-- 3500으로 변경하여라.

UPDATE emp
SET department_id = 20, salary = 3500
WHERE employee_id = 180;


-- 문제12) EMPLOYEES 테이블에서 Smith의 업무와 급여가 Hall의 업무와 급여와
-- 일치하도록 수정하라.

UPDATE EMP
SET job_id = (SELECT job_id FROM emp WHERE last_name='Hall'),
        salary =  (SELECT salary FROM emp WHERE last_name='Hall') 
WHERE last_name = 'Smith';









