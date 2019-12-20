--  프로시저 문제
SET SERVEROUTPUT ON;

-- 
--예제1) 사원번호 입력 받고 그 사원의 급여에 1000을 더한 값으로 갱신하라.
-- update --> Procedure 사용 
CREATE OR REPLACE PROCEDURE update_sal( empno IN employees.employee_id%TYPE)
IS
            v_plus_sal  NUMBER := 1000;
BEGIN
            UPDATE employees
            SET salary = salary + v_plus_sal
            WHERE employee_id = empno;
            
END;
/

EXEC update_sal(100);
rollback;


-- 또는 스크립트로 만들기
ACCEPT p_empno PROMPT '사원의 번호를 입력하시오(급여+1000) : '
DECLARE 
                v_sal NUMBER;
BEGIN
            
            UPDATE employees
            SET salary = salary +1000
            WHERE employee_id = &p_empno;
            
            SELECT salary
                        INTO v_sal
            FROM employees
            WHERE employee_id = &p_empno;
            DBMS_OUTPUT.PUT_LINE('사원번호 : '|| &p_empno || '  급여 : ' ||v_sal);
END;
/


--예제2) 이름,급여,부서번호를 입력받아 EMP 테이블에 자료를 등록하는 SCRIPT를 작성하여라. 
--단 10번 부서일 경우, 입력한 급여의 20%를 추가하고 
--초기값이 9000부터 9999까지 1씩 증가하는 SEQUENCE(EMP_EMPNO_SEQ)작성하여 사용하고 아래의 표를 
--참고하여라.

--이    름: 홍길동
--급    여: 2000
--부서번호: 10

-- INSERT -> procedure
-- 1. 시퀀스 만들기
CREATE SEQUENCE EMP_EMPNO_SEQ 
INCREMENT BY 1
START WITH 9000
MAXVALUE 9999;

-- 1. 프로시저 
CREATE OR REPLACE PROCEDURE insert_emp( v_name IN employees.last_name%TYPE,
                                                                                        v_sal IN employees.salary%TYPE,
                                                                                        v_deptno IN employees.department_id%TYPE)
IS
        var_plus_sal employees.salary%TYPE := v_sal;
           
BEGIN
           
            IF v_deptno = 10 THEN
                var_plus_sal := var_plus_sal * 1.2;
            END IF;

            INSERT INTO employees
            VALUES ( EMP_EMPNO_SEQ.NEXTVAL, null, v_name,
                                v_name||'@example.com', null, SYSDATE, 'IT_PROG', var_plus_sal, null, null, v_deptno);


END;
/


EXEC insert_emp('이길동',2000,10);

SELECT
    *
FROM employees
WHERE employee_id >=9000;


-- 스크립트로 작성하기
ACCEPT p_name PROMPT '이 름 : '
ACCEPT p_sal PROMPT '급 여 : '
ACCEPT p_deptno PROMPT '부서번호 : '
DECLARE
            v_name VARCHAR2(10) := '&p_name';
            v_sal employees.salary%TYPE := &p_sal;
            v_deptno employees.department_id%TYPE := &p_deptno;
            
            v_emp employees%ROWTYPE;
            
BEGIN
            
              IF v_deptno = 10 THEN
                v_sal := v_sal * 1.2;
            END IF;

            INSERT INTO employees
            VALUES ( EMP_EMPNO_SEQ.NEXTVAL, null, v_name,
                                v_name||'@example.com', null, SYSDATE, 'IT_PROG', v_sal, null, null, v_deptno);
          
            SELECT *
                        INTO v_emp
            FROM employees
            WHERE last_name = v_name;
            
            DBMS_OUTPUT.PUT_LINE('name = ' || v_emp.last_name);
            DBMS_OUTPUT.PUT_LINE('salary = ' || v_emp.salary);
            DBMS_OUTPUT.PUT_LINE('department_id = ' || v_emp.department_id);

END;
/




ROLLBACK;
commit;



