

-- [실습]
-- 현재 HR에 있는 7개 테이블들을 분석해서 인사관리에 의미있는 인사이트 5개 이상을 기술하세요
-- 인사관리 개선을 위한 KPI 2개를 설정하고 이것들을 테이블들의 데이터에 반영한 후 다시 분석해서 반영 여부를 검증


SELECT * FROM EMPLOYEES;
SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM job_history;
SELECT * FROM locations;
SELECT * FROM regions;
SELECT * FROM jobs;


-- CASE1 : 입사년도부터 현재 년도까지의 근무년수를 구하고 그에 따른 포상 휴가 산출
SELECT 
    LAST_NAME,
    HIRE_DATE,
    TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) AS 근무년수,
    CASE
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 22 THEN '한달 포상휴가'
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 20 THEN '2주 포상휴가'
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 18 THEN '1주 포상휴가'
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 17 THEN '3일 포상휴가'
        ELSE '휴가 없음'
    END AS 휴가
FROM EMPLOYEES ORDER BY 근무년수 DESC;

-- CASE2 : 근무일수에 따른 직급 산출 만약 근무일수가 비슷하다면 근무일수와 급여로 산출
-- 급여는 (자신의 급여가 총평균 급여보다 높은경우이다) 
SELECT 
    EMPLOYEE_ID AS 사원번호,
    LAST_NAME AS 이름,
    SALARY,
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
    EMPLOYEES ORDER BY SALARY;

-- CASE 3 : 지역별 생활비 고려한 급여 지급 방안 : 서로 다른 지역의 생활비 수준을 고려하여 현재 group by  group by EMPLOYEE_ID, LAST_NAME, HIRE_DATE group by EMPLOYEE_ID, LAST_NAME, HIRE_DATE 고정적인 급여에서 추가적으로 급여를 지급하는 방안
-- REGION_ID ( 1: 유럽 2: 아메리카 3: 아시아 4: 아프리카)
SELECT 
    country_NAME,salary 급여,
    CASE 
        WHEN REGION_ID = 1 THEN trunc(salary * 1.05)  -- 유럽 대륙: 105%의 급여
        WHEN REGION_ID = 2 THEN trunc(salary * 1.1)  -- 아메리카 대륙: 110%의 급여
        WHEN REGION_ID = 3 THEN trunc(salary * 1.15)  -- 아시아 대륙: 115%의 급여
        WHEN REGION_ID = 4 THEN trunc(salary * 1.2)  -- 아프리카 대륙: 120%의 급여
        ELSE salary  -- 기타 대륙은 기본 급여 그대로 유지하여 지급
    END AS "변동된 급여(salary)"
FROM countries, employees;

-- CASE 4 : 직업에 따른 등급을 10개로 나눠서 해당 등급에 맞는 급여에 대한 상여금을 지급한다. 

SELECT max(max_salary) "직업 중 최대 급여", min(max_salary) "직업 중 최소 급여" from jobs;

SELECT max_salary,
    CASE 
        WHEN grade = 1 THEN max_salary * 0.05  -- 등급 1에는 현재 급여의 0.05배를 지급
        WHEN grade = 2 THEN max_salary * 0.03  -- 등급 2에는 현재 급여의 0.03배를 지급
        WHEN grade = 3 THEN max_salary * 0.01  -- 등급 3에는 현재 급여의 0.01배를 지급
        WHEN grade = 4 THEN max_salary * 0 -- 등급 4에는 현재 급여와 동일한 금액을 지급
    END AS "상여금"
FROM ( SELECT max_salary, width_bucket(max_salary, 5000, 40001, 4) AS grade FROM jobs);

-- CASE 5 : 현재 날짜를 기준으로 입사 20년차 이상은 보너스 10000 지급하는 쿼리 
-- 근무한 날짜 계산 후에 해당 년수가 20년 이상은 보너스 지급 대상자 인지 확인.
SELECT first_name || ' ' || last_name AS "이름", sysdate,hire_date,trunc((sysdate - hire_date)/365) AS "근무기간(년)",
    CASE
        WHEN trunc((sysdate - hire_date)/365) >= 20 THEN 10000
        ELSE 0
    END AS "보너스 지급"
FROM employees
ORDER BY trunc((sysdate - hire_date)/365) DESC;

-- CASE 6 : 직업별로 상사와 그 밑에 있는 부하 직원을 산출하고, 해당 부하직원의 급여을 보여주는 쿼리.
SELECT e1.first_name || ' ' || e1.last_name AS "상사", 
       e2.first_name || ' ' || e2.last_name AS "부하 직원",
       j.JOB_TITLE AS "직업명", e2.SALARY AS "급여"
FROM employees e1
JOIN employees e2 ON e1.EMPLOYEE_ID = e2.MANAGER_ID
JOIN jobs j ON e2.JOB_ID = j.JOB_ID
ORDER BY JOB_TITLE; 

