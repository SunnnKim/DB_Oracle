����3) EVEN_ODD(ID:NUMBER(4) GUBUN:VARCHAR2(4)) ���̺��� �ۼ��ϰ� 
START���ڿ� END ���ڸ� �Է� �޾� 
�� ������ ���ڸ� ID�� ID�� ���ڰ� ¦���̸� GUBUN�� ��¦������ 
Ȧ���̸� GUBUN�� ��Ȧ������� �Է��ϴ� SCRIPT�� 
WHILE������ �ۼ��Ͽ���.



DROP TABLE even_odd;

CREATE TABLE even_odd(
  id      NUMBER(4) CONSTRAINT even_odd_id_pk PRIMARY KEY,
  gubun   VARCHAR2(10)
);

SET VERIFY OFF
SET SERVEROUTPUT ON
ACCEPT  p_start PROMPT ' START ���ڸ� �Է��Ͻÿ� : '
ACCEPT  p_end   PROMPT '  END  ���ڸ� �Է��Ͻÿ� : '
DECLARE
	v_start		even_odd.id%TYPE := &p_start;
	v_end		even_odd.id%TYPE := &p_end;
BEGIN
	IF v_start > v_end THEN
		DBMS_OUTPUT.PUT_LINE('START�� END���� Ů�ϴ�.');
	ELSE
		-- DELETE FROM even_odd;
		WHILE v_start <= v_end LOOP           
			IF MOD(v_start,2)=0 THEN
				INSERT INTO even_odd(id, gubun)
					VALUES (v_start,'¦��');
			ELSE
				INSERT INTO even_odd
					VALUES (v_start,'Ȧ��');
			END IF;
			v_start := v_start + 1;
		END LOOP;
    
		DBMS_OUTPUT.PUT_LINE(&p_start ||'���� ' || &p_end || '���� ' ||
			TO_CHAR(&p_end - &p_start + 1) || 
                         '���� �ڷᰡ �ԷµǾ����ϴ�.');
	END IF;
END;
/
SET VERIFY ON
SET SERVEROUTPUT OFF

SELECT * FROM EVEN_ODD;


