/*
    < �Լ� FUNCTION > 
    - �ڹٷ� ġ�� �޼ҵ尰�� ����
    - ���ް����� �о ����� ����� ��ȯ��
    
    > ������ �Լ� : N���� ���� �о N���� ����� ���� (�� �ึ�� �Լ� ������ ��ȯ)
    > �׷� �Լ�   : N���� ���� �о 1���� ����� ���� (�ϳ��� �׷캰�� �Լ� ������ ��ȯ) 
    
    * �������Լ��� �׷��Լ��� �Բ� ����� �� ����!! : ��� ���� ������ �ٸ��� ����
    
    * �Լ��� ����� �� �ִ� ��ġ : SELECT ��, WHERE ��, ORDER BY ��, GROUP BY ��, HAVING �� 
     
*/

--------------------------------------< ������ �Լ� >--------------------------------------------- 

/*
    < ���� ���� �Լ� >
    
    * LENGTH / LENGTHB
    
    LENGTH(STRING)     : �ش� ������ ���� �� ��ȯ
    LENGRHB(STRING)    : �ش� ������ ����Ʈ �� ��ȯ
    
    => ����� NUMBER Ÿ������ ��ȯ
    
    > STRING : ���ڿ� �ش��ϴ� �÷� | '���ڰ�'
    
    '��', '��', '��'   �ѱ� �� ���ڴ� 3BYTE�� ���
    'A', 'a', '1', '!'     �� ���ڴ� 1BYTE�� ���
    
*/

SELECT LENGTH('����Ŭ!'), LENGTHB('����Ŭ!')
FROM DUAL;  --> ����Ŭ���� �����ϴ� �������̺� (DUMMY TABLE)

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL), EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;

-----------------------------------------------------------------------------------------------------------

/*
    * INSTR
    ���ڿ��κ��� Ư�� ������ ��ġ�� ��ȯ
    
    INSTR(STRING, '����', [ã����ġ�� ���۰�, [����]])  <-- []��°�� ������ ����, ���� []�� ������ ����
    
    > ã�� ��ġ�� ���۰�
     1 : �տ������� ã�ڴ�. (�⺻��)
    -1 :�ڿ������� ã�ڴ�.

*/

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;  -- ã�� ��ġ�� ���۰�, ���� ������ �տ������� ù��°�� B�� ��ġ��
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL;


SELECT EMAIL, INSTR(EMAIL,'@') "@��ġ"
FROM EMPLOYEE;

-------------------------------------------------------------------------------------------

/*
    * SUBSTR
    ���ڿ��κ��� Ư�� ���ڿ��� �����ؼ� ��ȯ
    (�ڹٷ� ġ�� ���ڿ�.substring() �޼ҵ�� ����)
    
    
    SUBSTR(STRING, POSITION, [LENGTH]) 
    => ����� CHARACTER Ÿ��                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    
       
    > STRING : ����Ÿ�� �÷� �Ǵ� '���ڰ�'
    > POSITION : ���ڿ��� �߶� ������ġ��
    > LENGTH : ������ ���� ���� (������ ������ �ǹ�)
    
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL; -- ������ġ�� ���������� �����ϸ� �ڿ������� ��ġ�� ã��

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) ����
FROM EMPLOYEE;

-- ���ڻ���鸸 ��ȸ (�����, �޿�)
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO,8 ,1) = '1' OR SUBSTR(EMP_NO, 8, 3) = '3';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');

-- ���ڻ���鸸 ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

--------------------------------------------------------------------------------------

/*
    * LPAD / RPAD
    ���ڿ� ���� ���ϰ��ְ� �����ְ��� �� �� ���
    
    LDAP / RPAD(STRING, ���������� ��ȯ�� ������ ����(����Ʈ), [�����̰����ϴ� ����])
    => ����� CHARACTER Ÿ��
    
    ������ ���ڿ��� ������ ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ� ���� N���̸�ŭ�� ���ڿ��� ��ȯ
    > �����̰����ϴ� ���� ������ �⺻���� �������� ó��
*/

SELECT EMAIL, LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT EMAIL, RPAD(EMAIL, 20, '$')
FROM EMPLOYEE;

-- 891201-2****** �ֹι�ȣ ��ȸ       => �� ���ڼ� : 14����
SELECT RPAD('891201-2', 14, '*') FROM DUAL;

-- �Լ� ��ø���ε� ��� ����
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1, 8), 14, '*')
FROM EMPLOYEE;

-------------------------------------------------------------------------------------------------

