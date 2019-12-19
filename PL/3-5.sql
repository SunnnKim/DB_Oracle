DROP PROCEDURE Table_Test;

CREATE OR REPLACE PROCEDURE Table_Test
IS
  i BINARY_INTEGER := 0;
 
  -- PL/SQL Table of Record�� ����
  TYPE dept_table_type IS TABLE OF departments%ROWTYPE
  INDEX BY BINARY_INTEGER;
 
  dept_table dept_table_type;
 
BEGIN
  FOR dept_list IN (SELECT * FROM departments) LOOP
    i:= i+1;
  
    -- TABLE OF RECORD�� ������ ����
    dept_table(i).department_id := dept_list.department_id ;     
    dept_table(i).department_name := dept_list.department_name ;
    dept_table(i).location_id   := dept_list.location_id ;
 
  END LOOP;
 
  FOR cnt IN 1..i LOOP
 
    -- ������ ���
    DBMS_OUTPUT.PUT_LINE( '�μ���ȣ : ' || dept_table(cnt).department_id || 
                          ' �μ��� : ' ||  dept_table(cnt).department_name || 
                          ' ��ġ : ' || dept_table(cnt).location_id );
  END LOOP;
END;
/

SET SERVEROUTPUT ON ;

EXECUTE Table_test;

