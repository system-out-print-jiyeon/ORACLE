/*
    
    DML (MANIPULATION ����) : SELECT, INSERT, UPDATE, DELETE 
    DDL (DEFINITION ����)   : CREATE, ALTER, DROP
    DCL (CONTROL ����)      : GRANT, REVOKE, COMMIT, ROLLBACK
    
    DQL (QUERY ����) : SELECT
    DML              : INSERT, UPDATE, DELETE
    DDL              : CREATE, ALTER, DROP
    DCL              : GRANT, REVOKE
    TCL (TRANSACTION): COMMIT, ROLLBACK 

    * DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
    ����Ŭ���� �����ϴ� ��ü(OBJECT)���� 
    ������ �����(CREATE), ������ ����(ALTER), ���� ��ü�� ����(DROP)�ϴ� ����
    
    �ַ� DB������, �����ڰ� ����ϴ� ����
    
    ����Ŭ������ ��ü (����) : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE),
                            �ε���(INDEX), ��Ű��(PAKAGE), Ʈ����(TRIGGER),
                            ���ν���(PROCEDURE), �Լ�(FUNCTION), 
                            ���Ǿ�(SYNONYM), �����(USER)
                            
                            
    < CREATE >
    �پ��� ��ü(����)�� �����ϴ� ����
    
    1. ���̺� ���� 
    - ���̺�? : ��(ROW)�� ��(COLUMN)�� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
               �����͵��� �����ϱ� ���� ���� �ٽ����� ��ü
               
    [ǥ����]
    CREATE TABLE ���̺��(
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���,
        ...
    );
    
    * �ڷ��� (DATA TYPE)
    
    - ���� (CHAR(ũ��) / VARCHAR2(ũ��))
    > CHAR(ũ��) : �ִ� 2000BYTE ���� ���� ���� / �������� (�ƹ��� ���� ���� ���͵� ó�� �Ҵ��� ũ�� �״��)
    > VARCHAR2(ũ��) : �ִ� 4000BYTE ���� ���� ���� / �������� (��� ���� ���� ������ ũ�� ������)
    
    - ���� (NUMBER)
    
    - ��¥ (DATE)
    
*/

--> ȸ���� ���� �����͸� ������� ���̺� MEMBER �����ϱ�
CREATE TABLE MEMBER(
    MEM_NO NUMBER,          -- ȸ�� ��ȣ
    MEM_ID VARCHAR2(20),    -- ȸ�� ���̵�
    MEM_PWD VARCHAR2(20),   -- ȸ�� ��й�ȣ
    MEM_NAME VARCHAR2(20),  -- ȸ����
    GENDER CHAR(3),         -- ����
    PHONE CHAR(13),         -- ��ȭ��ȣ
    EMAIL VARCHAR2(50),     -- �̸���
    MEM_DATE DATE           -- ȸ��������
    
);

SELECT * FROM MEMBER;

-------------------------------------------------------------------------------------------------

/*
    2. �÷��� �ּ� �ޱ� (�÷��� ���� ��������)
    
    [ǥ����]
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
    
*/

COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ����';
COMMENT ON COLUMN MEMBER.GENDER IS '����(��/��)';
COMMENT ON COLUMN MEMBER.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.MEM_DATE IS 'ȸ��������';




-- ������ ��ųʸ� : �پ��� ��ü���� ������ �����ϰ� �ִ� �ý��� ���̺� (�̹� ����) --
-- [����] USER_TABLES : �� ����ڰ� �������ִ� ���̺���� �������� ������ Ȯ���� �� �ִ� �ý��� ���̺�
SELECT * FROM USER_TABLES;
-- [����] USER_TAB_COLUMNS : ���̺�� ���ǵǾ��ִ� ��� �÷��� �������� ������ Ȯ���� �� �ִ� �ý��� ���̺�
SELECT * FROM USER_TAB_COLUMNS;

SELECT * FROM MEMBER;

-- ������ �߰��� �� �ִ� ����
-- INSERT INTO ���̺�� VALUES(�÷���, �÷���, �÷��� ... );

INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', null, SYSDATE);
SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES(2, 'user02', 'pass02', 'ȫ���', '��', '010-1111-2222', null, '19/07/21');
SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
SELECT * FROM MEMBER; 

/*
    < �������� CONSTRAINTS >
    - ���ϴ� �����Ͱ�(��ȿ�� ��)�� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
    - ������ ���Ἲ ������ �������� �Ѵ�.
    - ���� �����Ͱ��� ������ ������ �ڵ����� �˻��� ����
    
    * ���� : NOT NULL, UNIQUE, CHECK(����), PRIMARY KEY, FOREIGN KEY
*/

