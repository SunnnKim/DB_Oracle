DECLARE
    -- ��� �̸��� ����ϱ� ���� PL/SQL ���̺� ���� 
    TYPE ename_table IS TABLE OF employees.first_name%TYPE
    INDEX BY BINARY_INTEGER;
	
    -- ��� �޿��� ����ϱ� ���� PL/SQL ���̺� ���� 
    TYPE sal_table IS TABLE OF employees.salary%TYPE
    INDEX BY BINARY_INTEGER;
	
    ename_tab    ename_table;
    sal_tab      sal_table;
	
    i BINARY_INTEGER := 0;

BEGIN
    DBMS_OUTPUT.ENABLE;
	
    FOR emp_list IN  (SELECT first_name, salary 
	                  FROM employees 
	                  WHERE department_id = 20) LOOP
        i := i +1;
	
        -- ���̺� ��ǰ �̸��� ����
        ename_tab(i) := emp_list.first_name;
	        
        -- ���̺� ��ǰ ������ ���� 
        sal_tab(i)   := emp_list.salary;
        
    END LOOP;
	
    --  ȭ�鿡 ���
    FOR cnt IN  1..i   LOOP
        DBMS_OUTPUT.PUT_LINE('����̸� : ' || ename_tab(cnt)); 
        DBMS_OUTPUT.PUT_LINE('����޿� : ' || sal_tab(cnt));
    END LOOP;
END;
 / 