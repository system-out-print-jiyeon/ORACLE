/*

    < JOIN >

    �� �� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ���Ǵ� ����
    ��ȸ ����� �ϳ��� �����(RESULT SET)�� ����

    ������ �����ͺ��̽��� �ּ����� �����ͷ� ������ ���̺� ������� (�ߺ��� �ּ�ȭ�ϱ� ���ؼ�)
    => ��, JOIN������ ������ �����ͺ��̽����� �������� ���̺� "����"�� �δ� ���
    
    ������ JOIN�� �ؼ� ���� ��ȸ�� �ϴ°� �ƴ϶�
    ���̺� "�����"�� �÷� �����͸� "��Ī"���Ѽ� ��ȸ�ؾߵ�!!
    
                                     [ JOIN ��� ���� ]
                                
                  JOIN�� ũ�� "����Ŭ ���� ����"�� "ANSI(�̱�����ǥ����ȸ) ����"
                  
                ����Ŭ DBMS������                              ����Ŭ + �ٸ� DBMS ������ 
                  ����Ŭ ����                       |              ANSI ����
    -----------------------------------------------------------------------------------------------
                   � ����                        |          ���� ���� (INNER JOIN) --> JOIN USING/ON
                 (EQUAL JOIN)                      |        �ڿ� ���� (NATURAL JOIN) --> JOIN US
    ------------------------------------------------------------------------------------------------
                   ���� ����                        |        ���� �ܺ� ����(LEFT OUTER JOIN),
                   (LEFT OUTER)                    |        ������ �ܺ� ���� (RIGHT OUTER JOIN),
                   (RIGHT OUTER)                   |      ��ü �ܺ� ���� (FULL OUTER JOIN, ����Ŭ�������� ���Ұ�)
    ---------------------------------------------------------------------------------------------------
               ī�׽þ� �� (CARTESIAN PRODUCT)      |            ���� ���� (CROSS JOIN) 
    -----------------------------------------------------------------------------------------------------
    ��ü ���� (SELF JOIN), ������(NON EQUAL JOIN)|           JOIN ON
    
*/

-- �� ������� ���, �����, �μ��ڵ�, �μ������ ���� ��ȸ�ϰ� ���� ��?
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- �� ������� ���, �����, �����ڵ�, ���޸��� ��ȸ�ϰ��� �� ��?
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, JOB_NAME
FROM JOB;

-- ������ ���ؼ� ������� �ش��ϴ� �÷����� ����� ��Ī�� ���ָ� ���� �ϳ��� ������� ��ȸ����!!

/*
    1. ����� (EQUAL JOIN) / �������� (INNER JOIN)
        �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ���εż� ��ȸ(== ��ġ�ϴ� ���� ���� ���� ��ȸ X)
    
*/

-->> ����Ŭ ���� ����
-- FROM ���� ��ȸ�ϰ��� �ϴ� ���̺���� ���� (, �����ڷ�)
-- WHERE ���� ��Ī��ų �÷���(�����)�� ���� ������ ������


-- ���, �����, �μ��ڵ�, �μ��� ��ȸ
-- 1) ������ �� �÷����� �ٸ� ��� (EMPLOYEE:DEPT_CODE   /   DEPARTMENT:DEPT_ID)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCATION_ID
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> ��ġ���� �ʴ� ���� ��ȸ���� ���ܵ� �� Ȯ�� ����
-- (DEPT_CODE�� NULL�̿��� 2���� ��������� ��ȸ�ȵ�, DEPT_ID�� D3,D4,D7�� �μ������� ��ȸ�ȵ�)


-- ���, �����, �����ڵ�, ���޸�
-- 2) ������ �� �÷����� ���� ��� (EMPLOYEE:JOB_CODE   /   JOB:JOB_CODE)

--  ��� 1) ���̺���� �̿��ϴ� ���
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME  -- 3
FROM EMPLOYEE, JOB                           -- 1
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;      -- 2
-->  ambiguously : �ָ��ϴ�, ��ȣ�ϴ�

--  ���2) ��Ī ��� (�� ���̺��� ��Ī �ο�����)
SELECT EMP_ID, EMP_NAME, J.JOB_CODE, JOB_NAME 
FROM EMPLOYEE E, JOB J     
WHERE E.JOB_CODE = J.JOB_CODE; 


-->> ANSI ����
--  FROM���� ���� ���̺��� �ϳ� ����� ��
--  �� �ڿ� JOIN������ ���� ��ȸ�ϰ����ϴ� ���̺� ��� (���� ��Ī��ų �÷��� ���� ����) => USING ����, ON ����


-- ���, �����, �μ��ڵ�, �μ���
-- 1) ������ �� �÷����� �ٸ� ��� (EMPLOYEE:DEPT_CODE   /   DEPARTMENT:DEPT_ID)
--     => JOIN ON ������ ��밡��!!!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
-- INNER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- INNER ���� ����
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- ���, �����, �����ڵ�, ���޸�
-- 2) ������ �� �÷����� ���� ��� (EMPLOYEE:JOB_CODE   /   JOB:JOB_CODE)
--    => JOIN USING ����, JOIN ON ����
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
/*INNER*/JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);    -- ON ���� : ambigously �߻�

SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
/*INNER*/JOIN JOB USING (JOB_CODE);  -- USING ���� : ambigously �߻� X 

-- [����] ���� ������ NATURAL JOIN(�ڿ�����)���ε� ���� --
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;


-- �߰����� ���ǵ� ���� ����!!

-- ������ �븮�� ����� ���, �����, �޿� ��ȸ

SELECT JOB_CODE
FROM JOB
WHERE JOB_NAME = '�븮'; --> J6

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J6';

-- JOIN�� ���ؼ�!!
-->> ����Ŭ ���� (FROM���� ��ȸ�����̺����, WHERE���� ��Ī��Ű�����Ǳ��)
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
    AND JOB_NAME = '�븮';

-->> ANSI ���� (FROM���� ���̺� �ϳ��� ���, JOIN���� �߰�����ȸ�ϰ����ϴ� ���̺� �� ���� (ON/USING)
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮';

-------------------------------------------------< �ǽ� ���� >------------------------------------------------
-- 1. �μ��� �λ�������� ������� ���, �����, ���ʽ� ��ȸ
-->> ����Ŭ ����
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_ID = DEPT_CODE AND DEPT_CODE = '�λ������';

-->> ANSI ����
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
WHERE DEPT_CODE = '�λ������';



-- 2. �μ��� �ѹ��ΰ� �ƴ� ������� �����, �޿�, �Ի��� ��ȸ
-->> ����Ŭ ����
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
    AND DEPT_TITLE != '�ѹ���';

-->> ANSI ����
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE != '�ѹ���';
    
    

-- 3. ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
-->> ����Ŭ ����
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
    AND BONUS IS NOT NULL;

-->> ANSI ����
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;
    
    

-- 4. �Ʒ��� �� ���̺� �����ؼ� �μ��ڵ�, �μ���, �����ڵ�, ������(LOCAL_NAME)�� ��ȸ
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;
-->> ����Ŭ ����
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;

-->> ANSI ����
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);


-- ���, �����, �μ���, ���޸�
SELECT * FROM EMPLOYEE;     -- DEPT_CODE    JOB_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID
SELECT * FROM JOB;          --              JOB_CODE
-->> ����Ŭ ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID
  AND E.JOB_CODE = J.JOB_CODE;

-->> ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE 
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE);

---------------------------------------------------------------------------------------

/*
    2. �������� / �ܺ����� (OUTER JOIN)
    
    ���̺��� JOIN�� ��ġ���� ���� �൵ ���Խ��Ѽ� ��ȸ ����
    ��, �ݵ�� LEFT/RIGHT�� �����ؾ߸� ��!! (������ �Ǵ� ���̺� ����)

*/

-- �����, �μ���, �޿�
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- �μ���ġ�� ���� ���� (DEPT_CODE���� NULL) 2���� ��������� ��ȸ X
-- �μ��� ������ ����� ���� �μ�(D3, D4, D7) ���� ��쵵 ��ȸ X


-- 1) LEFT OUTER JOIN : �� ���̺� �� ���� ����� ���̺� �������� JOIN
-- >> ANSI ����
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
LEFT /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);     -- OUTER ��������
--> �μ��ڵ尡 ���� ��� (�ϵ���, �̿���)�� �����͵� ��ȸ��!!

-- >> ����Ŭ ����
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);   -- ������ ���̺� �÷��� (+) ǥ�� (��ȸ�ϰ���� �÷��� �ݴ�Ǵ� �÷���!)


-- 2) RIGHT [OUTER] JOIN : �� ���̺� �� ������ ����� ���̺� �������� JOIN
-- >> ANSI ����
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);    
--> �μ��� ������ ����� ���� �μ�(D3, D4, D7)�� ��ȸ
--> �ϵ���, �̿����� �����ʹ� ��� X


-- >> ����Ŭ ����
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- 3) FULL [OUTER] JOIN : �� ���̺��� ���� ��� ���� ��ȸ�� �� ���� (��, ����Ŭ�������� �ȵ�)
-- >> ANSI ����
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);    

-- >> ����Ŭ ������ ������!!
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);

---------------------------------------------------------------------------------------------

/*
    3. ī�׽þ� �� (CARTESIAN PRODUCT) / �������� (CROSS JOIN)
        ��� ���̺��� �� ����� ���μ��� ���ε� �����Ͱ� ��ȸ�� (������)

        �� ���̺��� ����� ��� ������ ����� ������ ��� --> ����� ������ ��� --> �������� ���� (�׷��� �Ժη� ���� �ʴ´�)

*/

-- �����, �μ���
-- >> ����Ŭ ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT; --> 23 * 9 = 207��

