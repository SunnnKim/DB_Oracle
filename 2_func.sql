-- standard function 

-- DUAL : 가상 테이블 -> 결과 확인용 임시 테이블
SELECT 1 FROM DUAL;
SELECT 'A' FROM DUAL;
SELECT '가' FROM DUAL;
SELECT 32*24 FROM DUAL; -- 연산한 값도 확인 가능하다

-- 문자함수 
-- CHR(N) : ASCII 값을 문자로 변환하는 함수 
SELECT CHR(65) FROM DUAL;   -- A의 아스키코드 값: 65
SELECT CHR(97) FROM DUAL;   -- a의 아스키코드 값: 97

-- 예시
-- 출력문 : 내 점수는 A입니다.
SELECT '내 점수는 ' || CHR(65) || '입니다.' FROM DUAL;    
-- || 연산자는 문자열 합해주는 기능 (자바에서는 OR 연산자)
-- 자바코드 = "내 점수는 " + CHR(65) + "입니다.";


-- LPAD / RPAD : 나머지를 빈칸 또는 특정 문자로 채우는 함수
SELECT LPAD('BBB', 10) FROM DUAL;   -- 앞 칸(왼쪽)이 빈칸으로 채워짐
SELECT RPAD('BBB', 10) FROM DUAL;  -- 뒤 칸(오른쪽)이 빈칸으로 채워짐

SELECT LPAD('BBB', 10,'-') FROM DUAL; -- 앞 칸 빈문자열에 특정 문자열 ( - )을 넣어줌
SELECT LPAD('BBB', 10,'7') FROM DUAL;  -- 뒤 칸 빈 문자열에 특정 문자열 ( 7 ) 을 넣어줌



-- INSTR ('문자', '찾을문자') == 자바의 IndexOf('문자') : 해당 문자에 대한 인덱스를 찾아줌
-- 자바는 인덱스 번호 0번지 부터 찾아줌
-- DB는 인덱스 번호 무조건 1번지 부터
SELECT INSTR('123A456B789C', 'A') FROM DUAL; -- 답 : 4

SELECT INSTR('123A456B789B', 'B', 9) FROM DUAL; -- 
-- INSTR('123A456B789B', 문자, n) : n번째 위치 이후부터 존재하는 문자의 위치
SELECT INSTR('123A456B789B', 'B', 4, 1) FROM DUAL; -- 4번째 자리 이후부터 존재하는 B의 값 중 2번째로 발견되는 값 :  

SELECT INSTR('123A56B89B', 'B', 4, 2) FROM DUAL; -- 4번째 자리 이후부터 존재하는 B의 값 중 2번째로 발견되는 값 :  


-- REPLACE : 문자열 치환 * 자주쓰임

SELECT REPLACE('AAAAABCD', 'A') FROM DUAL;  -- A가 빈 문자열로 치환 -> BDC
SELECT REPLACE('AAAAABCD', 'A','a') FROM DUAL;  -- A가  a 로 치환 -> aaaaaBCD
SELECT REPLACE('AAAAABCD', 'AA', 'a') FROM DUAL;  -- AA가 a 로 치환 -> aaABCD


-- TRANSLATE : 문자 치환 * 쓰임

SELECT TRANSLATE('AAAAABCD', 'A', 'a') FROM DUAL;  -- A가 a 로 치환
SELECT TRANSLATE('AAAAABCD', 'AA', 'a') FROM DUAL;  -- A가 a 로 치환, 
-- REPLACE랑 다른 결과(문자열로 입력하면 앞 문자 1문자만 치환이 되고 뒤에 문자는 지워진다)



-- 숫자 함수
-- 올림
SELECT CEIL(13.1) FROM DUAL;    -- 14

-- 내림
SELECT FLOOR(13.9) FROM DUAL;   -- 13

-- 퍼센트 (나눈 나머지)
SELECT MOD(3,2) FROM DUAL; -- 1

-- 승수
SELECT POWER(3,2) FROM DUAL; -- 3 ^ 2 = 9

-- 반올림
SELECT ROUND(13.5) FROM DUAL; -- 14

-- 부호 ( + : 1/ 0 : 0 / - : -1 )
SELECT SIGN(13.4) FROM DUAL;    -- 1
SELECT SIGN(0) FROM DUAL;    -- 0
SELECT SIGN(-13.4) FROM DUAL;    -- -1

-- 버림
-- 평균, 날짜 계산 등에 사용
SELECT TRUNC(12.3456) FROM DUAL; -- 12
SELECT TRUNC(12.3456,2) FROM DUAL; -- 12.34 ( 소수점 2자리까지 나옴)
SELECT TRUNC(12.3456,-1) FROM DUAL; -- 10 ( -1 : 일의 자리까지 버림)

-- 아스키코드 값 반환함수 
--    <----> CHR(N)과 반대되는 함수
SELECT ASCII('A') FROM DUAL;    -- 65


-- 변환함수 ** 자주쓰임

-- DATE ---> STRING 
-- TO_CHAR
SELECT TO_CHAR(SYSDATE) FROM DUAL; -- 19/12/11 (오늘 날짜로 된 문자열)

SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD-HH-MI-SS') FROM DUAL;  -- 2019-12-11-03-45-21 (시간까지 들어감)
-- 토큰 형식이기 때문에 우리가 원하는 형식으로 가져올 수 있음
SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD HH:MI:SS') FROM DUAL;  -- 2019-12-11 03:46:31

SELECT TO_CHAR (100000000, '$999,999,999,999') FROM DUAL;  -- 숫자 단위로 잘라줌



-- T0_DATE :
-- STRING ----> DATE
SELECT TO_DATE('20191225') FROM DUAL;   -- 19/12/25 (자료형 날짜임)

SELECT TO_DATE('12252019', 'MMDDYYYY') FROM DUAL;   -- 위의 코드와 결과 동일


-- TO_NUMBER
-- 자바에서 parseInt 와 동일한 기능
SELECT TO_NUMBER('112') + 24  FROM DUAL; -- 136 

-- LAST_DAY
-- 해당 달의 마지막 날을 구함
SELECT LAST_DAY(SYSDATE) FROM DUAL; -- 이번 달의 마지막 날

SELECT LAST_DAY('19/11/20') FROM DUAL; -- 11월의 마지막 날

SELECT LAST_DAY(TO_DATE('11/20/2019','MM/DD/YYYY')) FROM DUAL; -- 11월의 마지막 날
-- 위의 코드는 LAST_DAY와 TO_DATE 함수를 같이 사용한 예


-- SUBSTR
-- 자바의substring : substring(1,3) "ABCDE" -> "BC"
SELECT SUBSTR('ABCDE' , 3) FROM DUAL;   -- 3번지부터 다 가져옴 : CDE (DB는 1번지부터 시작)
SELECT SUBSTR('ABCDE' , 3,2) FROM DUAL; -- 3번지부터 2개의 문자를 가져옴 : CD


-- LENGTHB  --> 문자의 길이를 바이트 형식으로 가져옴
-- LENGTH --> 문자의 길이를 가져옴
SELECT LENGTH('가나다라마') FROM DUAL;   -- 5
SELECT LENGTHB('가나다라마') FROM DUAL; -- 15


-- PPT에 안봐도 괜찮은 함수 : CONVERT.... 등
-- 사용해보기

-- MONTHS_BETWEEN : 두 날짜 사이의 개월 수 구하기 
-- 소수점이 있기 때문에 버림 또는 올림을 해줘야한다.
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, '19/11/01')) FROM DUAL;





-- 무결성 CONSTRAINT / CHECK / NOT NULL / PRIMARY KEY ...





