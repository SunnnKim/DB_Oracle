-- 문제1) EMPLOYEES 테이블에서 20번 부서의 세부 사항을 포함하는 EMP_20 VIEW를 생성 하라

CREATE VIEW EMP_20(
            employee_id, 
            first_name, 
            last_name, 
            email, hire_date, 
            job_id, salary, 
            department_id
)
AS
SELECT employee_id, first_name, last_name, email, hire_date, job_id, salary, department_id
FROM employees
WHERE department_id =20;


-- 문제2) EMPLOYEES 테이블에서 30번 부서만 EMPLOYEE_ID 를 emp_no 로
-- LAST_NAME을 name으로 SALARY를 sal로 바꾸어 EMP_30 VIEW를 생성하라.

CREATE VIEW EMP_30(
        emp_no,
        name,
        sal
)
AS
SELECT employee_id, last_name,salary
FROM employees 
WHERE department_id = 30;

SELECT * FROM emp_30;

-- 문제3) 부서별로 부서명,최소 급여,최대 급여,부서의 평균 급여를 포함하는
-- DEPT_SUM VIEW을 생성하여라.

CREATE VIEW DEPT_SUM(
        DEPARTMENT,
        MAX_SALARY,
        MIN_SALARY,
        AVG_SALARY
)
AS
SELECT d.department_name, MIN(e.salary) , MAX(e.salary) , ROUND(AVG(e.salary))
FROM employees e, departments d
WHERE d.department_id = e.department_id
GROUP BY d.department_name;

SELECT * FROM DEPT_SUM;

-- 문제4) 앞에서 생성한 EMP_20,EMP_30 VIEW을 삭제하여라.

DROP VIEW EMP_20;
DROP VIEW EMP_30;
DROP VIEW DEPT_SUM;


-- 시퀀스문제

--1. 초기값1부터 최대값999,999까지 1씩 증가하는 TEST_SEQ SEQUENCE를 생성하여라.

CREATE SEQUENCE TEST_SEQ
INCREMENT BY 1 
MAXVALUE 999999;

-- 참고
-- NOCACHE  -- 오라클 서버가 미리 할당하고 유지하는 여부를 결정 ( NOCACHE : 저장안함 )
-- NOCYCLE -- 최대값, 최소값에 도달한 후에 계속 값을 생성(사용)할지를 지정


-- 2. 1번에서 작성한 SRQUENCE의 현재 값을 조회하여라.

SELECT TEST_SEQ.CURRVAL  FROM DUAL;
SELECT TEST_SEQ.NEXTVAL  FROM DUAL;
  
-- 3. CURRVAL과 NEXTVAL을 설명하여라.

-- CURRVAL은 현재 시퀀스번호를 출력하는 예약어
-- NEXTVAL은 처음 설정한 증가값을 더해 다음 시퀀스 번호로 이동한다.

-- 4. 1번에서 생성한 SRQUENCE를 삭제하여라.

DROP SEQUENCE TEST_SEQ;

