--  ���ν��� ����
SET SERVEROUTPUT ON;

-- 
--����1) �����ȣ �Է� �ް� �� ����� �޿��� 1000�� ���� ������ �����϶�.
-- update --> Procedure ��� 
CREATE OR REPLACE PROCEDURE update_sal( empno IN employees.employee_id%TYPE)
IS
            v_plus_sal  NUMBER := 1000;
BEGIN
            UPDATE employees
            SET salary = salary + v_plus_sal
            WHERE employee_id = empno;
            
END;
/

EXEC update_sal(100);
rollback;


-- �Ǵ� ��ũ��Ʈ�� �����
ACCEPT p_empno PROMPT '����� ��ȣ�� �Է��Ͻÿ�(�޿�+1000) : '
DECLARE 
                v_sal NUMBER;
BEGIN
            
            UPDATE employees
            SET salary = salary +1000
            WHERE employee_id = &p_empno;
            
            SELECT salary
                        INTO v_sal
            FROM employees
            WHERE employee_id = &p_empno;
            DBMS_OUTPUT.PUT_LINE('�����ȣ : '|| &p_empno || '  �޿� : ' ||v_sal);
END;
/


--����2) �̸�,�޿�,�μ���ȣ�� �Է¹޾� EMP ���̺� �ڷḦ ����ϴ� SCRIPT�� �ۼ��Ͽ���. 
--�� 10�� �μ��� ���, �Է��� �޿��� 20%�� �߰��ϰ� 
--�ʱⰪ�� 9000���� 9999���� 1�� �����ϴ� SEQUENCE(EMP_EMPNO_SEQ)�ۼ��Ͽ� ����ϰ� �Ʒ��� ǥ�� 
--�����Ͽ���.

--��    ��: ȫ�浿
--��    ��: 2000
--�μ���ȣ: 10

-- INSERT -> procedure
-- 1. ������ �����
CREATE SEQUENCE EMP_EMPNO_SEQ 
INCREMENT BY 1
START WITH 9000
MAXVALUE 9999;

-- 1. ���ν��� 
CREATE OR REPLACE PROCEDURE insert_emp( v_name IN employees.last_name%TYPE,
                                                                                        v_sal IN employees.salary%TYPE,
                                                                                        v_deptno IN employees.department_id%TYPE)
IS
        var_plus_sal employees.salary%TYPE := v_sal;
           
BEGIN
           
            IF v_deptno = 10 THEN
                var_plus_sal := var_plus_sal * 1.2;
            END IF;

            INSERT INTO employees
            VALUES ( EMP_EMPNO_SEQ.NEXTVAL, null, v_name,
                                v_name||'@example.com', null, SYSDATE, 'IT_PROG', var_plus_sal, null, null, v_deptno);


END;
/


EXEC insert_emp('�̱浿',2000,10);

SELECT
    *
FROM employees
WHERE employee_id >=9000;


-- ��ũ��Ʈ�� �ۼ��ϱ�
ACCEPT p_name PROMPT '�� �� : '
ACCEPT p_sal PROMPT '�� �� : '
ACCEPT p_deptno PROMPT '�μ���ȣ : '
DECLARE
            v_name VARCHAR2(10) := '&p_name';
            v_sal employees.salary%TYPE := &p_sal;
            v_deptno employees.department_id%TYPE := &p_deptno;
            
            v_emp employees%ROWTYPE;
            
BEGIN
            
              IF v_deptno = 10 THEN
                v_sal := v_sal * 1.2;
            END IF;

            INSERT INTO employees
            VALUES ( EMP_EMPNO_SEQ.NEXTVAL, null, v_name,
                                v_name||'@example.com', null, SYSDATE, 'IT_PROG', v_sal, null, null, v_deptno);
          
            SELECT *
                        INTO v_emp
            FROM employees
            WHERE last_name = v_name;
            
            DBMS_OUTPUT.PUT_LINE('name = ' || v_emp.last_name);
            DBMS_OUTPUT.PUT_LINE('salary = ' || v_emp.salary);
            DBMS_OUTPUT.PUT_LINE('department_id = ' || v_emp.department_id);

END;
/




ROLLBACK;
commit;



