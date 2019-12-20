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

--����2) �̸�,�޿�,�μ���ȣ�� �Է¹޾� EMP ���̺� �ڷḦ ����ϴ� SCRIPT�� �ۼ��Ͽ���. 
--�� 10�� �μ��� ���, �Է��� �޿��� 20%�� �߰��ϰ� �ʱⰪ�� 9000���� 9999���� 
--1�� �����ϴ� SEQUENCE(EMP_EMPNO_SEQ)�ۼ��Ͽ� ����ϰ� �Ʒ��� ǥ�� 
--�����Ͽ���.

--��    ��: ȫ�浿
--��    ��: 2000
--�μ���ȣ: 10

-- INSERT -> procedure

CREATE OR REPLACE PROCEDURE insert_emp( v_name IN employees.last_name%TYPE,
                                                                                        v_sal IN employees.salary%TYPE,
                                                                                        v_deptno IN employees.department_id%TYPE)
IS
        var_plus_sal employees.salary%TYPE := v_sal;
           
BEGIN
           
            IF v_deptno = 10 THEN
                var_plus_sal := var_plus_sal * 1.1;
            END IF;

            INSERT INTO employees
            VALUES ( employees_SEQ.NEXTVAL, null, v_name,
                                v_name||'@example.com', null, SYSDATE, 'IT_PROG', var_plus_sal, null, null, v_deptno);


END;
/

EXEC insert_emp('ȫ�浿',2000,10);

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

            SELECT department_id 
                            INTO v_deptno
            FROM employees 
            WHERE employee_id = v_empno;


            SELECT MAX(salary) - MIN(salary)
                            INTO   v_salgap
            FROM employees
            WHERE  department_id = v_deptno;
            
               DBMS_OUTPUT.put_line('�ְ����� ���������� ���� : ' ||v_salgap ); 

END;
/

ACCEPT p_empno PROMPT '�����ȣ : '
EXEC print_maxmin(&p_empno);






-- function
--1) �� ���ڸ� �����ϸ� ������ �ؼ� ������� ��ȯ�ϴ� �Լ��� �����Ͻÿ�.(�Լ��� add_num)
CREATE OR REPLACE FUNCTION add_num( v_num1 NUMBER, v_num2 NUMBER) RETURN NUMBER
IS
            sum_num NUMBER(10);
BEGIN
            sum_num := v_num1 + v_num2;
            RETURN sum_num;

END;
/
SELECT add_num(1,2)
FROM DUAL;

-- ������ �����
VAR sum_num NUMBER;
EXEC :sum_num := add_num(1,2);
PRINT sum_num;


--2) �μ���ȣ�� �Է��ϸ� �ش� �μ����� �ٹ��ϴ� ��� ���� ��ȯ�ϴ� �Լ��� �����Ͻÿ�.
-- (�Լ��� get_emp_count)

CREATE OR REPLACE FUNCTION get_emp_count (v_deptno employees.employee_id%TYPE)
RETURN NUMBER
IS      
            cnt_emp NUMBER;
BEGIN
            SELECT count(employee_id)
                            INTO cnt_emp
            FROM employees
            WHERE department_id = v_deptno;
            
            RETURN cnt_emp;
            
--EXCEPTION WHEN NO_DATA_FOUND THEN  
--            DBMS_OUTPUT.PUT_LINE('�ش� �μ��� �����ϴ�.')
        
END;
/

VAR deptno NUMBER;
EXEC :deptno := get_emp_count(100);
PRINT deptno;




--3) emp���̺��� �̿��ؼ� �Ի����� �����ϸ� �ٹ������� ���ϴ� �Լ��� �����Ͻÿ�.(�Ҽ��� 
--   �ڸ� ����, �Լ��� get_info_hiredate)

CREATE OR REPLACE FUNCTION get_info_hiredate (empno employees.employee_id%TYPE)
RETURN NUMBER
IS
                v_workyear NUMBER;
BEGIN
                SELECT ROUND(MONTHS_BETWEEN(SYSDATE,hire_date)/12)
                        INTO v_workyear
                FROM employees
                WHERE empno = employee_id;
                
              RETURN   v_workyear;
              
                
                
END;
/

ACCEPT p_empno PROMPT '�����ȣ : '
SELECT get_info_hiredate(&p_empno) �ٹ�����
FROM DUAL;

--4) emp���̺��� �̿��ؼ� �����ȣ�� �Է��ϸ� �ش� ����� ������ �̸��� ���ϴ� �Լ���
  -- �����Ͻÿ�.(�Լ��� get_mgr_name)
  
CREATE OR REPLACE FUNCTION get_mgr_name (empno employees.employee_id%TYPE)
RETURN VARCHAR2
IS
            mgr_name VARCHAR2(20);
BEGIN
            SELECT b.first_name || ' ' || b.last_name manager_name
                            INTO mgr_name
            FROM employees a, employees b
            WHERE   a.manager_id = b.employee_id 
                            AND empno = a.employee_id;
            
            RETURN mgr_name;
                
END;
/

ACCEPT p_empno PROMPT '�����ȣ : '
select get_mgr_name(&p_empno)"�Ŵ��� �̸�"
FROM DUAL;


--5) emp���̺��� �̿��ؼ� �����ȣ�� �Է��ϸ� �޿� ����� ���ϴ� �Լ��� �����Ͻÿ�.
--(4000~5000 A, 3000~4000�̸� B, 2000~3000�̸� C, 1000~200�̸� D, 1000�̸� F,
--�Լ��� get_sal_grade)




