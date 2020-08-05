/*
    < GROUP BY �� >
    �׷������ ������ �� �ִ� ���� (�ش� �׷���غ��� �׷��� ������ �� �ִ�.)
    �������� ������ �ϳ��� �׷����� ��� ó���� �������� ���    
*/

SELECT SUM(SALARY)
FROM EMPLOYEE;  --> ��ü ������� �ϳ��� �׷����� ��� ������ ���� ���

-- �� �μ��� �� �޿���
SELECT DEPT_CODE, SUM(SALARY)
-- GROUP BY����ϸ� SUM�� ���� �� �࿡ ���°� ����
FROM EMPLOYEE
GROUP BY DEPT_CODE;


SELECT COUNT (*)
FROM EMPLOYEE; --> ��ü��� ��

-- �� �μ��� ��� ��
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;


-- �� �μ��� �� �޿����� �μ��� �������� �����ؼ� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)   -- 3. SELECT��
FROM EMPLOYEE                   -- 1. FROM��
GROUP BY DEPT_CODE              -- 2. GROUP BY��     => 7�׷�
ORDER BY DEPT_CODE;             -- 4. ORDER BY�� (ORDER BY�� �׻� ������!!)

-- �� ���޺� �� �޿���, �����, ���ʽ��� �޴� ��� ��
SELECT JOB_CODE ����, SUM(SALARY) �޿���, COUNT(*) �����, COUNT(BONUS) ���ʽ��޴»����
       ,FLOOR(AVG(SALARY)) ��ձ޿�, MAX(SALARY) �ְ�޿�, MIN(SALARY) �����޿�
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

-- �� �μ��� �� �����, ���ʽ��� �޴� �����, �޿���, ��ձ޿�, �ְ�޿�, �����޿�
SELECT DEPT_CODE �μ�,
       COUNT(*) �ѻ����,
       COUNT(BONUS) ���ʽ����޴»����,
       SUM(SALARY) �޿���,
       ROUND(AVG(SALARY)) ��ձ޿�,
       MAX(SALARY) �ְ�޿�,
       MIN(SALARY) �����޿�
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- * ���� �÷��� �׷�������� ���� ����
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE;

--------------------------------------------------------------------------------------------------------

/*
    < HAVING �� >
    
    �׷쿡 ���� ������ ������ �� ���Ǵ� ���� (�ַ� �׷��Լ��� ����� ������ �� ����)
    
*/

-- �� �μ��� ��� �޿��� 300���� �̻��� �μ��鸸 ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE                       -- 1
--WHERE AVG(SALARY) >= 3000000      -- 2 �������(���� �׷�������������)������ ���� �ȵ�
GROUP BY DEPT_CODE                  -- 3 
HAVING AVG(SALARY) >= 3000000;

-- �� ���޺� �� �޿����� 1000���� �̻��� ����, �޿����� ��ȸ
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- �� �μ��� ���ʽ��� �޴� ����� ���� �μ����� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

---------------------------------------------------------------------------------------------------
/*
    < ���� ���� >
    
    5 : SELECT *|��ȸ�ϰ����ϴ��÷���|��������|�Լ���  [AS] "��Ī"
    1 : FROM   ��ȸ�ϰ����ϴ� ���̺��
    2 : WHERE ���ǽ�
    3 : GROUP BY �׷���ؿ� �ش��ϴ� �÷���, �÷���, ...
    4 : HAVING �׷��Լ��Ŀ� ���� ���ǽ�
    6 : ORDER BY �÷���|��Ī|�÷����� [ASC|DESC] [NULLS FIRST|NULLS LAST];
*/


---------------------------------------------------------------------------------------------------

/*
    < ���� �Լ� >
    
    �׷캰 ������ ������� �߰����踦 ������ִ� �Լ�
    
    ROLLUP, CUBE    (GROUP BY���� ���Ǵ� �Լ�)
    
*/

-- �� ���޺� �޿���
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- ROLLUP
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE) 
ORDER BY JOB_CODE;

-- CUBE
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY JOB_CODE;

-- �׷�������� �ϳ��� �÷��� �����ϰԵǸ� ROLLUP�̵� CUBE�� �� ���� ����
-- ������ �࿡ ��ü �ѱ޿��ձ��� ���� ����

----- ROLLUP�� CUBE�� ������ (�׷������ ��� �ΰ��̻��� �÷��̿��ߵ�) -----
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE;     --> 13���� �׷�

-- ROLLUP(�÷�1, �÷�2) => �÷�1�� ������ �ٽ� �߰����踦 ���ִ� �Լ�
-- DEPT_CODE�� ��ġ�ϴ¾ֵ鳢�� ��� �߰��� ���賻��
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;


-- CUBE(�÷�1, �÷�2) => �÷�1�� ������ �߰����賻��, �÷�2�� ������ �߰����踦 ��
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY JOB_CODE ;

-----------------------------------------------------------------------------------------------------

/*
    < ���� ������ >
    SET OPERATION
    
    �������� ������(SELECT��)�� ������ �ϳ��� ���������� ����� ������
    
    - UNION     : ������ (�� ������ ������ ������� ���� �� �ߺ��Ǵ� �κ� �ѹ� ����) OR
    - INTERSECT : ������ (�� ������ ������ ������� �ߺ��� �����) AND
    - UNION ALL : ������ ������� �������� ������ ���� (�� ������ ������ ������� ������ ����) => �ߺ��� ���� �� �� �� �� ����
    - MINUS     : ������ (���� ������ ����� - ���� ������ ������� ���)
    
*/

-- 1. UNION
-- �μ��ڵ尡 D5�̰ų� �Ǵ� �޿��� 300���� �ʰ��� ����� ��ȸ (���, �̸�, �μ��ڵ�, �޿�)

-- �μ��ڵ尡 D5�� ����鸸 ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'; --> 6�� ��ȸ��

-- �޿��� 300���� �ʰ��� ����鸸 ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; --> 8�� ��ȸ��

-- UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'  --> ';'�����ְ� UNION����
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;
--> �ߺ����̿��� �ѹ��� �����

-- ���� ������ ��� �Ʒ�ó�� WHERE������ ���ؼ��� �ذ� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

-- �� �μ��� �޿��� (GROUP BY�� �̿�)
SELECT SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �� �μ��� �޿���(UNION �̿�)
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1'
UNION
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D2'
UNION 
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-----------------------------------------------------------------------------------------------

-- 2. UNION ALL : �������� ���� ����� ������ ���ϴ� ������ (�ߺ����� ������ �� �� ����)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, BONUS ���ʽ��Ǵ±޿�
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'                  --> 6��
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;                 --> 8��
-- ������1�� ������2�� �÷� ���� �¾ƾ��Ѵ�
-- ������1 ���ప�� ������2 ���ప �ִ� �״�� ���ؼ� ��� (�ߺ�����X)


-- 3. INTERSECT (������)
-- �μ��ڵ尡 D5�̸鼭 �׸��� �޿������� 300���� �ʰ��� ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

--�Ʒ�ó�� WHERE���� AND�ε� ����!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;


-- 4. MINUS
-- �μ��ڵ尡 D5�� ����� �� �޿��� 300���� �ʰ��� ����� �����ؼ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

--�Ʒ�ó�� WHERE���� AND�ε� ����!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <= 3000000;









