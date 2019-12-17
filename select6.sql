-- 특수 Query
-- CASE / DECODE
-- 1. Case
-- 오라클에서 사용하는 스위치 문
SELECT employee_id, first_name, phone_number,
          CASE SUBSTR(phone_number, 1, 3)
                    WHEN '515' THEN '서울'   
                    WHEN '590' THEN '부산'
                    WHEN '659' THEN '광주'
                    WHEN '603' THEN '대전'
                    ELSE '기타'
        END AS "지역"
FROM employees;
-- Alias 안써도 되지만 컬럼명 너무 길어지니까 설정하도록 함
-- 또는  
SELECT employee_id, first_name, phone_number,
                CASE 
                            WHEN  SUBSTR(phone_number, 1, 3 ) = '515' THEN '서울'
                            WHEN  SUBSTR(phone_number, 1, 3 ) = '590' THEN '부산'
                            WHEN  SUBSTR(phone_number, 1, 3 ) = '659' THEN '대전'
                            WHEN  SUBSTR(phone_number, 1, 3 ) = '603' THEN '대구'
                            ELSE '기타'
                END AS 
FROM employees;





-- 2. DECODE
SELECT employee_id, first_name, phone_number,
                 DECODE( SUBSTR ( phone_number, 1, 3 ),
                                    '515' ,  '서울',
                                    '590' ,  '부산',
                                    '659' ,  '광주',
                                    '603' ,  '대전',
                                    '기타'  ) AS 지역
FROM employees;

-- CASE와 DECODE의 용도는 동일하므로 원하는 문법을 찾아서 쓰면 된다.



-- 분석 함수
-- 1. RANK ( ) : 순위 지정하는 함수
-- 중복 순위가 있을 경우 : 
-- RANK() :                  1 2 3 3 5 6
-- DANSE_RANK() :   1 2 3 3 4 5
-- ROW_NUMBER() : 1 2 3 4 5 6
-- ROWNUM 

-- OVER (  PARTITION BY ORDER BY ) : 번호를 지정할 수 있는 쿼리문
-- Group by와 비슷한 기능을 한다.
SELECT job_id, COUNT(*) OVER()
FROM employees;
-- 전체 행 카운트

SELECT job_id, COUNT (*) OVER( PARTITION BY job_id)
FROM employees;
-- job_id 를 기준으로 카운트 함

SELECT job_id, salary, COUNT(*) OVER ( ORDER BY salary DESC)
FROM employees;
-- 현재 카운트에 대한 조건으로 카운트를 센다


-- RANK() / DENSE_RANK() / ROW_NUMBER() 함수
SELECT first_name, salary, job_id,
                RANK ( ) OVER (ORDER BY salary DESC) as rank
               --, DENSE_RANK ( ) OVER (  ORDER BY salary DESC) as dense_rank
               --, ROW_NUMBER () OVER ( ORDER BY salary desc) as row_number
FROM employees;




-- ROWNUM : 
-- 10명의 ROW만을 산출하는 경우 : 행번호 
SELECT ROWNUM, employee_id, first_name, last_name
FROM employees;

--10명 까지만 불러오기
SELECT ROWNUM, employee_id, first_name, last_name
FROM employees
WHERE ROWNUM <= 10;

-- 11번째~20번째 까지 불러오기
SELECT ROWNUM, employee_id, first_name, last_name
FROM employees
WHERE ROWNUM > 10 AND ROWNUM <= 20;
-- 위의 방법은 안됨
-- 실행순서가 WHERE 문이 1번, 그다음에 ROWNUM을 붙이기 때문에 아무것도 나오지 않는다

-- 순서
-- 1. 설정
-- 2. ROWNUM 완성
-- 3. 범위 설정

-- ** 중요 **
SELECT RNUM, employee_id, first_name, salary
FROM    (SELECT ROWNUM as RNUM, employee_id, first_name, salary  -- 2. ROWNUM 붙여주기
                 FROM    ( SELECT employee_id, first_name, salary -- 1. 데이터 설정 : 원하는 데이터로 정렬까지 해준다
                                      FROM   employees
                                      ORDER BY salary DESC) -- 여기서는 급여 순으로 정렬한 뒤 ROWNUM을 설정해줌
                )
WHERE RNUM >10 AND RNUM <=20;



-- 집합

/*
합집합 : UNION
- Full outer join 
교집합 : INTERSECT
- Inner join
차집합 : MINUS
- Outer join ( left join..)
* Join을 더 많이 쓰임

*/

-- UNION
SELECT job_id
FROM employees
WHERE job_id  IN ( 'AD_VP', 'FI_ACCOUNT' )
UNION 
SELECT job_id
FROM jobs
WHERE job_id  IN ( 'AD_VP', 'IT_PROG' );
-- 두 테이블의 데이터가 합해져서 나옴
-- 자동적으로 sorting이 됨


-- INTERSECT
SELECT employee_id
FROM employees
INTERSECT 
SELECT manager_id
FROM employees;
-- 위의 코드는 DISTINCT 를 사용했을 때와 결과가 같다
SELECT DISTINCT manager_id
FROM employees;

-- JOIN으로 표현하기
SELECT DISTINCT b.employee_id
FROM employees a, employees b
WHERE a.manager_id = b.employee_id;



-- MINUS
SELECT employee_id
FROM employees
MINUS
SELECT manager_id 
FROM employees;
-- 위의 코드는 매니저가 아닌 사원만 출력


/*

-- SELECT 절 정리
SELECT 컬럼 or 함수 or 그룹함수 or SubQuery (단일행,단일컬럼인 경우) or OVER()
FROM 테이블명 or SubQuery(다중행, 다중컬럼) 
[ WHERE ] : 조건절 IN AND OR AND ALL ANY LIKE < > <> != = SubQuery(다중행, 다중컬럼)  
[ GROUP BY ] 컬럼 (그룹으로 묶을 수 있는 컬럼)
[ HAVING ] : Grouping의 조건절, 여러개 넣을 수 있음
[ ORDER BY ] : 정렬 ASC(올림) / DESC (내림)
[ START BY ] : 계층형
[ CONNECT BY ] : 연결, PRIOR (상향, 하향)
-- [ ]은 생략가능함


JOIN
- INNER
- OUTTER
- SELF JOIN


SUBQUERY 


OVER
RANK()
ROW_NUMBER() -- over 사용했을 때
ROWNUM


*/






