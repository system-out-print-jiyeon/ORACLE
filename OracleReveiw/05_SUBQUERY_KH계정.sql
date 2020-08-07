/*
    * SUBQUERY (��������)
    - �ϳ��� SQL��(INSERT, UPDATE, CREATE,...) �ȿ� ���Ե� �Ǵٸ� SELECT��
    - ���� SQL���� ���� ���� ������ �ϴ� ������
*/
-- ���� �������� ����1
-- ���ö ����� ���� �μ��� ������� �̸� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';     --> D9�ΰ� �˾Ƴ�!!

-- 2) �μ��ڵ尡 D9�� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- ���� 2�ܰ踦 �ϳ��� ������!!
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö');

-- ���� �������� ����2
-- �� ������ ��ձ޿����� �� ���� �޿��� �ް� �ִ� ������� ���, �̸�, �����ڵ�, �޿� ��ȸ

-- 1) �� ������ ��� �޿� ��ȸ
SELECT AVG(SALARY)
FROM EMPLOYEE;  --> 3047663�� ��������!

-- 2) �޿��� 3047663�� �̻��� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                 FROM EMPLOYEE);

-------------------------------------------------------------------------------------------------------

/*
    * �������� ����
      ���������� ������ ������� ���� ��̳Ŀ� ���� �з���
      
      - ������ [���Ͽ�] �������� : ���������� ��ȸ ������� ������ ������ 1���� ��
      - ������ [���Ͽ�] �������� : ���������� ��ȸ ������� �� ���� �������� ��
      - [������] ���߿� �������� : ���������� ��ȸ ������� �� �������� �÷��� �������� �� 
      - ������ ���߿� ��������   : ���������� ��ȸ ������� ������ �����÷��� ��� 
      
    > ���������� ������� ���� ��̳Ŀ� ���� ��밡���� �����ڰ� �޶���
   
*/

/*
    1. ������ �������� (SINGLE ROW SUBQUERY)
       ���������� ��ȸ ����� ������ ������ 1���� ��
       
       �Ϲ� ������ ��� ����
       = != <= > ...
*/

-- �� ������ ��ձ޿����� �� ���� �޴� �������� �����, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)  --> ����� 1�� 1��
                FROM EMPLOYEE);

-- �����޿��� �޴� ����� ���, �̸�, �����ڵ�, �޿�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)  --> ����� 1�� 1��
                FROM EMPLOYEE);

-- ���ö����� �޿����� �� ���� �޴� ������� ���, �̸�, �μ��ڵ�, �����ڵ�, �޿��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE)
WHERE SALARY > (SELECT SALARY
                 FROM EMPLOYEE
                 WHERE EMP_NAME = '���ö');

-- �������� ���� �μ��� ������� ���, �����, ��ȭ��ȣ, �μ��� ��ȸ (��, �������� ����)
SELECT EMP_ID, EMP_NAME, PHONE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
  AND DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������' )
  AND EMP_NAME != '������'  ;


SELECT EMP_ID, EMP_NAME, PHONE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON ( DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������' )
  AND EMP_NAME != '������'  ;


-- �μ��� �޿����� ���� ū �μ����� ��ȸ �μ��ڵ�, �޿��� ��ȸ

SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;     --> 1770��

-- �� �μ��� �޿��� �� ���� ū ��
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT  MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE);

---------------------------------------------------------------------------------------------------

/*
    2. ������ �������� (MULTI ROW SUBQUERY)
       ���������� ��ȸ ������� �������� ��
       
       - IN �������� / NOT IN �������� : �������� ����� �߿��� �Ѱ��� ��ġ�ϴ� ���� ������ / ���ٸ� �̶�� �ǹ�
       - > ANY �������� : �������� ����� �߿��� "�ϳ���" Ŭ ���
                         �������� ����� �߿��� ���� ���� ������ Ŭ ���
       - < ANY �������� : �������� ����� �߿��� "�ϳ���" ���� ���
                         �������� ����� �߿��� ���� ū ������ ���� ���

       - > ALL �������� : �������� ������� "���" ������ Ŭ ���
                         �������� ����� �߿��� ���� ū ������ Ŭ ���
       - < ALL �������� : �������� ������� "���" ������ ���� ���
                         �������� ����� �߿��� ���� ���� ������ ���� ���
*/

-- �� �μ��� �ְ�޿��� �޴� ������ �̸�, �����ڵ�, �μ��ڵ�, �޿� ��ȸ