-- CASE 7 : 근로년에 따른 연차 갯수 쿼리 
SELECT 
    EMPLOYEE_ID,
    CASE 
        WHEN hire_date > ADD_MONTHS(SYSDATE, -12) THEN 14  -- 1년 미만
        WHEN hire_date <= ADD_MONTHS(SYSDATE, -12) AND hire_date > ADD_MONTHS(SYSDATE, -36) THEN 14 + 3  -- 1년 이상 ~ 3년 미만
        WHEN hire_date <= ADD_MONTHS(SYSDATE, -36) AND hire_date > ADD_MONTHS(SYSDATE, -60) THEN 14 + 5  -- 3년 이상 ~ 5년 미만
        ELSE 14 + 7  -- 5년 이상   
    END AS 연차
FROM employees;

SELECT 
    EMPLOYEE_ID,
    CASE 
        WHEN hire_date > TO_DATE('2006-01-01', 'YYYY-MM-DD') THEN 14  -- 1년 미만
        WHEN hire_date <= TO_DATE('2006-01-01', 'YYYY-MM-DD') AND hire_date > ADD_MONTHS(TO_DATE('2006-01-01', 'YYYY-MM-DD'), -24) THEN 14 + 3  -- 1년 이상 ~ 3년 미만
        WHEN hire_date <= ADD_MONTHS(TO_DATE('2006-01-01', 'YYYY-MM-DD'), -24) AND hire_date > ADD_MONTHS(TO_DATE('2006-01-01', 'YYYY-MM-DD'), -48) THEN 14 + 5  -- 3년 이상 ~ 5년 미만
        ELSE 14 + 7  -- 5년 이상
    END AS 연차
FROM employees
ORDER BY 연차;


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------확인 공간----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM JOBS;
SELECT * FROM departments;
SELECT DEPARTMENT_NAME FROM departments;
SELECT * FROM leadership_effect;
SELECT * FROM countries;
SELECT COUNTRY_ID, COUNTRY_NAME, REGION_ID FROM countries -- ( 1: 유럽 2: 아메리카 3: 아시아 4: 아프리카)
WHERE REGION_ID = 3;


DROP TABLE leadership_effect;

CREATE TABLE leadership_effect (
    leader_id NUMBER,
    department_id NUMBER,
    country_id CHAR(2),
    job_id VARCHAR2(10),
    performance_rating NUMBER CHECK (performance_rating BETWEEN 1 AND 5),
    communication_skills_rating NUMBER CHECK (communication_skills_rating BETWEEN 1 AND 5),
    decision_making_skills_rating NUMBER CHECK (decision_making_skills_rating BETWEEN 1 AND 5),
    conflict_resolution_skills_rating NUMBER CHECK (conflict_resolution_skills_rating BETWEEN 1 AND 5),
    coaching_skills_rating NUMBER CHECK (coaching_skills_rating BETWEEN 1 AND 5),
    FOREIGN KEY (department_id) REFERENCES departments(DEPARTMENT_ID),
    FOREIGN KEY (country_id) REFERENCES countries(COUNTRY_ID),
    FOREIGN KEY (job_id) REFERENCES jobs(JOB_ID)
);

INSERT INTO leadership_effect (
    leader_id, 
    department_id, 
    country_id, 
    job_id, 
    performance_rating, 
    communication_skills_rating, 
    decision_making_skills_rating, 
    conflict_resolution_skills_rating, 
    coaching_skills_rating
) VALUES 
(1, 110, 'US', 'IT_PROG', 4.5, 4.8, 4.3, 4.6, 4.7);

INSERT INTO leadership_effect (
    leader_id, 
    department_id, 
    country_id, 
    job_id, 
    performance_rating, 
    communication_skills_rating, 
    decision_making_skills_rating, 
    conflict_resolution_skills_rating, 
    coaching_skills_rating
) VALUES 
(2, 120, 'CA', 'SA_REP', 4.2, 4.4, 4.0, 4.5, 4.6);

INSERT INTO leadership_effect (
    leader_id, 
    department_id, 
    country_id, 
    job_id, 
    performance_rating, 
    communication_skills_rating, 
    decision_making_skills_rating, 
    conflict_resolution_skills_rating, 
    coaching_skills_rating
) VALUES 
(3, 130, 'US', 'IT_PROG', 4.6, 4.9, 4.7, 4.4, 4.8);

INSERT INTO leadership_effect (
    leader_id, 
    department_id, 
    country_id, 
    job_id, 
    performance_rating, 
    communication_skills_rating, 
    decision_making_skills_rating, 
    conflict_resolution_skills_rating, 
    coaching_skills_rating
) VALUES 
(4, 140, 'JP', 'FI_MGR', 4.3, 4.6, 4.2, 4.4, 4.5);

INSERT INTO leadership_effect (
    leader_id, 
    department_id, 
    country_id, 
    job_id, 
    performance_rating, 
    communication_skills_rating, 
    decision_making_skills_rating, 
    conflict_resolution_skills_rating, 
    coaching_skills_rating
) VALUES 
(5, 150, 'CA', 'FI_ACCOUNT', 4.4, 4.7, 4.5, 4.3, 4.6);

