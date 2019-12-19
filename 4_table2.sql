-- ���Ἲ : �÷��� �����ϴ� ����

-- * Primary Key (PK) 
-- �⺻Ű
-- NULL�� ������� ����
-- �ߺ����� �ʴ� ��
-- ID�� �ش�Ǵ� Ű

-- * Unique Key (UK) 
-- ����Ű : �� �� �ۿ� ���� Ű
-- �ߺ����� �ʴ� ��
-- NULL �����
-- email (������ �̸��� UK�� ���� �������� ����)

-- * Check 
-- ������ ������ ����
-- ������ ������ ���� ���� �� �ְ� �� �̿��� ���� ���� �� ����
-- NULL �����

-- * Foreign Key (FK)
-- �ܷ�Ű : �ٸ� ���̺��� PK�� UK �̾�� �Ѵ�.
-- ���� : ���̺�� ���̺��� �����ϱ� ���� (Join)
--NULL �����

-- * NOT NULL
-- NULL�� ������� ����
-- ����Ű+ NOT NULL = �⺻Ű


-- 1. NOT NULL
CREATE TABLE TB_TEST(
        COL_01 VARCHAR2(10) NOT NULL,
        COL_02 VARCHAR2(20) 
);
-- �Ϲ����� �� ����
INSERT INTO TB_TEST( COL_01, COL_02)
VALUES ( 'AAA', 'aaa');

-- null �� ����
INSERT INTO TB_TEST( COL_01, COL_02)
VALUES ( 'AAA', ''); -- 2��° Į���� NULL�� ����ϹǷ� NULL ���� �� ����

-- null �� ����
INSERT INTO TB_TEST( COL_01, COL_02)
VALUES ( '', 'aaa'); -- 1��° Į���� NULL�� ������� �����Ƿ� ������ �߻�
--���� �ڵ�� ���Ἲ ���� �߻�


-- 2. Primary Key : NOT NULL + Unique Key
-- �����ϰ� �ĺ��� �� �ִ� ���ǵ� ��Ģ
-- �� ���̺��� �ִ� 32�� �÷����� ������ �� �ִ�.
-- CONSTRAINT : ���Ἲ (PK)�� ���� id�� ����
CREATE TABLE TEST_01(
        KEY_01 VARCHAR2(10) CONSTRAINT PK_TEST_01 PRIMARY KEY ,
        KEY_02 VARCHAR2(10), 
        COL_03 VARCHAR2(20) 
        -- PK �̸� �����ϸ� ���߿� �ʿ信 ���� PK�� ���� �� ����
        -- �̸� ���� ���ص� �����̸Ӹ� Ű ���� �� ������ �̸��� ������ ������ �ȵ�
);

-- ������ �߰��ϱ�
INSERT INTO TEST_01( KEY_01, KEY_02,COL_03)
VALUES ('AAA','aaa','111');
-- ���� �������� 2�� �̻� �����ϸ� �����߻� : PK�� �ߺ��� ��� X

INSERT INTO TEST_01( KEY_01, KEY_02,COL_03)
VALUES ('BBB','bbb','222');

INSERT INTO TEST_01( KEY_01, KEY_02,COL_03)
VALUES ('','bbb','222');
-- ���� Ŀ������ PK�� NULL���� ������� �ʾ� ������ �߻��Ѵ�.


-- ** DROP���� �÷��� ������ PK�� �������� �� �ֱ� ������
-- CASCADE CONSTRAINTS �� �Է��Ͽ� ���Ἲ���� ��� �������Ѵ�
DROP TABLE TEST_01
CASCADE CONSTRAINTS;


-- �������� �����̸Ӹ� Ű

CREATE TABLE TEST_01(
        KEY_01 VARCHAR2(10) CONSTRAINT PK_TEST_01 PRIMARY KEY ,
        KEY_02 VARCHAR2(10)  CONSTRAINT PK_TEST_02 PRIMARY KEY ,
        COL_03 VARCHAR2(20) 
); -- �� �������� �ߺ� PK�� ��������� ���� (������ ���� ������)


