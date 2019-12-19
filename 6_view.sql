/*
    view : 가상 테이블
    - 실체가 없는 테이블 
    - 실제 저장되는 것이 아님 => c언어 포인터와 비슷한 개념
    - table <- view 로 접근
    - 창문의 역할 : 뷰를 통해 테이블을 볼 수 있음
    - 원하는 것만 뽑아서 볼 수 있음
    - 한개의 뷰로 여러개의 테이블의 데이터를 검색하는 것이 가능
    - 처리 속도가 빠름
    - 제한을 설정할 수 있음 (READ ONLY)
    - 데이터를 삽입할 때 무결성을 주의해서 데이터를 넣어야 함
    - 검색용으로 많이 쓰임
   
*/
CREATE VIEW UB_TEST_01(
        JOB_ID ,
        JOB_TITLE,
        MIN_SALARY
) AS
SELECT job_id, job_title, min_salary
FROM jobs;

-- 결과 테스트
SELECT * FROM ub_test_01; -- 창문을 통해서 검색함


INSERT INTO ub_test_01
VALUES('DEVELOPER', '개발자', 10000); -- 뷰에 데이터 삽입
-- 데이터를 삽입할 수는 있지만 실체가 없어서
-- 삽입된 데이터는 JOBS 테이블에 저장된다
-- 아래의 코드를 실행하면 방금 삽입한 데이터가 들어가있는 것을 알 수 있다
SELECT * FROM JOBS;
ROLLBACK; -- 커밋전에 수정하려면 롤백을 실행하면 된다.
COMMIT; -- 커밋후에 수정하려면 MODIFY나 UPDATE 예약어 또는 view 로  수정해야함


CREATE TABLE TB_TEST02(
        KEY_01 VARCHAR2(10),
        KEY_02 VARCHAR2(10),
        COL_01 VARCHAR2(20),
        COL_02 VARCHAR2(20),
        CONSTRAINT PK_TEST_02 PRIMARY KEY(KEY_01, KEY_02)
);

CREATE VIEW UB_TEST_02(
        KEY_01, 
        KEY_02,
        COL_01,
        CONSTRAINT PK_UB_TEST_02 PRIMARY KEY (KEY_01, KEY_02)
                DISABLE NOVALIDATE
) AS
SELECT KEY_01, KEY_02, COL_01
FROM TB_TEST02;

-- 데이터보기
SELECT * FROM TB_TEST02;

INSERT INTO UB_TEST_02( KEY_01, KEY_02, COL_01)
VALUES ('AAA', 'aaa', '111');

SELECT * FROM UB_TEST_02;


--READ ONLY
CREATE OR REPLACE VIEW EMPVIEW ( -- OR REPLACE : 이미 있는 테이블/뷰에 새로운 테이블을 덮어씌움
        "사원번호" , 
        "성" ,
        "이메일",
        "입사일",
        "업무",
        CONSTRAINT PK_UB_EMP PRIMARY KEY ("사원번호")
        DISABLE NOVALIDATE
)
AS
SELECT employee_id, last_name,email, hire_date, job_id FROM employees
WITH READ ONLY; -- 데이터 삽입이 불가능(오류발생함)
-- 확인
SELECT
    *
FROM empview;

INSERT INTO empview
VALUES(400,'KIM','MIN@NAVER.COM', SYSDATE, 'IT_PROG');
-- 에러발생 (READ ONLY이기 때문


-- 두개의 테이블을 뷰를 통해 한꺼번에 취득이 가능

CREATE OR REPLACE VIEW DEPT_EMP_VIEW
AS 
SELECT e.employee_id, e.first_name, d.department_id,    
                d.department_name, d.location_id
FROM  employees e, departments d
WHERE e.department_id = d.department_id
WITH READ ONLY;

SELECT
    *
FROM dept_emp_view;  --- 원하는 데이터에 빠르게 접근할 수 있다. 

