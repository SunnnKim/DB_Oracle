
-- ���� 1��) ���̺�� address,
--id, name, addr, phone, email (BYTE ũ��� ����)
--���̺� �����ϱ�.
CREATE TABLE address(
        id NUMBER (10) ,
        name VARCHAR2(10) ,
        addr VARCHAR2(30) ,
        phone VARCHAR2(20) ,
        email VARCHAR2(20)
);



--����2��) �ּҷ� ���̺��� ������ �����͸� �����Ͽ� addr_second ���̺��� ����.(������ �����͸� �����ؼ� ������.)

CREATE TABLE addr_second
AS
SELECT *
FROM address;




--���� 3��) �ּҷ� ���̺��� id, name Į���� �����Ͽ� 
--addr_forth ���̺��� ���� (������ ����)

CREATE TABLE addr_forth
AS
SELECT id, name
FROM address;



--����4��) Address ���̺� 5���� �����͸� �߰��ϼ��� 
INSERT INTO address( id, name, addr, phone, email)
VALUES (1, 'AAA', 'add the address1', '010-1234-5678','email1@mail.net');
INSERT INTO address( id, name, addr, phone, email)
VALUES (2, 'BBB', 'add the address2', '010-1234-5678','email2@mail.net');
INSERT INTO address( id, name, addr, phone, email)
VALUES (3, 'CCC', 'add the address3', '010-1234-5678','email3@mail.net');
INSERT INTO address( id, name, addr, phone, email)
VALUES (4, 'DDD', 'add the address4', '010-1234-5678','email4@mail.net');
INSERT INTO address( id, name, addr, phone, email)
VALUES (5, 'EEE', 'add the address5', '010-1234-5678','email5@mail.net');

--���� 5��)Address ���̺��� id, name �� ���� Address2 ���̺��� �����
--�ڷḦ ���� ������ ����
CREATE TABLE ADDRESS2
AS
SELECT id, name
FROM address;



--���� 6��) �ּҷ� ���̺� ��¥ Ÿ���� ������ birth Į���� �߰�

ALTER TABLE address
ADD
birth DATE;



--���� 7��) �ּҷ� ���̺� ���� Ÿ���� ������ comments Į���� �߰�
--�⺻���� 'No Comment'�� �����Ͽ���.

ALTER TABLE address
ADD
comments VARCHAR(30) DEFAULT 'No Comment';


--���� 8��)�ּҷ� ���̺��� comments Į���� ����

ALTER TABLE address
DROP COLUMN comments;



--���� 9��) �ּҷ� ���̺���
--phone Į���� ������ Ÿ���� ũ�⸦ 50���� ����

ALTER TABLE address

MODIFY
phone VARCHAR(50);






