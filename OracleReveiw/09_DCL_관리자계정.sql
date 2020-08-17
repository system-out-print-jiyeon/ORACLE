/*
    < DCL : DATA CONTROL LANGUAGE >
    �����͸� �����ϴ� ���
    
    �������� �ý��۱��� �Ǵ� ��ü���ٱ����� �ο�(GRANT)�ϰų� ȸ��(REVOKE)�ϴ� ���
    
    > �ý��۱��� : DB�� �����ϴ� ����, ��ü�� ������ �� �ִ� ����
    > ��ü���ٱ��� : Ư�� ��ü�� ������ �� �ִ� ����
    
    
    > �ý��۱��� ���� <
    - CREATE SESSION : ������ ������ �� �ִ� ����
    - CREATE TABLE : ���̺��� ������ �� �ִ� ����
    - CREATE VIEW : �� ������ �� �ִ� ����
    - CREATE SEQUENCE : ������ ������ �� �ִ� ����
    - CREATE USER : ���� ������ �� �ִ� ����
    - ....
    
    [ǥ����]
    GRANT ����1, ����2, .. TO ������;
    
    
*/

-- 1. SAMPLE ���� ����
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;

-- 2. ������ �����ϱ� ���ؼ� CREATE SESSION ���� �ο�
GRANT CREATE SESSION TO SAMPLE;

-- 3_1. ������ ���̺��� ������ �� �ִ� CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO SAMPLE;
-- 3_2. ���̺� �����̽� �Ҵ�����ߵ�! (SAMPLE ���� ����)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;

-- 4. ������ �並 ������ �� �ִ� CREATE VIEW ���� �ο��ϱ�
GRANT CREATE VIEW TO SAMPLE;

-------------------------------------------------------------------------------------------------------------------

/*
    > ��ü ���� ���� <
    Ư�� ��ü�� ������ �� �ִ� ���� 
    
    ��������        Ư����ü
    SELECT      TABLE, VIEW, SEQUENCE
    INSERT      TABLE, VIEW
    UPDATE      TABLE, VIEW
    DELETE      TABLE, VIEW
    ...
    
    [ǥ���]
    GRANT �������� ON Ư����ü TO ������;

*/

-- 5. �������� KH.EMPLOYEE���̺� ��ȸ(SELECT)�� �� �ִ� ���� �ο��ϱ�
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

-- 6. �������� KH.DEPARTMENT���̺� ����(INSERT)�� �� �ִ� ���� �ο��ϱ�
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

---------------------------------------------------------------------------------------------------

GRANT CONNECT, RESOUCE TO ������;

/*
    < �� ROLE >
    Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ��� ��
    
    CONNECT : CREATE SESSION (�����ͺ��̽��� ������ �� �ִ� ����)
    RESOURCE : CREATE TABLE, CREATE SEQUENCE, .... (Ư�� ��ü���� ������ �� �ִ� ����)   

*/

SELECT * 
FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT', 'RESOURCE') ;

-- �Ϲ� ���� ���� ��, CONNECT, RESOUCE ������ �ּ����� ���Ѹ� �ο��Ѱ��̿���













