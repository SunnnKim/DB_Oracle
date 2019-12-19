-- standard function 

-- DUAL : ���� ���̺� -> ��� Ȯ�ο� �ӽ� ���̺�
SELECT 1 FROM DUAL;
SELECT 'A' FROM DUAL;
SELECT '��' FROM DUAL;
SELECT 32*24 FROM DUAL; -- ������ ���� Ȯ�� �����ϴ�

-- �����Լ� 
-- CHR(N) : ASCII ���� ���ڷ� ��ȯ�ϴ� �Լ� 
SELECT CHR(65) FROM DUAL;   -- A�� �ƽ�Ű�ڵ� ��: 65
SELECT CHR(97) FROM DUAL;   -- a�� �ƽ�Ű�ڵ� ��: 97

-- ����
-- ��¹� : �� ������ A�Դϴ�.
SELECT '�� ������ ' || CHR(65) || '�Դϴ�.' FROM DUAL;    
-- || �����ڴ� ���ڿ� �����ִ� ��� (�ڹٿ����� OR ������)
-- �ڹ��ڵ� = "�� ������ " + CHR(65) + "�Դϴ�.";


-- LPAD / RPAD : �������� ��ĭ �Ǵ� Ư�� ���ڷ� ä��� �Լ�
SELECT LPAD('BBB', 10) FROM DUAL;   -- �� ĭ(����)�� ��ĭ���� ä����
SELECT RPAD('BBB', 10) FROM DUAL;  -- �� ĭ(������)�� ��ĭ���� ä����

SELECT LPAD('BBB', 10,'-') FROM DUAL; -- �� ĭ ���ڿ��� Ư�� ���ڿ� ( - )�� �־���
SELECT LPAD('BBB', 10,'7') FROM DUAL;  -- �� ĭ �� ���ڿ��� Ư�� ���ڿ� ( 7 ) �� �־���



-- INSTR ('����', 'ã������') == �ڹ��� IndexOf('����') : �ش� ���ڿ� ���� �ε����� ã����
-- �ڹٴ� �ε��� ��ȣ 0���� ���� ã����
-- DB�� �ε��� ��ȣ ������ 1���� ����
SELECT INSTR('123A456B789C', 'A') FROM DUAL; -- �� : 4

SELECT INSTR('123A456B789B', 'B', 9) FROM DUAL; -- 
-- INSTR('123A456B789B', ����, n) : n��° ��ġ ���ĺ��� �����ϴ� ������ ��ġ
SELECT INSTR('123A456B789B', 'B', 4, 1) FROM DUAL; -- 4��° �ڸ� ���ĺ��� �����ϴ� B�� �� �� 2��°�� �߰ߵǴ� �� :  

SELECT INSTR('123A56B89B', 'B', 4, 2) FROM DUAL; -- 4��° �ڸ� ���ĺ��� �����ϴ� B�� �� �� 2��°�� �߰ߵǴ� �� :  


-- REPLACE : ���ڿ� ġȯ * ���־���

SELECT REPLACE('AAAAABCD', 'A') FROM DUAL;  -- A�� �� ���ڿ��� ġȯ -> BDC
SELECT REPLACE('AAAAABCD', 'A','a') FROM DUAL;  -- A��  a �� ġȯ -> aaaaaBCD
SELECT REPLACE('AAAAABCD', 'AA', 'a') FROM DUAL;  -- AA�� a �� ġȯ -> aaABCD


-- TRANSLATE : ���� ġȯ * ����

SELECT TRANSLATE('AAAAABCD', 'A', 'a') FROM DUAL;  -- A�� a �� ġȯ
SELECT TRANSLATE('AAAAABCD', 'AA', 'a') FROM DUAL;  -- A�� a �� ġȯ, 
-- REPLACE�� �ٸ� ���(���ڿ��� �Է��ϸ� �� ���� 1���ڸ� ġȯ�� �ǰ� �ڿ� ���ڴ� ��������)



-- ���� �Լ�
-- �ø�
SELECT CEIL(13.1) FROM DUAL;    -- 14

