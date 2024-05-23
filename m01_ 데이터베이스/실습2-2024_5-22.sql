

--[실습]
-- 현재 HR에 있는 7개 테이블들을 분석해서 인사관리에 의미있는 인사이트 5개 이상을 기술하세요
-- 인사관리 개선을 위한 KPI 2개를 설정하고 이것들을 테이블들의 데이터에 반영한 후 다시 분석해서 반영 여부를 검증

SELECT * FROM EMPLOYEES;
SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM job_history;
SELECT * FROM locations;
SELECT * FROM regions;
SELECT * FROM jobs;


-- CASE : 성과금 계산
SELECT EMPLOYEE_ID, LAST_NAME, ROUND(CASE WHEN SALARY > (SELECT AVG(SALARY) 
FROM EMPLOYEES) THEN SALARY * 0.1 ELSE SALARY * 0.05 END) AS 성과금 FROM EMPLOYEES ORDER BY 성과금 DESC;

-- CASE : 근무년수에 따른 보상
SELECT 
    LAST_NAME,
    HIRE_DATE,
    TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) AS 근무년수,
    CASE
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 20 THEN '한달 포상휴가'
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 18 THEN '2주 포상휴가'
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 16 THEN '1주 포상휴가'
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 14 THEN '3일 포상휴가'
        ELSE '휴가 없음'
    END AS 휴가
FROM EMPLOYEES ORDER BY 근무년수 DESC;

-- CASE : 직급
SELECT 
    EMPLOYEE_ID AS 사원번호,
    LAST_NAME AS 이름,
    HIRE_DATE AS 입사일,
    CASE
        WHEN TRUNC(SYSDATE - HIRE_DATE) >= 8000 THEN '임원'
        WHEN TRUNC(SYSDATE - HIRE_DATE) >= 7000 AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES) THEN '본부장'
        WHEN TRUNC(SYSDATE - HIRE_DATE) >= 7000 THEN '부장'
        WHEN TRUNC(SYSDATE - HIRE_DATE) >= 5000 AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES) THEN '차장'
        WHEN TRUNC(SYSDATE - HIRE_DATE) >= 5000 THEN '과장'
        WHEN TRUNC(SYSDATE - HIRE_DATE) >= 3000 AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES) THEN '대리'
        ELSE '사원'
    END AS 직급
FROM 
    EMPLOYEES;
    

-- CASE: 직무 연장자
SELECT 
    e.EMPLOYEE_ID AS 사원번호,
    e.LAST_NAME AS 이름,
    e.JOB_ID,
    e.SALARY AS 급여,
    e.HIRE_DATE AS 입사일
FROM EMPLOYEES e WHERE (e.JOB_ID, e.SALARY, e.HIRE_DATE) IN (SELECT JOB_ID,MAX(SALARY) AS MAX_SALARY,
MIN(HIRE_DATE) AS MIN_HIRE_DATE FROM EMPLOYEES GROUP BY JOB_ID) ORDER BY 사원번호 DESC;

-- CASE: 커미션 수준에서 가장 높은 보상을 받는 직원을 식별
SELECT 
    EMPLOYEE_ID AS 사원번호,
    LAST_NAME AS 이름,
    COMMISSION_PCT AS 커미션,
    SALARY AS 급여
FROM EMPLOYEES WHERE (COMMISSION_PCT, SALARY) IN (SELECT COMMISSION_PCT,
MAX(SALARY) AS MAX_SALARY FROM EMPLOYEES GROUP BY 
COMMISSION_PCT);



-- 휴가 예
CREATE TABLE EMPLOYEES (
    EMPLOYEE_ID INT PRIMARY KEY,
    LAST_NAME VARCHAR(50),
    VACATION_DAYS INT,
    VACATION_DAYS_USED INT
);

INSERT INTO EMPLOYEES (EMPLOYEE_ID, LAST_NAME, VACATION_DAYS, VACATION_DAYS_USED) VALUES (1, 'Smith', 20, 5);
INSERT INTO EMPLOYEES (EMPLOYEE_ID, LAST_NAME, VACATION_DAYS, VACATION_DAYS_USED) VALUES (2, 'Johnson', 15, 8);
INSERT INTO EMPLOYEES (EMPLOYEE_ID, LAST_NAME, VACATION_DAYS, VACATION_DAYS_USED) VALUES (3, 'Williams', 25, 12);


-- CASE 각 직무별 최소, 최대, 평균 급여를 보여줍니다
SELECT 
    JOB_ID AS 직무,
    MIN(SALARY) AS 최소급여,
    MAX(SALARY) AS 최대급여,
    AVG(SALARY) AS 평균급여
FROM 
    EMPLOYEES
GROUP BY 
    JOB_ID
ORDER BY 
    평균급여 DESC;

-- CASE 커미션 비율에 따른 평균 급여
SELECT 
    COMMISSION_PCT AS 커미션비율,
    AVG(SALARY) AS 평균급여
FROM 
    EMPLOYEES
WHERE 
    COMMISSION_PCT IS NOT NULL
GROUP BY 
    COMMISSION_PCT
ORDER BY 
    커미션비율 DESC;





































































































