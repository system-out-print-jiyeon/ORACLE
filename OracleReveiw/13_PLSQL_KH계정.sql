/*
    < PL / SQL >
    PROCEDURE LANGUAGE EXTENSION TO SQL
    
    오라클 자체에 내장되어있는 절차적 언어
    변수의 정의, 조건처리(IF), 반복처리(LOOP, FOR, WHILE)등을 지원하여 SQL의 단점을 보완
    다수의 SQL문을 한번에 실행 가능 (BLOCK 구조로)

    * PL / SQL 구조
    - [ 선언부 (DECLARE SECTION)]      : DECLARE 로 시작, 변수나 상수를 선언 및 초기화하는 부분
    - 실행부 (EXECUTABLE SECTION)      : BEGIN 로 시작, SQL문 또는 제어문(조건문, 반복문) 등의 로직을 기술하는 부분 (생략불가) 
    - [ 예외처리부 (EXCEPTION SECTION)] : EXCEPTION 으로 시작, 예외 발생시 해결하기 위한 구문을 기술해두는 부분
    
*/

-- * 간단하게 화면에 HELLO ORACLE 출력

SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/

------------------------------------------------------------------------------------------------------------

-- 1. DECLARE 선언부
--    변수 및 상수 선언해 놓는 공간 (선언과 동시에 초기화도 가능)
--    일반타입변수, 레퍼런스타입변수, ROW타입변수

-- 1_1) 일반타입변수 선언 및 초기화
--      [표현법] 변수명 [CONSTANT] 자료형 [:= 담고자하는값];

DECLARE
    EID NUMBER; -- (java로 치면) int Eid 
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14; -- CONSTANT: 상수 / 선언과 동시에 초기화, 대입(:=) 
BEGIN 
    EID := 800;
    ENAME := '배장남';
    
     -- (java로 치면) system.out.println ("eid : " + eid); -- eid : 800
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID); 
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/

---------------------------------------------------------------------------------------------------------

-- 1_2) 레퍼런스 타입 변수 선언 및 초기화 (어떤 테이블의 어떤 컬럼의 데이터타입을 참조해서 그 타입으로 지정)
--      [표현법] 변수명 테이블명.컬럼명%TYPE;
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    -- 사번이 200번인 사원의 사번, 사원명, 급여 조회해서 각각 EID, ENAME, SAL 변수에 담기
    -- 유의할 점 : SELECT INTO를 이용해서 조회결과를 각 변수에 대입시키고자 한다면 반드시 한개의 행으로 조회
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM EMPLOYEE
    --WHERE EMP_ID = 200; -- 이 구문 안쓰면 여러행 조회돼서 오류뜸
    --WHERE EMP_ID = &사번;   -- 값 입력받으려면 & !!
    WHERE EMP_NAME = '&이름'; -- 문자는 '' 반드시 기술해줘야된다
    --> & 기호는 대체변수(값을 입력)를 입력하기 위한 창이 뜨게 해주는 구문


    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);

END;
/

------------------------------------ 실습문제 --------------------------------------------------------------
/*
    레퍼런스 타입의 변수로 EID, ENAME, JCODE, SAL, DTITLE를 선언하고
    각 자료형은 EMPLOYEE테이블의 각 EMP_ID, EMP_NAME, JOB_CODE, SALARY 컬럼 타입 참조하고
               DEPARTMENT테이블의 DEPT_TITLE 컬럼 타입을 참조하게끔
               
    사용자가 입력한 사원명과 일치하는 사원을 조회 (사번, 사원명, 직급코드, 급여, 부서명)한 후
    조회결과를 각 변수에 대입 후 출력
*/

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    
BEGIN 
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
    WHERE EMP_NAME = '&사원명';
    
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('직급 : ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SAL);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || DTITLE);
    
END;
/

------------------------------------------------------------------------------------------------------------------------

-- 1_3) 테이블의 한 행에 대한 타입 변수 선언 (테이블의 한 행에 대한 모든 컬럼값을 한꺼번에 다 담을 수 있는 변수)
--      [표현법] 변수명 테이블명%ROWTYPE;
DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *        -- 행타입에 담을땐 무조건 * 이여야함!!, 골라서 기술 X
    INTO E
    FROM EMPLOYEE
    WHERE EMP_NAME = '&사원명';

    DBMS_OUTPUT.PUT_LINE('사번 : ' || E.EMP_ID); -- E중에서 EMP_ID값만 뽑겠다
    DBMS_OUTPUT.PUT_LINE('급여 : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('전화번호 : ' || E.PHONE);

END;
/

------------------------------------------------------------------------------------------------------

-- 2. BEGIN

-- < 조건문 >

-- 1) IF 조건식 THEN 실행내용 END IF; (단일 IF문)
-- 사번 입력받은 후 해당 사원의 사번, 이름, 급여, 보너스율(%) 출력
-- 단, 보너스를 받지 않는 사원은 보너스율 출력 전 '보너스를 지급받지 않는 사원입니다' 출력
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN 
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY);
    
    IF (BONUS = 0) 
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');  
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('보너스율 : ' || BONUS * 100 || '%');
    
