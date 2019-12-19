/*
        sequence : ������ ���� �������ִ� Oracle Object
                            ȸ����ȣ, �Խ��� ���� �۹�ȣ 
        - ������ ���� �ϱ� ���� ���
        - �ʱ�ȭ�� �Ұ��� : ���� �� �ٽ� ����ؾ� ��
        �ڹٿ����� �̷��� ����
        int count   = 1;
        count++;
        - ������ �Ǹ� ��� ������ų �� ����

*/
-- sequence ����
CREATE SEQUENCE TEST_SEQ
INCREMENT BY 1           -- 1�� ����
START WITH 10               -- ���� : 10����
MAXVALUE 100               -- �ִ� �󸶱��� ������Ű����(��������)
MINVALUE 1;                    -- �ּ� �󸶺��� ������Ű���� (��������)

-- CURRVAL : ������ ������ ��
SELECT TEST_SEQ.CURRVAL -- ��ó���� ���� (�ƹ����� �ȳ����ֱ� ������), NEXTVAL �ѹ� ����� �ķ� CURRVAL��밡��
FROM DUAL;

-- NEXTVAL : ���� ��
SELECT TEST_SEQ.nextval
FROM DUAL;


-- ���̺� ������ ��ȣ�� �ø��� ���� ���� ���̺� ���� �����ϰų� ���̺��� �������� NEXTVAL�ϴ� ���� �ƴϰ�
-- ���̺� �����ϴ� �������� NEXTVAL�� �����Ѵ�. 


-- SEQUENCE ����
-- ���� �������� ����
ALTER SEQUENCE TEST_SEQ
INCREMENT BY 3; -- �������� �ٲ� �� ����
-- �� �������� NEXTVAL�� �ϸ� 3�� ������



-- �ʱ�ȭ�� �Ұ����� SEQUENCE
-- ����� �ٽ� ����ؾ���
DROP SEQUENCE TEST_SEQ;




-- ���Ǿ� ( SYNONYM / ��ü�� ���� )
/*
    �ڹٿ����� ��ü�� ���Ǿ�?
    int array_number[];
    int arrPosNum [] = array_number;
    �̷� ����
*/

CREATE SYNONYM "�����"
FOR EMPLOYEES;

-- �Ʒ��� �ڵ�� employees ���̺��� �����Ͱ� ��� ��µȴ�.
SELECT  * FROM �����;


-- SYNONYM ���� ���̺� ������ �����ϱ�
INSERT INTO "�����"
VALUES ( EMPLOYEES_SEQ.NEXTVAL, '�浿', 'ȫ', 'HGD@NAVER.COM',  -- SEQUENCE�� ����
                    '123-456-789', TO_DATE('20050101', 'YYYYMMDD'), 'IT_PROG', 20000, NULL, 100, 10);



ROLLBACK;