-- �Ʒ��� �������� �������� �⺻Ű�� ���� �� �ִ�
CREATE TABLE TEST_01(
        KEY_01 VARCHAR2(10) ,
        KEY_02 VARCHAR2(10) ,
        COL_03 VARCHAR2(20) ,
        CONSTRAINT PK_TEST_01 PRIMARY KEY (KEY_01, KEY_02)
); 


INSERT INTO TEST_01( KEY_01, KEY_02,COL_03)
VALUES ('AAA','aaa','111');

-- �Ʒ��� ������( NOT NULL)
INSERT INTO TEST_01( KEY_01, KEY_02,COL_03)
VALUES ('','aaa','111');
-- �Ʒ��� ������( NOT NULL)
INSERT INTO TEST_01( KEY_01, KEY_02,COL_03)
VALUES ('AAA','','111');


-- Ű�� 2���� ��, �� ��Ʈ�� ��
-- (�ϳ��� Ű�� ���� �̹� �����־ �ٸ� Ű ���� �ߺ����� ������ �� �����ʹ� �Էµȴ�.
INSERT INTO TEST_01( KEY_01, KEY_02,COL_03)
VALUES ('AAA','AAA','111');


-- ALTER �� �����̸Ӹ� Ű �����ϱ�
-- �켱 �����̸Ӹ� Ű�� ���� ���̺� ����
CREATE TABLE TEST_01(
        KEY_01 VARCHAR2(10) ,
        KEY_02 VARCHAR2(10) ,
        COL_03 VARCHAR2(20) 
); 
-- ALTER - ADD �� �⺻Ű �߰�
ALTER TABLE TEST_01
ADD CONSTRAINT PK_TEST_01
PRIMARY KEY( KEY_01, KEY_02);

-- ALTER - DROP ���� �⺻Ű ����
ALTER TABLE TEST_01
DROP CONSTRAINT PK_TEST_01;

DROP TABLE TEST_01
CASCADE CONSTRAINTS;

-- 3. Unique Key: ����Ű = Email�� ���� ������
-- ������ ��(�ߺ�X), NULL�� ���
CREATE TABLE TEST_01(
        UKEY_01 VARCHAR2(10) CONSTRAINT UK_TEST_01 UNIQUE,
        COL_01 VARCHAR2(10) ,
        COL_02 VARCHAR2(10)
);
INSERT INTO TEST_01 (UKEY_01, COL_01, COL_02)
VALUES ( 'AAA', 'aaa', '111');
-- �����ڵ�� 2���̻� �����Ҽ� ���� (�ߺ���� X)

INSERT INTO TEST_01 (UKEY_01, COL_01, COL_02)
VALUES ( '', 'aaa', '111');
-- ���� �ڵ�� ������ �ȴ�
-- Unique Key�� NULL�� ����ϱ� ����

-- �⺻ ���̺� ����ũ Ű �߰��ϱ�
-- ADD

-- �켱 �ִ°� ����
ALTER TABLE TEST_01
DROP CONSTRAINT UK_TEST_01;
-- ���� ����
ALTER TABLE TEST_01
ADD CONSTRAINT UK_TEST_01
UNIQUE ( UKEY_01);
-- ���������� ����, �������� ����ũ Ű ������ �⺻Ű�� ���� ������� ���� �� �ִ�.

DROP TABLE TEST_01
CASCADE CONSTRAINTS;


-- 4. CHECK
-- �������� ���� ����, Ư���� ���� ������ ����
-- NULL ���

CREATE TABLE TEST_01(
        KEY_01 VARCHAR2(10) ,
        COL_01 VARCHAR2(10),
        CONSTRAINT CHK_TEST_01 CHECK (KEY_01 IN ('���', '��', '�ٳ���')), -- �� ������ ����
        CONSTRAINT CHK_TEST_02 CHECK (COL_01 > 0 AND COL_01 <= 100) -- ������ ����
);

INSERT INTO TEST_01( KEY_01, COL_01)
VALUES ( '���', 5); -- ���� ���� ���� ���� : ���� X, �ߺ� ���

INSERT INTO TEST_01( KEY_01, COL_01)
VALUES ( '���', 0 );  -- CHECK�� �����ȿ� ���� ���� ���� �߻�

INSERT INTO TEST_01( KEY_01, COL_01)
VALUES ( '��',10 );  -- CHECK�� ���� ����Ʈ�� ���� ���� ���� �߻�

INSERT INTO TEST_01( KEY_01, COL_01)
VALUES ( '','' );  -- NULL���� ������ ���� (NULL���)
-- ������ �� �̿��� ���� ������ ������ ���� NULL���̴�

DROP TABLE TEST_01
CASCADE CONSTRAINTS;


-- 5. Foreign Key 
-- ���̺�� ���̺��� �����ϱ� ���� ���Ἲ ���� ����
-- �ٸ� ���̺� (�ڽ� ���̺�)�� ���� �⺻Ű �Ǵ� ����Ű�� ����ؾ��Ѵ�
-- �ߺ� ��� X
-- NULL �� ���

-- < ���� >
-- �⺻Ű�� �ִ� ���̺� ���� ���� : ��) hr ������ departments
CREATE TABLE TEST_PAR(
            PKEY_01 VARCHAR2(10) , -- �⺻Ű 1
            PKEY_02 VARCHAR2(10) , -- �⺻Ű 2
            COL_01 VARCHAR2 (20) ,
            COL_02 VARCHAR2(20) ,
            CONSTRAINT PK_TEST_01 PRIMARY KEY(PKEY_01, PKEY_02)
);

