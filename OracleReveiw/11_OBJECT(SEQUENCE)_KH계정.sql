/*
    < 시퀀스 SEQUENCE >
    자동으로 번호 발생시켜주는 역할을 하는 객체
    정수값을 자동으로 순차적으로 생성해줌
    
*/

/*
    1. 시퀀스객체 생성 구문
    
    [표현법]
    CREATE SEQUENCE 시퀀스명
    [START WITH 숫자]         --> 처음 발생시킬 시작값 지정
    [INCREMENT BY 숫자]       --> 몇씩 증가시킬건지 
    [MAXVALUE 숫자]           --> 최대값 지정
    [MINVALUE 숫자]           --> 최소값 지정
    [CYCLE | NOCYCLE]         --> 값 순환 여부 지정
    [CACHE 바이트크기 | NOCACHE] --> 캐시메모리 할당 (기본값 20바이트)

    * 캐시메모리 : 미리 발생될 값들을 생성해서 저장해둠
                  매번 호출할 때마다 새로이 번호를 생성하는 것보다 캐시메모리 공간에
                  미리 생성된 값들을 가져다쓰게되면 훨씬 속도가 더 빠름
  
*/

-- 테이블명 : TB_
-- 뷰명 : V_, VW_
-- 시퀀스명 : SEQ_
-- 트리거명 : TRG_

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

-- [참고] 이 계정이 소유하고있는 시퀀스들에 대한 정보 (시스템) 
SELECT * FROM USER_SEQUENCES;


------------------------------------------------------------------------------------------------------------------------

/*
    2. SEQUENCE 사용 구문
    
    시퀀스명.CURRVAL : 현재 시퀀스의 값 (마지막의 NEXTVAL의 값)
    시퀀스명.NEXTVAL : 시퀀스값을 증가시키고 증가된 시퀀스의 값
                      기존 시퀀스의 값에서 INCREMENT BY 값 만큼 증가된 값
                      == 시퀀스명.CURRVAL + INCREMENT BY 값
    
*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--> NEXTVAL를 한번이라도 수행하지 않는 이상 CURRVAL를 할 수 없음!!
--> 왜? : CURRVAL은 사실 마지막으로 성공적으로 수행된 NEXTVAL의 값을 저장해서 보여주는 임시값

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --> 300
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> 305
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> 310

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> 지정한 MAXVALUE값을 초과했기 때문에 오류 발생

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --> 310
-- LAST_NUMBER : 혹시나 NEXTVAL을 한 번 더 수행하면 변경될 값 임시 저장해두는 것



/*
    3. SEQUENCE 변경
    
    
    [표현법]
    ALTER SEQUENCES 시퀀스명
    [INCREMENT BY 숫자]
    [MAXVALUE 숫자]
    [MINVALUE 숫자]
    [CYCLE | NOCYCLE]
    [CACHE 바이트수 | NOCACHE];
    
    
    * START WITH는 변경불가!!
*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> 320


-- SEQUENCE 삭제하기
DROP SEQUENCE SEQ_EMPNO;

-------------------------------------------------------------------------------------------------------------------------------

-- 매번 새로운 사번이 발생되게끔 시퀀스 생성
CREATE SEQUENCE SEQ_EID
START WITH 300;

SELECT * FROM USER_SEQUENCES;

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, '홍길동', '111111-1111111', 'J1', SYSDATE);

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, '홍길녀', '222222-1111111', 'J2', SYSDATE);

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, '김말똥', '222222-3333333', 'J4', SYSDATE);





















