-- >> ANSI ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;  -- CROSS JOIN


----------------------------------------------------------------------------------------------------
/*
    4. ��ü ���� (SELF JOIN)
    
    ���� ���̺��� �ٽ� �ѹ� �����ϴ� ���
    �ڱ� �ڽŰ� ������ �δ� ��
*/

SELECT EMP_ID,EMP_NAME, SALARY, MANAGER_ID
FROM EMPLOYEE;

-- ������ ����� ������, �����, ����μ��ڵ�, ������, �����
SELECT * FROM EMPLOYEE; -- ����� ���� ���̺�   MANAGER_ID
SELECT * FROM EMPLOYEE; -- ����� ���� ���̺�   EMP_ID

-- >> ����Ŭ ����
SELECT E.EMP_ID �����ȣ, E.EMP_NAME �����, E.DEPT_CODE ����μ��ڵ�,
       E.MANAGER_ID ������, M.EMP_NAME �����, M.DEPT_CODE ����μ��ڵ�
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;
--> 15��, NULL�ξֵ��� ��ȸ �ȵ�


-- >> ANSI ����
SELECT E.EMP_ID �����ȣ, E.EMP_NAME �����, E.DEPT_CODE ����μ��ڵ�, E.MANAGER_ID ������,
       M.EMP_NAME �����, M.DEPT_CODE ����μ��ڵ�
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

------------------------------------------------------------------------------------------------------

/*
    5. �� ���� (NON EQUAL JOIN)
    '=' (��ȣ)�� ������� �ʴ� ���ι�
    
     ������ �÷����� ��ġ�ϴ� ��찡 �ƴ�, ���� "����"�� ���ԵǴ� ��� ��Ī
*/

-- �����, �޿�
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;

SELECT *
FROM SAL_GRADE;
    
-- �����, �޿�, �޿����(SAL_LEVEL)
-- >> ����Ŭ ����
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- >> ANSI ���� (ON ������!! USING�ȵ�)
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON(SALARY BETWEEN MIN_SAL AND MAX_SAL);

---------------------------------------------------------------------------------------------
/*
    < ���� JOIN >
    
    N���� ���̺��� JOIN 
*/

-- ���, �����, �μ���, �ٹ�������(LOCAL_NAME)
SELECT * FROM EMPLOYEE;     -- DEPT_CODE                    JOB_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID      LOCATION_ID
SELECT * FROM LOCATION;     --              LOCAL_CODE
SELECT * FROM JOB;          --                              JOB_CODE

-- >> ����Ŭ ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID
  AND LOCATION_ID = LOCAL_CODE;

-- >> ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN JOB USING(JOB_CODE); --> EMPLOYEE���̺��� �̹� �տ� ����Ǿ������Ƿ� �ƹ����̳� ������
--> ���� ������ ������ �߿�! ���̺���� �ٲ��� �ȵ�!!



SELECT * FROM EMPLOYEE;     -- DEPT_CODE                    JOB_CODE                    SALARY
SELECT * FROM DEPARTMENT;   -- DEPT_ID      LOCATION_ID
SELECT * FROM JOB;          --                              JOB_CODE
SELECT * FROM LOCATION;     --              LOCAL_CODE                 NATIONAL_CODE
SELECT * FROM NATIONAL;     --                                         NATIONAL_CODE
SELECT * FROM SAL_GRADE;    --                                                        MIN_SAL,MAX_SAL

-- ���, �����, �μ���, ���޸�, �ٹ�������, �ٹ�������, �޿���� ��ȸ
-- >> ����Ŭ ����
SELECT E.EMP_ID ���,
       E.EMP_NAME �����,
       D.DEPT_TITLE �μ���,
       J.JOB_CODE ���޸�,
       L.LOCAL_NAME �ٹ�������,
       N.NATIONAL_NAME �ٹ�������,
       S.SAL_LEVEL �޿����
  FROM EMPLOYEE E, 
       DEPARTMENT D,
       JOB J,
       LOCATION L,
       NATIONAL N,
       SAL_GRADE S
 WHERE E.DEPT_CODE = D.DEPT_ID
   AND E.JOB_CODE = J.JOB_CODE
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND L.NATIONAL_CODE = N.NATIONAL_CODE
   AND E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL;


-- >> ANSI ����
SELECT E.EMP_ID ���,
       E.EMP_NAME �����,
       D.DEPT_TITLE �μ���,
       J.JOB_CODE ���޸�,
       L.LOCAL_NAME �ٹ�������,
       N.NATIONAL_NAME �ٹ�������,
       S.SAL_LEVEL �޿����
  FROM EMPLOYEE E
JOIN D.DEPARTMENT ON (E.DEPT_CODE = D.DEPT_ID)
JOIN E.JOB_CODE = J.JOB_CODE
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND L.NATIONAL_CODE = N.NATIONAL_CODE
   AND E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL;