INSERT INTO leadership_effect (
    leader_id, 
    department_id, 
    country_id, 
    job_id, 
    performance_rating, 
    communication_skills_rating, 
    decision_making_skills_rating, 
    conflict_resolution_skills_rating, 
    coaching_skills_rating
) VALUES 
(6, 10, 'ML', 'FI_ACCOUNT', 4.4, 4.7, 4.5, 4.3, 4.6);

INSERT INTO leadership_effect (
    leader_id, 
    department_id, 
    country_id, 
    job_id, 
    performance_rating, 
    communication_skills_rating, 
    decision_making_skills_rating, 
    conflict_resolution_skills_rating, 
    coaching_skills_rating
) VALUES 
(7, 20, 'ML', 'IT_PROG', 3.4, 4.2, 4.0, 3.3, 2.9);
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

-- Additional CASE 1 : 각 국가에서의 리더들의 여러가지 평가들에 대한 평균을 계산하기.
SELECT 
    c.COUNTRY_NAME,
    AVG(le.performance_rating) AS "각 리더들의 평가 점수", 
    AVG(le.communication_skills_rating) AS "커뮤니케이션 스킬 점수",
    AVG(le.decision_making_skills_rating) AS "의사 결정 능력 점수",
    AVG(le.conflict_resolution_skills_rating) AS "갈등 해결 능력 점수",
    AVG(le.coaching_skills_rating) AS "코칭 스킬 점수"
    
FROM 
    leadership_effect le
JOIN
    countries c ON le.country_id = c.country_ID
GROUP BY 
    c.COUNTRY_NAME
ORDER BY 
    c.COUNTRY_NAME;


-- Additional CASE 2 신용등급 만들고 대출 조회 계산하기 신용점수는(랜덤값)

CREATE TABLE CREDIT_RATING (
EMPLOYEE_ID NUMBER(6,0) PRIMARY KEY,
CREDIT_RATING NUMBER(3,0),
FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID));

SELECT * FROM EMPLOYEES;

SELECT * FROM CREDIT_RATING;

DROP TABLE CREDIT_RATING;

DELETE CREDIT_RATING;


INSERT INTO CREDIT_RATING (EMPLOYEE_ID, CREDIT_RATING)
SELECT EMPLOYEE_ID, FLOOR(DBMS_RANDOM.VALUE(1, 1000))
FROM EMPLOYEES
WHERE ROWNUM <= 206;

-- KDI-2 신용등급을 추가하고 신용등급에 따른 대출 승인 조회 ( 근무일수에 따라 이자율이 다름 ) 
-- AAA: 급여의 5배까지 대출 가능 AA : 급여의 4배까지 가능 A : 급여의 3배까지 가능
-- B :  급여의 2배까지 가능 C: 급여의 1.5배까지 가능
-- 근무일수가 8000이상 1%, 7500이상 1.5%, 7000이상 2%, 6500이상 2.5%, 6000이상 3%
SELECT 
    E.EMPLOYEE_ID AS 사원번호,
    E.LAST_NAME AS 사원이름,
    E.SALARY AS 급여,
    C.CREDIT_RATING AS 신용점수,
CASE 
    WHEN C.CREDIT_RATING >= 800 THEN 'AAA'
    WHEN C.CREDIT_RATING >= 700 THEN 'AA'
    WHEN C.CREDIT_RATING >= 600 THEN 'A'
    WHEN C.CREDIT_RATING >= 500 THEN 'B'
    WHEN C.CREDIT_RATING >= 400 THEN 'C'
    ELSE '대출 불가능'
END AS 신용등급,
CASE
    WHEN C.CREDIT_RATING >= 800 THEN E.SALARY * 5 
    WHEN C.CREDIT_RATING >= 700 THEN E.SALARY * 4
    WHEN C.CREDIT_RATING >= 600 THEN E.SALARY * 3
    WHEN C.CREDIT_RATING >= 500 THEN E.SALARY * 2
    WHEN C.CREDIT_RATING >= 400 THEN E.SALARY * 1.5
    ELSE 0
END AS 대출금액,
TRUNC(SYSDATE - E.HIRE_DATE) AS 근무일수,
CASE --C.CREDIT_RATING >= 400 > 대출 가능자에게만 이자율을 붙이기 위해
    WHEN TRUNC(SYSDATE - E.HIRE_DATE) >= 8000 AND C.CREDIT_RATING >= 400 THEN 1.0   
    WHEN TRUNC(SYSDATE - E.HIRE_DATE) >= 7500 AND C.CREDIT_RATING >= 400 THEN 1.5
    WHEN TRUNC(SYSDATE - E.HIRE_DATE) >= 7000 AND C.CREDIT_RATING >= 400 THEN 2.0
    WHEN TRUNC(SYSDATE - E.HIRE_DATE) >= 6500 AND C.CREDIT_RATING >= 400 THEN 2.5
    WHEN TRUNC(SYSDATE - E.HIRE_DATE) >= 6000 AND C.CREDIT_RATING >= 400 THEN 3.0
    ELSE 0
END AS 이자율
FROM 
    EMPLOYEES E
JOIN
    CREDIT_RATING C ON E.EMPLOYEE_ID = C.EMPLOYEE_ID;