/*
    * NOT NULL ��������
      �ش� �÷��� �ݵ�� ���� �־�߸� �ϴ� ��� ��� (�ش� �÷��� NULL���� ���ͼ��� �ȵǴ� ���)
      ����/������ NULL���� ������� �ʵ��� ����
*/

-- ���������� �ο��ϴ� ����� ũ�� 2���� ���� (�÷�������� / ���̺������)
-- NOT NULL �������� �ο��� ������ �÷����� ��Ĺۿ� �ȵ� �Ф�
-- �÷����� ��� : �÷��� �ڷ���[(ũ��)] �������� 
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', null, NULL);
INSERT INTO MEM_NOTNULL VALUES(2, 'user02', 'pass02', '�踻��', NULL, NULL, NULL);
--> NOT NULL �������ǿ� ����Ǿ� ���� �߻���!! (���� �ǵ��ߴ����)


INSERT INTO MEM_NOTNULL
VALUES(3, 'user01', 'pass03', 'ȫ���', '��', '010-2222-3333', 'aaa@naver.com'); 
--> ���̵� �ߺ��������� �ұ��ϰ� ���������� ���Ե�!!
SELECT * FROM MEM_NOTNULL;


----------------------------------------------------------------------------------------------------

/*
    * UNIQUE ��������
      �÷����� �ߺ����� �����ϴ� ��������
      ����/������ ������ �ִ� �����Ͱ� �߿� �ߺ����� ���� ��� ���� �߻�
      
      �÷�������� / ���̺������ �� �� ��� ����
*/

DROP TABLE MEM_UNIQUE;
/*
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR(20) NOT NULL UNIQUE, --> �÷�������� (�ٷεڿ� ���)
    MEM_PWD VARCHAR(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50)
);
*/
-- ���̺� ���� ��� : ��������(�÷���)
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR(20) NOT NULL,
    MEM_PWD VARCHAR(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID)      --> ���̺������
    
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', null, NULL);
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '�踻��', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE VALUES(3, 'user01', 'pass03', 'ȫ���', NULL, NULL, NULL); 
--> UNIQUE �������ǿ� ����Ǿ����Ƿ� INSERT ����!!
--> ���� ������ �������Ǹ����� �˷���!! (Ư�� �÷��� � ���������� ����Ǿ����� ���� �˷����� ����..)
--> ���� �ľ��ϱ� �����.. (�������Ǹ��� ���������� ������ �ý��ۿ��� �˾Ƽ� ������ �������Ǹ��� �ο��ع���..)

/*
    * �������Ǹ���� �̸������ָ鼭 ���������� �ο��ϴ� ǥ����
    > �÷� ���� ���
    CREATE TABLE ���̺��(
        �÷��� �ڷ���(ũ��) [CONSTRAINT �������Ǹ�] ��������,
        �÷��� �ڷ���
    );
    
    > ���̺� ���� ���
    CREATE TABLE ���̺��(
        �÷��� �ڷ���(ũ��)
        �÷��� �ڷ���,
        [CONSTRAINT �������Ǹ�] ��������(�÷���)
    );
    
*/

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEM_NO_NN NOT NULL,
    MEM_ID VARCHAR(20) CONSTRAINT MEM_ID_NN NOT NULL,
    MEM_PWD VARCHAR(20) CONSTRAINT MEM_PWD_NN NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEM_ID_UQ UNIQUE(MEM_ID)
);
INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', null, NULL);
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '�踻��', NULL, NULL, NULL);


INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pass03', 'ȫ���', '��', NULL, NULL); 
--> ������ ��ȿ�� ���� �ƴѰ��� �־ �� INSERT �Ǿ����! �Ф�

SELECT * FROM MEM_UNIQUE;

---------------------------------------------------------------------------------------------

