SET SERVEROUTPUT ON; 

DECLARE
  v_cnt number := 300; 

BEGIN
  DBMS_OUTPUT.ENABLE; 
	
  WHILE v_cnt < 310 LOOP 

    INSERT INTO employees(employee_id, last_name, hire_date, department_id, job_id, email)
      VALUES(v_cnt, 'test'||to_char(v_cnt),  sysdate, 270, 'IT_PROG', to_char(v_cnt)||'@naver.com');
      
    v_cnt := v_cnt+1; 

    EXIT WHEN v_cnt > 310; 
	
  END LOOP; 
	
  DBMS_OUTPUT.PUT_LINE('������ �Է� �Ϸ�'); 
  DBMS_OUTPUT.PUT_LINE(v_cnt-300 || '���� �����Ͱ� �ԷµǾ����ϴ�'); 
		
END; 
 /
 
SELECT * FROM EMPLOYEES;

ROLLBACK;