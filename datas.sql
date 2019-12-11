-- SELECT * FROM employees;
select * from employees;
SELECT * FROM EMPLOYEES;

-- sql 한줄 주석문은 // 이 아니고 --

/*
범위 주석문 
*/



-- 자료형
--  java                            orcle
--   int                        Integer, NUMBER
-- String                     VARCHAR2, CHAR
-- double                   NUMBER( 정수의 자리수 , 소수의 자리수 )
-- Date                       DATE


-- 문자열 
-- CHAR
create table TB_CHAR(
    COL_CHAR1 CHAR(10 BYTE) ,     -- String COL_CHAR1(크기);
    COL_CHAR2 CHAR( 10 CHAR),    -- char : 문자열
    COL_CHAR3 CHAR(10)
);

/*
create TABLE 테이블명(
        컬럼명 자료형(크기)
        컬럼명 자료형(크기)
        컬럼명 자료형(크기)
        ..
);
*/
-- 테이블에 데이터 추가하기
INSERT into TB_CHAR( COL_CHAR1,COL_CHAR2,COL_CHAR3)
values ('ABC', 'ABC','ABC');             -- 영문자 1문자 당 크기 : 1 BYTE

SELECT * FROM tb_char ;

INSERT into TB_CHAR( COL_CHAR1,COL_CHAR2,COL_CHAR3)
values ('가', '가','가');                      -- 한글의 1문자 당 크기 : 3 BYTE

INSERT into TB_CHAR( COL_CHAR1,COL_CHAR2,COL_CHAR3)
values ('가나', '가나','가나');

INSERT into TB_CHAR( COL_CHAR1,COL_CHAR2,COL_CHAR3)
values ('가나다A', '가나다','가나다');


-- lengthb : byte크기를 알려주는 명령어
SELECT col_char1, col_char2, col_char3,
        LENGTHB(col_char1),  LENGTHB(col_char2),  LENGTHB(col_char3) 
FROM tb_char ;


/*

길이값(용량)
CHAR : 10 BYTE 00000 00000
ABC -> ABC00 00000          --> 낭비되는 영역존재


10 CHAT 
가(3 BYTE) + 9  BYTE = 12
가나 (6 BYTE) + 8 BYTE = 8 + 6 = 14;
가나다(9BYTE) 7 + 9 = 16

*/


-- 문자열 형식은 무조건 ' '(작은 따옴표)만 가능하다

-- VERCHAR 2 
-- verchar2는 사용할 영역보다 크게 용량을 지정해도 사용한 만큼만 차지한다
create Table  TB_VARCHAR(
        COL1 VARCHAR2 (10 BYTE ),
        COL2 VARCHAR2(10 char),
        COL3 VARCHAR2 (10)
);


Insert INTO TB_VARCHAR(COL1, COL2, COL3)
VALUES ('ABC', 'ABC','ABC');

Insert INTO TB_VARCHAR(COL1, COL2, COL3)
VALUES ('가나', '가나','가나');


SELECT COL1, COL2, COL3,
    LENGTHB(COL1), LENGTHB(COL2), LENGTHB(COL3)
From  tb_varchar;



-- LONG : 최대 2 GB까지 저장 가능한 문자
-- TABLE 당 1개만 사용가능
CREATE TABLE TB_LONG(
    COL_LONG1 LONG
--    COL_LONG2 LONG
);
-- 위의 코드의 주석을 해제하면 에러가 난다. 
-- 롱타입은 하나의 컬럼만 사용이 가능하기 때문

INSERT INTO TB_LONG(COL_LONG1)
VALUES ('ABC');
SELECT COL_LONG1 FROM tb_long;
-- LONG은 LENGTHB 사용이 불가능하다
-- 아래의 코드는 실행이 안됨.
SELECT COL_LONG1,LENGTHB(COL_LONG1) 
FROM TB_LONG;



-- 숫자 자료형 ( 정수형 , 정수실수형 )

-- 숫자 (정수만 가능) : INTEGER, 바이트 수 적는 곳 없음
CREATE TABLE TB_INTEGER(
    COL1 INTEGER,
    COL2 INTEGER
);

INSERT INTO TB_INTEGER(COL1, COL2)
VALUES (123,456);

SELECT *  FROM TB_INTEGER;



-- 숫자(정수, 실수 모두가능) : NUMBER
CREATE TABLE TB_NUMBER(
    COL_NUMBER1 NUMBER,          -- 정수, 소수부 모두
    COL_NUMBER2 NUMBER(5),      -- 정수(5자리까지, 그이후 넣을 수 없음)
    COL_NUMBER3 NUMBER(5,2),    -- 정수 5자리, 소수부 2자리
    COL_NUMBER4 NUMBER(*,2)     -- 정수(모두출력), 소수 2자리
);
INSERT INTO TB_NUMBER(COL_NUMBER1,COL_NUMBER2,COL_NUMBER3,COL_NUMBER4)
VALUES (1234.5678, 12345, 123.456, 12345.56);

SELECT *  FROM TB_NUMBER;




-- 날짜 자료형 DATE
-- 연도, 월, 일, (시, 분, 초)
CREATE TABLE TB_DATE(
    COL_DATE1 DATE,
    COL_DATE2 DATE
);

INSERT INTO TB_DATE(COL_DATE1, COL_DATE2)
VALUES (SYSDATE, SYSDATE-1);
-- SYSDATE : 현재 날짜와 시간을 얻어옴
-- 연산자를 사용할 수 있다. (위의 코드는 현재 날짜 -1일 (어제) 날짜가 저장)


INSERT INTO TB_DATE(COL_DATE1, COL_DATE2)
VALUES (SYSDATE,  TO_DATE('2019-12-25 11:55:55', 'YYYY-MM-DD HH:MI:SS'));   -- 분 단위는 MI, 월은 MM
-- TO_DATE() : 문자열을 날짜형식으로 바꾸는 함수 
-- 위의 코드는 시간이 테이블에 표시되지 않지만 시간은 모두 들어가 있음


INSERT INTO TB_DATE(COL_DATE1, COL_DATE2)
VALUES ('19/12/15', '19/12/16');    -- 시간은 설정해주지 않으면 현재 시간으로 입력된다.


INSERT INTO TB_DATE(COL_DATE1, COL_DATE2)
VALUES (SYSDATE, TO_DATE('20191225112233', 'YYYYMMDDHHMISS'));    -- 
-- TO_DATE() 함수는 입력 문자열형식을 마음대로 할수 있다( 대신 뒤에 파라미터에 형식이 같도록 적어준다)

SELECT *  FROM TB_DATE;



-- VERCHAR2 ( 문자열 ) --> DATE (문자열, 날짜형태) 로 바꿀 때 쓰는 함수 : TO_DATE

-- DATE (날짜형식) --> VERCHAR2 (문자열)로 바꿀 때 쓰는 함수 : TO_CHAR


-- 테이블 지우기
DROP TABLE TB_CHAR;
DROP TABLE TB_VARCHAR;
DROP TABLE TB_LONG;
DROP TABLE TB_NUMBER;
DROP TABLE TB_INTEGER;
DROP TABLE TB_DATE;


