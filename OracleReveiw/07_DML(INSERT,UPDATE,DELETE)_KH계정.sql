/*
    < DML : DATA MANIPULATION LANGUAGE >
    ������ ���� ���
    
    ���̺� ���� ����(INSERT)�ϰų�, ����(UPDATE)�ϰų�, ����(DELETE)�ϴ� ����
    
*/

/*
    1. INSERT 
       ���̺� ���ο� ���� �߰��ϴ� ����
       
    1) ���̺� ��� �÷��� ���� ���� �� �� INSERT�ϰ��� �� ��
       INSERT INTO ���̺�� VALUES(��, ��, ��, ....);
        
       ������ �� : ���̺� �����ϴ� �÷� ����ŭ �� ���� / �÷� ���� ���Ѽ� �� ����
*/

INSERT INTO EMPLOYEE 
VALUES(900, '��ä��', '980914-2112457', 'jang_ch@kh.or.kr',
       null, 'D1', 'J7', 2000000, null, 200, SYSDATE, NULL, DEFAULT);

SELECT *
FROM EMPLOYEE
WHERE EMP_ID = 900;

/*
    2) ���̺� ���� ������ �÷��� ���� ���� INSERT�� �� ���
       
       INSERT INTO ���̺��(�÷���, �÷���, �÷���) VALUES(��, ��, ��);
       
        �׷��� �� �� ������ �߰��Ǳ� ������ �������� �÷��� �⺻������ NULL���� ��
        => ������ �� : NOT NULL ���������� �ɷ��ִ� �÷��� �ݵ�� �����ؼ� ���� �� �����ؾߵ�
        
        (��, �⺻��(DEFAULT)�� �����Ǿ��ִ� �÷��� ��� NULL���� �ƴ� DEFAULT���� ���)
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
VALUES(901, '������', '800918-2145344', 'D2', 'J7', SYSDATE );

SELECT * 
FROM EMPLOYEE
WHERE EMP_NAME = '������';

----------------------------------------------------------------------------------------------------------------------------

/*
    3) ���������� ��ȸ�� ������� ��°�� INSERT�ϴ� ���
    
       INSERT INTO ���̺��(��������);
*/

-- ���ο� ���̺� ����
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(30)
);

SELECT * FROM EMP_01;

-- �� ����� ���, �����, �μ��� ��ȸ
-->> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);

-->> ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

INSERT INTO EMP_01(SELECT EMP_ID, EMP_NAME, DEPT_TITLE
                   FROM EMPLOYEE
                   LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID));

SELECT * FROM EMP_01;

-----------------------------------------------------------------------------------------------------------------------

/*
    2. INSERT ALL
       �ΰ� �̻��� ���̺� ���� INSERT�� �� ���
       ��, �� �� ���Ǵ� ���������� ������ ���
*/

-- ���̺� ����
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
   FROM EMPLOYEE
   WHERE 0 = 1;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
   FROM EMPLOYEE
   WHERE 1 = 0;

SELECT * FROM EMP_DEPT;      -- EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
SELECT * FROM EMP_MANAGER;   -- EMP_ID, EMP_NAME, MANAGER_ID


-- �μ��ڵ� D1�� ������� ���, �����, �μ��ڵ�, �Ի���, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

/*
    1) 
    INSERT ALL 
    INTO ���̺��1 VALUES(�÷���, �÷���, ...)
    INTO ���̺��2 VALUES(�÷���, �÷���, �÷���, ...)
        ��������;    
*/

INSERT ALL 
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';

SELECT * FROM EMP_DEPT;     
SELECT * FROM EMP_MANAGER;  


-- * ������ ����ؼ��� �� ���̺� INSERT ����

-- 2000�⵵ ������ �Ի��� �Ի��ڵ��� ������ ���̺�
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1=0;
   
-- 2000�⵵ ���Ŀ� �Ի��� �Ի��ڵ��� ������ ���̺�
CREATE TABLE EMP_NEW 
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1=0;
   
SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;
   
/*
    2) 
    INSERT ALL
    WHEN ����1 THEN 
        INTO ���̺��1 VALUES(�÷���, �÷���, �÷���)
    WHEN ����2 THEN
        INTO ���̺��2 VALUES(�÷���, �÷���, �÷���)
    ��������;
*/
   
INSERT ALL
WHEN HIRE_DATE < '2000/01/01' THEN 
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2000/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

----------------------------------------------------------------------------------------------------------------------------

/*
    3. UPDATE
       ���̺� ��ϵǾ��ִ� �����͸� �����ϴ� ����
       
       [ǥ����]
       UPDATE ���̺�� 
       SET �÷��� = �ٲܰ�,
           �÷��� = �ٲܰ�, ... --> �������� �÷��� ���ú��� ���� (,�� ����!! AND�ƴ�!!)
       [WHERE ���ǽ�]; --> WHERE�� �����ϸ� ��ü ��� ���� �����Ͱ� ����Ǿ����!!
*/

-- ���纻 ���̺� ���� �� �۾�
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- DEPT_ID�� D9�� �μ����� '������ȹ��'���� ����
UPDATE DEPT_COPY
SET DEPT_TITLE = '������ȹ��'
WHERE DEPT_ID = 'D9'; 

SELECT * FROM DEPT_COPY;

ROLLBACK;

-- ���纻 ���� 
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
   FROM EMPLOYEE;

SELECT * FROM EMP_SALARY;

-- ���ö����� �޿��� 1000000������ ����
UPDATE EMP_SALARY 
SET SALARY = 1000000
WHERE EMP_NAME = '���ö';

SELECT * FROM EMP_SALARY;

-- �����ϻ���� �޿��� 700��������, ���ʽ��� 0.2�� ����
UPDATE EMP_SALARY
   SET SALARY = 7000000 
     , BONUS = 0.2
WHERE EMP_NAME = '������';

SELECT * FROM EMP_SALARY;

-- ��� ����� �޿��� ������ �޿��� 10%�λ��� �ݾ�(�����޿� * 1.1)���� ���� 
UPDATE EMP_SALARY
   SET SALARY = SALARY * 1.1;

SELECT * FROM EMP_SALARY;

-- * UPDATE�ÿ� �������� ��� ����
--  ��, ���������� ������ ��������� �����ϰڴ�
/*
    UPDATE ���̺��
       SET �÷��� = (��������)
    [WHERE ���ǽ�];
*/

-- ��������� �޿��� ���ʽ����� ����Ļ���� �޿��� ���ʽ������� ����
UPDATE EMP_SALARY 
   SET SALARY = (
                 SELECT SALARY
                   FROM EMP_SALARY
                  WHERE EMP_NAME = '�����'
                )
     , BONUS = (
                SELECT BONUS 
                  FROM EMP_SALARY
                 WHERE EMP_NAME = '�����'
               )
 WHERE EMP_NAME = '����';

UPDATE EMP_SALARY 
   SET (SALARY, BONUS) = (
                           SELECT SALARY, BONUS
                             FROM EMP_SALARY
                            WHERE EMP_NAME = '�����'
                         )
 WHERE EMP_NAME = '����';


SELECT * FROM EMP_SALARY;

-- ���ö, ������ ������, �ϵ��� ������� �޿��� ���ʽ��� ����Ļ���� �޿��� ���ʽ������� ����
UPDATE EMP_SALARY
   SET (SALARY, BONUS) = (
                          SELECT SALARY, BONUS
                            FROM EMP_SALARY
                           WHERE EMP_NAME = '�����'
                         )
 WHERE EMP_NAME IN ('���ö', '������', '������', '�ϵ���');

SELECT * FROM EMP_SALARY;


-- ASIA �������� �ٹ��ϴ� ������� ���ʽ��� 0.3���� ����

-- ASIA �������� �ٹ��ϴ� ������� ��� ��ȸ
SELECT EMP_ID
FROM EMP_SALARY
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) --> LOCATION_ID
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';

UPDATE EMP_SALARY
   SET BONUS = 0.3
 WHERE EMP_ID IN(
                 SELECT EMP_ID
                   FROM EMP_SALARY
                   JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) --> LOCATION_ID
                   JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                  WHERE LOCAL_NAME LIKE 'ASIA%'
                );
                
SELECT * FROM EMP_SALARY;

---------------------------------------------------------------------------------------------------------------------
-- < ���� ���õ� >
-- UPDATE�� ������ ���� �ش� �÷��� ���� �������ǿ� ����Ǹ� �ȵ�!
-- �Ӹ� �ƴ϶� DATA TYPE�� �Ű�Ἥ �����ؾߵ�!!
-- ������ ����� �ֹι�ȣ���� NULL�� ����
UPDATE EMPLOYEE
   SET EMP_NO = NULL
 WHERE EMP_NAME = '������'; 

-- ���ö ����� �μ��ڵ带 D0���� ����
UPDATE EMPLOYEE
   SET DEPT_CODE = 'D0'
 WHERE EMP_NAME = '���ö';

-- �ɺ��� ����� ��ȭ��ȣ�� '010-1111-2222'�� ����
UPDATE EMPLOYEE
   SET PHONE = '010-1111-2222'
 WHERE EMP_NAME = '�ɺ���';

----------------------------------------------------------------------------------------------------------------------

COMMIT;

/*
    4. DELETE 
       ���̺� ��ϵ� �����͸� �����ϴ� ���� (�� ��ü�� ������)
       
       [ǥ����]
       DELETE FROM ���̺��
       [WHERE ����];  --> WHERE�� ���� ���ϸ� ��ü �� �� ������!!
       
*/

-- ��ä�� ����� ������ �����
DELETE FROM EMPLOYEE
WHERE EMP_NAME = '��ä��';

SELECT * FROM EMPLOYEE;
ROLLBACK; --> ������ Ŀ�Խ������� ����

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '������';

COMMIT;

-- DEPARTMENT�� ���� D1�� �μ� ����
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';  --> D1�� ���� ������ ���� �ڽĵ����Ͱ� �ֱ� ������ ���� �ȵ�!! (���� ���� �ɷ�����)

-- D3�� �μ� ����
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D3';

SELECT * FROM DEPARTMENT;

ROLLBACK;


-- * TRUNCATE(DDL) : ���̺��� ��ü���� ������ �� ���Ǵ� ���� (DELETE���� ����ӵ��� ����)
--   [ǥ����] TRUNCATE TABLE ���̺��;  -- ������ ���� ���� �Ұ�

-- ������ �� : DELETE�� ROLLBACK�� ���������� TRUNCATE�� ROLLBACK�Ұ�!!
SELECT * FROM EMP_SALARY;
DELETE FROM EMP_SALARY;
ROLLBACK;

TRUNCATE TABLE EMP_SALARY;


