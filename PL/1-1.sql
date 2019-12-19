--PL/SQL문의 실행

SET SERVEROUTPUT ON;

DECLARE
	V_NAME VARCHAR2(30) := '홍길동';
BEGIN
	DBMS_OUTPUT.PUT_LINE('오라클과 ' || V_NAME);	-- 단순 출력  (DBMS: DataBase Management System ; 데이터베이스 관리 시스템)

END;
/
SET SERVEROUTPUT OFF;

-----------------------------------------------------------------

SET SERVEROUTPUT ON;
DECLARE
	V_NAME employees.first_name%TYPE;
BEGIN
    V_NAME := 'PL';
	DBMS_OUTPUT.PUT_LINE('오라클과 ' || V_NAME);	

END;
/
SET SERVEROUTPUT OFF;

-----------------------------------------------------------------
 

-----------------------------------------------------------------
--정상적인 반복문 (1부터 10 더하기)

SET SERVEROUTPUT ON;
--단순 LOOP
DECLARE
    V_CNT NUMBER := 0;
    V_TOT NUMBER := 0;
BEGIN
    LOOP
        EXIT WHEN V_CNT = 10;        -- V_CNT 가 10이면 탈출 
            V_CNT := V_CNT + 1; 
            V_TOT := V_TOT + V_CNT;            
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('V_CNT : ' || V_CNT);
    DBMS_OUTPUT.PUT_LINE('V_TOT : ' || V_TOT);    
END;
/
SET SERVEROUTPUT OFF;
-----------------------------------------------------------------


-----------------------------------------------------------------
--단순 LOOP (3씩 중가)

SET SERVEROUTPUT ON;
DECLARE
    V_CNT NUMBER := 0;
    V_TOT NUMBER := 0;
BEGIN
    LOOP
        EXIT WHEN V_CNT = 12;        -- -- V_CNT 가 12면 탈출 
            V_CNT := V_CNT + 3; 
            V_TOT := V_TOT + V_CNT;            
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('V_CNT : ' || V_CNT);
    DBMS_OUTPUT.PUT_LINE('V_TOT : ' || V_TOT);    
END;
/
SET SERVEROUTPUT OFF;
-----------------------------------------------------------------


-----------------------------------------------------------------
--WHILE LOOP

SET SERVEROUTPUT ON;
DECLARE
    V_CNT NUMBER := 0;
    V_TOT NUMBER := 0;
BEGIN
    WHILE V_CNT < 10
    LOOP
            V_CNT := V_CNT + 1; 
            V_TOT := V_TOT + V_CNT;            
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('V_CNT : ' || V_CNT);
    DBMS_OUTPUT.PUT_LINE('V_TOT : ' || V_TOT);    
END;
/
SET SERVEROUTPUT OFF;
-----------------------------------------------------------------


-----------------------------------------------------------------
--WHILE LOOP (3씩 증가)

SET SERVEROUTPUT ON;
DECLARE
    V_CNT NUMBER := 0;
    V_TOT NUMBER := 0;
BEGIN
    WHILE V_CNT < 10
    LOOP
            V_CNT := V_CNT + 3; 
            V_TOT := V_TOT + V_CNT;            
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('V_CNT : ' || V_CNT);
    DBMS_OUTPUT.PUT_LINE('V_TOT : ' || V_TOT);    
END;
/
SET SERVEROUTPUT OFF;
-----------------------------------------------------------------


-----------------------------------------------------------------
--FOR LOOP

SET SERVEROUTPUT ON;
DECLARE
    V_CNT NUMBER := 0;
    V_TOT NUMBER := 0;
BEGIN
    FOR V_CNT IN 1 .. 10
    LOOP
            V_TOT := V_TOT + V_CNT;            
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('V_CNT : ' || V_CNT);
    DBMS_OUTPUT.PUT_LINE('V_TOT : ' || V_TOT);    
END;
/
SET SERVEROUTPUT OFF;
-----------------------------------------------------------------


-----------------------------------------------------------------
--FOR LOOP (3증가) -- IF문 사용

SET SERVEROUTPUT ON;
DECLARE
    V_CNT NUMBER := 0;
    V_TOT NUMBER := 0;
BEGIN
    FOR V_CNT IN 1 .. 10
    LOOP
        IF MOD(V_CNT, 3) = 0 THEN
            V_TOT := V_TOT + V_CNT;
        END IF;            
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('V_CNT : ' || V_CNT);
    DBMS_OUTPUT.PUT_LINE('V_TOT : ' || V_TOT);    
END;
/
SET SERVEROUTPUT OFF;
-----------------------------------------------------------------


-----------------------------------------------------------------
--제어문 CASE 와 GOTO

SET SERVEROUTPUT ON;
DECLARE
    V_NAME  VARCHAR2(30) := 'LEE';
    V_CASE  NUMBER := 1;
BEGIN
    CASE WHEN MOD(V_CASE, 2) = 0 THEN
              GOTO TEST1;			-- 나눈 나머지가 0일 경우, TEST1로 보낸다
         WHEN MOD(V_CASE, 2) = 1 THEN
              GOTO TEST2;			-- 나눈 나머지가 1일 경우, TEST2로 보낸다
         ELSE GOTO ERR;
    END CASE;

    
<<TEST1>>					-- TEST1
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' IS WOMAN');
    GOTO SUB_END;
<<TEST2>>					-- TEST2	
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' IS MAN');
    GOTO SUB_END;
<<ERR>>
    DBMS_OUTPUT.PUT_LINE('ERR_NAME : ' || V_NAME);
    GOTO SUB_END;
<<SUB_END>>
    DBMS_OUTPUT.PUT_LINE('EXIT SUB : ' || V_NAME);
   
END;
/
SET SERVEROUTPUT OFF;