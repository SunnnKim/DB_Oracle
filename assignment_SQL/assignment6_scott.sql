
-- Ư������ ����

--33) �� ����� �̸��� ǥ���ϰ� �ٹ� �� ��(�Ի��Ϸκ��� ��������� �޼�)�� ����Ͽ�
--�� ���̺��� MONTHS_WORKED�� �����Ͻÿ�. ����� ������ �ݿø��Ͽ� ǥ���ϰ� 
--�ٹ��� ���� �������� ������������ �����Ͻÿ�.(MONTHS_BETWEEN �Լ� ����)

SELECT ename, ROUND ( MONTHS_BETWEEN (sysdate, hiredate)) MONTHS_WORKED
FROM emp 
ORDER BY MONTHS_WORKED ASC;



--34)emp���̺��� �̸�, ����, �ٹ������� ����Ͻÿ�.

SELECT  ename, job,
                 ROUND(MONTHS_BETWEEN(sysdate, hiredate) / 12)  AS �ٹ�����
FROM emp;


--35)emp���̺��� ����̸�, ����, ���ް� Ŀ�̼��� ���� ���� �÷��� �Ǳ޿���� �ؼ� ���.
--��, NULL���� ��Ÿ���� �ʰ� �ۼ��Ͻÿ�.

SELECT ename, sal, sal+ NVL(comm , 0 ) "�Ǳ޿�"
FROM emp;


--36)���ް� Ŀ�̼��� ��ģ �ݾ��� 2,000�̻��� �޿��� �޴� ����� �̸�,����,����,Ŀ�̼�,��볯¥�� 
-- ����Ͻÿ�. ��, ��볯¥�� 1980-12-17 ���·� ����Ͻÿ�.

SELECT ename, job, sal, comm, TO_CHAR(hiredate,'YYYY-MM-DD')
FROM emp
WHERE sal + NVL(comm,0) >= 2000;



--37)DECODE �Ǵ� CASE WHEN THEN �Լ��� ����Ͽ� ���� �����Ϳ� ���� JOB���� ���� ��������
--��� ����� ����� ǥ���Ͻÿ�.
--     ����               ���
--PRESIDENT       A
--ANALYST            B
--MANAGER          C
--SALESMAN        D
--CLERK               E
--��Ÿ                     0

SELECT job ����, 
                CASE job 
                            WHEN 'PRESIDENT' THEN 'A'
                            WHEN 'ANALYST' THEN 'B'
                            WHEN 'MANAGER' THEN 'C'
                            WHEN 'SALESMAN' THEN 'D'
                            WHEN 'CLERK' THEN 'E'
                            ELSE '0'
                END ���
FROM emp;




-- ��������


-- 60) (BLAKE�� ���� �μ�)�� �ִ� ������� �̸��� �Ի����� ���ϴµ� 
-- BLAKE�� �����ϰ� ����Ͻÿ�.(BLAKE�� �������� �� ����)

SELECT ename, hiredate
FROM emp
WHERE  deptno IN (SELECT deptno
                                FROM emp
                                WHERE ename = 'BLAKE')
            AND ename != 'BLAKE';


-- 61) ��ձ޿����� ���� �޿��� �޴� ������� �����ȣ, �̸�, ������ ����ϴµ� 
-- ������ ���� ��������� ����Ͻÿ�.

SELECT empno, ename, sal
FROM emp 
WHERE sal > (SELECT AVG(sal) FROM emp)
ORDER BY sal DESC;


-- 62) (10���μ����� �޿��� ���� ���� �޴� ���)�� ������ �޿��� �޴� ����� �̸��� ����Ͻÿ�.

SELECT ename, sal
FROM emp 
WHERE sal = (SELECT  MIN(sal)
                        FROM emp 
                        WHERE deptno = 10);


-- 63) ������� 3���� �Ѵ� �μ��� �μ���� ������� ����Ͻÿ�.
SELECT d.dname, e.count
FROM    dept d, (SELECT deptno, COUNT(*) count
                                    FROM emp
                                    GROUP BY deptno
                                    HAVING COUNT(*)>3) e
WHERE d.deptno = e.deptno;


-- GROUP BY �̿�
SELECT d.dname, COUNT(e.empno)
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY d.dname
HAVING COUNT(e.empno)>3;



