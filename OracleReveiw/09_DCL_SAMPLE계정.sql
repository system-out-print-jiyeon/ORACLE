

-- CREATE TABLE �� �� �ִ� ������ ��� ���� �߻�
-- 3_1. CREATE TABLE ���� �ο� ����
-- 3_2. TABLESPACE �Ҵ� ����
CREATE TABLE TEST(
    TEST_ID NUMBER
);

-- ������ �����ϰ� �ִ� ���̺���� �ٷ� ���� ����
SELECT * FROM TEST;
INSERT INTO TEST VALUES(10);

-- �� ��ü�� ������ �� �ִ� CREATE VIEW ������ ���� ������
-- 4. CREATE VIEW ���� �ο�����
CREATE VIEW V_TEST 
AS SELECT * FROM TEST;

------------------------------------------------------------------------------------------------------------
-- �ٸ� ������ ���̺� ������ �� �ִ� ������ ���� ������ �߻��� ����
-- 5. KH.EMPLOYEE�� SELECT ���� �ο�����
SELECT * FROM KH.EMPLOYEE;
SELECT * FROM KH.DEPARTMENT; --> ���Ѿ���, ������

-- 6. KH.DEPARTMENT�� INSERT ���� �ο�����

INSERT INTO KH.DEPARTMENT 
VALUES('D0', 'ȸ���', 'L2');

ROLLBACK;

































