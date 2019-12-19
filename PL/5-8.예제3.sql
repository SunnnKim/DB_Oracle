예제3) EVEN_ODD(ID:NUMBER(4) GUBUN:VARCHAR2(4)) 테이블을 작성하고 
START숫자와 END 숫자를 입력 받아 
그 사이의 숫자를 ID에 ID의 숫자가 짝수이면 GUBUN에 “짝수”를 
홀수이면 GUBUN에 “홀수”라고 입력하는 SCRIPT를 
WHILE문으로 작성하여라.



DROP TABLE even_odd;

CREATE TABLE even_odd(
  id      NUMBER(4) CONSTRAINT even_odd_id_pk PRIMARY KEY,
  gubun   VARCHAR2(10)
);

SET VERIFY OFF
SET SERVEROUTPUT ON
ACCEPT  p_start PROMPT ' START 숫자를 입력하시오 : '
ACCEPT  p_end   PROMPT '  END  숫자를 입력하시오 : '
DECLARE
	v_start		even_odd.id%TYPE := &p_start;
	v_end		even_odd.id%TYPE := &p_end;
BEGIN
	IF v_start > v_end THEN
		DBMS_OUTPUT.PUT_LINE('START가 END보다 큽니다.');
	ELSE
		-- DELETE FROM even_odd;
		WHILE v_start <= v_end LOOP           
			IF MOD(v_start,2)=0 THEN
				INSERT INTO even_odd(id, gubun)
					VALUES (v_start,'짝수');
			ELSE
				INSERT INTO even_odd
					VALUES (v_start,'홀수');
			END IF;
			v_start := v_start + 1;
		END LOOP;
    
		DBMS_OUTPUT.PUT_LINE(&p_start ||'부터 ' || &p_end || '까지 ' ||
			TO_CHAR(&p_end - &p_start + 1) || 
                         '건의 자료가 입력되었습니다.');
	END IF;
END;
/
SET VERIFY ON
SET SERVEROUTPUT OFF

SELECT * FROM EVEN_ODD;


