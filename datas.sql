-- SELECT * FROM employees;
select * from employees;
SELECT * FROM EMPLOYEES;

-- sql ���� �ּ����� // �� �ƴϰ� --

/*
���� �ּ��� 
*/



-- �ڷ���
--  java                            orcle
--   int                        Integer, NUMBER
-- String                     VARCHAR2, CHAR
-- double                   NUMBER( ������ �ڸ��� , �Ҽ��� �ڸ��� )
-- Date                       DATE


-- ���ڿ� 
-- CHAR
create table TB_CHAR(
    COL_CHAR1 CHAR(10 BYTE) ,     -- String COL_CHAR1(ũ��);
    COL_CHAR2 CHAR( 10 CHAR),    -- char : ���ڿ�
    COL_CHAR3 CHAR(10)
);

/*
create TABLE ���̺��(
        �÷��� �ڷ���(ũ��)
        �÷��� �ڷ���(ũ��)
        �÷��� �ڷ���(ũ��)
        ..
);
*/
-- ���̺� ������ �߰��ϱ�
INSERT into TB_CHAR( COL_CHAR1,COL_CHAR2,COL_CHAR3)
values ('ABC', 'ABC','ABC');             -- ������ 1���� �� ũ�� : 1 BYTE

SELECT * FROM tb_char ;

INSERT into TB_CHAR( COL_CHAR1,COL_CHAR2,COL_CHAR3)
values ('��', '��','��');                      -- �ѱ��� 1���� �� ũ�� : 3 BYTE

INSERT into TB_CHAR( COL_CHAR1,COL_CHAR2,COL_CHAR3)
values ('����', '����','����');

INSERT into TB_CHAR( COL_CHAR1,COL_CHAR2,COL_CHAR3)
values ('������A', '������','������');


-- lengthb : byteũ�⸦ �˷��ִ� ��ɾ�
SELECT col_char1, col_char2, col_char3,
        LENGTHB(col_char1),  LENGTHB(col_char2),  LENGTHB(col_char3) 
FROM tb_char ;


/*

���̰�(�뷮)
CHAR : 10 BYTE 00000 00000
ABC -> ABC00 00000          --> ����Ǵ� ��������


10 CHAT 
��(3 BYTE) + 9  BYTE = 12
���� (6 BYTE) + 8 BYTE = 8 + 6 = 14;
������(9BYTE) 7 + 9 = 16

*/


-- ���ڿ� ������ ������ ' '(���� ����ǥ)�� �����ϴ�

-- VERCHAR 2 
-- verchar2�� ����� �������� ũ�� �뷮�� �����ص� ����� ��ŭ�� �����Ѵ�
create Table  TB_VARCHAR(
        COL1 VARCHAR2 (10 BYTE ),
        COL2 VARCHAR2(10 char),
        COL3 VARCHAR2 (10)
);


Insert INTO TB_VARCHAR(COL1, COL2, COL3)
VALUES ('ABC', 'ABC','ABC');

Insert INTO TB_VARCHAR(COL1, COL2, COL3)
VALUES ('����', '����','����');


SELECT COL1, COL2, COL3,
    LENGTHB(COL1), LENGTHB(COL2), LENGTHB(COL3)
From  tb_varchar;



-- LONG : �ִ� 2 GB���� ���� ������ ����
-- TABLE �� 1���� ��밡��
CREATE TABLE TB_LONG(
    COL_LONG1 LONG
--    COL_LONG2 LONG
);
-- ���� �ڵ��� �ּ��� �����ϸ� ������ ����. 
-- ��Ÿ���� �ϳ��� �÷��� ����� �����ϱ� ����

INSERT INTO TB_LONG(COL_LONG1)
VALUES ('ABC');
SELECT COL_LONG1 FROM tb_long;
-- LONG�� LENGTHB ����� �Ұ����ϴ�
-- �Ʒ��� �ڵ�� ������ �ȵ�.
SELECT COL_LONG1,LENGTHB(COL_LONG1) 
FROM TB_LONG;



-- ���� �ڷ��� ( ������ , �����Ǽ��� )

-- ���� (������ ����) : INTEGER, ����Ʈ �� ���� �� ����
CREATE TABLE TB_INTEGER(
    COL1 INTEGER,
    COL2 INTEGER
);

INSERT INTO TB_INTEGER(COL1, COL2)
VALUES (123,456);

SELECT *  FROM TB_INTEGER;



-- ����(����, �Ǽ� ��ΰ���) : NUMBER
CREATE TABLE TB_NUMBER(
    COL_NUMBER1 NUMBER,          -- ����, �Ҽ��� ���
    COL_NUMBER2 NUMBER(5),      -- ����(5�ڸ�����, ������ ���� �� ����)
    COL_NUMBER3 NUMBER(5,2),    -- ���� 5�ڸ�, �Ҽ��� 2�ڸ�
    COL_NUMBER4 NUMBER(*,2)     -- ����(������), �Ҽ� 2�ڸ�
);
INSERT INTO TB_NUMBER(COL_NUMBER1,COL_NUMBER2,COL_NUMBER3,COL_NUMBER4)
VALUES (1234.5678, 12345, 123.456, 12345.56);

SELECT *  FROM TB_NUMBER;




-- ��¥ �ڷ��� DATE
-- ����, ��, ��, (��, ��, ��)
CREATE TABLE TB_DATE(
    COL_DATE1 DATE,
    COL_DATE2 DATE
);

INSERT INTO TB_DATE(COL_DATE1, COL_DATE2)
VALUES (SYSDATE, SYSDATE-1);
-- SYSDATE : ���� ��¥�� �ð��� ����
-- �����ڸ� ����� �� �ִ�. (���� �ڵ�� ���� ��¥ -1�� (����) ��¥�� ����)


INSERT INTO TB_DATE(COL_DATE1, COL_DATE2)
VALUES (SYSDATE,  TO_DATE('2019-12-25 11:55:55', 'YYYY-MM-DD HH:MI:SS'));   -- �� ������ MI, ���� MM
-- TO_DATE() : ���ڿ��� ��¥�������� �ٲٴ� �Լ� 
-- ���� �ڵ�� �ð��� ���̺� ǥ�õ��� ������ �ð��� ��� �� ����


INSERT INTO TB_DATE(COL_DATE1, COL_DATE2)
VALUES ('19/12/15', '19/12/16');    -- �ð��� ���������� ������ ���� �ð����� �Էµȴ�.


INSERT INTO TB_DATE(COL_DATE1, COL_DATE2)
VALUES (SYSDATE, TO_DATE('20191225112233', 'YYYYMMDDHHMISS'));    -- 
-- TO_DATE() �Լ��� �Է� ���ڿ������� ������� �Ҽ� �ִ�( ��� �ڿ� �Ķ���Ϳ� ������ ������ �����ش�)

SELECT *  FROM TB_DATE;



-- VERCHAR2 ( ���ڿ� ) --> DATE (���ڿ�, ��¥����) �� �ٲ� �� ���� �Լ� : TO_DATE

-- DATE (��¥����) --> VERCHAR2 (���ڿ�)�� �ٲ� �� ���� �Լ� : TO_CHAR


-- ���̺� �����
DROP TABLE TB_CHAR;
DROP TABLE TB_VARCHAR;
DROP TABLE TB_LONG;
DROP TABLE TB_NUMBER;
DROP TABLE TB_INTEGER;
DROP TABLE TB_DATE;


