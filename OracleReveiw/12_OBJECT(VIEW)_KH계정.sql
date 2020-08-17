/*
    < VIEW �� >
    
    SELECT��(������)�� �����ص� �� �ִ� ��ü (���� ���� �� SELECT���� �����صθ� �� SELECT���� �Ź� �ٽ� ��� �� �ʿ����) 
*/

-- '�ѱ�'���� �ٹ��ϴ� ����� ���, �̸�, �μ���, �޿�, �ٹ��������� ��ȸ�Ͻÿ�
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) 
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '�ѱ�';


-- '���þ�'���� �ٹ��ϴ� ����� ���, �̸�, �μ���, �޿�, �ٹ��������� ��ȸ�Ͻÿ�
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '���þ�';

-------------------------------------------------------------------------------

/*
    1. VIEW ���� ���
    
    [ǥ����]
    CREATE [OR REPLACE] VIEW ��� 
    AS ��������;
    
    [OR REPLACE] : �� ������ ������ �ߺ��� �䰡 ���ٸ� ������ �並 �����ϰ�,
                            ������ �ߺ��� �䰡 �ִٸ� �ش� �並 ����(����)�ϴ� Ű����
    
*/

CREATE OR REPLACE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME 
   FROM EMPLOYEE
   JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
   JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
   JOIN NATIONAL USING(NATIONAL_CODE)
   JOIN JOB USING(JOB_CODE);
   
--> ó�� ������ CREATE VIEW ������ ������ ������ ���ѹ���! => CREATE VIEW ���Ѻο��޾ƾߵ�

SELECT * 
FROM VW_EMPLOYEE;

-- �ѱ����� �ٹ��ϴ� ���
SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�ѱ�';

-- ���þƿ��� �ٹ��ϴ� ���
SELECT EMP_NAME, SALARY--, BONUS
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '���þ�';

-- �߱����� �ٹ��ϴ� ���
SELECT * 
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�߱�';

-- ��� ������ �������̺� --> ���������� �����͸� �����ϰ� ���� ���� (�ܼ��� �������� TEXT������ ����Ǿ��ִ°� ��)

-- [����] �ش� ������ ������ �ִ� VIEW�鿡 ���� ���� ��ȸ�� ���Ǵ� �ý��� ���̺�
SELECT * FROM USER_VIEWS;

-------------------------------------------------------------------------------

-- * �� �÷��� ��Ī �ο�
--   ���������� SELECT ���� �Լ����̳� ���������� ����Ǿ��ִ� ��� �ݵ�� ��Ī ����!!

-- ����� ���, �̸�, ���޸�, ����, �ٹ������ ��ȸ�� �� �ִ� SELECT���� ��� ����
CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
          DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') "����",
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "�ٹ����"
   FROM EMPLOYEE
   JOIN JOB USING(JOB_CODE);

CREATE OR REPLACE VIEW VW_EMP_JOB(���, �����, ���޸�, ����, �ٹ����) --> ��� �÷��� ���� ��Ī �ο��ؾߵ�
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
          DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��'),
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
   FROM EMPLOYEE
   JOIN JOB USING(JOB_CODE);

SELECT �����, �ٹ����
FROM VW_EMP_JOB;

SELECT �����, �ٹ����
FROM VW_EMP_JOB
WHERE ���� = '��';

SELECT * 
FROM VW_EMP_JOB
WHERE �ٹ���� >= 20;

-- �� ���� �ϰ��� �Ѵٸ�
DROP VIEW VW_EMP_JOB;

------------------------------------------------------------------------------

-- ������ �並 �̿��ؼ� DML(INSERT, UPDATE, DELETE) ��밡��
-- �並 ���ؼ� �����ϰ� �Ǹ� ���� �����Ͱ� ����ִ� ���̽����̺� ���� ��

CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
    FROM JOB;
    
SELECT * FROM VW_JOB;
SELECT * FROM JOB;

-- �信 INSERT
INSERT INTO VW_JOB VALUES('J8', '����');  --> ���̽����̺� �� INSERT

-- ��� UPDATE (J8 ���޸��� '�˹�'�� ����)
UPDATE VW_JOB
SET JOB_NAME = '�˹�'
WHERE JOB_CODE = 'J8';      --> ���̽����̺� �� UPDATE

-- �信 DELETE
DELETE FROM VW_JOB
WHERE JOB_CODE = 'J8';      --> ���̽����̺� �� DELETE

-------------------------------------------------------------------------------

