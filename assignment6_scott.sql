
-- 특수쿼리 문제

--33) 각 사원의 이름을 표시하고 근무 달 수(입사일로부터 현재까지의 달수)를 계산하여
--열 레이블을 MONTHS_WORKED로 지정하시오. 결과는 정수로 반올림하여 표시하고 
--근무달 수를 기준으로 오름차순으로 정렬하시오.(MONTHS_BETWEEN 함수 참고)

SELECT ename, ROUND ( MONTHS_BETWEEN (sysdate, hiredate)) MONTHS_WORKED
FROM emp 
ORDER BY MONTHS_WORKED ASC;



--34)emp테이블에서 이름, 업무, 근무연차를 출력하시오.

SELECT  ename, job,
                 ROUND(MONTHS_BETWEEN(sysdate, hiredate) / 12)  AS 근무연차
FROM emp;


--35)emp테이블에서 사원이름, 월급, 월급과 커미션을 더한 값을 컬럼명 실급여라고 해서 출력.
--단, NULL값은 나타나지 않게 작성하시오.

SELECT ename, sal, sal+ NVL(comm , 0 ) "실급여"
FROM emp;


--36)월급과 커미션을 합친 금액이 2,000이상인 급여를 받는 사원의 이름,업무,월급,커미션,고용날짜를 
-- 출력하시오. 단, 고용날짜는 1980-12-17 형태로 출력하시오.

SELECT ename, job, sal, comm, TO_CHAR(hiredate,'YYYY-MM-DD')
FROM emp
WHERE sal + NVL(comm,0) >= 2000;



--37)DECODE 또는 CASE WHEN THEN 함수를 사용하여 다음 데이터에 따라 JOB열의 값을 기준으로
--모든 사원의 등급을 표시하시오.
--     업무               등급
--PRESIDENT       A
--ANALYST            B
--MANAGER          C
--SALESMAN        D
--CLERK               E
--기타                     0

SELECT job 업무, 
                CASE job 
                            WHEN 'PRESIDENT' THEN 'A'
                            WHEN 'ANALYST' THEN 'B'
                            WHEN 'MANAGER' THEN 'C'
                            WHEN 'SALESMAN' THEN 'D'
                            WHEN 'CLERK' THEN 'E'
                            ELSE '0'
                END 등급
FROM emp;




-- 서브쿼리


-- 60) (BLAKE와 같은 부서)에 있는 사원들의 이름과 입사일을 구하는데 
-- BLAKE는 제외하고 출력하시오.(BLAKE가 여러명일 수 있음)

SELECT ename, hiredate
FROM emp
WHERE  deptno IN (SELECT deptno
                                FROM emp
                                WHERE ename = 'BLAKE')
            AND ename != 'BLAKE';


-- 61) 평균급여보다 많은 급여를 받는 사원들의 사원번호, 이름, 월급을 출력하는데 
-- 월급이 높은 사람순으로 출력하시오.

SELECT empno, ename, sal
FROM emp 
WHERE sal > (SELECT AVG(sal) FROM emp)
ORDER BY sal DESC;


-- 62) (10번부서에서 급여를 가장 적게 받는 사원)과 동일한 급여를 받는 사원의 이름을 출력하시오.

SELECT ename, sal
FROM emp 
WHERE sal = (SELECT  MIN(sal)
                        FROM emp 
                        WHERE deptno = 10);


-- 63) 사원수가 3명이 넘는 부서의 부서명과 사원수를 출력하시오.
SELECT d.dname, e.count
FROM    dept d, (SELECT deptno, COUNT(*) count
                                    FROM emp
                                    GROUP BY deptno
                                    HAVING COUNT(*)>3) e
WHERE d.deptno = e.deptno;


-- GROUP BY 이용
SELECT d.dname, COUNT(e.empno)
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY d.dname
HAVING COUNT(e.empno)>3;



-- 64) (사원번호가 7844인 사원)보다 빨리 입사한 사원의 이름과 입사일을 출력하시오.
SELECT ename, hiredate
FROM emp
WHERE hiredate  <   (SELECT hiredate
                                    FROM emp
                                    WHERE empno = 7844);

-- 65) 직속상사(mgr)가 KING인 모든 사원의 이름과 급여를 출력하시오.
SELECT ename, sal
FROM emp
WHERE mgr =   (SELECT empno
                            FROM emp
                            WHERE ename = 'KING');


-- 66) (20번 부서에서 가장 급여를 많이 받는 사원)과 동일한 급여를 받는 
-- 사원의 이름과 부서명,급여, 급여등급을 출력하시오.(emp, dept, salgrade)

SELECT e.ename, d.dname, e.sal, s.grade
FROM emp e, dept d, salgrade s
WHERE d.deptno = e.deptno
               AND  e.sal = (SELECT MAX(sal)
                                        FROM emp
                                        WHERE deptno = 20)
                AND e.sal BETWEEN s.losal AND s.hisal;


--67) (총급여(sal+comm)가 평균 급여)보다 많은 급여를 받는 사람의 부서번호, 이름, 총급여, 
--    커미션을 출력하시오.(커미션은 유(O),무(X)로 표시하고 컬럼명은 "comm유무" 출력)

SELECT deptno, ename, sal+NVL(comm,0) 총급여, NVL2( comm,'O','X') comm유무
FROM emp 
WHERE sal+NVL(comm,0) > (SELECT AVG(sal)
                                        FROM emp );



-- 68) (CHICAGO 지역에서 근무하는 사원의 평균 급여)보다 높은 급여를 받는 사원의 이름과 급여,
--    지역명을 출력하시오. 30 - CHICAGO
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
            

-- 69) 업무가 SALESMAN인 직원이 2명 이상인 부서의 이름, 근무하는 사원의 이름, 업무를 출력
--    하시오.(컬럼명은 부서명, 사원명, 업무로 출력)

SELECT d.dname 부서명, e.ename 사원명, e.job 업무
FROM emp e, dept d, (SELECT deptno
                                        FROM emp
                                        WHERE job = 'SALESMAN'
                                        GROUP BY deptno
                                        HAVING COUNT(job) >= 2 ) a
WHERE    e.deptno = d.deptno 
                AND a.deptno = e.deptno;

SELECT d.dname 부서명, e.ename 사원명, e.job 업무
FROM emp e, dept d
WHERE e.deptno = d.deptno
            AND e.deptno  IN (SELECT deptno
                                        FROM emp
                                        WHERE job = 'SALESMAN'
                                        GROUP BY deptno
                                        HAVING COUNT(job) >= 2 ) ;



-- 70) (커미션이 없는 사원들) 중 월급이 가장 높은 사원의 이름과 급여등급을 출력하시오.

SELECT ename, s.grade
FROM  emp e, salgrade s
WHERE sal =  ( SELECT MAX(sal)
                            FROM emp 
                            WHERE comm =0 OR comm IS NULL)
            AND e.sal BETWEEN s.losal AND s.hisal;
            


-- 71) SMITH의 관리자(mgr)의 이름과 부서명, 근무지역을 출력하시오. 

SELECT e.ename, d.dname, d.loc
FROM emp e, dept d 
WHERE e.deptno = d.deptno AND
             e.empno = (SELECT mgr
                                FROM emp
                                WHERE ename = 'SMITH');

