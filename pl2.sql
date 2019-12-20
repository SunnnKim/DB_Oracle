-- Procedure
/*
        - block �Ǿ��ִ� ó�� : �Լ�ȭ, �Լ������� ����� ��
        - �������� ������ �ִ� ��� : �Ű�����, RETURN ��
        * PL
        1) PROCEDURE : INSERT, DELETE, UPDATE ���� ���� �����
        2) FUNCTION : SELECT���� ����� �� ���� ���
        3) TRIGGER : �Լ��� ���� (Ȯ�ο�), UTIL ������ ���� �����

*/
SET SERVEROUTPUT ON -- �ֿܼ� ����ϱ� ���� �����ƿ�ǲ ON

-- PROCEDURE ���� ( OR REPLACE : ��Ȱ��)
CREATE OR REPLACE PROCEDURE myProc ( inNum IN NUMBER, outNum OUT NUMBER) 
IS
                -- �����
                
BEGIN
                -- �����
                DBMS_OUTPUT.PUT_LINE('inNum= ' || inNum ); 
                outNum := 333;      -- �ܺο��� ���� �־� ��ȯ��
                
                DBMS_OUTPUT.PUT_LINE('outNum= ' || outNum );                 
                -- ����ó����

END;
/

-- IN / OUT : �Ű����� / ���ϰ�, ���ν����� �Ű������� ���� ��ȯ���� ���ϵǹǷ� ���ϰ��� Ÿ�԰� �̸��� �Ű������� �����ش�.
-- IS  : �����, declare��� IS�� ���
-- BEGIN : ����� + ����ó��
-- END : ����
-- ������ :
-- Procedure MYPROC��(��) �����ϵǾ����ϴ�. 
-- ���ν����� �Լ��� �����ΰ� ȣ���ϴ� ����̱� ����
-- ������ ������ ���ν��� ������ ���� ����

-- ���ν��� ȣ���ϱ� : 
-- 1. ���� ����� : VAR
-- 2. ���ν��� ȣ�� : EXECUTE
-- 3. ����ϱ� : PRINT
VAR val NUMBER ;            
/* VAR ������  �ڷ���;   
    = int val;            
    myproc ( ������� ��, ���ϰ� ���� ����)*/
EXECUTE myproc ( 111, :val );
PRINT val;

-- �Ű������� ���� ���ν���
CREATE OR REPLACE PROCEDURE helloProc
IS
            msg VARCHAR(10);
BEGIN
            msg := 'helloProc';
            DBMS_OUTPUT.put_line(msg || 'ȣ��');
END;
/

-- �ٷ� exec�� ȣ���ϸ� �ȴ�
EXEC helloproc;

-- departments ���̺�  row �߰��ϱ�
-- ���� �ڵ�
INSERT INTO departments ( department_id, department_name, location_id)
VALUES ( 300 , '������', 1700);
ROLLBACK;
-- ���ν����� ���߰��ϱ�
CREATE OR REPLACE PROCEDURE add_dept( p_deptno IN departments.department_id%TYPE,
                                                                                        p_deptname IN departments.department_name%TYPE,
                                                                                        p_deptloc IN departments.location_id%TYPE)
IS
        
BEGIN
                INSERT INTO departments ( department_id, department_name, location_id)
                VALUES ( p_deptno , p_deptname, p_deptloc);
                
                EXCEPTION WHEN OTHERS THEN 
                DBMS_OUTPUT.put_line('�߰��� �����߽��ϴ�.');
                ROLLBACK;
END;
/
-- ���� ������ COMMIT,
-- �����߻��ϸ� ����ó���κп� �޼��� ����ְ� ROLLBACK

-- �����ϱ�
EXECUTE add_dept(301, '�űԺμ�', 2500);





-- 2. UPDATE
-- update salary : �����ȣ�� �Է¹޾Ƽ� �޿��� �λ� (30%)

-- ���ν��� �ۼ� �� ����
CREATE OR REPLACE PROCEDURE updateSal ( v_empno IN NUMBER)
IS
BEGIN
        UPDATE employees
        SET salary = salary * 1.3
        WHERE employee_id = v_empno;
        
        EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('�߰��� �����߽��ϴ�.');
        ROLLBACK;
END;
/

-- ȣ���ϱ�
ACCEP empno PROMPT '�����ȣ : '
EXEC updatesal ( &empno );
ROLLBACK;


--  select
-- ���ν����� SELECT�ϱ⿣ �Ѱ谡 �ֱ� ������ �� �������� �ʴ´�
-- �����ȣ �Է¹����� �� ����� �̸�, �����ȣ, ����޿��� ����� �ǵ��� �Ͻÿ�
CREATE OR REPLACE PROCEDURE emp_info(p_empno IN employees.employee_id%TYPE)
IS
            v_emp employees%ROWTYPE;