/*
    * CHECK(����) ��������
      �÷��� ���� ���� ���� ������ �����ص� �� ����
      �ش� ���ǿ� �����ϴ� �����Ͱ��� ��� �� ����
    
*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CONSTRAINT GENDER_CK CHECK(GENDER IN('��', '��')), -- �÷����� ���
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID)
    -- , CONSTRAINT GENDER_CK CHECK(GENDER IN ('��', '��'))   ���̺��� ���
);

INSERT INTO MEM_CHECK VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', null, NULL);
INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pass02', '�踻��', NULL, NULL, NULL);
INSERT INTO MEM_CHECK VALUES(3, 'user03', 'pass03', 'ȫ���', '��', null, null);
--> GENDER �÷��� ���� ���´ٸ� '��' �Ǵ� '��'�� ����
--> �Ӹ� �ƴ϶� NULL���� INSERT����!!
--> ���࿡ NULL���� �������Բ� �ϰ��� �Ѵٸ� NOT NULL �������ǵ� ���� �ο��ϸ� ��!!

INSERT INTO MEM_CHECK VALUES(3, 'user04', 'pass04', '�踻��', '��', '010-1111-2222', 'bbb@naver.com');
--> ȸ����ȣ�� �����ص� ���������� INSERT ��...

 
SELECT * FROM MEM_CHECK;

-------------------------------------------------------------------------------------------------

/*
    * PRIMARY KEY (�⺻Ű) ��������
      ���̺��� �� ���� ������ �ĺ��ϱ� ���� ����� �÷��� �ο��ϴ� �������� (�ĺ����� ����)
      EX) �й�, ȸ����ȣ, �����ȣ, �μ��ڵ�, �����ڵ�, �ֹ���ȣ, �����ȣ, ������ȣ
      
      PRIMARY KEY ���������� �ο��ϰ� �Ǹ�
      �ش� �� �÷��� NOT NULL + UNIQUE ���������� �ǹ�
      
      ������ �� : �� ���̺�� �� ���� ���� ����
      
*/

CREATE TABLE MEM_PRIMARYKEY(
    MEM_NO NUMBER CONSTRAINT MEM_NO_PK PRIMARY KEY,     --> �÷����� ��� 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,        --> ȸ����ȣ�� �ƴ϶� ���̵� ���� �ĺ��� ���� �����ϱ��� (��üŰ)
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    CHECK(GENDER IN('��', '��'))      --> ���̺��� ���
    -- ,CONSTRAINT MEM_NO_PK PRIMARY KEY(MEM_NO)     --> PRIMARY KEY�� ���̺��� ��� (�� �� �ϳ��� �ؾߵǱ⶧���� �ּ�ó��)
);

INSERT INTO MEM_PRIMARYKEY
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', null, null);

INSERT INTO MEM_PRIMARYKEY
VALUES(null, 'user02', 'pass02', '�̼���', null, null, null);
--> �⺻Ű�� null�� �������� �� �� ��������

INSERT INTO MEM_PRIMARYKEY
VALUES(1, 'user02', 'pass02', '�̼���', null, null, null);
--> �⺻Ű�� �ߺ����� �������� �� �� ��������

--> PRIMARY KEY = NOT NULL + UNIQUE
INSERT INTO MEM_PRIMARYKEY
VALUES(2, 'user02', 'pass02', '�̼���', null, null, null);
SELECT * FROM MEM_PRIMARYKEY;


--- * ������ �� : �� ���̺�� �Ѱ��� PRIMARY KEY�� ����!!
CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),   
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    CHECK(GENDER IN('��', '��')),
    PRIMARY KEY(MEM_NO, MEM_ID)  --> ��� PRIMARY KEY �������� �ο����� (����Ű)
);

INSERT INTO MEM_PRIMARYKEY2
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', null, null);

INSERT INTO MEM_PRIMARYKEY2
VALUES(1, 'user02', 'pass02', 'ȫ���', '��', null, null);

INSERT INTO MEM_PRIMARYKEY2
VALUES(2, 'user02', 'pass03', '�踻��', NULL, null, null);

INSERT INTO MEM_PRIMARYKEY2
VALUES(NULL, 'user03', 'pass04', '�踻��', NULL, null, null);
--> �⺻Ű�� �����ִ� �� �÷����� ���� NULL���� ������ �ȵ�!!

SELECT * FROM MEM_PRIMARYKEY2;



-- ȸ����޿� ���� �����͸� ���� �����ϴ� ���̺�
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO MEM_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES(20, '���ȸ��');
INSERT INTO MEM_GRADE VALUES(30, 'Ư��ȸ��');

SELECT * FROM MEM_GRADE;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3)CHECK(GENDER IN ('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50), 
    GRADE_ID NUMBER     --> ȸ����޹�ȣ ���� ������ �÷� 
);

INSERT INTO MEM VALUES(1, 'user01', 'pass01', 'ȫ�浿', null, null, null, null);
INSERT INTO MEM VALUES(2, 'user02', 'pass02', '�踻��', '��', null, null, 10);
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '�̼���', null, null, null, 40);

