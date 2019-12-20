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

--예제2) 이름,급여,부서번호를 입력받아 EMP 테이블에 자료를 등록하는 SCRIPT를 작성하여라. 
--단 10번 부서일 경우, 입력한 급여의 20%를 추가하고 초기값이 9000부터 9999까지 
--1씩 증가하는 SEQUENCE(EMP_EMPNO_SEQ)작성하여 사용하고 아래의 표를 
--참고하여라.

--이    름: 홍길동
--급    여: 2000
--부서번호: 10

-- INSERT -> procedure

CREATE OR REPLACE PROCEDURE insert_emp( v_name IN employees.last_name%TYPE,
                                                                                        v_sal IN employees.salary%TYPE,
                                                                                        v_deptno IN employees.department_id%TYPE)
IS
        var_plus_sal employees.salary%TYPE := v_sal;
           
BEGIN
           
            IF v_deptno = 10 THEN
                var_plus_sal := var_plus_sal * 1.1;
            END IF;

            INSERT INTO employees
            VALUES ( employees_SEQ.NEXTVAL, null, v_name,
                                v_name||'@example.com', null, SYSDATE, 'IT_PROG', var_plus_sal, null, null, v_deptno);


END;
/

EXEC insert_emp('홍길동',2000,10);

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

            SELECT department_id 
                            INTO v_deptno
            FROM employees 
            WHERE employee_id = v_empno;


            SELECT MAX(salary) - MIN(salary)
                            INTO   v_salgap
            FROM employees
            WHERE  department_id = v_deptno;
            
               DBMS_OUTPUT.put_line('최고연봉과 최저연봉의 차이 : ' ||v_salgap ); 

END;
/

ACCEPT p_empno PROMPT '사원번호 : '
EXEC print_maxmin(&p_empno);






-- function
--1) 두 숫자를 제공하면 덧셈을 해서 결과값을 반환하는 함수를 정의하시오.(함수명 add_num)
CREATE OR REPLACE FUNCTION add_num( v_num1 NUMBER, v_num2 NUMBER) RETURN NUMBER
IS
            sum_num NUMBER(10);
BEGIN
            sum_num := v_num1 + v_num2;
            RETURN sum_num;

END;
/
SELECT add_num(1,2)
FROM DUAL;

-- 변수로 만들기
VAR sum_num NUMBER;
EXEC :sum_num := add_num(1,2);
PRINT sum_num;


--2) 부서번호를 입력하면 해당 부서에서 근무하는 사원 수를 반환하는 함수를 정의하시오.
-- (함수명 get_emp_count)

CREATE OR REPLACE FUNCTION get_emp_count (v_deptno employees.employee_id%TYPE)
RETURN NUMBER
IS      
            cnt_emp NUMBER;
BEGIN
            SELECT count(employee_id)
                            INTO cnt_emp
            FROM employees
            WHERE department_id = v_deptno;
            
            RETURN cnt_emp;
            
--EXCEPTION WHEN NO_DATA_FOUND THEN  
--            DBMS_OUTPUT.PUT_LINE('해당 부서가 없습니다.')
        
END;
/

VAR deptno NUMBER;
EXEC :deptno := get_emp_count(100);
PRINT deptno;




--3) emp테이블을 이용해서 입사일을 제공하면 근무연차를 구하는 함수를 정의하시오.(소수점 
--   자리 절삭, 함수명 get_info_hiredate)

CREATE OR REPLACE FUNCTION get_info_hiredate (empno employees.employee_id%TYPE)
RETURN NUMBER
IS
                v_workyear NUMBER;
BEGIN
                SELECT ROUND(MONTHS_BETWEEN(SYSDATE,hire_date)/12)
                        INTO v_workyear
                FROM employees
                WHERE empno = employee_id;
                
              RETURN   v_workyear;
              
                
                
END;
/

ACCEPT p_empno PROMPT '사원번호 : '
SELECT get_info_hiredate(&p_empno) 근무연차
FROM DUAL;

--4) emp테이블을 이용해서 사원번호를 입력하면 해당 사원의 관리자 이름을 구하는 함수를
  -- 정의하시오.(함수명 get_mgr_name)
  
CREATE OR REPLACE FUNCTION get_mgr_name (empno employees.employee_id%TYPE)
RETURN VARCHAR2
IS
            mgr_name VARCHAR2(20);
BEGIN
            SELECT b.first_name || ' ' || b.last_name manager_name
                            INTO mgr_name
            FROM employees a, employees b
            WHERE   a.manager_id = b.employee_id 
                            AND empno = a.employee_id;
            
            RETURN mgr_name;
                
END;
/

ACCEPT p_empno PROMPT '사원번호 : '
select get_mgr_name(&p_empno)"매니저 이름"
FROM DUAL;


--5) emp테이블을 이용해서 사원번호를 입력하면 급여 등급을 구하는 함수를 정의하시오.
--(4000~5000 A, 3000~4000미만 B, 2000~3000미만 C, 1000~200미만 D, 1000미만 F,
--함수명 get_sal_grade)