/*
    * LTRIM / RTRIM
    
    LTRIM/RTRIM(STRING, [�����ϰ����ϴ� ���ڵ�]) <-- �����ϸ� ��������
    => ����� CHARACTER Ÿ��
    
    ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ����ϴ� ���ڵ��� ã�Ƽ� ������ ������ ���ڿ��� ��ȯ
    
*/

SELECT LTRIM('     K H') FROM DUAL;
SELECT LTRIM('00012345600', '0')FROM DUAL;  -- ����ٰ� �ٸ����� ������ ��ȯ
SELECT LTRIM('123123KH123', '123')FROM DUAL;
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL; -- �ܾ ã�Ƽ� ����°� �ƴ϶� ������ ���ڵ� ã�Ƽ� ����� ���� // KH�� ���� 
SELECT LTRIM('584654642415782KH123', '0123456789') FROM DUAL;

SELECT RTRIM('00012345600', '0')FROM DUAL;

----------------------------------------------------------------------------------------------------

/*
    * TRIM
    ���ڿ��� ��/��/���ʿ� �ִ� Ư�� ���ڸ� ������ ������ ���ڿ��� ��ȯ
    
*/

-- �⺻�����Τ� ���ʿ� �ִ� ���� ����
 SELECT TRIM('  K H  ') FROM DUAL;  -- �����ϰ����ϴ� ���� ������ �⺻���� ����

SELECT TRIM('Z' FROM 'ZZZKHZZZ')FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ')FROM DUAL;  -- LEADING : ��
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ')FROM DUAL; -- TRAILING : ��
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ')FROM DUAL;     -- BOTH : ���� (�⺻��)

-- [ǥ����]
-- TRIM([LEADING|TRAILING|BOTH] '�����ϰ����ϴ¹���' FROM STRING)
-- => ����� CHARACTER Ÿ��

---------------------------------------------------------------------------------------------

/*
    * LOWER / UPPER / INITCAP
    
    LOWER : �� �ҹ��ڷ�
    UPPER : �� �빮�ڷ�
    INITCAP : �ܾ� �ձ��ڸ��� �빮�ڷ�
    
    LOWER/UPPER/INITCAP(STRING) 
    (STRING�� ���ڰ�, ����Ÿ�����÷� �� ����)
    => ����� CHARACTER Ÿ��
    
*/

SELECT LOWER('Welcome To My World!') FROM DUAL;
SELECT UPPER('Welcome To My World!') FROM DUAL;
SELECT INITCAP('welcome to myworld!') FROM DUAL;

--------------------------------------------------------------------------------------

/*
    * CONCAT
    ���޵� �ΰ��� ���ڿ� �ϳ��� ��ģ �� ��� ��ȯ
    
    CONCAT(STRING, STRING)
    => ����� CHARACTER Ÿ��
*/

SELECT CONCAT('�����ٶ�', 'ABCD') FROM DUAL;
SELECT '�����ٶ�'||'ABCD' FROM DUAL;    -- ���Ῥ���� ����Ѱ��̶� ������ ���

SELECT CONCAT('������', 'ABC', 'DEF') FROM DUAL; --�� ���� ���� / CONCAT�� �ΰ��� ���ڿ��ۿ� �ȵ�..
SELECT '������' || 'ABC' || 'DEF' FROM DUAL;

-----------------------------------------------------------------------------------------------------------

/*
    * REPLACE
    
    REPLACE(STRING, STR1, STR2)
    => ����� CHARACTER Ÿ��
    
    STRING���κ��� STR1 ã�Ƽ� STR2�� �ٲ� ���ڿ��� ��ȯ
    
*/

SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��') FROM DUAL;

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'iei.com')
FROM EMPLOYEE;

--------------------------------------------------------------------------------------------------

/*
    < ���� ���� �Լ� >
    ���� �����ִ� �Լ�
    
    ABS(NUMBER)
    
    > NUMBER : ����Ÿ���� �÷� / ���ڰ�

*/

SELECT ABS('-10') FROM DUAL; -- '-10'�� ��
-- �ڹٿ� �޸� ����Ŭ������ ���ڿ� ������ ����ȯ�� ������ �� ��
SELECT ABS(-10.9) FROM DUAL;


----------------------------------------------------------------------------------------

/*
* MOD
�� ���� ���� ������ ���� ��ȯ���ִ� �Լ�

MOD(NUMBER, NUMBER)
*/
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;

-------------------------------------------------------------------------------------------

