예제2) LOOP문과 FOR문으로 아래와 같이 출력하는 각각의 SCRIPT를 작성하여라.

*
**
***
****
*****
******
*******
********
*********
**********



SET SERVEROUTPUT ON
DECLARE
	v_cnt	NUMBER := 1;
	v_str	VARCHAR2(10) := NULL;
BEGIN
	LOOP
		v_str := v_str || '*';
		DBMS_OUTPUT.PUT_LINE(v_str);
    v_cnt := v_cnt + 1;
    
		IF v_cnt > 10 THEN
			EXIT;
		END IF;    
	END LOOP;
END;
/
SET SERVEROUTPUT OFF
