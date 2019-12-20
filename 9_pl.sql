-- PL  (1)
/*
    PL / SQL  : Procedural Language / extension to Structured Query Language
        Procedural  = ó����
        - SQL�� Ȯ���� �������� ��� -> Procedure, Function, Trigger
        - SQL ���� ������ �����ϱ� ���ؼ� �ۼ��س��� �Լ� 
    
        + script �߰��ؼ� ����� �� ����
        
*/


/*
Script ����
--1. ����� : ����� ����/����� ����, �ʱ�ȭ
--2. ����� : ���� ó���� Query �κ��̳� ��� ���� Ȱ��. ���� ó��
--3. ����ó���� : ���� ���� �κ� ó�� (������ ����)
*/

-- PL Ű��
--SET SERVEROUTPUT ON -- �ѹ��� Ű�� �� ���� ����
BEGIN

        -- ����� 
        dbms_output.put_line('HELLO PL');

END;
/
--SET SERVEROUTPUT OFF
 -- �������� �ڵ忡���� END; �ڿ� �ݵ�� / (������) �Է��ؾ���  


DECLARE
        -- �����
        message VARCHAR2(10);       -- ������ �ڷ���;
        
BEGIN
        -- �����
        message  :=  'hello PL?';           -- ������ ������ ���� : (�ݷ�) �� �ݵ�� �ٿ��ش�
        DBMS_OUTPUT.put_line('message=' || message); -- || ���ڿ��⸮ �����ִ� ������
        
        -- ����ó����

END;
/

-- if ��
DECLARE
        counter INTEGER;
BEGIN
        counter := 1;
        counter := counter + 1;
    
        IF counter = 0 then
            
            DBMS_OUTPUT.put_line('RESULT : counter is null' );  
        ELSIF counter = 1 then
            DBMS_OUTPUT.put_line('RESULT : counter is not null' );  
        
      END IF;
    
        
END;
/



-- FOR ��
DECLARE 
            counter INTEGER;
            i INTEGER;
BEGIN
        for i IN 1..9 LOOP
        DBMS_OUTPUT.put_line('i=' || i ); 
        counter:=i * 2;
        DBMS_OUTPUT.put_line('2 * ' ||  '='|| counter ); 
        END LOOP;
  
END;
/

-- loop ��
DECLARE 
        v_count NUMBER :=  0; -- ����� ���ÿ� �ʱ�ȭ
        v_total NUMBER := 0;
BEGIN
        
        LOOP       
                    EXIT WHEN v_count = 10; -- ������ Ż������
                    v_count := v_count + 1;
                    v_total := v_total + v_count;
                    DBMS_OUTPUT.put_line('v_count = ' || v_count  ); 
        END LOOP;
        
            DBMS_OUTPUT.put_line('v_total = ' || v_total  ); 
 

END;
/


-- WHILE 
DECLARE
          v_count NUMBER :=  0; 
          v_total NUMBER := 0;

BEGIN
            WHILE v_count < 10
            LOOP -- ���ڵ� �Ʒ��� ������ �ۼ�
                    v_count := v_count + 1;
                    v_total := v_total + v_count;
                   
            END LOOP;
            DBMS_OUTPUT.put_line('v_total = ' || v_total  ); 
END;
/

-- GOTO
-- �ڹ� /c���� ������
-- �̵�(Ż��)�� �� ����
DECLARE
        v_name VARCHAR2(10) := 'LEE';
        v_case NUMBER := 1;
BEGIN
        CASE WHEN MOD(v_case, 2) = 0 THEN 
                            GOTO test1;     -- v_case�� 2�� ���� ���� 0�϶� test1�� ���ÿ�
                    WHEN MOD(v_case, 2) = 1 THEN 
                            GOTO test2;
                    ELSE 
                            GOTO ERR;   -- ���ڰ� ������ ������ ǥ���Ͻÿ�
        END CASE;
        
<<test1>>         
    dbms_output.put_line(v_name || 'is woman'); -- ���
    GOTO sub_end;
<<test2>>         
    dbms_output.put_line(v_name || 'is man'); -- ���
    GOTO sub_end;

<<err>>         
    dbms_output.put_line('ERR');
    GOTO sub_end;
    
    
<<sub_end>>
    dbms_output.put_line('Exit');

END;
/

--  ����ó����

DECLARE
        counter INTEGER;
BEGIN
        counter := 10;
        counter := 10 / 0; -- ���ܰ� ������ �ڵ�
        
EXCEPTION WHEN OTHERS THEN  -- ����ó����
    dbms_output.put_line('���ܰ� �߻��߽��ϴ�.'); -- ���

END;
/


-- varray : �迭 ( Variable ARRAY )
DECLARE
        TYPE varray_test IS VARRAY(3) OF INTEGER; -- TYPE Ÿ�Ը� IS VARRAY(�迭����) OF �ڷ���
        -- 3���� �迭, �������� 1���� ����(�ڹٴ� 0)
        -- int varray_test[ ]; �� ���� �ǹ��� �ڵ�
        varr  varray_test; -- ������ Ÿ�� : varray_testŸ���� ���� varr ����
BEGIN
        varr := varray_test(111,222,333); 
        -- varray_test[] = new int [3] �� ���� �ǹ�
        dbms_output.put_line('varr(1) = ' || varr(1)); 
        dbms_output.put_line('varr(2) = ' || varr(2));  
        dbms_output.put_line('varr(3) = ' || varr(3));         
        
END;
/



-- UI ȭ��(��� ������Ʈ â) ����� �Է°��� ���� ��� ����

ACCEPT p_deptno PROMPT '�μ���ȣ�� �Է��Ͻÿ�(�޿��� ��)' 
-- ������Ʈâ ����� �Է°� (�μ���ȣ)
DECLARE 
        v_salTotal NUMBER;