/*
    * ROUND
    �ݿø� ó�����ִ� �Լ�
    
    ROUND(NUMBER, [��ġ])
*/
SELECT ROUND(123.456) FROM DUAL;    -- ��ġ ������ �⺻�� 0
SELECT ROUND(123.456, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 4) FROM DUAL; -- �����ڸ��Է��ص� ���� �ȶ�, �ִ� �״���� �Ǽ� ������
SELECT ROUND(123.456, -1) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;

------------------------------------------------------------------------------------------------

/*
    * CEIL
    ������ �ø�ó�����ִ� �Լ�
    
    CEIL(NUMBER)
*/

SELECT CEIL(123.156) FROM DUAL;
SELECT CEIL(123.156, 2) FROM DUAL;  -- ������, ��ġ���� �Ұ�!!

--------------------------------------------------------------------------------------------------------

/*
    * FLOOR
    �Ҽ��� �Ʒ� ������ ���������� �Լ�
    
    FLOOR(NUMBER)
*/

SELECT FLOOR(123.456) FROM DUAL;    -- �굵 ��ġ���� �Ұ�!

SELECT EMP_NAME, FLOOR(SYSDATE - HIRE_DATE) || '��' �ٹ��ϼ�
FROM EMPLOYEE;

------------------------------------------------------------------------------------------

/*
    * TRUNC
    ��ġ ���� ������ ����ó�����ִ� �Լ�
    
    TRUNC(NUMBER, [��ġ])
*/

SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;

----------------------------------------------------------------------------------------------------------------

/*
    < ��¥ ���� �Լ� >
    
    

*/
-- DATE Ÿ���� ���� : ��/��/��, �ú���

-- * SYSDATE : ���ó�¥ (�ý��� ��¥) ��ȯ
SELECT SYSDATE FROM DUAL;

-- * MONTHS_BETWEEN(DATE1, DATE2) : �� ��¥ ������ ���� �� ��ȯ
--   => ����� NUMBER Ÿ��
SELECT EMP_NAME,FLOOR(SYSDATE-HIRE_DATE) �ٹ��ϼ�, FLOOR(MONTHS_BETWEEN (SYSDATE, HIRE_DATE)) �ٹ�������
FROM EMPLOYEE;

-- * ADD_MONTHS(DATE, NUMBER) : Ư�� ��¥�� �ش� ���ڸ�ŭ�� �������� ���� ��¥ ��ȯ
--  => ����� DATE Ÿ��
-- ���ó�¥�κ��� 5���� ��
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- �� ����鸶�� ������, �Ի���, �Ի��� 6������ �� ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,6) "�Ի��� 6���� ��"
FROM EMPLOYEE;

-- * NEXT_DAY(DATE, ����(����|����)) : Ư����¥���� ���� ����� �ش� ������ ã�� �� ��¥ ��ȯ
--   => ����� DATE Ÿ��
SELECT NEXT_DAY(SYSDATE, '�����') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 5) FROM DUAL;  -- 1:�Ͽ���, 2:������, .... 5:�����, 6:�ݿ���, 7:�����
SELECT NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL; -- ���� (���� ���Ÿ���� KOREAN�̱� ������)

-- ����
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '�����') FROM DUAL;  -- ����

-- �ٽ� ����
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- * LAST_DAY(DATE) : �ش� Ư�� ��¥ ���� ������ ��¥�� ���ؼ� ��ȯ
--   => ����� DATE Ÿ��
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- ������, �Ի���, �Ի���� ������ ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;


/*
    * EXTRACT 
    �⵵, ��, �� ������ �����ؼ� ��ȯ
    
    EXTRACT(YEAR FROM DATE)  : Ư�� ��¥�κ��� �⵵�� ����
    EXTRACT(MONTH FROM DATE) : Ư�� ��¥�κ��� ���� ����
    EXTRACT(DAY FROM DATE)   : Ư�� ��¥�κ��� �ϸ� ����
    
    => ����� NUMBER Ÿ��
*/
-- ������, �Ի�⵵, �Ի��, �Ի��� ��ȸ
SELECT EMP_NAME,
      EXTRACT(YEAR FROM HIRE_DATE) ||'��' �Ի�⵵,
      EXTRACT(MONTH FROM HIRE_DATE) ||'��' �Ի��,
      EXTRACT(DAY FROM HIRE_DATE) ||'��' �Ի���
FROM EMPLOYEE 
ORDER BY �Ի�⵵, �Ի�� ASC, �Ի��� ASC ; -- ASC�� ���� ����

-----------------------------------------------------------------------------------

