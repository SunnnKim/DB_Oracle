-- 무결성 : 컬럼에 지정하는 성질

-- * Primary Key (PK) 
-- 기본키
-- NULL을 허용하지 않음
-- 중복되지 않는 값
-- ID에 해당되는 키

-- * Unique Key (UK) 
-- 고유키 : 한 개 밖에 없는 키
-- 중복되지 않는 값
-- NULL 허용함
-- email (요즘은 이메일 UK로 많이 설정하지 않음)

-- * Check 
-- 범위를 가지고 있음
-- 설정된 범위의 값만 받을 수 있고 그 이외의 값은 받을 수 없다
-- NULL 허용함

-- * Foreign Key (FK)
-- 외래키 : 다른 테이블에서 PK나 UK 이어야 한다.
-- 목적 : 테이블과 테이블을 연결하기 위함 (Join)
--NULL 허용함

-- * NOT NULL
-- NULL을 허용하지 않음
-- 고유키+ NOT NULL = 기본키


-- 1. NOT NULL
CREATE TABLE TB_TEST(
        COL_01 VARCHAR2(10) NOT NULL,
        COL_02 VARCHAR2(20) 
);
-- 일반적인 행 삽입
INSERT INTO TB_TEST( COL_01, COL_02)
VALUES ( 'AAA', 'aaa');

-- null 값 삽입
INSERT INTO TB_TEST( COL_01, COL_02)
VALUES ( 'AAA', ''); -- 2번째 칼럼은 NULL값 허용하므로 NULL 값이 잘 들어간다

-- null 값 삽입
INSERT INTO TB_TEST( COL_01, COL_02)
VALUES ( '', 'aaa'); -- 1번째 칼럼은 NULL값 허용하지 않으므로 오류가 발생
--위의 코드는 무결성 에러 발생


-- 2. Primary Key : NOT NULL + Unique Key
-- 유일하게 식별할 수 있는 정의된 규칙
-- 한 테이블에서 최대 32개 컬럼까지 지정할 수 있다.
-- CONSTRAINT : 무결성 (PK)에 대한 id를 설정
CREATE TABLE TEST_01(
        KEY_01 VARCHAR2(10) CONSTRAINT PK_TEST_01 PRIMARY KEY ,
        KEY_02 VARCHAR2(10), 
        COL_03 VARCHAR2(20) 
        -- PK 이름 설정하면 나중에 필요에 따라 PK를 지울 수 있음
        -- 이름 설정 안해도 프라이머리 키 만들 수 있으나 이름이 없으면 삭제가 안됨
);

-- 데이터 추가하기
INSERT INTO TEST_01( KEY_01, KEY_02,COL_03)
VALUES ('AAA','aaa','111');
-- 위의 쿼리문을 2번 이상 실행하면 오류발생 : PK는 중복값 허용 X

INSERT INTO TEST_01( KEY_01, KEY_02,COL_03)
VALUES ('BBB','bbb','222');

INSERT INTO TEST_01( KEY_01, KEY_02,COL_03)
VALUES ('','bbb','222');
-- 위의 커리문은 PK가 NULL값을 허용하지 않아 오류가 발생한다.


-- ** DROP으로 컬럼을 지워도 PK는 남아있을 수 있기 때문에
-- CASCADE CONSTRAINTS 를 입력하여 무결성까지 모두 지워야한다
DROP TABLE TEST_01
CASCADE CONSTRAINTS;


-- 여러개의 프라이머리 키

CREATE TABLE TEST_01(
        KEY_01 VARCHAR2(10) CONSTRAINT PK_TEST_01 PRIMARY KEY ,
        KEY_02 VARCHAR2(10)  CONSTRAINT PK_TEST_02 PRIMARY KEY ,
        COL_03 VARCHAR2(20) 
); -- 위 쿼리문은 중복 PK가 만들어지지 않음 (쿼리문 문법 오류임)