-- ����
SELECT FLOOR(13.9) FROM DUAL;   -- 13

-- �ۼ�Ʈ (���� ������)
SELECT MOD(3,2) FROM DUAL; -- 1

-- �¼�
SELECT POWER(3,2) FROM DUAL; -- 3 ^ 2 = 9

-- �ݿø�
SELECT ROUND(13.5) FROM DUAL; -- 14

-- ��ȣ ( + : 1/ 0 : 0 / - : -1 )
SELECT SIGN(13.4) FROM DUAL;    -- 1
SELECT SIGN(0) FROM DUAL;    -- 0
SELECT SIGN(-13.4) FROM DUAL;    -- -1

-- ����
-- ���, ��¥ ��� � ���
SELECT TRUNC(12.3456) FROM DUAL; -- 12
SELECT TRUNC(12.3456,2) FROM DUAL; -- 12.34 ( �Ҽ��� 2�ڸ����� ����)
SELECT TRUNC(12.3456,-1) FROM DUAL; -- 10 ( -1 : ���� �ڸ����� ����)

-- �ƽ�Ű�ڵ� �� ��ȯ�Լ� 
--    <----> CHR(N)�� �ݴ�Ǵ� �Լ�
SELECT ASCII('A') FROM DUAL;    -- 65


-- ��ȯ�Լ� ** ���־���

-- DATE ---> STRING 
-- TO_CHAR
SELECT TO_CHAR(SYSDATE) FROM DUAL; -- 19/12/11 (���� ��¥�� �� ���ڿ�)

SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD-HH-MI-SS') FROM DUAL;  -- 2019-12-11-03-45-21 (�ð����� ��)
-- ��ū �����̱� ������ �츮�� ���ϴ� �������� ������ �� ����
SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD HH:MI:SS') FROM DUAL;  -- 2019-12-11 03:46:31

SELECT TO_CHAR (100000000, '$999,999,999,999') FROM DUAL;  -- ���� ������ �߶���



-- T0_DATE :
-- STRING ----> DATE
SELECT TO_DATE('20191225') FROM DUAL;   -- 19/12/25 (�ڷ��� ��¥��)

SELECT TO_DATE('12252019', 'MMDDYYYY') FROM DUAL;   -- ���� �ڵ�� ��� ����


-- TO_NUMBER
-- �ڹٿ��� parseInt �� ������ ���
SELECT TO_NUMBER('112') + 24  FROM DUAL; -- 136 

-- LAST_DAY
-- �ش� ���� ������ ���� ����
SELECT LAST_DAY(SYSDATE) FROM DUAL; -- �̹� ���� ������ ��

SELECT LAST_DAY('19/11/20') FROM DUAL; -- 11���� ������ ��

SELECT LAST_DAY(TO_DATE('11/20/2019','MM/DD/YYYY')) FROM DUAL; -- 11���� ������ ��
-- ���� �ڵ�� LAST_DAY�� TO_DATE �Լ��� ���� ����� ��


-- SUBSTR
-- �ڹ���substring : substring(1,3) "ABCDE" -> "BC"
SELECT SUBSTR('ABCDE' , 3) FROM DUAL;   -- 3�������� �� ������ : CDE (DB�� 1�������� ����)
SELECT SUBSTR('ABCDE' , 3,2) FROM DUAL; -- 3�������� 2���� ���ڸ� ������ : CD


-- LENGTHB  --> ������ ���̸� ����Ʈ �������� ������
-- LENGTH --> ������ ���̸� ������
SELECT LENGTH('�����ٶ�') FROM DUAL;   -- 5
SELECT LENGTHB('�����ٶ�') FROM DUAL; -- 15


-- PPT�� �Ⱥ��� ������ �Լ� : CONVERT.... ��
-- ����غ���

-- MONTHS_BETWEEN : �� ��¥ ������ ���� �� ���ϱ� 
-- �Ҽ����� �ֱ� ������ ���� �Ǵ� �ø��� ������Ѵ�.
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, '19/11/01')) FROM DUAL;





-- ���Ἲ CONSTRAINT / CHECK / NOT NULL / PRIMARY KEY ...