-- 64) (�����ȣ�� 7844�� ���)���� ���� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�.
SELECT ename, hiredate
FROM emp
WHERE hiredate  <   (SELECT hiredate
                                    FROM emp
                                    WHERE empno = 7844);

-- 65) ���ӻ��(mgr)�� KING�� ��� ����� �̸��� �޿��� ����Ͻÿ�.
SELECT ename, sal
FROM emp
WHERE mgr =   (SELECT empno
                            FROM emp
                            WHERE ename = 'KING');


-- 66) (20�� �μ����� ���� �޿��� ���� �޴� ���)�� ������ �޿��� �޴� 
-- ����� �̸��� �μ���,�޿�, �޿������ ����Ͻÿ�.(emp, dept, salgrade)

SELECT e.ename, d.dname, e.sal, s.grade
FROM emp e, dept d, salgrade s
WHERE d.deptno = e.deptno
               AND  e.sal = (SELECT MAX(sal)
                                        FROM emp
                                        WHERE deptno = 20)
                AND e.sal BETWEEN s.losal AND s.hisal;


--67) (�ѱ޿�(sal+comm)�� ��� �޿�)���� ���� �޿��� �޴� ����� �μ���ȣ, �̸�, �ѱ޿�, 
--    Ŀ�̼��� ����Ͻÿ�.(Ŀ�̼��� ��(O),��(X)�� ǥ���ϰ� �÷����� "comm����" ���)

SELECT deptno, ename, sal+NVL(comm,0) �ѱ޿�, NVL2( comm,'O','X') comm����
FROM emp 
WHERE sal+NVL(comm,0) > (SELECT AVG(sal)
                                        FROM emp );



-- 68) (CHICAGO �������� �ٹ��ϴ� ����� ��� �޿�)���� ���� �޿��� �޴� ����� �̸��� �޿�,
--    �������� ����Ͻÿ�. 30 - CHICAGO
SELECT e.ename, e.sal, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
            AND e.sal > (SELECT AVG (sal)
                                  FROM emp e, dept d
                                  WHERE e.deptno = d.deptno
                                  AND d.loc = 'CHICAGO');


SELECT e.ename, e.sal, d.dname
FROM emp e, dept d
WHERE   e.deptno = d.deptno AND
                sal > (SELECT AVG(sal)
                        FROM emp
                        WHERE deptno = ( SELECT deptno
                                                        FROM dept
                                                        WHERE loc = 'CHICAGO')
                       GROUP BY deptno);
            

-- 69) ������ SALESMAN�� ������ 2�� �̻��� �μ��� �̸�, �ٹ��ϴ� ����� �̸�, ������ ���
--    �Ͻÿ�.(�÷����� �μ���, �����, ������ ���)

SELECT d.dname �μ���, e.ename �����, e.job ����
FROM emp e, dept d, (SELECT deptno
                                        FROM emp
                                        WHERE job = 'SALESMAN'
                                        GROUP BY deptno
                                        HAVING COUNT(job) >= 2 ) a
WHERE    e.deptno = d.deptno 
                AND a.deptno = e.deptno;

SELECT d.dname �μ���, e.ename �����, e.job ����
FROM emp e, dept d
WHERE e.deptno = d.deptno
            AND e.deptno  IN (SELECT deptno
                                        FROM emp
                                        WHERE job = 'SALESMAN'
                                        GROUP BY deptno
                                        HAVING COUNT(job) >= 2 ) ;



-- 70) (Ŀ�̼��� ���� �����) �� ������ ���� ���� ����� �̸��� �޿������ ����Ͻÿ�.

SELECT ename, s.grade
FROM  emp e, salgrade s
WHERE sal =  ( SELECT MAX(sal)
                            FROM emp 
                            WHERE comm =0 OR comm IS NULL)
            AND e.sal BETWEEN s.losal AND s.hisal;
            


-- 71) SMITH�� ������(mgr)�� �̸��� �μ���, �ٹ������� ����Ͻÿ�. 

SELECT e.ename, d.dname, d.loc
FROM emp e, dept d 
WHERE e.deptno = d.deptno AND
             e.empno = (SELECT mgr
                                FROM emp
                                WHERE ename = 'SMITH');

