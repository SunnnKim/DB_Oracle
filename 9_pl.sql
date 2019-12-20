-- PL  (1)
/*
    PL / SQL  : Procedural Language / extension to Structured Query Language
        Procedural  = 처리자
        - SQL을 확장한 순차적인 언어 -> Procedure, Function, Trigger
        - SQL 문을 간단히 접근하기 위해서 작성해놓은 함수 
    
        + script 추가해서 사용할 수 있음
        
*/


/*
Script 구조
--1. 선언부 : 사용할 변수/상수를 선언, 초기화
--2. 실행부 : 실제 처리할 Query 부분이나 제어문 등을 활용. 실제 처리
--3. 예외처리부 : 각종 오류 부분 처리 (생략이 가능)
*/

-- PL 키기
--SET SERVEROUTPUT ON -- 한번만 키면 쭉 켜져 있음
BEGIN

        -- 실행부 
        dbms_output.put_line('HELLO PL');

END;
/
--SET SERVEROUTPUT OFF
 -- 오리지널 코드에서는 END; 뒤에 반드시 / (슬래쉬) 입력해야함  


DECLARE
        -- 선언부
        message VARCHAR2(10);       -- 변수명 자료형;
        
BEGIN
        -- 실행부
        message  :=  'hello PL?';           -- 변수에 대입할 때는 : (콜론) 을 반드시 붙여준다
        DBMS_OUTPUT.put_line('message=' || message); -- || 문자열기리 더해주는 연산자
        
        -- 예외처리부

END;
/

-- if 문
DECLARE
        counter INTEGER;
BEGIN
        counter := 1;
        counter := counter + 1;
    
        IF counter = 0 then
            
            DBMS_OUTPUT.put_line('RESULT : counter is null' );  
        ELSIF counter = 1 then
            DBMS_OUTPUT.put_line('RESULT : counter is not null' );  
        
      END IF;
    
        
END;
/



-- FOR 문
DECLARE 
            counter INTEGER;
            i INTEGER;
BEGIN
        for i IN 1..9 LOOP
        DBMS_OUTPUT.put_line('i=' || i ); 
        counter:=i * 2;
        DBMS_OUTPUT.put_line('2 * ' ||  '='|| counter ); 
        END LOOP;
  
END;
/

-- loop 문
DECLARE 
        v_count NUMBER :=  0; -- 선언과 동시에 초기화
        v_total NUMBER := 0;
BEGIN
        
        LOOP       
                    EXIT WHEN v_count = 10; -- 루프문 탈출조건
                    v_count := v_count + 1;
                    v_total := v_total + v_count;
                    DBMS_OUTPUT.put_line('v_count = ' || v_count  ); 
        END LOOP;
        
            DBMS_OUTPUT.put_line('v_total = ' || v_total  ); 
 

END;
/


-- WHILE 
DECLARE
          v_count NUMBER :=  0; 
          v_total NUMBER := 0;

BEGIN
            WHILE v_count < 10
            LOOP -- 이코드 아래에 루프문 작성
                    v_count := v_count + 1;
                    v_total := v_total + v_count;
                   
            END LOOP;
            DBMS_OUTPUT.put_line('v_total = ' || v_total  ); 
END;
/

-- GOTO
-- 자바 /c에서 없어짐
-- 이동(탈출)할 때 쓰임
DECLARE
        v_name VARCHAR2(10) := 'LEE';
        v_case NUMBER := 1;
BEGIN
        CASE WHEN MOD(v_case, 2) = 0 THEN 
                            GOTO test1;     -- v_case를 2로 나눈 값이 0일때 test1로 가시오
                    WHEN MOD(v_case, 2) = 1 THEN 
                            GOTO test2;
                    ELSE 
                            GOTO ERR;   -- 문자가 들어오면 에러로 표시하시오
        END CASE;
        
<<test1>>         
    dbms_output.put_line(v_name || 'is woman'); -- 출력
    GOTO sub_end;
<<test2>>         
    dbms_output.put_line(v_name || 'is man'); -- 출력
    GOTO sub_end;

<<err>>         
    dbms_output.put_line('ERR');
    GOTO sub_end;
    
    
<<sub_end>>
    dbms_output.put_line('Exit');

END;
/

--  예외처리부

DECLARE
        counter INTEGER;
BEGIN
        counter := 10;
        counter := 10 / 0; -- 예외가 나오는 코드
        
EXCEPTION WHEN OTHERS THEN  -- 예외처리부
    dbms_output.put_line('예외가 발생했습니다.'); -- 출력

END;
/


-- varray : 배열 ( Variable ARRAY )
DECLARE
        TYPE varray_test IS VARRAY(3) OF INTEGER; -- TYPE 타입명 IS VARRAY(배열개수) OF 자료형
        -- 3개의 배열, 번지수는 1부터 시작(자바는 0)
        -- int varray_test[ ]; 과 같은 의미의 코드
        varr  varray_test; -- 변수명 타입 : varray_test타입의 변수 varr 선언
BEGIN
        varr := varray_test(111,222,333); 
        -- varray_test[] = new int [3] 와 같은 의미
        dbms_output.put_line('varr(1) = ' || varr(1)); 
        dbms_output.put_line('varr(2) = ' || varr(2));  
        dbms_output.put_line('varr(3) = ' || varr(3));         
        
END;
/



-- UI 화면(명령 프롬프트 창) 띄워서 입력값에 따른 결과 띄우기

ACCEPT p_deptno PROMPT '부서번호를 입력하시오(급여의 합)' 
-- 프롬프트창 띄워서 입력값 (부서번호)
DECLARE 
        v_salTotal NUMBER;
BEGIN
        -- 쿼리문 작성해서 입력값을 집어 넣는다.
        SELECT  SUM(salary) INTO v_saltotal         
        -- select구문은 output(조회한 쿼리)이 있는데, 그 값을 v_saltotal에 집어넣는다는 의미의 코드
        -- INTO : select구문의 결과값을 다른 곳으로 넣는 예약어
        FROM employees
        WHERE department_id = &p_deptno;
        -- &는 외부에서 값을 가져온다는 의미
         dbms_output.put_line(&p_deptno ||'번 부서의 급여의 합은 ' 
                                                || TO_CHAR( v_saltotal, '$999,999,999')  || ' 입니다.');         
END;
/


-- 예제
-- 사원번호를 입력받고 그 사원의 급여의 1000을 더한 값으로 갱신하시오(update)
-- 그 값을 가져와서 사원번호, 갱신된 급여를 출력하도록 하시오 (SELECT) 

ACCEPT p_empid PROMPT '사원번호를 입력하시오(+1000)'
DECLARE
            v_sal EMPLOYEES.salary%TYPE := 1000;    -- 더할 값(1000)
            -- 테이블명.컬럼명%TYPE : 자동적으로 해당 컬럼의 자료형으로 맞춰준다
            v_salTotal NUMBER;
BEGIN
            -- 업데이트 전 값을 출력하기
            SELECT salary INTO v_salTotal
            FROM employees
            WHERE employee_id = &p_empid;
            dbms_output.put_line('사원번호 : ' || &p_empid || ', 급여 : ' || v_salTotal );
            
            -- update
            UPDATE employees
            SET salary = salary + v_sal
            WHERE employee_id = &p_empid;
            
            -- select
            -- 가져와서 출력하기
            SELECT salary INTO v_salTotal
            FROM employees
            WHERE employee_id = &p_empid;

            dbms_output.put_line('사원번호 : ' || &p_empid || '번 +1000후의 급여 : ' || v_salTotal );
END;
/

rollback;



-- ROWTYPE
-- 한 테이블의 모든 컬럼 자료형을 가진 변수가 들어가있음
DECLARE
--        v_empno employees.employee_id%TYPE
        -- 또는 
        v_emp EMPLOYEES%ROWTYPE;    
        -- EMPLOYEES 테이블의 타입이 모두 들어가있음
        -- column 의 이름이 자동적으로 변수명이 된다
        -- 한 테이블의 여러 변수타입을 가져오고 싶을때 사용할 수 있음
        -- 접근 예 ) v_emp.first_name;

BEGIN
        SELECT employee_id, first_name, last_name, salary 
                        INTO v_emp.employee_id, v_emp.first_name, v_emp.last_name, v_emp.salary 
                        -- 이렇게 사용이 가능함  ( 변수 하나씩 모두 선언할 필요 없음)
        FROM employees
        WHERE employee_id = 100;
        dbms_output.put_line('사원번호 : ' ||  v_emp.employee_id );
        dbms_output.put_line('사원이름 : ' || v_emp.first_name );
        dbms_output.put_line('사원성 : ' || v_emp.last_name );
        dbms_output.put_line('사원급여 : ' ||  v_emp.salary );
              
END;
/

-- 예제 2

-- 이름, 급여, 부서번호를 입력받아
-- 사원을 추가하기 (employees 테이블)  * job_id = IT_PROG / email : 이름@example.com
-- 부서번호가 30일 경우 -> 입력받은 급여에 20% 인상해서 입력
-- 부서번호가 60일 경우 -> 입력받은 급여에 10% 인상해서 입력

-- 입력처리
ACCEPT p_name PROMPT '이름 : '
ACCEPT p_sal PROMPT '급여 : '
ACCEPT p_deptno PROMPT '부서번호 : '

DECLARE
        v_name employees.last_name%TYPE := '&p_name'; -- 문자열일때는 '' 안에 넣어주기
        v_sal employees.salary%TYPE := &p_sal;
        v_deptno employees.department_id%TYPE := &p_deptno;
        v_emp employees%ROWTYPE;
BEGIN
                dbms_output.put_line( '입력값 확인하기');
                dbms_output.put_line( v_name);
                dbms_output.put_line( v_sal);
                dbms_output.put_line( v_deptno);

                IF v_deptno = 30 THEN v_sal := v_sal * 1.2;
                ELSIF v_deptno = 60 THEN v_sal := v_sal *1.1;
                END IF;
                
                INSERT INTO employees
                VALUES ( EMPLOYEES_SEQ.nextval, null, v_name, v_name||'@example.com',
                                    null, SYSDATE, 'IT_PROG', v_sal, null,null, v_deptno);
                
                -- 출력하기
                SELECT * INTO v_emp 
                FROM employees
                WHERE last_name = v_name;
                
                dbms_output.put_line( '<입력된 사원>');
                dbms_output.put_line( v_emp.employee_id);
                dbms_output.put_line( v_emp.last_name);
                dbms_output.put_line( v_emp.salary);
                dbms_output.put_line( v_emp.email);
                dbms_output.put_line( v_emp.department_id);
          
END;
/
-- 주석문은 되도록 바깥에 달기
    
                 
SELECT
    *
FROM employees;

ROLLBACK;
COMMIT;
