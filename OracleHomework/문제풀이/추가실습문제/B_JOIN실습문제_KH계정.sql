-- 1. 직급이 대리이면서 ASIA지역에 근무하는 직원들의
--    사번, 사원명, 직급명, 부서명, 근무지역명, 급여를 조회하시오
-->> 오라클 구문
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE, L.LOCAL_NAME, E.SALARY
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, JOB J
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID=LOCAL_CODE
AND E.JOB_CODE = J.JOB_CODE
AND JOB_NAME = '대리' 
AND LOCAL_NAME LIKE 'ASIA%';

-->> ANSI 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION   ON(LOCATION_ID=LOCAL_CODE)
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '대리' 
AND LOCAL_NAME LIKE 'ASIA%';


-- 2. 70년대생이면서 여자이고, 성이 전씨인 직원들의
--    사원명, 주민번호, 부서명, 직급명을 조회하시오
-->> 오라클 구문
SELECT E.EMP_NAME, E.EMP_NO, D.DEPT_TITLE, J.JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE DEPT_CODE = DEPT_ID
  AND E.JOB_CODE = J.JOB_CODE
  AND EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 6))) LIKE '__7_'
  AND SUBSTR(EMP_NO, 8, 1) = 2
  AND EMP_NAME LIKE '전%';

-->> ANSI 구문
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE)
WHERE EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 6))) LIKE '__7_'
  AND SUBSTR(EMP_NO, 8, 1) = 2
  AND EMP_NAME LIKE '전%';



-- 3. 이름에 '형'자가 들어있는 직원들의
--    사번, 사원명, 직급명을 조회하시오
-->> 오라클 구문
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
  AND EMP_NAME LIKE '%형%';

-->> ANSI 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE EMP_NAME LIKE '%형%';


-- 4. 해외영업팀에 근무하는 직원들의
--    사원명, 직급명, 부서코드, 부서명을 조회하시오
-->> 오라클 구문
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_CODE = J.JOB_CODE
  AND DEPT_CODE = DEPT_ID
  AND DEPT_TITLE LIKE '%해외영업%';

-->> ANSI 구문
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE 
JOIN JOB USING (JOB_CODE)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE LIKE '%해외영업%';


-- 5. 보너스를 받는 직원들의
--    사원명, 보너스, 연봉, 부서명, 근무지역명을 조회하시오
-->> 오라클 구문
SELECT EMP_NAME, BONUS, SALARY * 12, DEPT_CODE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION 
WHERE DEPT_CODE = DEPT_ID
  AND LOCATION_ID = LOCAL_CODE
  AND BONUS IS NOT NULL;

-->> ANSI 구문
SELECT EMP_NAME, BONUS, SALARY * 12, DEPT_CODE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE BONUS IS NOT NULL;


-- 6. 부서가 있는 직원들의
--    사원명, 직급명, 부서명, 근무지역명을 조회하시오
-->> 오라클 구문
SELECT E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE, L.LOCAL_NAME
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE
  AND DEPT_CODE = DEPT_ID
  AND LOCATION_ID = LOCAL_CODE
  AND DEPT_CODE IS NOT NULL;

-->> ANSI 구문
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE DEPT_CODE IS NOT NULL;

-- 7. '한국'과 '일본'에 근무하는 직원들의 
--    사원명, 부서명, 근무지역명, 근무국가명을 조회하시오
-->> 오라클 구문
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE DEPT_CODE = DEPT_ID
  AND LOCATION_ID = LOCAL_CODE
  AND L.NATIONAL_CODE = N.NATIONAL_CODE
  AND NATIONAL_NAME IN ('한국', '일본');

-->> ANSI 구문
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME IN ('한국', '일본');


-- 8. 보너스를 받지 않는 직원들 중 직급코드가 J4 또는 J7인 직원들의
--    사원명, 직급명, 급여를 조회하시오
-->> 오라클 구문
SELECT E.EMP_NAME, J.JOB_NAME, E.SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
  AND BONUS IS NULL
  AND E.JOB_CODE IN ('J4', 'J7');
  
-->> ANSI 구문
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE BONUS IS NULL
  AND JOB_CODE IN ('J4', 'J7');
  
  
  
-- 9. 사번, 사원명, 직급명, 급여등급, 구분을 조회하는데
--    이때 구분에 해당하는 값은
--    급여등급이 S1, S2인 경우 '고급'
--    급여등급이 S3, S4인 경우 '중급'
--    급여등급이 S5, S6인 경우 '초급' 으로 조회되게 하시오.
-->> 오라클 구문
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, S.SAL_LEVEL, CASE WHEN SAL_LEVEL = 'S1' OR SAL_LEVEL = 'S2' THEN '고급'
                                                           WHEN SAL_LEVEL ='S3' OR SAL_LEVEL = 'S4' THEN '중급'
                                                           WHEN SAL_LEVEL ='S5' OR SAL_LEVEL = 'S6' THEN '초급'
                                                           END 구분
FROM EMPLOYEE E, JOB J, SAL_GRADE S
WHERE E.JOB_CODE = J.JOB_CODE
  AND SALARY BETWEEN MIN_SAL AND MAX_SAL;

-->> ANSI 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME, SAL_LEVEL, CASE WHEN SAL_LEVEL = 'S1' OR SAL_LEVEL = 'S2' THEN '고급'
                                                           WHEN SAL_LEVEL ='S3' OR SAL_LEVEL = 'S4' THEN '중급'
                                                           WHEN SAL_LEVEL ='S5' OR SAL_LEVEL = 'S6' THEN '초급'
                                                           END 구분
FROM EMPLOYEE 
JOIN JOB USING (JOB_CODE)
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);



-- 10. 각 부서별 총 급여합을 조회하되
--     이때, 총 급여합이 1000만원 이상인 부서명, 급여합을 조회하시오
-->> 오라클 구문
SELECT DEPT_TITLE 부서명, SUM(SALARY) 급여합
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) >= 10000000;

-->> ANSI 구문
SELECT DEPT_TITLE, SUM(SALARY) 급여합
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) >= 10000000;


-- 11. 각 부서별 평균급여를 조회하여 부서명, 평균급여 (정수처리)로 조회하시오.
--      단, 부서배치가 안된 사원들의 평균도 같이 나오게끔 하시오.
-->> 오라클 구문
SELECT DEPT_TITLE,
       ROUND(AVG(SALARY)) 평균급여
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE(+) = D.DEPT_ID
GROUP BY DEPT_TITLE;

-->> ANSI 구문
SELECT DEPT_TITLE,
       ROUND(AVG(SALARY)) 평균급여
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE;

