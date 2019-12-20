-- FUCTION
/*
        매개변수, RETURN값이 반드시 있음
        SELECT구문에서 많이 사용함
        
*/
CREATE OR REPLACE FUNCTION func( p_val IN NUMBER)
        RETURN NUMBER
        -- 리턴하는 부분
IS
        v_val NUMBER;
BEGIN
        v_val := p_val *2;
        RETURN v_val;
END;
/
-- 함수는 EXEC로 호출 못하고 select문에서 사용가능
SELECT  func(10) FROM DUAL;


set SERVEROUTPUT ON;
-- 세율구하는 함수
CREATE OR REPLACE FUNCTION tax(p_val IN NUMBER) RETURN NUMBER
IS

BEGIN
            RETURN (p_val * 0.15);
END;
/
-- DUAL 테이블로 확인하기
SELECT tax(1000) FROM DUAL;




-- 급여와 커미션을 합쳐서 세금을 계산
CREATE OR REPLACE FUNCTION tax2 (p_sal IN employees.salary%TYPE, p_bonus IN employees.commission_pct%TYPE)
        RETURN  NUMBER
IS
BEGIN
            RETURN ( (p_sal + NVL(p_bonus,0) * p_sal) *0.15) ;
END;
/

SELECT first_name, salary + salary * NVL(commission_pct,0) 실급여,
                tax2 ( salary, commission_pct) 세금
FROM employees;


-- 사원번호를 입력하면 업무명을 취득할 수 있는 함수
CREATE OR REPLACE FUNCTION getJobName ( p_empno IN employees.employee_id%TYPE)
                RETURN VARCHAR2
IS
                v_jobname jobs.job_title%TYPE;
BEGIN
                SELECT j.job_title INTO v_jobname
                FROM employees E, jobs J
                WHERE e.job_id = j.job_id
                                AND p_empno = e.employee_id;
                
                RETURN v_jobname;
END;
/

SELECT getjobname(100)
FROM DUAL;


-- 변수 만들어 출력해보기

VAR name VARCHAR2(20);
EXECUTE :name := getjobname(100);
PRINT name;
-- : (콜론)이 변수 앞에도 들어가야 정상작동된다.

-- 원하는 결과(데이터를) 얻어올 때 쉽게 할 수 있는 방법이 함수 (Function)
