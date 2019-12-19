/*
    view : ���� ���̺�
    - ��ü�� ���� ���̺� 
    - ���� ����Ǵ� ���� �ƴ� => c��� �����Ϳ� ����� ����
    - table <- view �� ����
    - â���� ���� : �並 ���� ���̺��� �� �� ����
    - ���ϴ� �͸� �̾Ƽ� �� �� ����
    - �Ѱ��� ��� �������� ���̺��� �����͸� �˻��ϴ� ���� ����
    - ó�� �ӵ��� ����
    - ������ ������ �� ���� (READ ONLY)
    - �����͸� ������ �� ���Ἲ�� �����ؼ� �����͸� �־�� ��
    - �˻������� ���� ����
   
*/
CREATE VIEW UB_TEST_01(
        JOB_ID ,
        JOB_TITLE,
        MIN_SALARY
) AS
SELECT job_id, job_title, min_salary
FROM jobs;

-- ��� �׽�Ʈ
SELECT * FROM ub_test_01; -- â���� ���ؼ� �˻���


INSERT INTO ub_test_01
VALUES('DEVELOPER', '������', 10000); -- �信 ������ ����
-- �����͸� ������ ���� ������ ��ü�� ���
-- ���Ե� �����ʹ� JOBS ���̺� ����ȴ�
-- �Ʒ��� �ڵ带 �����ϸ� ��� ������ �����Ͱ� ���ִ� ���� �� �� �ִ�
SELECT * FROM JOBS;
ROLLBACK; -- Ŀ������ �����Ϸ��� �ѹ��� �����ϸ� �ȴ�.
COMMIT; -- Ŀ���Ŀ� �����Ϸ��� MODIFY�� UPDATE ����� �Ǵ� view ��  �����ؾ���


CREATE TABLE TB_TEST02(
        KEY_01 VARCHAR2(10),
        KEY_02 VARCHAR2(10),
        COL_01 VARCHAR2(20),
        COL_02 VARCHAR2(20),
        CONSTRAINT PK_TEST_02 PRIMARY KEY(KEY_01, KEY_02)
);

CREATE VIEW UB_TEST_02(
        KEY_01, 
        KEY_02,
        COL_01,
        CONSTRAINT PK_UB_TEST_02 PRIMARY KEY (KEY_01, KEY_02)
                DISABLE NOVALIDATE
) AS
SELECT KEY_01, KEY_02, COL_01
FROM TB_TEST02;

-- �����ͺ���
SELECT * FROM TB_TEST02;

INSERT INTO UB_TEST_02( KEY_01, KEY_02, COL_01)
VALUES ('AAA', 'aaa', '111');

SELECT * FROM UB_TEST_02;


--READ ONLY
CREATE OR REPLACE VIEW EMPVIEW ( -- OR REPLACE : �̹� �ִ� ���̺�/�信 ���ο� ���̺��� �����
        "�����ȣ" , 
        "��" ,
        "�̸���",
        "�Ի���",
        "����",
        CONSTRAINT PK_UB_EMP PRIMARY KEY ("�����ȣ")
        DISABLE NOVALIDATE
)
AS
SELECT employee_id, last_name,email, hire_date, job_id FROM employees
WITH READ ONLY; -- ������ ������ �Ұ���(�����߻���)
-- Ȯ��
SELECT
    *
FROM empview;

INSERT INTO empview
VALUES(400,'KIM','MIN@NAVER.COM', SYSDATE, 'IT_PROG');
-- �����߻� (READ ONLY�̱� ����


-- �ΰ��� ���̺��� �並 ���� �Ѳ����� ����� ����

CREATE OR REPLACE VIEW DEPT_EMP_VIEW
AS 
SELECT e.employee_id, e.first_name, d.department_id,    
                d.department_name, d.location_id
FROM  employees e, departments d
WHERE e.department_id = d.department_id
WITH READ ONLY;

SELECT
    *
FROM dept_emp_view;  --- ���ϴ� �����Ϳ� ������ ������ �� �ִ�. 

