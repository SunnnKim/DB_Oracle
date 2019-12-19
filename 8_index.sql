-- INDEX
/*
        INDEX = 색인
        - 원하는 정보의 위치를 빠르고 정확하게 알아낼 수 있는 방법
        -- 자동생성 : Primary Key, Unique 은 자동적으로 생성됨
        -- 수동생성 : Query문으로 생성하기
        
        생성을 했을 때 효율적인 경우 : 
        1. WHERE절이나 JOIN 조건안에 자주 사용되는 column 
        예) department_id
        
        2. NULL 값이 많이 포함되어 있는 column
        예) manager_id
        3. WHERE절이나 JOIN 조건 안에 2개 이상 사용하는 column
        
        생성을 했을 때 비효율적인 경우 :
        1. 테이블의 크기(row의 개수가 작을 때) 가 적을 때 (3000개 이하)
        2. 테이블이 자주 갱신될 때
*/

-- 제약조건이 없는 EMPLOYEES 테이블 카피하기
CREATE TABLE EMP_COPY
AS
SELECT * FROM employees;


-- 자동생성 (프라이머리 키 추가하면 인덱스가 자동으로 생성된다)
ALTER TABLE EMP_COPY
ADD
CONSTRAINT PK_EMPCOPY_01 PRIMARY KEY(employee_id);

-- INDEX 확인하기
-- WHERE에 조건을 적용하면 특정 인덱스만 조회할 수 있음
SELECT  * FROM ALL_INDEXES
WHERE index_name = 'PK_EMPCOPY_01';


-- 인덱스 강제 생성
-- CREATE INDEX  ON
CREATE INDEX EMP_INDEX01
ON EMP_COPY ( MANAGER_ID); 

-- 만들어졌는지 확인하기
SELECT  * FROM ALL_INDEXES
WHERE index_name IN('EMP_INDEX01');


-- 지우기
DROP INDEX EMP_INDEX01;