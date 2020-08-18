/*
3.
*/
SELECT BOOK_NO, BOOK_NM
FROM TB_BOOK
WHERE LENGTH(BOOK_NM) >= 25 ;

/*
4.
*/
SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
FROM (SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
        FROM TB_WRITER
        WHERE MOBILE_NO LIKE '019%'
        AND WRITER_NM LIKE '김%'
        ORDER BY WRITER_NM)
WHERE ROWNUM =1;


/*
5.
*/
SELECT COUNT(W.WRITER_NO) "작가(명)"
FROM TB_WRITER W, TB_BOOK_AUTHOR BA
WHERE W.WRITER_NO = BA.WRITER_NO
AND COMPOSE_TYPE = '옮김';


/*
6. 문제 잘못됨 [300권 --> 300페이지] 로 변경
*/
SELECT BOOK_NM, COMPOSE_TYPE, STOCK_QTY
FROM TB_BOOK_AUTHOR BA, TB_BOOK B
WHERE BA.BOOK_NO = B.BOOK_NO
AND COMPOSE_TYPE IS NOT NULL
AND PAGE >= 300;


/*
7.
*/
SELECT *
FROM (SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
        FROM TB_BOOK
        ORDER BY ISSUE_DATE DESC)
WHERE ROWNUM = 1;
        

/*
8.
*/
SELECT *
FROM (SELECT WRITER_NM "작가 이름", COUNT(W.WRITER_NO) "권 수"
        FROM TB_WRITER W, TB_BOOK_AUTHOR BA
        WHERE W.WRITER_NO = BA.WRITER_NO
        GROUP BY WRITER_NM, W.WRITER_NO
        ORDER BY COUNT(W.WRITER_NO) DESC)
WHERE ROWNUM IN (1,2,3);


/*
9.
*/

--


/*
10.
*/
CREATE TABLE TB_BOOK_TRANSLATOR(
    BOOK_NO VARCHAR2(10) NOT NULL,
    WRITER_NO VARCHAR2(10) NOT NULL,
    TRANS_LANG VARCHAR2(60),
    CONSTRAINT FK_BOOK_TRANSLATOR_01 FOREIGN KEY(BOOK_NO) REFERENCES TB_BOOK,
    CONSTRAINT FK_BOOK_TRANSLATOR_02 FOREIGN KEY(WRITER_NO) REFERENCES TB_WRITER,
    CONSTRAINT PK_BOOK_TRANSLATOR PRIMARY KEY(BOOK_NO,WRITER_NO)
);

COMMENT ON COLUMN TB_BOOK_TRANSLATOR.BOOK_NO IS '도서 번호';
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.WRITER_NO IS '작가 번호';
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.TRANS_LANG IS '번역 언어';


/*
11.
*/
CREATE TABLE DATACOPY AS
(SELECT BOOK_NO,WRITER_NO
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IN('옮김','역주','편역','공역'));

MERGE INTO TB_BOOK_TRANSLATOR 
USING DATACOPY
ON(TB_BOOK_TRANSLATOR.BOOK_NO=DATACOPY.BOOK_NO)
WHEN NOT MATCHED THEN
INSERT VALUES(
    DATACOPY.BOOK_NO,
    DATACOPY.WRITER_NO,
    NULL);

DROP TABLE DATACOPY;
DELETE FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IN('옮김','역주','편역','공역');

COMMIT;

/*
12.
*/
SELECT BOOK_NM, WRITER_NM
FROM TB_BOOK B, TB_WRITER W, TB_BOOK_TRANSLATOR BT
WHERE B.BOOK_NO = BT.BOOK_NO
AND W.WRITER_NO = BT.WRITER_NO
AND EXTRACT(YEAR FROM B.ISSUE_DATE) = 2007;
















