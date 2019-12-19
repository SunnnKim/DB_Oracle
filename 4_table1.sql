-- 테이블 생성하기
-- 반드시 시스템 계정으로
CREATE TABLESPACE TABLESPACE2
DATAFILE 'D:\oracle\tabletest\TEST_TBS1.DBF' SIZE 10M
AUTOEXTEND ON NEXT 1M MAXSIZE UNLIMITED  -- 추가되는 용량
LOGGING  -- 로깅 : 기록여부 정함 (화면출력/ 파일저장로깅)
EXTENT MANAGEMENT LOCAL AUTOALLOCATE -- LOCAL
BLOCKSIZE 8K -- 블록의 크기, 블록 크기 크게 잡을수록 대용량 데이터 받을 수 있음
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

-- table space name 테이블 이름 변경 쿼리문 
ALTER TABLESPACE TABLESPACE2
RENAME TO TEST_TBS_NEW;

-- 파일 용량 수정 쿼리문
ALTER DATABASE 
DATAFILE 'D:\oracle\tabletest\TEST_TBS1.DBF' RESIZE 20M;


-- TABLESPACE 삭제하기
DROP TABLESPACE "TABLESPACE1"
INCLUDING CONTENTS AND DATAFILES
CASCADE CONSTRAINTS; -- 무결성



-- 테이블 생성
-- 데이터에서 가장기본적인 데이터 저장 단위
-- 세로열 (컬럼) 과 가로행(로우)으로 표현

-- TABLE 생성
CREATE TABLE TB_TEST01(
    COL_01 VARCHAR2(10),
    COL_02 VARCHAR2(10),
    COL_03 VARCHAR2(10),
    COL_04 VARCHAR2(10)
);
-- TABLESPACE 를 지정하지 않으면 defalut 값은 USERS임


CREATE TABLE TB_TEST02(
    COL_01 VARCHAR2(10),
    COL_02 VARCHAR2(10),
    COL_03 VARCHAR2(10),
    COL_04 VARCHAR2(10)
)
TABLESPACE TABLESPACE2 -- 현재 만드는 테이블의 공간을 유저 계정에 맞추어 하겠다
;

-- TABEL COPY : 데이터 포함해서 모두 복사하기 (원본데이터에 영향없음)
CREATE TABLE TB_TEST03
AS 
SELECT *
FROM jobs; 

SELECT   * FROM tb_test03;


-- 데이블 지우기
DROP TABLE tb_test03;

-- 테이블 복사
CREATE TABLE TB_TEST03
AS 
SELECT JOB_ID as 업무번호, JOB_TITLE as 업무명 -- alias를 통해
FROM jobs; 


DROP TABLE tb_test03;

-- 다른 테이블의 데이터를 복사 + 그룹함수를 적용하여 새로운 테이블을 만들 수 있다 (복제 데이터라 원본에 손상없다)

CREATE TABLE TB_GROUP_DEPT
    AS -- 복사한다는 의미, 아래는 새로운 테이블에 넣을 데이터를 조회하는 쿼리문 
SELECT department_id AS "부서번호", SUM(salary) AS "합계", AVG(salary) AS "평균"
FROM employees
GROUP BY department_id;


-- TABLE COPY : 데이터가 미포함 된 테이블 복사하기 (형태만 복사)
CREATE TABLE TB_TEST04
AS
SELECT
    *
FROM departments
WHERE 1=2;                   -- WHERE 절에 성립할 수 없는 조건을 넣으면 데이터가 미포함된 틀만 복제된다
-- 위의 코드를 실행하면 테이블 형식 및 칼럼의 형식만 가져옴
SELECT
    *
FROM tb_test04;

-- **<참고> 테이블과 데이터 처리 명령어
-- TABLE : CREATE(테이블 생성), ALTER(테이블 수정/변경), DROP(테이블 삭제)
-- DATA : INSERT(데이터 삽입), UPDATE(데이터 수정), DELETE(데이터 삭제), SELECT(데이터조회)


-- TABLE 수정1 : 테이블명 수정
-- ALTER
ALTER TABLE TB_TEST04
RENAME TO TB_TEST99;        -- 테이블명 수정
SELECT * FROM tb_test99;

-- TABLE 수정2 : 단일 컬럼 추가
-- ADD
-- 데이터가 적을 때는 다시 만들면 되지만, 이미 삽입된 데이터가 너무 많으면 칼럼을 추가한다
ALTER TABLE TB_TEST99
ADD
LOCATION_NAME VARCHAR2(30); --추가할 컬럼명 및 컬럼 데이터형 설정


-- TABLE 수정3 : 다중 컬럼 추가
-- ADD
-- 괄호 안에 추가할 컬럼 및 데이터형을 써준다
ALTER TABLE TB_TEST99
ADD
( COL_01 VARCHAR2(30) , COL_02 NUMBER(5,2) );


-- TABLE 수정4 : 단일 컬럼 수정
-- MODIFY 
ALTER TABLE TB_TEST99
MODIFY 
COL_01 VARCHAR2(20);    -- 용량 수정도 가능함


-- TABLE 수정5 : 다중 컬럼 수정
-- MODIFY 
ALTER TABLE TB_TEST99
MODIFY 
(COL_01 VARCHAR2(20), COL_02 NUMBER(4) );

-- TABLE 수정 : 단일 컬럼 삭제
-- DROP
ALTER TABLE TB_TEST99
DROP COLUMN LOCATION_NAME;

-- TABLE 수정 : 다중 컬럼 삭제
ALTER TABLE TB_TEST99
DROP 
(COL_01, COL_02);


--TABLE 수정 : 컬럼명 수정
-- RENAME
ALTER TABLE TB_TEST99
RENAME 
COLUMN DEPARTMENT_ID TO "부서번호";


-- TABLE 삭제 :
-- DROP
DROP TABLE TB_TEST01;
-- CASCADE CONSTRAINTS : 무결성 데이터 모두 다 지워짐
DROP TABLE TB_TEST02
CASCADE CONSTRAINTS;


-- 삭제한 테이블 휴지통에서 복구하기
FLASHBACK TABLE TB_TEST02
TO BEFORE DROP;

-- 휴지통 비우기
-- PURGE : 테이블 복구가 안되기 때문에 신중하게 써야함
PURGE RECYCLEBIN;