/*
    < ����ȯ �Լ� >

    * NUMBER|DATE       => CHARACTER���� ��ȯ��Ű�� �Լ�
    
    TO_CHAR(NUMBER|DATE, [����]) : ������ �Ǵ� ��¥�� �����͸� ������Ÿ������ ��ȯ
    => ����� CHARACTER Ÿ��
    
*/

-- NUMBER => CHARACTER
SELECT TO_CHAR(1234) FROM DUAL; -- 1234 => '1234'
SELECT TO_CHAR(1234,'00000') FROM DUAL; -- 1234 => '01234'      => ��ĭ 0���� ä��
-- '0'�� �ڸ��� �ǹ�, ���� ������� (����������)
-- System.out.printf("%5d", 1234);
SELECT TO_CHAR(1234, '99999') FROM DUAL; -- 1234 => ' 1234'     => ��ĭ �������� ä��
-- '9'�� �������� ä����

SELECT TO_CHAR(1234, 'L00000') FROM DUAL; -- 1234 => '\01234'   => ���� ������ ����(LOCAL)�� ȭ�����
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;
SELECT TO_CHAR(1234, '$99999') FROM DUAL;

SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')
FROM EMPLOYEE;

-- DATE(����Ͻú���) => CHARACTER
SELECT SYSDATE FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;    -- ���ĸ� AM�̶��ᵵ ���ķ� ����
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;  -- 24�ð�Ÿ��
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;   -- DY:ȭ, DAY:ȭ���� 

-- �⵵�ν� �� �� �ִ� ����
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- ���ν� �� �� �ִ� ����
SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM')       -- �θ�����
FROM DUAL;

-- �Ϸν� �� �� �ִ� ����
SELECT TO_CHAR(SYSDATE, 'D'),   -- 1�ֱ��� ����°
       TO_CHAR(SYSDATE, 'DD'),  -- 1�ޱ��� ����°
       TO_CHAR(SYSDATE, 'DDD')  -- 1����� ����°
FROM DUAL;

-- ���Ϸν� �� �� �ִ� ����
SELECT TO_CHAR(SYSDATE, 'DY'),
       TO_CHAR(SYSDATE, 'DAY')
FROM DUAL;

-- 2020�� 08�� 04�� (ȭ)
SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��" (DY)') FROM DUAL;

-- ������, �Ի���(���� ���� ����)
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��" (DY)') 
FROM EMPLOYEE;

-----------------------------------------------------------------------------------

/* 
    * NUMBER/CHARACTER  => DATE�� ��ȯ��Ű�� �Լ�
    
    TO_DATE(NUMBER|CHARACTER, [����]) : ������ �Ǵ� ������ �����͸� ��¥Ÿ������ ��ȯ
    => ����� DATE Ÿ��
    
*/

SELECT TO_DATE(20100101) FROM DUAL;
SELECT TO_DATE('20100101') FROM DUAL;
SELECT TO_DATE('100101') FROM DUAL;

SELECT TO_DATE('20100101', 'YYYYMMDD')FROM DUAL;
--SELECT TO_DATE('041030 143021') FROM DUAL; -- ����ϱ����� �׳� �����ѵ� �׿ܿ� ���������ؾ���
SELECT TO_DATE('041030 143021', 'YYMMDD HH24MISS') FROM DUAL; -- �ú��ʴ� ȭ�鿣 �Ⱥ���, ������ ����

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL;
SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL; -- TO_DATE�Լ��� ���� DATE�������� ��ȯ�� 
--                                                             YY���� : ������ ���缼��

SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL;
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL; -- RR ���� : �ش� ���ڸ� ���ڰ��� 50�̻��̸� ��������,
--                                                                            50�̸��̸� ���缼��


-- 1998�� 1�� 1�� ���Ŀ� �Ի��� ����� ��ȸ(���, �̸�, �Ի��� ��ȸ)
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE HIRE_DATE > TO_DATE('980101', 'YYMMDD'); -- 2098/01/01
--                                               ���� ���� ����� YYYY 4�ڸ� ��Ȯ�� ���
WHERE HIRE_DATE > TO_DATE('980101', 'RRMMDD');   -- 1998/01/01

----------------------------------------------------------------------------------------------

/*
    * CHARACTER         =>  NUMBER          ����Ÿ������ �����ϴ� ���� ������ ���ڸ� ����!!
    
    TO_NUMBER(CHARACTER, [����]) : ������ �����͸� ����Ÿ������ ��ȯ
    => ����� NUMBER Ÿ��

*/
-- JAVA : 123123
-- ORACLE : 246 => ���ڿ� ���� �ڵ�����ȯ ������ �����ο�
SELECT '123' + '123' FROM DUAL; --> �˾Ƽ� �ڵ����� ���ڷ� ����ȯ �� �� ���������� ����

SELECT '10,000,000' + '550,000' FROM DUAL;  --> ���� / ���ڰ� ���ԵǾ��ֱ� ������ �ڵ�����ȯ �ȵ�..

SELECT TO_NUMBER('0123')FROM DUAL;        -- ������ ����, ����
SELECT TO_NUMBER('10,000,000', '99,999,999') + TO_NUMBER('550,000', '999,999') FROM DUAL; -- ���ڰ� �������� �ȵ�, ���������ؾߵ�

-------------------------------------------------------------------------------------------------------

/*
    < NULL ó�� �Լ� >
*/
-- * NVL(�÷���, �ش� �÷����� NULL�� ��� ��ȯ�� �����)

SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- ���ʽ� ���� ���� ��ȸ
SELECT EMP_NAME, (SALARY + NVL(BONUS, 0)*SALARY) *12
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '����')
FROM EMPLOYEE;

-- * NVL2(�÷���, �����1, �����2)
-- �ش� �÷����� �����ϸ� �����1����
-- �ش� �÷����� NULL�̸� �����2����

SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0)
FROM EMPLOYEE;

-- * NULLIF(�񱳴��1, �񱳴��2)
-- �� ���� ���� �����ϸ� NULL��ȯ
-- �� ���� ���� �������� ������ �񱳴��1 ��ȯ

SELECT NULLIF('123', '123') FROM DUAL;
SELECT NULLIF('123', '456') FROM DUAL;

-----------------------------------------------------------------------------------------------------------------

/*
    < ���� �Լ� >
    
    * DECODE(�񱳴�� (�÷��� | ������� | �Լ�), ���ǰ�1, �����1, ���ǰ�2, �����2, .... , �����)
    
    > JAVA������ SWITCH���� ����
    switch(�񱳴��){
    case ���ǰ�1 : �����1;
    case ���ǰ�2 : �����2;
    default : �����;
     }
       
*/

-- ���, �����, �ֹι�ȣ�κ��� �����ڸ� ����
SELECT EMP_ID, EMP_NAME, DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') ����
FROM EMPLOYEE;

-- �������� �޿��� �λ���Ѽ� ��ȸ

-- �����ڵ尡 J7�� ����� �޿��� 10%�� �λ��ؼ� ��ȸ
--           J6�� ����� �޿��� 15%�� �λ��ؼ� ��ȸ
--           J5�� ����� �޿��� 20%�� �λ��ؼ� ��ȸ
--  �� ���� ���� ������� �޿��� 5%�θ� �λ��ؼ� ��ȸ

SELECT EMP_NAME, JOB_CODE, SALARY �����޿�, 
       DECODE(JOB_CODE, 'J7', SALARY*1.1, 
                        'J6', SALARY*1.15,
                        'J5', SALARY*1.2,
                              SALARY*1.05)�λ�޿�
FROM EMPLOYEE;

-------------------------------------------------------------------------------------

/*
    * CASE WHEN THEN ����
    
    DECODE �����Լ��� ���ϸ� DECODE�� �ش� ���� �˻�� ����񱳸��� �����Ѵٸ�
    CASE WHEN THEN �������δ� Ư�� ���� ���ý� ���� ��������
    (�ڹٷ� IF-ELSE IF��)
    
    [ǥ����]
    CASE WHEN ���ǽ�1 THEN �����1
         WHEN ���ǽ�2 THEN �����2
         ...
         ELSE �����
    END
    
*/

SELECT EMP_ID, EMP_NAME,
       DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') ����
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME,
       CASE WHEN SUBSTR(EMP_NO, 8, 1) = '1' THEN '��'
            WHEN SUBSTR(EMP_NO, 8, 1) = '2' THEN '��'
        END ����
FROM EMPLOYEE;


-- �����, �޿�, �޿����(���, �߱�, �ʱ�)
-- SALARY���� 500���� �ʰ��� ��� '���'
-- SALARY���� 500���� ���� 350���� �ʰ��� ��� '�߱�'
-- SALARY���� 350���� ������ ��� '�ʱ�'

SELECT EMP_NAME, SALARY, 
       CASE WHEN SALARY > 5000000 THEN '���'
            WHEN SALARY > 3500000 THEN '�߱�'
            ELSE '�ʱ�'
            END �޿����
FROM EMPLOYEE;


------------------------------------------------------------------------------------------------










