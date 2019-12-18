-- ���̺� �����ϱ�
-- �ݵ�� �ý��� ��������
CREATE TABLESPACE TABLESPACE2
DATAFILE 'D:\oracle\tabletest\TEST_TBS1.DBF' SIZE 10M
AUTOEXTEND ON NEXT 1M MAXSIZE UNLIMITED  -- �߰��Ǵ� �뷮
LOGGING  -- �α� : ��Ͽ��� ���� (ȭ�����/ ��������α�)
EXTENT MANAGEMENT LOCAL AUTOALLOCATE -- LOCAL
BLOCKSIZE 8K -- ����� ũ��, ��� ũ�� ũ�� �������� ��뷮 ������ ���� �� ����
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

-- table space name ���̺� �̸� ���� ������ 
ALTER TABLESPACE TABLESPACE2
RENAME TO TEST_TBS_NEW;

-- ���� �뷮 ���� ������
ALTER DATABASE 
DATAFILE 'D:\oracle\tabletest\TEST_TBS1.DBF' RESIZE 20M;


-- TABLESPACE �����ϱ�
DROP TABLESPACE "TABLESPACE1"
INCLUDING CONTENTS AND DATAFILES
CASCADE CONSTRAINTS; -- ���Ἲ



-- ���̺� ����
-- �����Ϳ��� ����⺻���� ������ ���� ����
-- ���ο� (�÷�) �� ������(�ο�)���� ǥ��

-- TABLE ����
CREATE TABLE TB_TEST01(
    COL_01 VARCHAR2(10),
    COL_02 VARCHAR2(10),
    COL_03 VARCHAR2(10),
    COL_04 VARCHAR2(10)
);
-- TABLESPACE �� �������� ������ defalut ���� USERS��


CREATE TABLE TB_TEST02(
    COL_01 VARCHAR2(10),
    COL_02 VARCHAR2(10),
    COL_03 VARCHAR2(10),
    COL_04 VARCHAR2(10)
)
TABLESPACE TABLESPACE2 -- ���� ����� ���̺��� ������ ���� ������ ���߾� �ϰڴ�
;

-- TABEL COPY : ������ �����ؼ� ��� �����ϱ� (���������Ϳ� �������)
CREATE TABLE TB_TEST03
AS 
SELECT *
FROM jobs; 

SELECT   * FROM tb_test03;


-- ���̺� �����
DROP TABLE tb_test03;

-- ���̺� ����
CREATE TABLE TB_TEST03
AS 
SELECT JOB_ID as ������ȣ, JOB_TITLE as ������ -- alias�� ����
FROM jobs; 


DROP TABLE tb_test03;

-- �ٸ� ���̺��� �����͸� ���� + �׷��Լ��� �����Ͽ� ���ο� ���̺��� ���� �� �ִ� (���� �����Ͷ� ������ �ջ����)

CREATE TABLE TB_GROUP_DEPT
    AS -- �����Ѵٴ� �ǹ�, �Ʒ��� ���ο� ���̺� ���� �����͸� ��ȸ�ϴ� ������ 
SELECT department_id AS "�μ���ȣ", SUM(salary) AS "�հ�", AVG(salary) AS "���"
FROM employees
GROUP BY department_id;


-- TABLE COPY : �����Ͱ� ������ �� ���̺� �����ϱ� (���¸� ����)
CREATE TABLE TB_TEST04
AS
SELECT
    *
FROM departments
WHERE 1=2;                   -- WHERE ���� ������ �� ���� ������ ������ �����Ͱ� �����Ե� Ʋ�� �����ȴ�
-- ���� �ڵ带 �����ϸ� ���̺� ���� �� Į���� ���ĸ� ������
SELECT
    *
FROM tb_test04;

-- **<����> ���̺�� ������ ó�� ��ɾ�
-- TABLE : CREATE(���̺� ����), ALTER(���̺� ����/����), DROP(���̺� ����)
-- DATA : INSERT(������ ����), UPDATE(������ ����), DELETE(������ ����), SELECT(��������ȸ)


-- TABLE ����1 : ���̺�� ����
-- ALTER
ALTER TABLE TB_TEST04
RENAME TO TB_TEST99;        -- ���̺�� ����
SELECT * FROM tb_test99;

-- TABLE ����2 : ���� �÷� �߰�
-- ADD
-- �����Ͱ� ���� ���� �ٽ� ����� ������, �̹� ���Ե� �����Ͱ� �ʹ� ������ Į���� �߰��Ѵ�
ALTER TABLE TB_TEST99
ADD
LOCATION_NAME VARCHAR2(30); --�߰��� �÷��� �� �÷� �������� ����


-- TABLE ����3 : ���� �÷� �߰�
-- ADD
-- ��ȣ �ȿ� �߰��� �÷� �� ���������� ���ش�
ALTER TABLE TB_TEST99
ADD
( COL_01 VARCHAR2(30) , COL_02 NUMBER(5,2) );


-- TABLE ����4 : ���� �÷� ����
-- MODIFY 
ALTER TABLE TB_TEST99
MODIFY 
COL_01 VARCHAR2(20);    -- �뷮 ������ ������


-- TABLE ����5 : ���� �÷� ����
-- MODIFY 
ALTER TABLE TB_TEST99
MODIFY 
(COL_01 VARCHAR2(20), COL_02 NUMBER(4) );

-- TABLE ���� : ���� �÷� ����
-- DROP
ALTER TABLE TB_TEST99
DROP COLUMN LOCATION_NAME;

-- TABLE ���� : ���� �÷� ����
ALTER TABLE TB_TEST99
DROP 
(COL_01, COL_02);


--TABLE ���� : �÷��� ����
-- RENAME
ALTER TABLE TB_TEST99
RENAME 
COLUMN DEPARTMENT_ID TO "�μ���ȣ";


-- TABLE ���� :
-- DROP
DROP TABLE TB_TEST01;
-- CASCADE CONSTRAINTS : ���Ἲ ������ ��� �� ������
DROP TABLE TB_TEST02
CASCADE CONSTRAINTS;


-- ������ ���̺� �����뿡�� �����ϱ�
FLASHBACK TABLE TB_TEST02
TO BEFORE DROP;

-- ������ ����
-- PURGE : ���̺� ������ �ȵǱ� ������ �����ϰ� �����
PURGE RECYCLEBIN;

