/*
        sequence : 유일한 값을 생성해주는 Oracle Object
                            회원번호, 게시판 관리 글번호 
        - 순서를 관리 하기 위해 사용
        - 초기화가 불가능 : 삭제 후 다시 사용해야 함
        자바에서도 이렇게 쓰임
        int count   = 1;
        count++;
        - 생성이 되면 계속 증가시킬 수 있음

*/
-- sequence 생성
CREATE SEQUENCE TEST_SEQ
INCREMENT BY 1           -- 1씩 증가
START WITH 10               -- 시작 : 10부터
MAXVALUE 100               -- 최대 얼마까지 증가시키는지(생략가능)
MINVALUE 1;                    -- 최소 얼마부터 증가시키는지 (생략가능)

-- CURRVAL : 현재의 시퀀스 값
SELECT TEST_SEQ.CURRVAL -- 맨처음은 오류 (아무값도 안나와있기 때문에), NEXTVAL 한번 실행된 후로 CURRVAL사용가능
FROM DUAL;

-- NEXTVAL : 진행 값
SELECT TEST_SEQ.nextval
FROM DUAL;


-- 테이블에 시퀀스 번호를 늘리고 싶을 때는 테이블 값을 변경하거나 테이블에서 시퀀스를 NEXTVAL하는 것이 아니고
-- 테이블에 존재하는 시퀀스에 NEXTVAL을 실행한다. 


-- SEQUENCE 수정
-- 값은 수정하지 못함
ALTER SEQUENCE TEST_SEQ
INCREMENT BY 3; -- 증가값을 바꿀 수 있음
-- 이 다음부터 NEXTVAL을 하면 3씩 증가됨



-- 초기화가 불가능한 SEQUENCE
-- 지우고 다시 사용해야함
DROP SEQUENCE TEST_SEQ;




-- 동의어 ( SYNONYM / 객체의 별명 )
/*
    자바에서의 객체의 동의어?
    int array_number[];
    int arrPosNum [] = array_number;
    이런 느낌
*/

CREATE SYNONYM "사원들"
FOR EMPLOYEES;

-- 아래의 코드는 employees 테이블의 데이터가 모두 출력된다.
SELECT  * FROM 사원들;


-- SYNONYM 으로 테이블에 데이터 삽입하기
INSERT INTO "사원들"
VALUES ( EMPLOYEES_SEQ.NEXTVAL, '길동', '홍', 'HGD@NAVER.COM',  -- SEQUENCE의 사용법
                    '123-456-789', TO_DATE('20050101', 'YYYYMMDD'), 'IT_PROG', 20000, NULL, 100, 10);



ROLLBACK;




