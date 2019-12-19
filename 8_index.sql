-- INDEX
/*
        INDEX = ����
        - ���ϴ� ������ ��ġ�� ������ ��Ȯ�ϰ� �˾Ƴ� �� �ִ� ���
        -- �ڵ����� : Primary Key, Unique �� �ڵ������� ������
        -- �������� : Query������ �����ϱ�
        
        ������ ���� �� ȿ������ ��� : 
        1. WHERE���̳� JOIN ���Ǿȿ� ���� ���Ǵ� column 
        ��) department_id
        
        2. NULL ���� ���� ���ԵǾ� �ִ� column
        ��) manager_id
        3. WHERE���̳� JOIN ���� �ȿ� 2�� �̻� ����ϴ� column
        
        ������ ���� �� ��ȿ������ ��� :
        1. ���̺��� ũ��(row�� ������ ���� ��) �� ���� �� (3000�� ����)
        2. ���̺��� ���� ���ŵ� ��
*/

-- ���������� ���� EMPLOYEES ���̺� ī���ϱ�
CREATE TABLE EMP_COPY
AS
SELECT * FROM employees;


-- �ڵ����� (�����̸Ӹ� Ű �߰��ϸ� �ε����� �ڵ����� �����ȴ�)
ALTER TABLE EMP_COPY
ADD
CONSTRAINT PK_EMPCOPY_01 PRIMARY KEY(employee_id);

-- INDEX Ȯ���ϱ�
-- WHERE�� ������ �����ϸ� Ư�� �ε����� ��ȸ�� �� ����
SELECT  * FROM ALL_INDEXES
WHERE index_name = 'PK_EMPCOPY_01';


-- �ε��� ���� ����
-- CREATE INDEX  ON
CREATE INDEX EMP_INDEX01
ON EMP_COPY ( MANAGER_ID); 

-- ����������� Ȯ���ϱ�
SELECT  * FROM ALL_INDEXES
WHERE index_name IN('EMP_INDEX01');


-- �����
DROP INDEX EMP_INDEX01;