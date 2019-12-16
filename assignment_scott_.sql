-- SCOTT
--23) emp���̺��� ����(job)�� ù���ڴ� �빮�� �������� �ҹ��ڷ� ����Ͻÿ�.

select concat( substr(job,1,1), LOWER(substr(job, 2)))
from emp;

-- INITCAP : �� ���� ö�ڸ� �빮�ڷ� ����� �������� �ҹ���
SELECT INITCAP(Job)
FROM emp;



--24) emp���̺��� ����̸� �� A�� ���Ե� ����̸��� ���ϰ� 
-- �� �̸� �� �տ��� 3�ڸ� �����Ͽ� ���

SELECT ename, SUBSTR(ename,1,3) 
FROM emp
WHERE ename LIKE '%A%';



--25) �̸��� ����° ���ڰ� A�� ��� ����� �̸��� ǥ���Ͻÿ�.
SELECT ename
FROM emp
WHERE ename LIKE '__A%';



--26) �̸��� J,A �Ǵ� M���� �����ϴ� ��� ����� �̸�
-- (ù ���ڴ� �빮�ڷ�, ������ ���ڴ� �ҹ��ڷ� ǥ��) 
-- �� �̸��� ���̸� ǥ���Ͻÿ�.(�� ���̺��� name�� length�� ǥ��)   
SELECT ename, INITCAP(ename) as cap, length(ename)
FROM emp
WHERE ename LIKE 'J%' OR
      ename LIKE 'A%' OR
      ename LIKE 'M%' ;
        



--27) �̸��� ���ڼ��� 6�� �̻��� ����� �̸��� �ҹ��ڷ� �̸��� ����Ͻÿ�
SELECT LOWER(ename)
FROM emp
WHERE length(ename)=6;



--28) �̸��� ���ڼ��� 6�� �̻��� ����� �̸��� �տ��� 3�ڸ� ���Ͽ� �ҹ��ڷ� ����Ͻÿ�.
SELECT LOWER(SUBSTR(ename,1,3))
FROM emp
WHERE length(ename) >=6;


--29) ��� ����� �̸��� �޿��� ǥ���Ͻÿ�. �޿��� 15�� ���̷� ���ʿ� $��ȣ�� ä���� ��������
--    ǥ���ϰ� �����̺��� SALARY�� �����Ͻÿ�.

-- LPAD :���� ����(�Ǵ� Ư������) �ֱ�
SELECT ename, LPAD(sal,15,'$')as SALARY
FROM emp;