END;
/

----------------------------------------------------------------------------------------------------

-- 2) IF 조건식 THEN 실행내용 ELSE 실행내용 END IF; (IF-ELSE)

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN 
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY);
    
    IF (BONUS = 0) 
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');  
    ELSE
        DBMS_OUTPUT.PUT_LINE('보너스율 : ' || BONUS * 100 || '%');
    END IF;
    
   
END;
/



-- 검색된 해당 사원의 사번, 이름, 부서명, 국가코드(NATIONAL_CODE) 조회 후 변수에 담기
-- 해당 사원의 사번, 이름, 부서명, 소속(국내팀/해외팀) 출력
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(10);
BEGIN
    SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, L.NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
   WHERE E.DEPT_CODE = D.DEPT_ID
     AND D.LOCATION_ID = L.LOCAL_CODE
     AND E.EMP_ID = &사번;
     
    IF (NCODE = 'KO')
        THEN TEAM := '국내팀';
    ELSE
        TEAM := '해외팀';
    END IF;
    
        
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('소속 : ' || TEAM);

END;
/

--------------------------------------------------------------------------------------------

-- 3) IF 조건식1 THEN 실행내용1 ELSIF 조건식2 THEN 실행내용2 .. ELSE 실행내용N  END IF;

-- 사용자에게 입력받은 점수값을 SCORE변수에 저장한 후
-- 90점 이상은 'A', 80점 이상 'B', 70점 이상 'C', 60점 이상 'D', 60점 미만은 'F'로 처리한 후 GRADE변수에 저장
-- '당신의 점수는 XX점이고, 학점은 X학점입니다.'
DECLARE
    SCORE NUMBER;
    GRADE CHAR(1);
BEGIN
    SCORE := &점수;
    
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE>= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('당신의 점수는 ' || SCORE || '점이고, 학점은 ' || GRADE || '학점입니다.');

END;
/

------------------------------------------------------------------------------------------------------------------

-- < 반복문 >

/*
    1) BASIC LOOP 문
    
    [표현식]
    LOOP
        반복적으로 실행할 구문
    
        반복문을 빠져나갈 조건
    END LOOP;
    
    --> 반복문을 빠져나갈 조건 (2가지)
        1) IF 조건식 THEN EXIT;  END IF; 
        2) EXIT WHEN 조건식;               (더 간단)
        
*/

-- 1~5까지 순차적으로 1씩 증가하는 값을 출력
DECLARE
    I NUMBER := 1;
BEGIN
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 1;
        --IF I = 6 THEN EXIT; END IF; -- 첫번째 방법
        EXIT WHEN I = 6;              -- 두번째 방법
    END LOOP;

END;
/
----------------------------------------------------------------------------------------------------------

/*
    2) FOR LOOP 문
    
    [표현식]
    FOR 변수 IN [REVERSE 역으로실행] 초기값..최종값 (1씩 증가만 하는 구문)
    LOOP
        반복적으로 실행할 구문
    END LOOP;

*/

