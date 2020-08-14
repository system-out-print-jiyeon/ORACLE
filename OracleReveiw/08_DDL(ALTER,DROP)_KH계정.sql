/*
    * DDL (DATA DEFINITION LANGUAGES)

    < ALTER >
    ��ü���� �����ϴ� ����
    
    >> ���̺� ����
    
    [ǥ����]
    ALTER TABLE ���̺�� �����ҳ���;
    
    - ������ ���� -
    1) �÷� �߰�/����/����
    2) �������� �߰�/����   => ������ �Ұ� (�����ϰ��� �Ѵٸ� ������ �� ������ �߰��ؾߵ�)
    3) ���̺��/�÷���/�������Ǹ� ����
    
*/

-- 1) �÷� �߰�/����/����
-- 1_1) �÷� �߰�(ADD) : ADD �÷��� ������Ÿ�� [DEFAULT �⺻��]
SELECT * FROM DEPT_COPY;

-- CNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
--> ���ο� �÷��� ��������� �⺻������ NULL������ ä����

-- LNAME �÷� �߰� (�⺻�� ������ ä��)
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';
--> ���ο� �÷��� ��������� ���� ������ �⺻������ ä����


-- 1_2) �÷� ���� (MODIFY)
--      ������ Ÿ�� ���� : MODIFY �÷��� �ٲٰ����ϴµ�����Ÿ��
--          �⺻�� ���� : MODIFY �÷��� DEFAULT �ٲٰ����ϴ±⺻��
SELECT * FROM DEPT_COPY;

-- DEPT_ID �÷��� ������ Ÿ���� CHAR(3)�� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
-- ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER; (����Ұ�!! ������)
-- ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10); (�����Ͱ� �ʰ�!! ������)

-- DEPT_TITLE �÷��� ������ Ÿ���� VARCHAR2(40)��,
-- LOCATION_ID �÷��� ������ Ÿ���� VARCHAR2(2)��,
-- LNAME �÷��� �⺻���� '�̱�'����
ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY LNAME DEFAULT '�̱�';
--> ���� ���� ����



-- 1_3) �÷� ���� (DROP COLUMN) : DROP COLUMN �����ϰ����ϴ��÷���
--                    ������ �� : ���̺��� �ּ� �Ѱ��� �÷��� �����ؾߵ�

CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

-- DEPT_ID �÷� �����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;

-- DEPT_TITLE, CNAME, LNAME �÷��� �����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;

ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;   --> �ּ� �Ѱ��� �÷��� �־�߸� �� (������!!)

ALTER TABLE DEPARTMENT DROP COLUMN DEPT_ID;       --> �θ�Ű ������ �� ���� (������!!)
--> �����ǰ� �ִ� �÷��̶�� ���� �Ұ���

-----------------------------------------------------------------------------------------------------------------






