BEGIN
            SELECT first_name, employee_id, salary
                            INTO v_emp.first_name, v_emp.employee_id, v_emp.salary
                            FROM employees
            WHERE employee_id = p_empno;
            
            DBMS_OUTPUT.put_line('�̸�: ' || v_emp.first_name );
            DBMS_OUTPUT.put_line('�����ȣ: ' || v_emp.employee_id );
            DBMS_OUTPUT.put_line('�޿�: ' || v_emp.salary );
            
END;
/
-- 3���� ���� ���� ( ROWTYPE�� v_emp ���� ���)


-- ȣ���ϱ�
EXEC emp_info(102);


-- Cursor
/*
        Cursor  : ���� �ּ� ���� -> pointer
        1) �Ͻ��� Ŀ�� : �ڵ�����
                    SQL%ROWCOUNT : ROW�� �� (�⺻���� Ŀ��)
                    SQL%FOUND : ROW�� ���� �� �� �̻��� ��� (�����Ͱ� �ִ��� Ȯ��)
                    SQL%NOTFOUND : ROW�� ����  0
        2) ����� Ŀ�� : ��������
                    
*/
-- �Ͻ��� Ŀ�� ����

CREATE OR REPLACE PROCEDURE implicit_cursor( p_empname IN employees.first_name%TYPE)
IS
                v_sal employees.salary%TYPE;
                v_update_row NUMBER;
                
BEGIN
                -- �˻�
                SELECT salary
                                INTO v_sal
                FROM employees
                WHERE first_name = p_empname;
                
                -- �˻��� �� �����Ͱ� �ִ� ���
                IF SQL%FOUND  THEN
                    DBMS_OUTPUT.PUT_LINE('�˻��� �����Ͱ� �ֽ��ϴ�');
                END IF;

                -- �����۾�
                UPDATE employees
                SET salary = salary * 1.1
                WHERE first_name = p_empname;
                
                -- ���
                v_update_row := SQL%ROWCOUNT;
                DBMS_OUTPUT.PUT_LINE('�޿��� �λ�� ��� �� : ' || v_update_row);
                
                -- �˻��� �����Ͱ� ������ ����ó��
EXCEPTION WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('�˻��� ����� �����ϴ�.');
                
END;
/
-- IS ; 
-- v_sal :  salary �˻��� ����
-- v_update_row :��� ���� �����Ǵ��� �����ϴ� �κ��� ����
-- SQL%FOUND : ���� �����ϴ��� Ȯ��
-- SQL%ROWCOUNT : ���� �ٷ� ������Ʈ �� �������� ���� ���� ���

-- ȣ���ϱ�
-- Steven
EXECUTE implicit_cursor('Guy');
-- ���� �ڵ�� 1�� �ִ� �����͸� ����� �ȴ�
ROLLBACK;


-- ����� Ŀ��
-- ���� ������ �ʿ���
-- ���������� ���ϴ� ���� Ŀ���� ���� �ٿ��־� ������ ������ ���� �� ����
-- ���� : 
CREATE OR REPLACE PROCEDURE expCursor_test( v_deptno IN departments.department_id%TYPE)
IS
               CURSOR dept_avg      -- Ŀ�� ��ü�� 3���� ������ �ٿ��� 
               IS 
               SELECT d.department_name, COUNT (e.employee_id) CNT,
                                ROUND( AVG (salary) , 3) SAL  
               FROM employees e , departments d 
               WHERE e.department_id = d.department_id
                            AND e.department_id = v_deptno
               GROUP BY d.department_name;
               
               -- Cursor �� Patch �ϱ� ���� �������� ����
               v_dname departments.department_name%TYPE;
               emp_cnt NUMBER;
               sal_avg NUMBER;
               -- Ŀ���� �ٿ���
               
BEGIN   
            -- CURSOR OPEN : Ŀ���� ����
            OPEN dept_avg;
            
            
            -- CURSOR FETCH : Ŀ���� ����
            FETCH dept_avg INTO v_dname, emp_cnt, sal_avg;
            
            -- ���
            DBMS_OUTPUT.PUT_LINE('�μ��� : ' || v_dname);
            DBMS_OUTPUT.PUT_LINE('����� : ' || emp_cnt);
            DBMS_OUTPUT.PUT_LINE('�޿���� : ' || sal_avg);
            
            --Ŀ���ݱ�
            CLOSE dept_avg;

END;
/

EXEC expcursor_test(50);