SELECT * FROM MEM;

------------------------------------------------------------------------------------------

/*
    * FOREIGN KEY (�ܷ�Ű) ��������
      �ٸ� ���̺� �����ϴ� ���� ���;� �Ǵ� Ư�� Į���� �ο��ϴ� ��������
      
      --> �ٸ� ���̺��� �����Ѵٰ� ǥ��
      --> FOREIGN KEY �������ǿ� ���� ���̺� ���� ���谡 ������!!
      
      > �÷����� ���
        �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] REFERENCES ���������̺�� [(�÷���)]
      
      > ���̺��� ���
        [CONSTRAINT �������Ǹ�] FOREIGN KEY(�÷���) REFERENCES ���������̺��[(�÷���)]
*/

SELECT * FROM MEM_GRADE;

DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3)CHECK(GENDER IN ('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50), 
    GRADE_ID NUMBER REFERENCES MEM_GRADE/*(GRADE_CODE)*/  --> �÷����� ���
    -- FOREIGN KEY (GRADE_ID) REFERENCES MEM_GRADE/*(GRADE_CODE)*/ --> ���̺��� ���
);

INSERT INTO MEM VALUES(1, 'user01', 'pass01', 'ȫ�浿', null, null, null, 10);
INSERT INTO MEM VALUES(2, 'user02', 'pass02', '�踻��', null, null, null, 20);
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '�̼���', null, null, null, 10);
INSERT INTO MEM VALUES(4, 'user04', 'pass04', '���߱�', null, null, null, null);
--> �ܷ�Ű ���������� �ο��� �÷��� �⺻������ NULL�� ��°� ����
INSERT INTO MEM VALUES(5, 'user05', 'pass05', '�Ż��Ӵ�', null, null, null, 40);
--> PARENT KEY�� ã�� �� ���ٴ� ���� �߻�
-- 40�̶�� ���� MEM_GRADE ���̺� GRADE_CODE �÷����� �����ǰ��ִ� ���� �ƴ�

-- �θ����̺�(MEM_GRADE) -|-------<- �ڽ����̺�(MEM)

SELECT * FROM MEM_GRADE;        -- GRADE_CODE
SELECT * FROM MEM;              -- GRADE_ID

-- ȸ����ȣ, ȸ�����̵�, ȸ����, ��޸�
-- ����Ŭ
SELECT MEM_NO, MEM_ID, MEM_NAME, GRADE_NAME
FROM MEM, MEM_GRADE
WHERE GRADE_ID = GRADE_CODE(+);

-- ANSI
SELECT MEM_NO, MEM_ID, MEM_NAME, GRADE_NAME
FROM MEM
FULL JOIN MEM_GRADE ON (GRADE_ID = GRADE_CODE);

--> �ٵ� ������ �θ����̺� (MEM_GRADE)���� �����Ͱ��� ������ �� ���� �߻�!!
SELECT * FROM MEM_GRADE;
SELECT * FROM MEM;

--> 10�� ����� ���ְڴ�!! ������ ����
-- DELETE FROM ���̺�� WHERE ���ǽ�;
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
--> �ڽ����̺�(MEM)�߿� 10�� ����ϰ� �ֱ� ������ ������ �� ����!!
-- �ڽ����̺� ����ϰ� �ִ� ���� ���� ��� �θ����̺�κ��� ������ �ȵǴ� "���� ����" �ɼ��� �ɷ�����!!

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 30;

ROLLBACK;

-------------------------------------------------------------------------------------------------------------

/*
    �θ����̺��� ������ ������ �ڽ����̺��� ���� ��� ó���Ұ����� �ɼ����� ���ص� �� ����!!
    ����? => �ڽ����̺� ������ �� �ܷ�Ű �������� �ο���
    
    * FOREIGN KEY ���� �ɼ�
    
    �����ɼ��� ������ �������� ������ ON DELETE RESTRICTED (���� ����)����  �⺻ ������ �Ǿ�����!!

*/

-- 1) ON DELETE SET NULL : �θ����� ������ �ش� �����͸� ����ϰ� �ִ� �ڽĵ����Ͱ��� NULL������ �����Ű��
DROP TABLE MEM;
CREATE TABLE MEM (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL

);

INSERT INTO MEM VALUES(1, 'user01', 'pass01', 'ȫ�浿', null, null, null, 10);
INSERT INTO MEM VALUES(2, 'user02', 'pass02', '�踻��', null, null, null, 20);
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '�̼���', null, null, null, 10);
INSERT INTO MEM VALUES(4, 'user04', 'pass04', '���߱�', null, null, null, null);


