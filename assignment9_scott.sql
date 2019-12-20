
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

CREATE OR REPLACE FUNCTION get_emp_count (v_deptno emp.empno%TYPE)
RETURN NUMBER
IS      
            cnt_emp NUMBER;
BEGIN
            SELECT count(empno)
                            INTO cnt_emp
            FROM emp
            WHERE deptno = v_deptno;
            
            RETURN cnt_emp;
            

END;
/

ACCEPT p_deptno PROMPT '�����ȣ : '
VAR deptno NUMBER;
EXEC :deptno := get_emp_count(&p_deptno);
PRINT deptno;




--3) emp���̺��� �̿��ؼ� �Ի����� �����ϸ� �ٹ������� ���ϴ� �Լ��� �����Ͻÿ�.(�Ҽ��� 
--   �ڸ� ����, �Լ��� get_info_hiredate)

CREATE OR REPLACE FUNCTION get_info_hiredate (empnum emp.empno%TYPE)
RETURN NUMBER
IS
                v_workyear NUMBER;
BEGIN
                SELECT ROUND(MONTHS_BETWEEN(SYSDATE,hiredate)/12)
                        INTO v_workyear
                FROM emp
                WHERE empnum = empno;
                
              RETURN   v_workyear;
              
                
                
END;
/

ACCEPT p_empno PROMPT '�����ȣ : '
SELECT get_info_hiredate(&p_empno) �ٹ�����
FROM DUAL;




--4) emp���̺��� �̿��ؼ� �����ȣ�� �Է��ϸ� �ش� ����� ������ �̸��� ���ϴ� �Լ���
  -- �����Ͻÿ�.(�Լ��� get_mgr_name)
  
CREATE OR REPLACE FUNCTION get_mgr_name (empnum emp.empno%TYPE)
RETURN VARCHAR2
IS
            mgr_name VARCHAR2(20);
BEGIN
            SELECT b.ename manager_name
                            INTO mgr_name
            FROM emp a, emp b
            WHERE   a.mgr = b.empno 
                            AND empnum = a.empno;
            
            RETURN mgr_name;
            
END;
/

ACCEPT p_empno PROMPT '�����ȣ : '
select get_mgr_name(&p_empno)"�Ŵ��� �̸�"
FROM DUAL;


--5) emp���̺��� �̿��ؼ� �����ȣ�� �Է��ϸ� �޿� ����� ���ϴ� �Լ��� �����Ͻÿ�.
--(4000~5000 A, 3000~4000�̸� B, 2000~3000�̸� C, 1000~200�̸� D, 1000�̸� F,
--�Լ��� get_sal_grade)

CREATE OR REPLACE FUNCTION get_sal_grade ( empnum emp.empno%TYPE)
RETURN VARCHAR2
IS
        emp_sal emp.sal%TYPE;
        sal_rate VARCHAR2(10);
BEGIN
            SELECT sal
                        INTO emp_sal
            FROM emp
            WHERE empno = empnum;
            
            CASE WHEN emp_sal >=4000 AND emp_sal<= 5000 THEN 
                            sal_rate := 'A' ;
                        WHEN emp_sal >=3000 THEN 
                            sal_rate := 'B';
                        WHEN emp_sal >=2000 THEN 
                            sal_rate := 'C';
                        WHEN emp_sal >=1000 THEN 
                            sal_rate := 'D';
                        ELSE 
                            sal_rate := 'F';
                        END CASE;
                        
            RETURN sal_rate;
            
END;
/

ACCEPT p_empno PROMPT '�����ȣ : '
SELECT get_sal_grade(&p_empno)
FROM DUAL;