BEGIN
        -- ������ �ۼ��ؼ� �Է°��� ���� �ִ´�.
        SELECT  SUM(salary) INTO v_saltotal         
        -- select������ output(��ȸ�� ����)�� �ִµ�, �� ���� v_saltotal�� ����ִ´ٴ� �ǹ��� �ڵ�
        -- INTO : select������ ������� �ٸ� ������ �ִ� �����
        FROM employees
        WHERE department_id = &p_deptno;
        -- &�� �ܺο��� ���� �����´ٴ� �ǹ�
         dbms_output.put_line(&p_deptno ||'�� �μ��� �޿��� ���� ' 
                                                || TO_CHAR( v_saltotal, '$999,999,999')  || ' �Դϴ�.');         
END;
/


-- ����
-- �����ȣ�� �Է¹ް� �� ����� �޿��� 1000�� ���� ������ �����Ͻÿ�(update)
-- �� ���� �����ͼ� �����ȣ, ���ŵ� �޿��� ����ϵ��� �Ͻÿ� (SELECT) 

ACCEPT p_empid PROMPT '�����ȣ�� �Է��Ͻÿ�(+1000)'
DECLARE
            v_sal EMPLOYEES.salary%TYPE := 1000;    -- ���� ��(1000)
            -- ���̺��.�÷���%TYPE : �ڵ������� �ش� �÷��� �ڷ������� �����ش�
            v_salTotal NUMBER;
BEGIN
            -- ������Ʈ �� ���� ����ϱ�
            SELECT salary INTO v_salTotal
            FROM employees
            WHERE employee_id = &p_empid;
            dbms_output.put_line('�����ȣ : ' || &p_empid || ', �޿� : ' || v_salTotal );
            
            -- update
            UPDATE employees
            SET salary = salary + v_sal
            WHERE employee_id = &p_empid;
            
            -- select
            -- �����ͼ� ����ϱ�
            SELECT salary INTO v_salTotal
            FROM employees
            WHERE employee_id = &p_empid;

            dbms_output.put_line('�����ȣ : ' || &p_empid || '�� +1000���� �޿� : ' || v_salTotal );
END;
/

rollback;



-- ROWTYPE
-- �� ���̺��� ��� �÷� �ڷ����� ���� ������ ������
DECLARE
--        v_empno employees.employee_id%TYPE
        -- �Ǵ� 
        v_emp EMPLOYEES%ROWTYPE;    
        -- EMPLOYEES ���̺��� Ÿ���� ��� ������
        -- column �� �̸��� �ڵ������� �������� �ȴ�
        -- �� ���̺��� ���� ����Ÿ���� �������� ������ ����� �� ����
        -- ���� �� ) v_emp.first_name;

BEGIN
        SELECT employee_id, first_name, last_name, salary 
                        INTO v_emp.employee_id, v_emp.first_name, v_emp.last_name, v_emp.salary 
                        -- �̷��� ����� ������  ( ���� �ϳ��� ��� ������ �ʿ� ����)
        FROM employees
        WHERE employee_id = 100;
        dbms_output.put_line('�����ȣ : ' ||  v_emp.employee_id );
        dbms_output.put_line('����̸� : ' || v_emp.first_name );
        dbms_output.put_line('����� : ' || v_emp.last_name );
        dbms_output.put_line('����޿� : ' ||  v_emp.salary );
              
END;
/

-- ���� 2

-- �̸�, �޿�, �μ���ȣ�� �Է¹޾�
-- ����� �߰��ϱ� (employees ���̺�)  * job_id = IT_PROG / email : �̸�@example.com
-- �μ���ȣ�� 30�� ��� -> �Է¹��� �޿��� 20% �λ��ؼ� �Է�
-- �μ���ȣ�� 60�� ��� -> �Է¹��� �޿��� 10% �λ��ؼ� �Է�

-- �Է�ó��
ACCEPT p_name PROMPT '�̸� : '
ACCEPT p_sal PROMPT '�޿� : '
ACCEPT p_deptno PROMPT '�μ���ȣ : '

DECLARE
        v_name employees.last_name%TYPE := '&p_name'; -- ���ڿ��϶��� '' �ȿ� �־��ֱ�
        v_sal employees.salary%TYPE := &p_sal;
        v_deptno employees.department_id%TYPE := &p_deptno;
        v_emp employees%ROWTYPE;
BEGIN
                dbms_output.put_line( '�Է°� Ȯ���ϱ�');
                dbms_output.put_line( v_name);
                dbms_output.put_line( v_sal);
                dbms_output.put_line( v_deptno);

                IF v_deptno = 30 THEN v_sal := v_sal * 1.2;
                ELSIF v_deptno = 60 THEN v_sal := v_sal *1.1;
                END IF;
                
                INSERT INTO employees
                VALUES ( EMPLOYEES_SEQ.nextval, null, v_name, v_name||'@example.com',
                                    null, SYSDATE, 'IT_PROG', v_sal, null,null, v_deptno);
                
                -- ����ϱ�
                SELECT * INTO v_emp 
                FROM employees
                WHERE last_name = v_name;
                
                dbms_output.put_line( '<�Էµ� ���>');
                dbms_output.put_line( v_emp.employee_id);
                dbms_output.put_line( v_emp.last_name);
                dbms_output.put_line( v_emp.salary);
                dbms_output.put_line( v_emp.email);
                dbms_output.put_line( v_emp.department_id);
          
END;
/
-- �ּ����� �ǵ��� �ٱ��� �ޱ�
    
                 
SELECT
    *
FROM employees;

ROLLBACK;
COMMIT;