-- 아래의 쿼리문은 여러개의 기본키를 만들 수 있다
CREATE TABLE TEST_01(
        KEY_01 VARCHAR2(10) ,
        KEY_02 VARCHAR2(10) ,
        COL_03 VARCHAR2(20) ,
        CONSTRAINT PK_TEST_01 PRIMARY KEY (KEY_01, KEY_02)
); 


INSERT INTO TEST_01( KEY_01, KEY_02,COL_03)
VALUES ('AAA','aaa','111');

-- 아래는 오류남( NOT NULL)
INSERT INTO TEST_01( KEY_01, KEY_02,COL_03)
VALUES ('','aaa','111');
-- 아래는 오류남( NOT NULL)
INSERT INTO TEST_01( KEY_01, KEY_02,COL_03)
VALUES ('AAA','','111');


-- 키가 2개일 때, 한 세트로 봄
-- (하나의 키의 값이 이미 들어와있어도 다른 키 값이 중복되지 않으면 그 데이터는 입력된다.
INSERT INTO TEST_01( KEY_01, KEY_02,COL_03)
VALUES ('AAA','AAA','111');


-- ALTER 로 프라이머리 키 세팅하기
-- 우선 프라이머리 키가 없는 테이블 생성
CREATE TABLE TEST_01(
        KEY_01 VARCHAR2(10) ,
        KEY_02 VARCHAR2(10) ,
        COL_03 VARCHAR2(20) 
); 
-- ALTER - ADD 로 기본키 추가
ALTER TABLE TEST_01
ADD CONSTRAINT PK_TEST_01
PRIMARY KEY( KEY_01, KEY_02);

-- ALTER - DROP 으로 기본키 삭제
ALTER TABLE TEST_01
DROP CONSTRAINT PK_TEST_01;

DROP TABLE TEST_01
CASCADE CONSTRAINTS;

-- 3. Unique Key: 고유키 = Email과 같은 데이터
-- 유일한 값(중복X), NULL을 허용
CREATE TABLE TEST_01(
        UKEY_01 VARCHAR2(10) CONSTRAINT UK_TEST_01 UNIQUE,
        COL_01 VARCHAR2(10) ,
        COL_02 VARCHAR2(10)
);
INSERT INTO TEST_01 (UKEY_01, COL_01, COL_02)
VALUES ( 'AAA', 'aaa', '111');
-- 위의코드는 2번이상 생성할수 없다 (중복허용 X)

INSERT INTO TEST_01 (UKEY_01, COL_01, COL_02)
VALUES ( '', 'aaa', '111');
-- 위의 코드는 삽입이 된다
-- Unique Key는 NULL을 허용하기 때문

-- 기본 테이블에 유니크 키 추가하기
-- ADD

-- 우선 있는것 삭제
ALTER TABLE TEST_01
DROP CONSTRAINT UK_TEST_01;
-- 새로 생성
ALTER TABLE TEST_01
ADD CONSTRAINT UK_TEST_01
UNIQUE ( UKEY_01);
-- 마찬가지로 수정, 여러개의 유니크 키 설정도 기본키와 같은 방법으로 만들 수 있다.

DROP TABLE TEST_01
CASCADE CONSTRAINTS;


-- 4. CHECK
-- 데이터의 값을 범위, 특정한 값의 지정이 가능
-- NULL 허용

CREATE TABLE TEST_01(
        KEY_01 VARCHAR2(10) ,
        COL_01 VARCHAR2(10),
        CONSTRAINT CHK_TEST_01 CHECK (KEY_01 IN ('사과', '배', '바나나')), -- 들어갈 값들을 지정
        CONSTRAINT CHK_TEST_02 CHECK (COL_01 > 0 AND COL_01 <= 100) -- 범위를 지정
);

INSERT INTO TEST_01( KEY_01, COL_01)
VALUES ( '사과', 5); -- 범위 안의 값을 삽입 : 오류 X, 중복 허용

INSERT INTO TEST_01( KEY_01, COL_01)
VALUES ( '사과', 0 );  -- CHECK의 범위안에 없는 수는 오류 발생

INSERT INTO TEST_01( KEY_01, COL_01)
VALUES ( '귤',10 );  -- CHECK의 값의 리스트에 없는 값은 오류 발생

INSERT INTO TEST_01( KEY_01, COL_01)
VALUES ( '','' );  -- NULL값은 삽입이 가능 (NULL허용)
-- 지정된 값 이외의 값중 삽입이 가능한 값은 NULL뿐이다

DROP TABLE TEST_01
CASCADE CONSTRAINTS;


-- 5. Foreign Key 
-- 테이블과 테이블을 연결하기 위한 무결성 제약 조건
-- 다른 테이블 (자식 테이블)의 값이 기본키 또는 고유키로 사용해야한다
-- 중복 허용 X
-- NULL 은 허용

-- < 순서 >
-- 기본키가 있는 테이블 먼저 생성 : 예) hr 계정의 departments
CREATE TABLE TEST_PAR(
            PKEY_01 VARCHAR2(10) , -- 기본키 1
            PKEY_02 VARCHAR2(10) , -- 기본키 2
            COL_01 VARCHAR2 (20) ,
            COL_02 VARCHAR2(20) ,
            CONSTRAINT PK_TEST_01 PRIMARY KEY(PKEY_01, PKEY_02)
);

