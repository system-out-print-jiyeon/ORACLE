
-- ���� �ּ�

/*
    <SELECT>
    �����͸� ��ȸ�� �� ���Ǵ� ��ɾ� (DML, DQL)
    
    >> RESULT SET : SELECT���� ���� ��ȸ�� �����
    
    [ǥ����]
    SELECT ��ȸ�ϰ��� �ϴ� �÷�, �÷�, �÷�...
    FROM ���̺��;
*/

-- EMPLOYEE ���̺�κ��� ��ü ����� ��� �÷� ���� ��ȸ
SELECT *
FROM EMPLOYEE;

-- JOB ���̺�κ��� ��ü ������ ��ü �÷� ��ȸ
SELECT *
FROM JOB;

-- DEPARTMENT���̺�κ��� ��ü �μ��� ��ü �÷� ��ȸ
SELECT *
FROM DEPARTMENT;

-- EMPLOYEE ���̺�κ��� ��ü ������� ���, �̸�, �޿����� ��ȸ
--SELECT ���� ��ȸ�ϰ��� �ϴ� �÷���� ����
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- DEPARTMENT ���̺�κ��� �μ����̵�� �μ����� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- EMPLOYEE ���̺�κ��� �����, �̸���, ��ȭ��ȣ, �Ի��� �������� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

select emp_name, email, phone, hire_date
from employee;
-- Ű����, ���̺��, �÷��� ��� ��ҹ��ڸ� ������ ���� (��, ���� ����ִ� �����Ͱ��� ������!!)

------------------------------------------------------------------------------------------------

/*
    <�÷����� ���� �������>
    
    SELECT���� ���������(+-/*)�� �����ؼ� �������� ��� ��ȸ ����

*/

-- EMPLOYEE ���̺�κ��� ������, �޿�, ������ ����(���� == �޿�*12) ��ȸ
SELECT EMP_NAME, SALARY, SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE ���̺�κ��� ������, �޿�, ���ʽ�, ����, ���ʽ��� ���Ե� ����((�޿� + ���ʽ�*�޿�) *12)
SELECT EMP_NAME, SALARY, BONUS, SALARY, (SALARY + BONUS*SALARY)*12
FROM EMPLOYEE;
--> ������� �߿� NULL���� ������ ��� ��������� ��������� ������ NULL������ ��ȸ��!!

-- EMPLOYEE ���̺�κ��� ������, �Ի���, �ٹ��ϼ�(���ó�¥ - �Ի���)
-- DATE ���ĳ����� ���� ����
-- ���� ��¥ : SYSDATE (DATE���� == ����Ͻú���)
SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE
FROM EMPLOYEE;

---------------------------------------------------------------------------------------

/*
    < �÷��� ��Ī �����ϱ� >
    
    [ǥ����]
    �÷��� AS ��Ī | �÷��� AS "��Ī" (Ư�����ڳ� ���� ���� ���) | �÷��� ��Ī | �÷��� "��Ī"
    
    AS�� ���̵� �Ⱥ��̵簣�� �ο��ϰ��� �ϴ� ��Ī�� Ư������ �Ǵ� ���Ⱑ ���Ե� ��� �ݵ�� �ֵ���ǥ�� ��ߵȴ�!!
    
*/

SELECT EMP_NAME AS �̸�, SALARY AS "�޿�", BONUS ���ʽ�, 
       SALARY*12 "����(��)", (SALARY + BONUS*SALARY)*12 "�� �ҵ�"
FROM EMPLOYEE;

-------------------------------------------------------------------------------------------

/*
    < ���ͷ� >
    ���Ƿ� ������ ���ڿ� ('')�� SELECT���� ����ϸ�
    ���� �� ���̺� �����ϴ� ������ó�� ��ȸ����

*/

-- EMPLOYEE���̺�κ��� ���, �����, �޿�, ����('��') ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, '��' ����
FROM EMPLOYEE;
--> SELECT���� ������ ���ͷ� ���� ��ȸ����� ��� �࿡ �ݺ������� ��µ�

-----------------------------------------------------------------------

/*
    < DESTINCT >
    �÷��� ���Ե� �ߺ����� �� �ѹ����� ǥ���ϰ��� �� �� ���
    (��, SELECT���� �� �Ѱ��� ���� ����)
*/

-- EMPLOYEE ���̺�κ��� �μ��ڵ� ��ȸ (���� ������� � �μ��� �����ִ���..)
SELECT DEPT_CODE
FROM EMPLOYEE;

-- EMPLOYEE���̺�κ��� �ߺ������� �μ��ڵ� ��ȸ
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