-->> �� �μ��� �ְ� �޿� ��ȸ
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE; --> 2890000, 3660000, 8000000, 3760000, 3900000, 2490000, 2550000

-->> ���� �޿��� �޴� ����� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (2890000, 3660000, 8000000, 3760000, 3900000, 2490000, 2550000);

-->> ���ļ� �ϳ��� ������!!
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY) --> ����� ������ 1��
                 FROM EMPLOYEE
                 GROUP BY DEPT_CODE);


-- ��� => �븮 => ���� => ���� => ���� ...
-- �븮 �����ӿ��� �ұ��ϰ� ���� ���޵��� �ּұ޿����� ���� �޴� ���� ��ȸ (���, �̸�, ����, �޿�)

-->> ���� ������ �޿� ��ȸ
SELECT SALARY , JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '����';      -- 2200000, 2500000, 3760000

-->> ������ �븮�̸鼭 �޿����� ���� ��ϵ� �� �߿� �ϳ��� ū ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮'
  AND SALARY > ANY( 2200000, 2500000, 3760000 );
    -- OR
    -- SALARY > 220000 OR SALARY > 250000 OR SALARY > 3760000 
  
  
--> �ϳ��� ���ĺ���!!
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮'
  AND SALARY > ANY(SELECT SALARY            --> ����� ������ 1��
                    FROM EMPLOYEE
                    JOIN JOB USING (JOB_CODE)
                    WHERE JOB_NAME = '����');


--> ������ ���������ε� ���� 
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮'
  AND SALARY >  ( SELECT MIN(SALARY)            --> ����� 1�� ������, ANY�� ���ص� ��� ����
                    FROM EMPLOYEE
                    JOIN JOB USING (JOB_CODE)
                    WHERE JOB_NAME = '����');


-- ���� �����ӿ��� �ұ��ϰ� ���� ������ �ִ� �޿����� �� ���� �޴� ��� (���, �����, ���޸�, �޿�)

-->> ���� ������ �޿� ��ȸ
SELECT SALARY 
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '����';      --> 2800000, 1550000, 2490000,2480000

-->> ���� �����̸鼭 �޿����� ���� ��ϵ� ��� ������ ū ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '����'
  AND SALARY > ALL (2800000, 1550000, 2490000, 2480000);
  -- AND
  -- SALARY > 2800000 AND SALARY > 1550000 AND SALARY > 2490000 AND SALARY > 2480000
  
  
-->> �ϳ��� ��ġ��
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '����'
  AND SALARY > ALL (SELECT SALARY
                FROM EMPLOYEE
                JOIN JOB USING (JOB_CODE)
                WHERE JOB_NAME = '����');

-->> ������ ���������ε� ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '����'
  AND SALARY > (SELECT MAX(SALARY)  --> ����� 1��
                FROM EMPLOYEE
                JOIN JOB USING (JOB_CODE)
                WHERE JOB_NAME = '����');

---------------------------------------------------------------------------------------------------------

/*
    3. [������] ���߿� ��������
        ��ȸ��� ���� �� �������� ������ �÷����� �������� ��

*/

-- ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ����� ��ȸ

-->> ������ ����� �μ��ڵ�� �����ڵ� ���� ��ȸ
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������';     --> D5/J5

-->> �μ��ڵ尡 D5�̸鼭 �����ڵ尡 J5�� ����� ��ȸ
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
  AND JOB_CODE = 'J5';

--> �ϳ��� ������ (�����༭������)
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������')
  AND JOB_CODE = (SELECT JOB_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������');

--> �ϳ��� ������ (���߿� ��������)
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE   --> ����� 1�� ������
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '������');

--�ڳ��� ����� �����ڵ尡 ��ġ�ϸ鼭 ���� ����� ������ �ִ� ��� ��ȸ (���, �̸�, �����ڵ�, ������)
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID     --> ����� 1�� ������
                                   FROM EMPLOYEE
                                   WHERE EMP_NAME = '�ڳ���');


-----------------------------------------------------------------------------------------------------------------------

/*
    4. ������ ���߿� ��������
       �������� ��ȸ ������� ������ �������� ���
*/

-- 1) �� ���޺� �ּ� �޿��� �޴� ����� ��ȸ (���, �̸�, �����ڵ�, �޿�)

-->> �� ���޺� �ּ� �޿� ��ȸ
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;


SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) = ('J2',3700000)
   OR (JOB_CODE, SALARY) = ('J7',1380000)
   OR (JOB_CODE, SALARY) = ('J3',3400000)
   ....;


SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)   --> ����� ������ ���߿�
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE);
-- =�� ���� ���� �� 1�������ϱ⶧���� IN ����ߵ�



-- �� �μ��� �ְ�޿��� �޴� ����� ���, �����, �μ��ڵ�, �޿�
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE(DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                            FROM EMPLOYEE
                            GROUP BY DEPT_CODE);

------------------------------------------------------------------------------------------------------

/*
    5. �ζ��� �� (INLINE-VIEW)
       FROM���� ���������� �����ϴ� ��
       
       ���������� ������ ����� ���̺� ��ſ� �����!!
    
*/

-- ���ʽ� ���� ������ 3000���� �̻��� ������� ���, �̸�, ���ʽ����Կ���, �μ��ڵ带 ��ȸ
SELECT EMP_ID, EMP_NAME, (SALARY+ SALARY*NVL(BONUS,0) )*12 ���ʽ����Կ���, NVL(DEPT_CODE, '����') �μ��ڵ�
FROM EMPLOYEE
-- WHERE ���ʽ����Կ��� >= 30000000; -- ������������� ��Ī���� �� �� ����
WHERE (SALARY+ SALARY*NVL(BONUS,0) )*12 >= 3000000;


SELECT EMP_ID, EMP_NAME
 FROM (SELECT EMP_ID, EMP_NAME, (SALARY+ SALARY*NVL(BONUS,0) )*12 ���ʽ����Կ���, NVL(DEPT_CODE, '����') �μ��ڵ�
    FROM EMPLOYEE)
WHERE ���ʽ����Կ��� >= 30000000;

-- �ǻ�� ����
-->> �ζ��� �並 �ַ� ����ϴ� ��
-- * TOP-N �м� (�ǽð� �˻���, �α��ǰ, �Խ��� �� ���, ...)

-- �� ���� �� �޿��� ���� ���� ���� 5��

-- * ROWNUM : ����Ŭ���� �������ִ� �÷�, ��ȸ�� ������� 1���� ������ �ο����ִ� �÷�
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;
-- FROM => SELECT (���ĵ� �Ǳ� ���� ROWNUM �ο���!! )=> ORDER BY
-- ������ ���׹���


--> ORDER BY�� ������� ������ ROWNUM �ο��ؾߵ�!!
SELECT ROWNUM ����, E.*
FROM(SELECT EMP_NAME, SALARY, DEPT_CODE
    FROM EMPLOYEE
    ORDER BY SALARY DESC) E
WHERE ROWNUM <= 5;


-- �� �μ��� ��ձ޿��� ���� 3���� �μ��� �μ��ڵ�, ��� �޿� ��ȸ

SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 2 DESC;

SELECT ROWNUM ����, DEPT_CODE, ROUND(��ձ޿�)
FROM (SELECT DEPT_CODE, AVG(SALARY) ��ձ޿�
       FROM EMPLOYEE
       GROUP BY DEPT_CODE
       ORDER BY 2 DESC)
WHERE ROWNUM <= 3;

----------------------------------------------------------------------------------------------------
 
 /*
    6. ���� �ű�� �Լ� 
     RANK() OVER(���ı���)          /       DENSE_RANK() OVER(���ı���)
     
     - RANK() OVER(���ı���) : EX) ���� 1���� 3���̸� �� ���� ������ 4��
     - DENSE_RANK() OVER(���ı���) : EX) ���� 1���� 3���̴��� �� ���� ������ 2��
    
    * SELECT�������� ���� ����
    
 */


-- ����� �޿��� ���� ����� ������ �Űܼ� �����, �޿�, ���� ��ȸ
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) ����
FROM EMPLOYEE;
--> ���� 19�� 2�� �� ���� ���� 21��

SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC)����
FROM EMPLOYEE;
--> ���� 19�� 2�� �� ���� ���� 20��

-- ���� 5�� ��ȸ
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC)����
FROM EMPLOYEE
-- WHERE ���� <= 5;       ��Ī X
WHERE RANK() OVER(ORDER BY SALARY DESC) <= 5;
--> ���� �ű�� �Լ��� SELECT������ ��� ����!!

--> �ᱹ �ζ��κ�� ��ȸ�ؾߵ�!!
SELECT *
FROM (SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) ����
      FROM EMPLOYEE)
WHERE ���� <= 5;










