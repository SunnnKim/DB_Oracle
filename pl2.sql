-- Procedure
/*
        - block 되어있는 처리 : 함수화, 함수식으로 만들어 둠
        - 공통으로 가지고 있는 요소 : 매개변수, RETURN 값
        * PL
        1) PROCEDURE : INSERT, DELETE, UPDATE 사용시 자주 사용함
        2) FUNCTION : SELECT문을 사용할 때 자주 사용
        3) TRIGGER : 함수의 일종 (확인용), UTIL 쪽으로 많이 사용함

*/
SET SERVEROUTPUT ON -- 콘솔에 출력하기 위해 서버아웃풋 ON

-- PROCEDURE 생성 ( OR REPLACE : 재활용)
CREATE OR REPLACE PROCEDURE myProc ( inNum IN NUMBER, outNum OUT NUMBER) 
IS
                -- 선언부
                
BEGIN
                -- 실행부
                DBMS_OUTPUT.PUT_LINE('inNum= ' || inNum ); 
                outNum := 333;      -- 외부에서 값을 넣어 반환함
                
                DBMS_OUTPUT.PUT_LINE('outNum= ' || outNum );                 
                -- 예외처리부

END;
/

-- IN / OUT : 매개변수 / 리턴값, 프로시저는 매개변수를 통해 반환값이 리턴되므로 리턴값의 타입과 이름을 매개변수에 적어준다.
-- IS  : 선언부, declare대신 IS를 사용
-- BEGIN : 실행부 + 예외처리
-- END : 종료
-- 실행결과 :
-- Procedure MYPROC이(가) 컴파일되었습니다. 
-- 프로시저는 함수를 만들어두고 호출하는 방식이기 때문
-- 생성한 계정의 프로시저 폴더에 가면 있음

-- 프로시저 호출하기 : 
-- 1. 변수 만들기 : VAR
-- 2. 프로시저 호출 : EXECUTE
-- 3. 출력하기 : PRINT
VAR val NUMBER ;            
/* VAR 변수명  자료형;   
    = int val;            
    myproc ( 집어넣을 값, 리턴값 받을 변수)*/
EXECUTE myproc ( 111, :val );
PRINT val;

-- 매개변수가 없는 프로시저
CREATE OR REPLACE PROCEDURE helloProc
IS
            msg VARCHAR(10);
BEGIN
            msg := 'helloProc';
            DBMS_OUTPUT.put_line(msg || '호출');
END;
/

-- 바로 exec로 호출하면 된다
EXEC helloproc;

-- departments 테이블에  row 추가하기
-- 원래 코드
INSERT INTO departments ( department_id, department_name, location_id)
VALUES ( 300 , '관리부', 1700);
ROLLBACK;
-- 프로시저로 행추가하기
CREATE OR REPLACE PROCEDURE add_dept( p_deptno IN departments.department_id%TYPE,
                                                                                        p_deptname IN departments.department_name%TYPE,
                                                                                        p_deptloc IN departments.location_id%TYPE)
IS
        
BEGIN
                INSERT INTO departments ( department_id, department_name, location_id)
                VALUES ( p_deptno , p_deptname, p_deptloc);
                
                EXCEPTION WHEN OTHERS THEN 
                DBMS_OUTPUT.put_line('추가에 실패했습니다.');
                ROLLBACK;
END;
/
-- 문제 없으면 COMMIT,
-- 문제발생하면 예외처리부분에 메세지 띄워주고 ROLLBACK

-- 실행하기
EXECUTE add_dept(301, '신규부서', 2500);





-- 2. UPDATE
-- update salary : 사원번호를 입력받아서 급여를 인상 (30%)

-- 프로시저 작성 및 실행
CREATE OR REPLACE PROCEDURE updateSal ( v_empno IN NUMBER)
IS
BEGIN
        UPDATE employees
        SET salary = salary * 1.3
        WHERE employee_id = v_empno;
        
        EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('추가에 실패했습니다.');
        ROLLBACK;
END;
/

-- 호출하기
ACCEP empno PROMPT '사원번호 : '
EXEC updatesal ( &empno );
ROLLBACK;


--  select
-- 프로시저로 SELECT하기엔 한계가 있기 때문에 잘 사용되지는 않는다
-- 사원번호 입력받으면 그 사원의 이름, 사원번호, 사원급여도 출력이 되도록 하시오
CREATE OR REPLACE PROCEDURE emp_info(p_empno IN employees.employee_id%TYPE)
IS
            v_emp employees%ROWTYPE;