-- 외래키가 있는 테이블 생성 : 예) hr 계정의 employees
CREATE TABLE TEST_CHD(
        COL_1 VARCHAR2 (10) ,
        FKEY_01 VARCHAR2(10) , -- 외래키는 연결하는 곳과 똑같은 크기와 데이터형으로 만들어야함
        FKEY_02 VARCHAR2(10) ,
        CONSTRAINT FK_TEST_01 FOREIGN KEY (FKEY_01, FKEY_02)
            REFERENCES TEST_PAR(PKEY_01, PKEY_02) -- 어느 테이블의 어느 컬럼을 참조할 건지 작성
); 

-- 데이터 집어넣기
-- PAR
INSERT INTO TEST_PAR ( PKEY_01, PKEY_02, COL_01, COL_02) 
VALUES ( 'AAA', 'aaa', '111', '***');
INSERT INTO TEST_PAR ( PKEY_01, PKEY_02, COL_01, COL_02) 
VALUES ( 'BBB', 'bbb', '222', '*!*');
--CHD
INSERT INTO TEST_CHD ( COL_1, FKEY_01, FKEY_02) 
VALUES ( 'ABC', 'AAA', 'aaa'); -- 외래키를 등록할 때는 참조한 테이블에 값이 있어야 집어넣을 수 있음

--오류남
INSERT INTO TEST_CHD ( COL_1, FKEY_01, FKEY_02) 
VALUES ( 'ABC', 'aaa', 'aaa'); -- 참조한 테이블에 없는 외래키값이면 오류가 생김

-- NULL허용
INSERT INTO TEST_CHD ( COL_1, FKEY_01, FKEY_02) 
VALUES ( 'CDE', '', ''); -- NULL은 허용함


-- DDL :
-- 다룰 테이블 복제해서 생성하기
CREATE TABLE EMP 
AS
SELECT
    *
FROM employees; -- 테이블을 복제하면 모든 제약조건이 다 빠짐 ( CHECK빼고)

-- UPDATE

UPDATE emp
SET salary = 12000, department_id = NULL -- 바꿀 컬럼과 값
WHERE employee_id = 100 ;-- 바꿀 조건

SELECT  first_name, salary FROM emp WHERE employee_id =100;

ROLLBACK; -- 커밋전에 데이터를 돌려놓을 수 있음
COMMIT; -- 커밋하면 롤백해도 소용없음

-- DELETE

DELETE 
FROM EMP
WHERE salary > 15000;
-- 조회
SELECT  first_name, salary FROM emp;