--����3) EVEN_ODD(ID:NUMBER(4) GUBUN:VARCHAR2(10)) ���̺��� �ۼ��ϰ� 
--START���ڿ� END ���ڸ� �Է� �޾� �� ������ ���ڸ� ID�� ID�� ���ڰ� ¦���̸� GUBUN�� ��¦������ 
--Ȧ���̸� GUBUN�� ��Ȧ������� �Է��ϴ� SCRIPT�� WHILE������ �ۼ��Ͽ���.


CREATE TABLE EVEN_ODD(
    ID NUMBER(4),
    GUBUN VARCHAR2(10)
);

CREATE OR REPLACE PROCEDURE check_odd_even( v_start NUMBER, v_end NUMBER)
IS
            check_num NUMBER := v_start;
            end_num NUMBER := v_end;
            check_mag VARCHAR2(10);
BEGIN   
                WHILE  check_num <= end_num
                LOOP 
                            IF ( MOD( check_num, 2) = 0) THEN
                                check_mag := '¦��';
                            ELSE 
                                 check_mag := 'Ȧ��';
                            END IF;
                            
                            INSERT INTO even_odd
                            VALUES (check_num, check_mag);
                            check_num := check_num +1;
                END LOOP;
END;
/

ACCEPT p_startnum PROMPT '���۹�ȣ :'
ACCEPT p_endnum PROMPT '����ȣ :'
EXEC check_odd_even( &p_startnum, &p_endnum);


SELECT
    *
FROM even_odd;


ROLLBACK;

-- ������Ʈ�� �����
ACCEPT p_start PROMPT '���۹�ȣ :'
ACCEPT p_end PROMPT '����ȣ :'
DECLARE
            v_start even_odd.id%TYPE := &p_start;
            v_end even_odd.id%TYPE := &p_end;
BEGIN
                IF v_start > v_end THEN
                    DBMS_OUTPUT.PUT_LINE('start�� end���� Ů�ϴ�.');
                ELSE 
                        WHILE v_start <= v_end 
                        LOOP
                            IF MOD(v_start, 2) = 0 THEN
                                INSERT INTO even_odd
                                VALUES(v_start, '¦��');
                            ELSE 
                                INSERT INTO even_odd
                                VALUES(v_start, 'Ȧ��');
                            END IF;
                                   
                             v_start := v_start+1;
                        END LOOP;
                
                DBMS_OUTPUT.PUT_LINE(&p_start || '�κ��� ' || &p_end ||'���� ' ||
                                                               TO_CHAR( &p_end - &p_start+1) || '���� �ڷᰡ �ԷµǾ����ϴ�.');
                END IF;
END;
/






--����4)�����ȣ�� �Է� ������ ������ ���� ��µǴ� PROCEDURE�� �ۼ��϶�
 --Purchasing �μ����� ����Դϴ�

CREATE OR REPLACE PROCEDURE print_deptname( v_empno employees.employee_id%TYPE)
IS
        v_deptname departments.department_name%TYPE;
BEGIN
            SELECT d.department_name
                            INTO v_deptname
            FROM employees e, departments d 
            WHERE e.department_id = d.department_id
                            AND v_empno = e.employee_id;
            
            DBMS_OUTPUT.put_line(v_deptname ||' �μ����� ����Դϴ�.');
END;
/

ACCEPT p_empno PROMPT '�����ȣ : '
EXEC print_deptname (&p_empno);





--����5)�����ȣ�� �Է¹ް�, �ҼӺμ��� �ְ�, �������� ������ �Ķ���ͷ� ����ϴ� PROCEDURE�� �ۼ��϶�.

CREATE OR REPLACE PROCEDURE print_maxmin ( v_empno employees.employee_id%TYPE)
IS
                v_salgap employees.salary%TYPE;
                v_deptno employees.salary%TYPE;                
                
BEGIN
            -- �μ���ȣ �˾Ƴ���
            SELECT department_id 
                            INTO v_deptno
            FROM employees 
            WHERE employee_id = v_empno;

            -- �ְ� , �ּұ޿��� ���� 
            SELECT MAX(salary) - MIN(salary)
                            INTO   v_salgap
            FROM employees
            WHERE  department_id = v_deptno;
            
               DBMS_OUTPUT.put_line('�ְ����� ���������� ���� : ' ||v_salgap ); 

END;
/

ACCEPT p_empno PROMPT '�����ȣ : '
EXEC print_maxmin(&p_empno);

-- ������ �ޱ�
VAR di NUMBER
EXECUTE :di := print_maxmin(107);
PRINT di;