BEGIN
            SELECT first_name, employee_id, salary
                            INTO v_emp.first_name, v_emp.employee_id, v_emp.salary
                            FROM employees
            WHERE employee_id = p_empno;
            
            DBMS_OUTPUT.put_line('이름: ' || v_emp.first_name );
            DBMS_OUTPUT.put_line('사원번호: ' || v_emp.employee_id );
            DBMS_OUTPUT.put_line('급여: ' || v_emp.salary );
            
END;
/
-- 3개의 변수 선언 ( ROWTYPE의 v_emp 만들어서 사용)


-- 호출하기
EXEC emp_info(102);


-- Cursor
/*
        Cursor  : 저장 주소 공간 -> pointer
        1) 암시적 커서 : 자동생성
                    SQL%ROWCOUNT : ROW의 수 (기본제공 커서)
                    SQL%FOUND : ROW의 수가 한 개 이상의 경우 (데이터가 있는지 확인)
                    SQL%NOTFOUND : ROW의 수가  0
        2) 명시적 커서 : 수동생성
                    
*/
-- 암시적 커서 예제

CREATE OR REPLACE PROCEDURE implicit_cursor( p_empname IN employees.first_name%TYPE)
IS
                v_sal employees.salary%TYPE;
                v_update_row NUMBER;
                
BEGIN
                -- 검색
                SELECT salary
                                INTO v_sal
                FROM employees
                WHERE first_name = p_empname;
                
                -- 검색이 된 데이터가 있는 경우
                IF SQL%FOUND  THEN
                    DBMS_OUTPUT.PUT_LINE('검색된 데이터가 있습니다');
                END IF;

                -- 수정작업
                UPDATE employees
                SET salary = salary * 1.1
                WHERE first_name = p_empname;
                
                -- 출력
                v_update_row := SQL%ROWCOUNT;
                DBMS_OUTPUT.PUT_LINE('급여가 인상된 사원 수 : ' || v_update_row);
                
                -- 검색된 데이터가 없을때 예외처리
EXCEPTION WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('검색된 사원이 없습니다.');
                
END;
/
-- IS ; 
-- v_sal :  salary 검색용 변수
-- v_update_row :몇개의 행이 수정되는지 조사하는 부분의 변수
-- SQL%FOUND : 행이 존재하는지 확인
-- SQL%ROWCOUNT : 지금 바로 업데이트 된 쿼리문의 행의 수를 출력

-- 호출하기
-- Steven
EXECUTE implicit_cursor('Guy');
-- 위의 코드는 1명만 있는 데이터만 출력이 된다
ROLLBACK;


-- 명시적 커서
-- 강제 생성이 필요함
-- 쿼리문에서 원하는 값을 커서를 통해 붙여주어 지정한 변수에 넣을 수 있음
-- 예제 : 
CREATE OR REPLACE PROCEDURE expCursor_test( v_deptno IN departments.department_id%TYPE)
IS
               CURSOR dept_avg      -- 커서 자체에 3가지 변수를 붙여둠 
               IS 
               SELECT d.department_name, COUNT (e.employee_id) CNT,
                                ROUND( AVG (salary) , 3) SAL  
               FROM employees e , departments d 
               WHERE e.department_id = d.department_id
                            AND e.department_id = v_deptno
               GROUP BY d.department_name;
               
               -- Cursor 에 Patch 하기 위한 변수들을 선언
               v_dname departments.department_name%TYPE;
               emp_cnt NUMBER;
               sal_avg NUMBER;
               -- 커서를 붙여둠
               
BEGIN   
            -- CURSOR OPEN : 커서를 오픈
            OPEN dept_avg;
            
            
            -- CURSOR FETCH : 커서를 붙임
            FETCH dept_avg INTO v_dname, emp_cnt, sal_avg;
            
            -- 출력
            DBMS_OUTPUT.PUT_LINE('부서명 : ' || v_dname);
            DBMS_OUTPUT.PUT_LINE('사원수 : ' || emp_cnt);
            DBMS_OUTPUT.PUT_LINE('급여평균 : ' || sal_avg);
            
            --커서닫기
            CLOSE dept_avg;

END;
/

EXEC expcursor_test(50);