-- DECLARE부 필요없음, 'FOR 변수'에서 저절로 담김
BEGIN 
    FOR I IN REVERSE 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);   
    END LOOP;
END;
/

-- 반복문을 이용한 데이터 삽입
CREATE TABLE TEST2(
    NUM NUMBER PRIMARY KEY,
    TODAY DATE
);

SELECT * FROM TEST2;

CREATE SEQUENCE SEQ_TEST
START WITH 200;


BEGIN
    FOR I IN 1..100
    LOOP
        INSERT INTO TEST2 VALUES(SEQ_TEST.NEXTVAL, SYSDATE);
    END LOOP;

END;
/

--------------------------------------------------------------------------------------------------------------

-- 중첩 반복문
-- 구구단 (2~9단) 출력하기
DECLARE
    RESULT NUMBER;
BEGIN
    
    -- 바깥쪽 FOR문에 단수 (2~9)
    -- 안쪽 FOR문에 곱해지는 수 (1~9)
    FOR DAN IN 2..9
    LOOP
        DBMS_OUTPUT.PUT_LINE('===== ' || DAN || '단 =====');
        FOR SU IN 1..9
        LOOP
            RESULT := DAN * SU;
            DBMS_OUTPUT.PUT_LINE(DAN || 'X' || SU || '=' || RESULT);
        END LOOP;
    
        DBMS_OUTPUT.PUT_LINE(''); -- 개행넣어주기
    
    END LOOP;
    
END;
/

/*
-- 이건 내가 해본것
BEGIN
    FOR I IN 2..9
    LOOP
        FOR J IN 1..9
            LOOP
                DBMS_OUTPUT.PUT_LINE(I ||'X'|| J || '=' || I * J);
            END LOOP;
    END LOOP;
END;
/
*/

-----------------------------------------------------------------------------------------------------------

/*
    3) WHILE LOOP 문
    
    [표현법]
    WHILE 반복문이수행될조건
    LOOP
        반복적으로 실행할 구문;
    END LOOP;
*/

DECLARE
    I NUMBER := 1;
BEGIN
    WHILE I < 6
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 1;
    END LOOP;

END;
/

-----------------------------------------------------------------------------------------------------------

/*
    3. 예외처리부 (EXCEPTION)
    
    예외 (EXCEPTION) : 실행 중 발생하는 오류
    

    [표현법]
    EXCEPTION
        WHEN 예외명1 THEN 예외처리구문1;
        WHEN 예외명2 THEN 예외처리구문2;
        ...
        WHEN OTHERS THEN 예외처리구문N;   --> OTHERS는 모든 예외 다 받을 수 있다.
        
    * 시스템 예외 (오라클에서 미리 정의되어있는 예외)
    - NO_DATA_FOUND : SELECT한 결과가 한 행도 없었을 경우
    - TOO_MANY_ROWS : SELECT한 결과가 여러행일 경우
    - ZERO_DIVIDE : 0으로 나눌 때
    - DUP_VAL_ON_INDEX : UNIQUE 제약조건에 위배되었을 경우
    ....등등
    
*/
-- 사용자가 입력한 수로 나눗셈 연산한 결과 출력
DECLARE
    RESULT NUMBER;
BEGIN 
    RESULT := 10 / &숫자;
    DBMS_OUTPUT.PUT_LINE('결과 : ' || RESULT);
EXCEPTION 
    --WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('나누기 연산시 0으로 나눌 수 없어요');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('나누기 연산시 0으로 나눌 수 없어요');
END;
/


-- UNIQUE 제약조건 위배시
BEGIN 
    UPDATE EMPLOYEE
    SET EMP_ID = '&변경할사번'
    WHERE EMP_NAME = '노옹철';
EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번입니다.');
END;
/
SELECT * FROM EMPLOYEE;
ROLLBACK;



DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO EID, ENAME
    FROM EMPLOYEE
    WHERE MANAGER_ID = &사수사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
EXCEPTION
    --WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('조회결과가 없습니다.');
    --WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('너무 많은 행이 조회되었습니다.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('예외가 발생했어요'); -- 모든 예외 받을 수 있지만 두루뭉실하게 알려줌
END;
/