/*
    * ������ DML ��ɾ�� ������ �Ұ����� ��찡 �� ����..��
    
    1) �信 ���ǵǾ����� ���� �÷��� �����ϴ� ���
    2) �信 ���ǵǾ����� ���� �÷� �߿� ���̽����̺� �� NOT NULL���������� ������ ���
    3) �������� �Ǵ� �Լ������� ���ǵ� ���
    4) �׷��Լ��� GROUP BY���� ���Ե� ���
    5) DISTINCT ������ ���Ե� ���
    6) JOIN�� �̿��ؼ� ���� ���̺��� ������ѳ��� ���
*/

-- 1) �信 ���ǵǾ� ���� ���� �÷��� �����ϴ� ���
CREATE OR REPLACE VIEW VW_JOB2
AS SELECT JOB_CODE
   FROM JOB;
   
SELECT * FROM VW_JOB2;

-- INSERT
INSERT INTO VW_JOB2(JOB_CODE, JOB_NAME) VALUES('J8', '����');

-- J7 ���޸��� �������� ����
-- UPDATE
UPDATE VW_JOB2
SET JOB_NAME = '����'
WHERE JOB_CODE = 'J7';

-- DELETE 
DELETE FROM VW_JOB2
WHERE JOB_NAME = '���';

-- 2) �信 ���ǵǾ����� ���� �÷� �߿��� NOT NULL ���������� ������ ���
CREATE OR REPLACE VIEW VW_JOB3
AS SELECT JOB_NAME
   FROM JOB;
   
SELECT * FROM VW_JOB3;

-- INSERT 
INSERT INTO VW_JOB3 VALUES('����');
--> ���̽����̺��� JOB�� JOB_CODE�� �⺻������ NULL�� �������� �� (��, JOB_CODE PRIMARY KEY ���������� �ɷ�����)

SELECT * FROM JOB;
-- UPDATE
-- ����� �˹ٷ� ����
UPDATE VW_JOB3
SET JOB_NAME = '�˹�'
WHERE JOB_NAME = '���';

ROLLBACK;

INSERT INTO JOB VALUES('J8', '����');

-- DELETE 
DELETE FROM VW_JOB3
WHERE JOB_NAME = '����';


-- 3) �Լ��� �Ǵ� ������������ ���ǵ� ���

-- ����� ���, �����, �޿�, ������ ���ؼ� ��ȸ�ϴ� ��
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 "����"
   FROM EMPLOYEE;
   
SELECT * FROM VW_EMP_SAL;

-- INSERT 
INSERT INTO VW_EMP_SAL(EMP_ID, EMP_NAME, SALARY) VALUES(400, '������', 3000000);

-- UPDATE (200�� ����� ������ 8000��������)
UPDATE VW_EMP_SAL
SET ���� = 80000000
WHERE EMP_ID = 200;

-- UPDATE (200�� ����� �޿��� 700��������)
UPDATE VW_EMP_SAL
SET SALARY = 7000000
WHERE EMP_ID = 200;

SELECT * FROM EMPLOYEE;

-- DELETE
-- ������ 7200������ ��� �����
DELETE FROM VW_EMP_SAL
WHERE ���� = 72000000;

ROLLBACK;


-- 4) �׷��Լ� �Ǵ� GROUP BY ���� ������ ���

-- �μ��� �޿���, �޿���� ��ȸ�ϴ� ��
CREATE OR REPLACE VIEW VW_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) �հ�, FLOOR(AVG(SALARY)) ���
   FROM EMPLOYEE
   GROUP BY DEPT_CODE;
   
SELECT * FROM VW_GROUPDEPT;

-- INSERT
INSERT INTO VW_GROUPDEPT VALUES('D0', 8000000, 4000000);

-- UPDATE (�μ��ڵ尡 D1�� D0���� ����)
UPDATE VW_GROUPDEPT
SET DEPT_CODE = 'D0'
WHERE DEPT_CODE = 'D1';

-- DELETE (�μ��ڵ尡 D1�ΰ� �����)
DELETE FROM VW_GROUPDEPT
WHERE DEPT_CODE = 'D1';


-- 5) DISTINCT�� ���Ե� ���
CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT JOB_CODE
   FROM EMPLOYEE;

SELECT * FROM VW_DT_JOB;

-- INSERT
INSERT INTO VW_DT_JOB VALUES('J8');

-- UPDATE(J7 --> J8)
UPDATE VW_DT_JOB
SET JOB_CODE = 'J8'
WHERE JOB_CODE = 'J7';

-- DELETE (J2 �����)
DELETE FROM VW_DT_JOB
WHERE JOB_CODE = 'J2';


-- 6) JOIN�� �̿��� ���� ���̺��� ������ ���

CREATE OR REPLACE VIEW VW_JOINEMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
   FROM EMPLOYEE
   JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
   
