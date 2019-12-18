
-- 문제 1번) 테이블명 address,
--id, name, addr, phone, email (BYTE 크기는 자유)
--테이블 생성하기.
CREATE TABLE address(
        id NUMBER (10) ,
        name VARCHAR2(10) ,
        addr VARCHAR2(30) ,
        phone VARCHAR2(20) ,
        email VARCHAR2(20)
);



--문제2번) 주소록 테이블의 구조와 데이터를 복사하여 addr_second 테이블을 생성.(구조와 데이터만 복사해서 생성함.)

CREATE TABLE addr_second
AS
SELECT *
FROM address;




--문제 3번) 주소록 테이블에서 id, name 칼럼만 복사하여 
--addr_forth 테이블을 생성 (구조만 복사)

CREATE TABLE addr_forth
AS
SELECT id, name
FROM address;



--문제4번) Address 테이블에 5개의 데이터를 추가하세요 
INSERT INTO address( id, name, addr, phone, email)
VALUES (1, 'AAA', 'add the address1', '010-1234-5678','email1@mail.net');
INSERT INTO address( id, name, addr, phone, email)
VALUES (2, 'BBB', 'add the address2', '010-1234-5678','email2@mail.net');
INSERT INTO address( id, name, addr, phone, email)
VALUES (3, 'CCC', 'add the address3', '010-1234-5678','email3@mail.net');
INSERT INTO address( id, name, addr, phone, email)
VALUES (4, 'DDD', 'add the address4', '010-1234-5678','email4@mail.net');
INSERT INTO address( id, name, addr, phone, email)
VALUES (5, 'EEE', 'add the address5', '010-1234-5678','email5@mail.net');

--문제 5번)Address 테이블에서 id, name 만 가진 Address2 테이블을 만들고
--자료를 전부 가지고 오기
CREATE TABLE ADDRESS2
AS
SELECT id, name
FROM address;



--문제 6번) 주소록 테이블에 날짜 타입을 가지는 birth 칼럼을 추가

ALTER TABLE address
ADD
birth DATE;



--문제 7번) 주소록 테이블에 문자 타입을 가지는 comments 칼럼을 추가
--기본값은 'No Comment'로 지정하여라.

ALTER TABLE address
ADD
comments VARCHAR(30) DEFAULT 'No Comment';


--문제 8번)주소록 테이블에서 comments 칼럼을 삭제

ALTER TABLE address
DROP COLUMN comments;



--문제 9번) 주소록 테이블에서
--phone 칼럼의 데이터 타입의 크기를 50으로 증가

ALTER TABLE address

MODIFY
phone VARCHAR(50);