-- �ܷ�Ű�� �ִ� ���̺� ���� : ��) hr ������ employees
CREATE TABLE TEST_CHD(
        COL_1 VARCHAR2 (10) ,
        FKEY_01 VARCHAR2(10) , -- �ܷ�Ű�� �����ϴ� ���� �Ȱ��� ũ��� ������������ ��������
        FKEY_02 VARCHAR2(10) ,
        CONSTRAINT FK_TEST_01 FOREIGN KEY (FKEY_01, FKEY_02)
            REFERENCES TEST_PAR(PKEY_01, PKEY_02) -- ��� ���̺��� ��� �÷��� ������ ���� �ۼ�
); 

-- ������ ����ֱ�
-- PAR
INSERT INTO TEST_PAR ( PKEY_01, PKEY_02, COL_01, COL_02) 
VALUES ( 'AAA', 'aaa', '111', '***');
INSERT INTO TEST_PAR ( PKEY_01, PKEY_02, COL_01, COL_02) 
VALUES ( 'BBB', 'bbb', '222', '*!*');
--CHD
INSERT INTO TEST_CHD ( COL_1, FKEY_01, FKEY_02) 
VALUES ( 'ABC', 'AAA', 'aaa'); -- �ܷ�Ű�� ����� ���� ������ ���̺� ���� �־�� ������� �� ����

--������
INSERT INTO TEST_CHD ( COL_1, FKEY_01, FKEY_02) 
VALUES ( 'ABC', 'aaa', 'aaa'); -- ������ ���̺� ���� �ܷ�Ű���̸� ������ ����

-- NULL���
INSERT INTO TEST_CHD ( COL_1, FKEY_01, FKEY_02) 
VALUES ( 'CDE', '', ''); -- NULL�� �����


-- DDL :
-- �ٷ� ���̺� �����ؼ� �����ϱ�
CREATE TABLE EMP 
AS
SELECT
    *
FROM employees; -- ���̺��� �����ϸ� ��� ���������� �� ���� ( CHECK����)

-- UPDATE

UPDATE emp
SET salary = 12000, department_id = NULL -- �ٲ� �÷��� ��
WHERE employee_id = 100 ;-- �ٲ� ����

SELECT  first_name, salary FROM emp WHERE employee_id =100;

ROLLBACK; -- Ŀ������ �����͸� �������� �� ����
COMMIT; -- Ŀ���ϸ� �ѹ��ص� �ҿ����

-- DELETE

DELETE 
FROM EMP
WHERE salary > 15000;
-- ��ȸ
SELECT  first_name, salary FROM emp;