-- EMPLOYEE���̺�κ��� �ߺ������� ���� ��ȸ
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;
--> DEP_CODE���̶� JOB_CODE���̶� ��Ʈ�� ��� �ߺ��Ǻ�!

---------------------------------------------------------------------

/*
    < WHERE �� >
    
    ��ȸ�ϰ����ϴ� ���̺��� Ư�� ���ǿ� �����ϴ� �����͸��� ��ȸ�ϰ��� �� �� ����ϴ� ����
    
    [ǥ����]
    SELECT ��ȸ�ϰ����ϴ� �÷�, �÷�, ...
    FROM ���̺��
    WHERE ���ǽ�;
    
    -> ���ǽĿ� �پ��� �����ڵ� ��밡��
    
    < �񱳿����� >
    >, <, >=, <=       -> ��Һ�
         =             -> �����
      !=, ^=, <>       -> ��ġ���� �������
   
*/

-- EMPLOYEE ���̺�κ��� �޿��� 400���� �̻��� ����鸸 ��ȸ
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE ���̺��� �μ��ڵ尡 D9�� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY      -- 3  (����)
FROM EMPLOYEE                           -- 1
WHERE DEPT_CODE = 'D9';                 -- 2 

-- EMPLOYEE ���̺��� �μ��ڵ尡 D9�� �ƴ� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';

--------------------------------------- �ǽ����� -------------------------------------------

-- 1. EMPLOYEE���̺��� �޿��� 300���� �̻��� �������� ������, �޿�, �Ի��� ��ȸ
    SELECT EMP_NAME ������, SALARY �޿�, HIRE_DATE �Ի���
    FROM EMPLOYEE
    WHERE SALARY >= 3000000;

-- 2. EMPLOYEE���̺��� �������� �������� ���, �̸�, �Ի��� ��ȸ
    SELECT EMP_ID ���, EMP_NAME �̸�, HIRE_DATE �Ի���
    FROM EMPLOYEE
    WHERE ENT_YN = 'N';

-- 3. EMPLOYEE���̺��� �����ڵ尡 J2�� �������� ������, �޿�, ���ʽ� ��ȸ
    SELECT EMP_NAME ������, SALARY �޿�, BONUS ���ʽ�
    FROM EMPLOYEE
    WHERE JOB_CODE = 'J2';

-- 4. EMPLOYEE���̺��� ������ 5000���� �̻��� �������� ������, �޿�, ����, �Ի��� ��ȸ
    SELECT EMP_NAME ������, SALARY �޿�, SALARY*12 ����, HIRE_DATE �Ի��� -- 3 
    FROM EMPLOYEE                                                       -- 1 
    WHERE SALARY*12 >= 50000000;                                        -- 2 
    --> WHERE�������� SELECT���� �ο��� ��Ī �� �� ����!!

-------------------------------------------------------------------------------------------------------------------
/*
    < �������� >
    
    �������� ������ ���� �� ���
    AND (~�̸鼭, �׸���), OR (~�̰ų�, �Ǵ�)
 
*/

-- �μ��ڵ尡 'D9'�̸鼭 �޿��� 500���� �̻��� �������� ������, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- �μ��ڵ尡 'D6'�̰ų� �޿��� 300�����̻��� �������� ������, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- �޿��� 350���� �̻��̰� 600���� ������ �������� ������, ���, �޿�, �����ڵ� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

----------------------------------------------------------------------------

/*
    < BETWEEN AND >
    �� �̻� �� ������ ������ ���� ������ ������ �� ���
    
    [ǥ����]
    �񱳴���÷��� BETWEEN ���Ѱ� AND ���Ѱ�
*/

-- �޿��� 350���� �̻�, 600���� ������ ������� �����, ���, �޿�, �����ڵ� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
--WHERE SALARY >= 3500000 AND SALARY <= 6000000;
WHERE SALARY BETWEEN 3500000 AND 6000000;


-- �޿��� 350���� �̻� 600���� ���ϰ� �ƴ� ������� ��ȸ (�޿��� 350�� �̸��̰ų� �޿��� 600�� �ʰ���)
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
--WHERE SALARY <3500000 OR SALARY >6000000
WHERE NOT SALARY BETWEEN 3500000 AND 6000000; -- NOT�� ���̰� �Ǹ� �ش� ������ �ݴ�Ǵ� ���� (�ڹٷ� ������ �� !�� ����)
--WHERE SALARY NOT BETWEEN 3500000 AND 6000000; NOT�� BETWEEN �տ� �ٿ��� ������


-- * BETWEEN AND ������ DATE���İ������� ��밡��
-- �Ի����� '90/01/01' ~ '01/01/01'�� ������� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';  -- 10�� �� ��ȸ

SELECT *
FROM EMPLOYEE
WHERE NOT HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';  -- 13�� �� ��ȸ

-----------------------------------------------------------------------------------

/*
    < LIKE 'Ư������' >
    ���Ϸ��� �÷����� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
    
    [ǥ����]
    �񱳴���÷��� LIKE 'Ư������'
    
    - Ư�����Ͽ� '%', '_'�� ���ϵ� ī��� ����� �� ����
    > '%' : 0���� �̻�
    EX) �񱳴���÷��� LIKE '����%' => �÷��� �߿� '����'�� "����"�Ǵ� ���� ��ȸ
        �񱳴���÷��� LIKE '%����' => �÷��� �߿� '����'�� "��"���� ���� ��ȸ
        �񱳴���÷��� LIKR '%����%' => �÷��� �߿� '����'�� "����"�Ǵ� ���� ��ȸ
    
    > '_' : 1���� (������!!)
    EX) �񱳴���÷��� LIKE '_����' => �÷��� �߿� '����'�տ� ������ �ѱ��ڰ� �� ��� ��ȸ
        �񱳴���÷��� LIKE '__����' => �÷��� �߿� '����'�տ� ������ �α��ڰ� �� ��� ��ȸ
       
*/

-- ���� ������ ������� �����, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- �̸� �߿� '��'�� ���Ե� ������� �����, �ֹι�ȣ, �μ��ڵ� ��ȸ ('��' ��ġ ���� ������� ���)
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- ��ȭ��ȣ 4��° �ڸ��� 9�� �����ϴ� ������� ���, �����, ��ȭ��ȣ, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';    
-- '___9'�θ� �ϸ� -> 0109  0119  0179 �ΰ��� ã�°��̱� ������ �ڿ� %�ٿ������

-- �̸��� �� _�ձ��ڰ� 3������ �̸��� �ּҸ� ���� ������� ���, �̸�, �̸��� ��ȸ
-- �̸��� 4��° �ڸ��� _�� �����ϴ� ����̶�� ��
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE 
WHERE EMAIL LIKE '____%';  -- ���ϵ�ī��� ���Ǵ� ���ڿ� ���� ����ִ� �÷����� ������ ��� ���� �߻�!!

-- ��� ���ϵ�ī��� ��� �����Ͱ����� ���������ָ� ��!!
-- �����Ͱ����� �νĽ�ų �� �տ� ���Ƿ� ������ ���ϵ�ī�带 �����ϰ� ������ ���ϵ�ī�带 ESCAPE�� ���

SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE 
WHERE EMAIL LIKE '___$_%' ESCAPE '$'; 
-- $�� �������� '���ϵ�ī�� $ �����Ͱ�'



-- �达 ���� �ƴ� ������� ���, �����, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE NOT EMP_NAME LIKE '��%';
WHERE EMP_NAME NOT LIKE '��%';


------------------------------- �ǽ����� -------------------------------------
-- 1. �̸� ���� '��'���� ������ ������� �����, �Ի��� ��ȸ
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

-- 2. ��ȭ��ȣ ó�� �����ڰ� 010�� �ƴ� ������� �����, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

-- 3. DEPARTMENT ���̺��� �ؿܿ������� ��� �÷� ��ȸ
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '�ؿܿ���%';


-----------------------------------------------------------------------------------------

/*
    < IS NULL / IS NOT NULL >
    
    �񱳴���÷� IS NULL : �÷����� NULL�� ���
    �񱳴���÷� IS NOT NULL : �÷����� NULL�� �ƴ� ���
*/

-- ���ʽ��� ���� �ʴ� ���(BONUS�÷����� NULL��)���� ���, �̸�, �޿�, ���ʽ�
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
-- WHERE BONUS = NULL;  -- ����� ��ȸ �ȵ�
WHERE BONUS IS NULL;

-- ���ʽ��� �޴� ���(BONUS�÷����� NULL�� �ƴ�)�� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;


-- ����� ���� ���(MANAGER_ID�÷����� NULL��)���� �����, ������, �μ��ڵ� ��ȸ 
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- ����� ���� �μ���ġ�� ���� ���� ����� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- �μ���ġ�� ���� �ʾ����� ���ʽ��� �޴� ��� ��ȸ (�����, ���ʽ� , �μ��ڵ�)
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

--------------------------------------------------------------

/*
    < IN >
    �񱳴���÷����� ��ϵ� �߿� ��ġ�ϴ� ���� �ִ���
    
    [ǥ����]
    �񱳴���÷� IN (��, ��, ��, .....)
*/

-- �μ��ڵ尡 D6�̰ų� �Ǵ� D8�̰ų� �Ǵ� D5�� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5' ;
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');

-- �� ���� �����
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE NOT DEPT_CODE IN ('D6', 'D8', 'D5');
WHERE DEPT_CODE NOT IN ('D6', 'D8', 'D5');

------------------------------------------------------------------------------------

/*
    < ���� ������ || >
    ���� �÷������� �ϳ��� �÷��ΰ�ó�� ��������ִ� ������
    �÷��� ���ͷ�(������ ���ڿ�)�� ������ ���� �ִ�.
*/

-- system.out.println("NUM : " + num);�ڹٿ����� + ����

-- ���, �����, �޿��� �ϳ��� �÷����� ���ļ� ��ȸ
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- XXX�� XXX�� ������ XXXXXX�� �Դϴ�.
-- �÷����� ���ͷ� ���� 
SELECT EMP_ID ||'�� ' || EMP_NAME || '�� ������ ' || SALARY || '�� �Դϴ�.' �޿�����
FROM EMPLOYEE;

-----------------------------------------------------------------------------------------
/*
    < ������ �켱���� >
    0. ()
    1. ���������
    2. ���Ῥ����
    3. �񱳿�����
    4. IS NULL     LIKE     IN
    5. BETWEEN AND 
    6. NOT 
    7. AND (��������)
    8. OR (��������)
*/

-- OR���� AND�� ���� ����

-- �����ڵ尡 J7�̰ų� �Ǵ� J2�� ����� �� �޿��� 200���� �̻��� ����鸸 ��ȸ, ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
--WHERE JOB_CODE='J7' OR JOB_CODE= 'J2' AND SALARY >= 2000000; 
-- �����ڵ尡 J2�̸鼭 �޿��� 200���� �̻��� �����  +  �����ڵ尡 J7
WHERE (JOB_CODE='J7' OR JOB_CODE= 'J2') AND SALARY >= 2000000;
-- �ùٸ� ���, ()�� ��� OR���� ���� �����ϰԲ� �������

/*
    �������
    3 : SELECT
    1 : FROM    
    2 : WHERE
*/

-----------------------------------------------------------------------------------------------------

/*
    < ORDER BY ��>
    SELECT�� ���� �������� �����ϴ� ����
    SELECT�� ���� �������� �ۼ��ϴ� �� �Ӹ� �ƴ϶� ������� ���� ���� ������
    
    [ǥ����]
    SELECT ��ȸ���÷�, �÷�, ...
    FROM ��ȸ�����̺��
    WHERE ���ǽ�
    ORDER BY ���Ľ�Ű�����ϴ��÷��� | ��Ī | �÷�����    [ASC|DESC] [NULLS FIRST|NULLS LAST] ��������, �⺻������ ��������
    
    - ASC : �������� ���� (������ �⺻��)
    - DESC : �������� ����
    
    - NULLS FIRST : �����ϰ��� �ϴ� �÷����� NULL�� ���� ��� �ش� NULL������ �� ��
    - NULLS LAST  : �����ϰ��� �ϴ� �÷����� NULL�� ���� ��� �ش� NULL������ �� �ڷ� ����
    
    ** ���� ���� **
    1. FROM ��
    2. WHERE ��
    3. SELECT ��
    4. ORDER BY ��
    
*/
-- �� ������� ���ʽ��� �������� ���� ��ȸ
SELECT *
FROM EMPLOYEE
--ORDER BY BONUS;      -- ASC �Ǵ� DESC ������ �⺻���� ASC(������������)
--ORDER BY BONUS ASC;  -- �������� ������ �⺻������ NULLS LAST����
--ORDER BY BONUS ASC NULLS FIRST;
--ORDER BY BONUS DESC;   -- �������� ������ �⺻������ NULLS FIRST����
ORDER BY BONUS DESC, SALARY ASC;  -- ù��° ������ ���� �÷����� ��ġ�� ��� �ι�° ������ ���ı����� ������ ���� 


-- ������ �������� ���ķ� ��ȸ (�����, ����)
SELECT EMP_NAME, SALARY*12 ���� 
FROM EMPLOYEE
-- ORDER BY SALARY*12 DESC;
--ORDER BY ���� DESC;  -- ��Ī���� ��� ����
                      -- WHERE�������� ��Ī���� ���Ұ�, ��������
ORDER BY 2 DESC;      -- �÷� ���� ��� ����




