CREATE OR REPLACE PROCEDURE emp_name (id IN NUMBER, emp_name OUT VARCHAR2)
IS
BEGIN
    SELECT FIRST_NAME INTO emp_name
    FROM EMPLOYEES WHERE EMPLOYEE_ID = id;
END;
/

SET SERVEROUTPUT ON;
DECLARE
    empName varchar(20);
    CURSOR id_cur 
        IS 
        SELECT EMPLOYEE_ID 
        FROM EMPLOYEES; -- 커서를 셋팅
BEGIN
    FOR emp_rec in id_cur   -- 커서를 통해서 loop
    LOOP
        emp_name(emp_rec.EMPLOYEE_ID, empName); -- (들어감, 나옴)
        dbms_output.put_line('사원이름: ' || empName || ' 사원번호 ' || emp_rec.EMPLOYEE_ID);
    END LOOP;
END;
/

VAR empName VARCHAR2(20);
EXECUTE emp_name(&EMPNO, :empName);
PRINT empName;