SELECT * FROM MEM;

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;  --> �� ������!! (��, 10�� �����ٰ� �����ִ� �ڽĵ����Ͱ����� �� NULL�� ����)

SELECT * FROM MEM_GRADE;

ROLLBACK;

-- 2) ON DELETE CASCADE : �θ� ������ ������ �ش� �����͸� ������ ���� �ִ� �ڽĵ����͵� ���� �����ع�����
DROP TABLE MEM;
CREATE TABLE MEM (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE

);

INSERT INTO MEM VALUES(1, 'user01', 'pass01', 'ȫ�浿', null, null, null, 10);
INSERT INTO MEM VALUES(2, 'user02', 'pass02', '�踻��', null, null, null, 20);
INSERT INTO MEM VALUES(3, 'user03', 'pass03', '�̼���', null, null, null, 10);
INSERT INTO MEM VALUES(4, 'user04', 'pass04', '���߱�', null, null, null, null);

SELECT * FROM MEM;
SELECT * FROM MEM_GRADE;

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;  --> �� ������ (��, �ش絥���͸� ����ϰ� �ִ� �ڽ����̺� ���� DELETE�Ǿ����!!)

-------------------------------------------------------------------------------------------------------------

/*
    < DEFAULT �⺻�� >
    
    �÷� �������� �ʰ� INSERT�� �⺻���� INSERT�ϰ��� �� �� �����ص� �� �ִ� ��
    (�������� �ƴ�!!)
*/

DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20),
    MEM_AGE NUMBER DEFAULT 20,
    MEM_DATE DATE DEFAULT SYSDATE 

);
SELECT * FROM MEMBER;
-- INSERT INTO ���̺�� VALUES(�÷���, �÷���, �÷���);
INSERT INTO MEMBER VALUES(1, 'ȫ�浿', 20, SYSDATE);

-- INSERT INTO ���̺��(�÷���, �÷���) VALUES(�÷���, �÷���);
INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(2, '�踻��');
--> ������ �ȵ� �÷����� �⺻������ NULL���� ������
--> �ش� �� �÷��� DEFAULT���� �ο��Ǿ����� ��� NULL���� �ƴ� DEFAULT���� ��!!

-- ��ǰ�� ���� �����͸� ������ ���̺�(��ǰ��ȣ, ��ǰ��, �귣���, ����, ������)
CREATE TABLE PRODUCT(
    PRODUCT_NO NUMBER PRIMARY KEY,
    PRODUCT_NAME VARCHAR2(30) NOT NULL,
    BRAND VARCHAR2(20) NOT NULL,
    PRICE NUMBER,
    STOCK NUMBER DEFAULT 10
);

INSERT INTO PRODUCT VALUES(1, '������', '�Ｚ', 1300000, 100);
INSERT INTO PRODUCT(PRODUCT_NO, PRODUCT_NAME, BRAND) VALUES(2, '������12PRO', '����');
INSERT INTO PRODUCT VALUES(3, '�����е�', '����', 2500000, DEFAULT);

SELECT * FROM PRODUCT;

----------------------------------------------------------------------------------------------------------

/*
   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! KH �������� !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
    < SUBQUERY�� �̿��� ���̺� ���� (���̺� ����ߴ� ����) >
    
    [ǥ����]
    CREATE TABLE ���̺��
    AS ��������;
    
*/

-- EMPLOYEE ���̺��� ������ ���ο� ���̺� ����
CREATE TABLE EMPLOYEE_COPY
AS SELECT * 
   FROM EMPLOYEE;
--> �÷�, ����ִ� �����Ͱ�, �������ǰ��� ��� NOT NULL�� �����

SELECT * FROM EMPLOYEE_COPY;


CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS
   FROM EMPLOYEE
   WHERE 1 = 0;     --> ������ FALSE�� ����
-- Ʋ�� �����ϰ������ �����Ͱ����� ���������ʰ���� �� �� ��� ��
-- ������ ����ǰ� ��� �࿡ ���� �Ź� FALSE�̱� ������ �����Ͱ��� ����ȵ�

SELECT * FROM EMPLOYEE_COPY2;


CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 ����
   FROM EMPLOYEE;
--> �������� SELECT���� �������� �Ǵ� �Լ��� ����� ��� �ݵ�� ��Ī �����ؾߵ�!!

SELECT * FROM EMPLOYEE_COPY3;

------------------------------------------------------------------------------------------------------------------
