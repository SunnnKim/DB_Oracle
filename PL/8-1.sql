DROP TRIGGER triger_test;

CREATE OR REPLACE TRIGGER triger_test
  BEFORE
    UPDATE ON departments
    FOR EACH ROW

BEGIN
  DBMS_OUTPUT.PUT_LINE('���� �� �÷� �� : ' || :old.department_name); -- â�� �߸� �׳� enter�� �Ѿ��
  DBMS_OUTPUT.PUT_LINE('���� �� �÷� �� : ' || :new.department_name);
END;
 /

-- DBMS_OUTPUT.PUT_LINE�� ���
SET SERVEROUTPUT ON ; 

-- UPDATE���� �����Ű��.. 
UPDATE departments SET department_name = '���ߺ�' WHERE department_id = 60;
-- �ڵ������� Ʈ���Ű� ����Ǿ� 60�� �μ����� ���ߺη� ����ȴ�

SELECT * FROM DEPARTMENTS;
ROLLBACK;