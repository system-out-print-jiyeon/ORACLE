/*
    < ������ SEQUENCE >
    �ڵ����� ��ȣ �߻������ִ� ������ �ϴ� ��ü
    �������� �ڵ����� ���������� ��������
    
*/

/*
    1. ��������ü ���� ����
    
    [ǥ����]
    CREATE SEQUENCE ��������
    [START WITH ����]         --> ó�� �߻���ų ���۰� ����
    [INCREMENT BY ����]       --> � ������ų���� 
    [MAXVALUE ����]           --> �ִ밪 ����
    [MINVALUE ����]           --> �ּҰ� ����
    [CYCLE | NOCYCLE]         --> �� ��ȯ ���� ����
    [CACHE ����Ʈũ�� | NOCACHE] --> ĳ�ø޸� �Ҵ� (�⺻�� 20����Ʈ)

    * ĳ�ø޸� : �̸� �߻��� ������ �����ؼ� �����ص�
                  �Ź� ȣ���� ������ ������ ��ȣ�� �����ϴ� �ͺ��� ĳ�ø޸� ������
                  �̸� ������ ������ �����پ��ԵǸ� �ξ� �ӵ��� �� ����
  
*/

-- ���̺�� : TB_
-- ��� : V_, VW_
-- �������� : SEQ_
-- Ʈ���Ÿ� : TRG_

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

-- [����] �� ������ �����ϰ��ִ� �������鿡 ���� ���� (�ý���) 
SELECT * FROM USER_SEQUENCES;


------------------------------------------------------------------------------------------------------------------------

/*
    2. SEQUENCE ��� ����
    
    ��������.CURRVAL : ���� �������� �� (�������� NEXTVAL�� ��)
    ��������.NEXTVAL : ���������� ������Ű�� ������ �������� ��
                      ���� �������� ������ INCREMENT BY �� ��ŭ ������ ��
                      == ��������.CURRVAL + INCREMENT BY ��
    
*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--> NEXTVAL�� �ѹ��̶� �������� �ʴ� �̻� CURRVAL�� �� �� ����!!
--> ��? : CURRVAL�� ��� ���������� ���������� ����� NEXTVAL�� ���� �����ؼ� �����ִ� �ӽð�

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --> 300
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> 305
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> 310

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> ������ MAXVALUE���� �ʰ��߱� ������ ���� �߻�

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --> 310
-- LAST_NUMBER : Ȥ�ó� NEXTVAL�� �� �� �� �����ϸ� ����� �� �ӽ� �����صδ� ��



/*
    3. SEQUENCE ����
    
    
    [ǥ����]
    ALTER SEQUENCES ��������
    [INCREMENT BY ����]
    [MAXVALUE ����]
    [MINVALUE ����]
    [CYCLE | NOCYCLE]
    [CACHE ����Ʈ�� | NOCACHE];
    
    
    * START WITH�� ����Ұ�!!
*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> 320


-- SEQUENCE �����ϱ�
DROP SEQUENCE SEQ_EMPNO;

-------------------------------------------------------------------------------------------------------------------------------

-- �Ź� ���ο� ����� �߻��ǰԲ� ������ ����
CREATE SEQUENCE SEQ_EID
START WITH 300;

SELECT * FROM USER_SEQUENCES;

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, 'ȫ�浿', '111111-1111111', 'J1', SYSDATE);

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, 'ȫ���', '222222-1111111', 'J2', SYSDATE);

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, '�踻��', '222222-3333333', 'J4', SYSDATE);





















































