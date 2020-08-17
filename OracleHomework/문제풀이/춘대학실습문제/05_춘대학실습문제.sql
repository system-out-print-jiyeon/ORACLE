/*
1.
*/
INSERT INTO TB_CLASS_TYPE VALUES(01, '전공필수');
INSERT INTO TB_CLASS_TYPE VALUES(02, '전공선택');
INSERT INTO TB_CLASS_TYPE VALUES(03, '교양필수');
INSERT INTO TB_CLASS_TYPE VALUES(04, '교양선택');
INSERT INTO TB_CLASS_TYPE VALUES(05, '논문지도');


/*
2.
*/
CREATE TABLE TB_학생일반정보 AS (SELECT STUDENT_NO , STUDENT_NAME, STUDENT_ADDRESS
                            FROM TB_STUDENT);


/*
3.
*/
CREATE TABLE TB_국어국문학과 AS (SELECT STUDENT_NO 학번,
                                      STUDENT_NAME 학생이름,
                                      19||SUBSTR(STUDENT_SSN, 1, 2) 출생년도,
                                      PROFESSOR_NAME 교수이름
                                 FROM TB_STUDENT S, TB_PROFESSOR P, TB_DEPARTMENT D 
                                 WHERE S.COACH_PROFESSOR_NO = P.PROFESSOR_NO(+)
                                 AND P.DEPARTMENT_NO = D.DEPARTMENT_NO
                                 AND DEPARTMENT_NAME = '국어국문학과'
                               );

SELECT * FROM TB_국어국문학과;



/*
4.
*/
UPDATE TB_DEPARTMENT
SET CAPACITY = ROUND(CAPACITY * 1.1);


/*
5
*/
UPDATE TB_STUDENT
SET STUDENT_ADDRESS = '서울시 종로구 숭인동 181-21'
WHERE STUDENT_NO = 'A413042';


/*
6.
*/
UPDATE TB_STUDENT
SET STUDENT_SSN = SUBSTR(STUDENT_SSN, 1,6);


ROLLBACK;

/*
7.
*/
UPDATE TB_GRADE
SET POINT = '3.5'
WHERE TERM_NO = '200501'
AND STUDENT_NO = (SELECT STUDENT_NO
                    FROM TB_STUDENT
                    JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
                    WHERE STUDENT_NAME = '김명훈'
                    AND DEPARTMENT_NAME = '의학과')
AND CLASS_NO = (SELECT CLASS_NO
                  FROM TB_CLASS
                  WHERE CLASS_NAME = '피부생리학');



/*
8.
*/
DELETE FROM TB_GRADE
WHERE STUDENT_NO IN (SELECT STUDENT_NO
                      FROM TB_STUDENT
                      WHERE ABSENCE_YN = 'Y');
