--예제3) EVEN_ODD(ID:NUMBER(4) GUBUN:VARCHAR2(10)) 테이블을 작성하고 
--START숫자와 END 숫자를 입력 받아 그 사이의 숫자를 ID에 ID의 숫자가 짝수이면 GUBUN에 “짝수”를 
--홀수이면 GUBUN에 “홀수”라고 입력하는 SCRIPT를 WHILE문으로 작성하여라.


CREATE TABLE EVEN_ODD(
    ID NUMBER(4),
    GUBUN VARCHAR2(10)
);

CREATE OR REPLACE PROCEDURE check_odd_even( v_start NUMBER, v_end NUMBER)
IS
            check_num NUMBER := v_start;
            end_num NUMBER := v_end;
            check_mag VARCHAR2(10);
BEGIN   
                WHILE  check_num <= end_num
                LOOP 
                            IF ( MOD( check_num, 2) = 0) THEN
                                check_mag := '짝수';
                            ELSE 
                                 check_mag := '홀수';
                            END IF;
                            
                            INSERT INTO even_odd
                            VALUES (check_num, check_mag);
                            check_num := check_num +1;
                END LOOP;
END;
/

ACCEPT p_startnum PROMPT '시작번호 :'
ACCEPT p_endnum PROMPT '끝번호 :'
EXEC check_odd_even( &p_startnum, &p_endnum);


SELECT
    *
FROM even_odd;


ROLLBACK;

-- 프롬프트로 만들기
ACCEPT p_start PROMPT '시작번호 :'
ACCEPT p_end PROMPT '끝번호 :'
DECLARE
            v_start even_odd.id%TYPE := &p_start;
            v_end even_odd.id%TYPE := &p_end;
BEGIN
                IF v_start > v_end THEN
                    DBMS_OUTPUT.PUT_LINE('start가 end보다 큽니다.');
                ELSE 
                        WHILE v_start <= v_end 
                        LOOP
                            IF MOD(v_start, 2) = 0 THEN
                                INSERT INTO even_odd
                                VALUES(v_start, '짝수');
                            ELSE 
                                INSERT INTO even_odd
                                VALUES(v_start, '홀수');
                            END IF;
                                   
                             v_start := v_start+1;
                        END LOOP;
                
                DBMS_OUTPUT.PUT_LINE(&p_start || '로부터 ' || &p_end ||'까지 ' ||
                                                               TO_CHAR( &p_end - &p_start+1) || '개의 자료가 입력되었습니다.');
                END IF;
END;
/






--예제4)사원번호를 입력 받으면 다음과 같이 출력되는 PROCEDURE를 작성하라
 --Purchasing 부서명의 사원입니다

CREATE OR REPLACE PROCEDURE print_deptname( v_empno employees.employee_id%TYPE)
IS
        v_deptname departments.department_name%TYPE;
BEGIN
            SELECT d.department_name
                            INTO v_deptname
            FROM employees e, departments d 
            WHERE e.department_id = d.department_id
                            AND v_empno = e.employee_id;
            
            DBMS_OUTPUT.put_line(v_deptname ||' 부서명의 사원입니다.');
END;
/

ACCEPT p_empno PROMPT '사원번호 : '
EXEC print_deptname (&p_empno);





--예제5)사원번호를 입력받고, 소속부서의 최고, 최저연봉 차액을 파라미터로 출력하는 PROCEDURE를 작성하라.

CREATE OR REPLACE PROCEDURE print_maxmin ( v_empno employees.employee_id%TYPE)
IS
                v_salgap employees.salary%TYPE;
                v_deptno employees.salary%TYPE;                
                
BEGIN
            -- 부서번호 알아내기
            SELECT department_id 
                            INTO v_deptno
            FROM employees 
            WHERE employee_id = v_empno;

            -- 최고 , 최소급여의 차이 
            SELECT MAX(salary) - MIN(salary)
                            INTO   v_salgap
            FROM employees
            WHERE  department_id = v_deptno;
            
               DBMS_OUTPUT.put_line('최고연봉과 최저연봉의 차이 : ' ||v_salgap ); 

END;
/

ACCEPT p_empno PROMPT '사원번호 : '
EXEC print_maxmin(&p_empno);

-- 변수로 받기
VAR di NUMBER
EXECUTE :di := print_maxmin(107);
PRINT di;


