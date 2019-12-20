
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

CREATE OR REPLACE FUNCTION get_emp_count (v_deptno emp.empno%TYPE)
RETURN NUMBER
IS      
            cnt_emp NUMBER;
BEGIN
            SELECT count(empno)
                            INTO cnt_emp
            FROM emp
            WHERE deptno = v_deptno;
            
            RETURN cnt_emp;
            

END;
/

ACCEPT p_deptno PROMPT '사원번호 : '
VAR deptno NUMBER;
EXEC :deptno := get_emp_count(&p_deptno);
PRINT deptno;




--3) emp테이블을 이용해서 입사일을 제공하면 근무연차를 구하는 함수를 정의하시오.(소수점 
--   자리 절삭, 함수명 get_info_hiredate)

CREATE OR REPLACE FUNCTION get_info_hiredate (empnum emp.empno%TYPE)
RETURN NUMBER
IS
                v_workyear NUMBER;
BEGIN
                SELECT ROUND(MONTHS_BETWEEN(SYSDATE,hiredate)/12)
                        INTO v_workyear
                FROM emp
                WHERE empnum = empno;
                
              RETURN   v_workyear;
              
                
                
END;
/

ACCEPT p_empno PROMPT '사원번호 : '
SELECT get_info_hiredate(&p_empno) 근무연차
FROM DUAL;




--4) emp테이블을 이용해서 사원번호를 입력하면 해당 사원의 관리자 이름을 구하는 함수를
  -- 정의하시오.(함수명 get_mgr_name)
  
CREATE OR REPLACE FUNCTION get_mgr_name (empnum emp.empno%TYPE)
RETURN VARCHAR2
IS
            mgr_name VARCHAR2(20);
BEGIN
            SELECT b.ename manager_name
                            INTO mgr_name
            FROM emp a, emp b
            WHERE   a.mgr = b.empno 
                            AND empnum = a.empno;
            
            RETURN mgr_name;
            
END;
/

ACCEPT p_empno PROMPT '사원번호 : '
select get_mgr_name(&p_empno)"매니저 이름"
FROM DUAL;


--5) emp테이블을 이용해서 사원번호를 입력하면 급여 등급을 구하는 함수를 정의하시오.
--(4000~5000 A, 3000~4000미만 B, 2000~3000미만 C, 1000~200미만 D, 1000미만 F,
--함수명 get_sal_grade)

CREATE OR REPLACE FUNCTION get_sal_grade ( empnum emp.empno%TYPE)
RETURN VARCHAR2
IS
        emp_sal emp.sal%TYPE;
        sal_rate VARCHAR2(10);
BEGIN
            SELECT sal
                        INTO emp_sal
            FROM emp
            WHERE empno = empnum;
            
            CASE WHEN emp_sal >=4000 AND emp_sal<= 5000 THEN 
                            sal_rate := 'A' ;
                        WHEN emp_sal >=3000 THEN 
                            sal_rate := 'B';
                        WHEN emp_sal >=2000 THEN 
                            sal_rate := 'C';
                        WHEN emp_sal >=1000 THEN 
                            sal_rate := 'D';
                        ELSE 
                            sal_rate := 'F';
                        END CASE;
                        
            RETURN sal_rate;
            
END;
/

ACCEPT p_empno PROMPT '사원번호 : '
SELECT get_sal_grade(&p_empno)
FROM DUAL;



