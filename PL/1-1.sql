--PL/SQL���� ����

SET SERVEROUTPUT ON;

DECLARE
	V_NAME VARCHAR2(30) := 'ȫ�浿';
BEGIN
	DBMS_OUTPUT.PUT_LINE('����Ŭ�� ' || V_NAME);	-- �ܼ� ���  (DBMS: DataBase Management System ; �����ͺ��̽� ���� �ý���)

END;
/
SET SERVEROUTPUT OFF;

-----------------------------------------------------------------

SET SERVEROUTPUT ON;
DECLARE
	V_NAME employees.first_name%TYPE;
BEGIN
    V_NAME := 'PL';
	DBMS_OUTPUT.PUT_LINE('����Ŭ�� ' || V_NAME);	

END;
/
SET SERVEROUTPUT OFF;

-----------------------------------------------------------------
 

-----------------------------------------------------------------
--�������� �ݺ��� (1���� 10 ���ϱ�)

SET SERVEROUTPUT ON;
--�ܼ� LOOP
DECLARE
    V_CNT NUMBER := 0;
    V_TOT NUMBER := 0;
BEGIN
    LOOP
        EXIT WHEN V_CNT = 10;        -- V_CNT �� 10�̸� Ż�� 
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
--�ܼ� LOOP (3�� �߰�)

SET SERVEROUTPUT ON;
DECLARE
    V_CNT NUMBER := 0;
    V_TOT NUMBER := 0;
BEGIN
    LOOP
        EXIT WHEN V_CNT = 12;        -- -- V_CNT �� 12�� Ż�� 
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
--WHILE LOOP (3�� ����)

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
--FOR LOOP (3����) -- IF�� ���

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
--��� CASE �� GOTO

SET SERVEROUTPUT ON;
DECLARE
    V_NAME  VARCHAR2(30) := 'LEE';
    V_CASE  NUMBER := 1;
BEGIN
    CASE WHEN MOD(V_CASE, 2) = 0 THEN
              GOTO TEST1;			-- ���� �������� 0�� ���, TEST1�� ������
         WHEN MOD(V_CASE, 2) = 1 THEN
              GOTO TEST2;			-- ���� �������� 1�� ���, TEST2�� ������
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