SELECT * FROM VW_JOINEMP;

-- INSERT 
INSERT INTO VW_JOINEMP VALUES(888, '������', '�ѹ���');

-- UPDATE (200�� ����� �̸��� ������ ����)
UPDATE VW_JOINEMP
SET EMP_NAME = '������'
WHERE EMP_ID = 200;

SELECT * FROM EMPLOYEE;

-- UPDATE(�ѹ��θ� �ѹ�1������ ����)
UPDATE VW_JOINEMP
SET DEPT_TITLE = '�ѹ�1��'
WHERE DEPT_TITLE = '�ѹ���';

-- DELETE (200�� ��� �����)
DELETE FROM VW_JOINEMP
WHERE EMP_ID = 200;

ROLLBACK;

SELECT * FROM EMPLOYEE;

------------------------------------------------------------------------------

/*
    * VIEW �ɼ�
    
    [��ǥ����]
    CREATE [OR REPLACE] [FORCE|"NOFORCE"] VIEW ���
    AS ��������
    [WITH CHECK OPTION]
    [WITH READ ONLY];
    
    1) OR REPLACE �ɼ� : ������ ������ �䰡 ���� ��� �����, �������� ������ ������ ���������ִ�
    2) FORCE / NOFORCE �ɼ�
       > FORCE : ���������� ����� ���̺��� �������� �ʴ� ���̺��̿��� �䰡 �����ǰ� �ϴ�
       > NOFORCE : ���������� ����� ���̺��� �����ؾ߸� �䰡 ���� (������ �⺻��)
    3) WITH CHECK OPTION �ɼ� : ���������� ����� ���ǿ� �������� ���� ������ �����ϴ� ��� ���� �߻�
    4) WITH READ ONLY �ɼ� : �信 ���� ��ȸ�� ���� (DML ���� �Ұ�) 
    
*/

-- 2) FORCE / NOFORCE �ɼ�
-- NOFORCE : ���������� ����� ���̺��� �����ؾ߸� �䰡 ���� (������ �⺻��)
CREATE OR REPLACE /*NOFORCE*/ VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
   FROM TT;
   
-- FORCE : ���������� ����� ���̺��� �������� �ʴ� ���̺��̿��� �䰡 �����ǰ� �ϴ�
CREATE OR REPLACE FORCE VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
   FROM TT;
--> ������ ������ �Բ� �䰡 �����Ǿ����ϴ�.
   
SELECT * FROM VW_EMP;

CREATE TABLE TT( --> TT ���̺��� �����ؾ߸� �׶����� VIEW ��ȸ ����
    TCODE NUMBER,
    TNAME VARCHAR2(30),
    TCONTENT VARCHAR2(50)
);

-- 3) WITH CHECK OPTION �ɼ� : ���������� ����� ���ǿ� ���յ��� ���� ������ �����ϴ� ��� ���� �߻�

-- �޿��� 300���� �̻��� ���
CREATE OR REPLACE VIEW VW_EMP2
AS SELECT *
   FROM EMPLOYEE
   WHERE SALARY >= 3000000;

SELECT * FROM VW_EMP2; ---> 8�� ��ȸ

-- 200�� ����� �޿��� 200�������� ���� --> ���������� ���ǿ� �������� �ʾƵ� �� ���� ��!!
UPDATE VW_EMP2
SET SALARY = 2000000
WHERE EMP_ID = 200;

ROLLBACK;

SELECT * FROM EMPLOYEE;


CREATE OR REPLACE VIEW VW_EMP2
AS SELECT *
   FROM EMPLOYEE
   WHERE SALARY >= 3000000
WITH CHECK OPTION;

SELECT * FROM VW_EMP2; --> 8��

UPDATE VW_EMP2
SET SALARY = 2000000  --> ���������� ����� ���ǿ� �������� �ʱ⶧���� ���� �Ұ�
WHERE EMP_ID = 200;

UPDATE VW_EMP2
SET SALARY = 4000000  --> ���������� ����� ���ǿ� �����ϱ� ������ ���� ����
WHERE EMP_ID = 200;

SELECT * FROM EMPLOYEE;

ROLLBACK;

-- 4) WITH READ ONLY : �信 ���� ��ȸ�� ���� (DML ����Ұ�)

CREATE OR REPLACE VIEW VW_EMPBONUS
AS SELECT EMP_ID, EMP_NAME, BONUS
   FROM EMPLOYEE
   WHERE BONUS IS NOT NULL
WITH READ ONLY;

SELECT * FROM VW_EMPBONUS;

DELETE FROM VW_EMPBONUS
WHERE EMP_ID = 200;































