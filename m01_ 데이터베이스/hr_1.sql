SELECT * FROM employees;


-- Q 사번이 120번인 사람의 사번, 이름, 업무(JOB_ID), 업무명(JOB_TITLE)을 출력,
SELECT E.EMPLOYEE_ID 사번, E.FIRST_NAME 이름, E.LAST_NAME 성, E.JOB_ID 업무, J.JOB_TITLE 업무명
FROM EMPLOYEES E INNER JOIN JOBS J ON E.JOB_ID = J.JOB_ID WHERE E.EMPLOYEE_ID = 120;

-- FIRST_NAME || ' ' || LAST_NAME AS 이름 : FIRST_NAME과 LAST_NAME을 공백으로 연결하여
-- 하나의 문자열로 합치고, 이 결과의 별칭을 이름 '이름'으로 지정
SELECT E.EMPLOYEE_ID 사번, FIRST_NAME || ' ' || LAST_NAME AS 이름, J.JOB_ID 업무, J.JOB_TITLE 업무명
FROM EMPLOYEES E, JOBS J  WHERE E.EMPLOYEE_ID = 120 AND E.JOB_ID = J.JOB_ID;

-- Q 2005년 상반기에 입사한 사람들의 이름(FULL NAME)만 출력
SELECT FIRST_NAME || ' ' || LAST_NAME AS 이름, HIRE_DATE 입사일 FROM employees WHERE TO_CHAR(HIRE_DATE,'YY/MM')
BETWEEN '05/01' AND '05/06';

-- _을 와일드카드가 아닌 문자로 취급하고 싶을 떄 ESCAPE 옵션을 사용
SELECT * FROM employees WHERE JOB_ID LIKE '%\_A%';
SELECT * FROM employees WHERE JOB_ID LIKE '%\_A%' ESCAPE '\';
SELECT * FROM employees WHERE JOB_ID LIKE '%#_A%' ESCAPE '#';

-- IN : OR 대신 사용
SELECT * FROM employees WHERE MANAGER_ID = 101 OR MANAGER_ID = 102 OR MANAGER_ID = 103;
SELECT * FROM employees WHERE MANAGER_ID IN (101,102,103);

-- Q 업무 SA_MAN, IT_PROG, ST_MAN 인 사람만 출력
SELECT * FROM employees WHERE JOB_ID IN('SA_MAN', 'IT_PROG', 'ST_MAN');

-- IS NULL / IS NOT NULL
-- NULL 값인지를 확인할 경우 = 비교 연산자를 사용하지 않고 IS NULL을 사용한다
SELECT * FROM employees WHERE COMMISSION_PCT IS NULL;
SELECT * FROM employees WHERE COMMISSION_PCT IS NOT NULL;


-- ORDER BY
-- ORDER BY 컬림명 [ ASC | DESC ]
SELECT * FROM employees ORDER BY SALARY ASC;
SELECT * FROM employees ORDER BY SALARY DESC;
SELECT * FROM employees ORDER BY SALARY ASC, LAST_NAME DESC;

-- DUAL 테이블
-- MOD 나머지
SELECT * FROM employees WHERE MOD ( EMPLOYEE_ID, 2 ) = 1;
SELECT MOD( 10, 3 ) FROM DUAL;


-- ROUND()
SELECT ROUND( 355.95555 ) FROM DUAL;
SELECT ROUND( 355.95555, 2 ) FROM DUAL;
SELECT ROUND( 355.95555, -2 ) FROM DUAL;

-- TRUNC() 버림 함수, 지정한 자리수 이하를 버린 결과 제공
SELECT TRUNC( 45.5555, 1 ) FROM DUAL;

-- CEIL() 무조건 올림
SELECT CEIL ( 45.111 ) FROM DUAL; 

-- Q HR EMPLOYEES 테이블에서 이름, 급여, 10% 인상된 급여을 출력하세요
SELECT LAST_NAME 이름, SALARY 급여, SALARY * 1.1 "인상된 급여" FROM employees;

-- Q EMPLOYEES_ID가 홀수인 직원의 EMPLPYEE_ID와 LAST_NAME을 출력하세요.
SELECT EMPLOYEE_ID 사원번호, LAST_NAME 이름 FROM employees 
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM employees WHERE MOD( EMPLOYEE_ID, 2 ) = 1);

-- Q EMPLOYEES 테이블에서 COMMISSION_PCT 의 NULL값 갯수를 출력하세요
SELECT COUNT(*) FROM employees WHERE COMMISSION_PCT IS NULL;

-- Q EMPLOYEES 테이블에서 DEPARMENT_ID 가 없는 직원을 추출하여 POSITON을 '신입'으로 출력하세요(POSITION 열 추가)
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, '신입' POSITION 
FROM employees WHERE DEPARTMENT_ID IS NULL;

-- 날짜 관련
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE + 1 FROM DUAL;
SELECT SYSDATE - 1 FROM DUAL;


-- 근무한 날짜 계산
SELECT LAST_NAME, SYSDATE, HIRE_DATE, TRUNC(SYSDATE-HIRE_DATE) 근무기간 FROM EMPLOYEES;

-- ADD_MONTHS( )        특정 개월 수를 더한 날짜를 구한다
SELECT LAST_NAME, HIRE_DATE, ADD_MONTHS( HIRE_DATE, 6 ) REVISED_DATE FROM employees;

-- LAST_DAY( )          해당 월의 마지막 날짜를 반환하는 함수
SELECT LAST_NAME, HIRE_DATE, LAST_DAY( HIRE_DATE ) FROM employees;

SELECT LAST_NAME, HIRE_DATE, LAST_DAY( ADD_MONTHS( HIRE_DATE, 1 )) FROM employees; 

-- NEXT_DAY( )          해당 날짜를 기준으로 다음에 오는 요일에 해당하는 날짜를 반환
SELECT HIRE_DATE, NEXT_DAY( HIRE_DATE, '월' ) FROM employees;
SELECT HIRE_DATE, NEXT_DAY( HIRE_DATE, 2 ) FROM employees;

-- MONTHS_BETWEEN( )    날짜와 날짜 사이의 개월수를 구한다
SELECT HIRE_DATE, ROUND( MONTHS_BETWEEN ( SYSDATE, HIRE_DATE ) , 1 ) FROM employees;

-- 형 변환 함수  : TO_DATE( )    문자열을 날짜로
-- '2023-01-01' 이라는 문자열을 날짜 타입으로 변환
SELECT TO_DATE('2023-01-01', 'YYYY-MM-DD' ) FROM DUAL;

-- TO_CHAR ( 날짜 )       날짜를 문자로 변환
SELECT TO_CHAR( SYSDATE, 'YY/MM/DD' ) FROM DUAL;

--형식
--YYYY       네 자리 연도
--YY      두 자리 연도
--YEAR      연도 영문 표기
--MM      월을 숫자로
--MON      월을 알파벳으로
--DD      일을 숫자로
--DAY      요일 표현
--DY      요일 약어 표현
--D      요일 숫자 표현
--AM 또는 PM   오전 오후
--HH 또는 HH12   12시간
--HH24      24시간
--MI      분
--SS      초



-- Q 현재 날짜( SYSDATE ) 를 'YYYY/MM/DD'형식의 문자열로 변환하세요
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') "날짜" FROM DUAL;

-- Q '01-01-2023'이라는 문자열을 날짜 타입으로 변환하세요
SELECT TO_DATE('01-01-2023', 'MM-DD-YYYY' ) "날짜" FROM DUAL;

-- Q 현재 날짜와 시간 (SYSDATE)을 'YYYY-MM-DD HH24:MI:SS' 형식의 문자열로변환하세요
SELECT TO_CHAR( SYSDATE, 'YYYY-MM-DD HH24:MI:SS' ) FROM DUAL;

-- Q '2023-01-01 15:30:00'이라는 문자열을 날짜 및 시간 타입으로 변환하세요
SELECT TO_DATE('2023-01-01 15:30:00', 'YYYY-MM-DD HH24:MI:SS' ) FROM DUAL;


--to_char( 숫자 )   숫자를 문자로 변환
--9      한 자리의 숫자 표현      ( 1111, ‘99999’ )      1111   
--0      앞 부분을 0으로 표현      ( 1111, ‘099999’ )      001111
--$      달러 기호를 앞에 표현      ( 1111, ‘$99999’ )      $1111
--.      소수점을 표시         ( 1111, ‘99999.99’ )      1111.00
--,      특정 위치에 , 표시      ( 1111, ‘99,999’ )      1,111
--MI      오른쪽에 - 기호 표시      ( 1111, ‘99999MI’ )      1111-
--PR      음수값을 <>로 표현      ( -1111, ‘99999PR’ )      <1111>
--EEEE      과학적 표현         ( 1111, ‘99.99EEEE’ )      1.11E+03
--V      10을 n승 곱한값으로 표현   ( 1111, ‘999V99’ )      111100
--B      공백을 0으로 표현      ( 1111, ‘B9999.99’ )      1111.00
--L      지역통화         ( 1111, ‘L9999’ )


SELECT SALARY, TO_CHAR( SALARY, '0999999' ) FROM employees;
SELECT SALARY, TO_CHAR( -SALARY, '999999PR') FROM employees;
-- 1111 -> 1.11E+03
SELECT TO_CHAR( 11111, '9.999EEEE' ) FROM DUAL;
SELECT TO_CHAR( -1111111, '9999999MI') FROM DUAL;

-- WIDTH_BUCKET( )      지정값, 최소값, 최대값, BUCKET 개수
SELECT WIDTH_BUCKET( 92, 0, 100, 10 ) FROM DUAL;
SELECT WIDTH_BUCKET( 100, 0, 100, 10 ) FROM DUAL;

-- EMPLOYEES 테이블의 SALARY를 5개 등급으로 표시하세요
SELECT MAX(SALARY) MAX, MIN(SALARY) MIN FROM employees;
SELECT SALARY, WIDTH_BUCKET(SALARY, 2100, 24001, 5) AS GRADE FROM employees;



-- 문자 함수 CHARACTER FUNCTION
-- UPPER()      대문자로 변경
SELECT UPPER ( 'Hello World' ) FROM DUAL;
-- LOWER()      소문자로 변경
SELECT LOWER ( 'Hello World' ) FROM DUAL;

-- Q LAST_NAME이 SEO인 직원의 LAST_NAME 과 SALARY를 구하세요 (Seo, SEO, seo 모두 검출) 
SELECT LAST_NAME,SALARY FROM employees WHERE LOWER(LAST_NAME) = 'seo'; 

-- INITCAP()    첫글자만 대문자
SELECT JOB_ID, INITCAP( JOB_ID ) FROM employees;

-- LENGTH()     문자열의 길이
SELECT JOB_ID, LENGTH( JOB_ID ) FROM employees;

-- INSTR( )     문자열, 찾을 문자, 찾을 위치, 찾은 문자 중 몇 번 쨰
SELECT INSTR( 'Hello World', 'o', 3, 2 ) FROM DUAL;


-- SUBSTR()     문자열, 시작위치, 개수
SELECT SUBSTR ( 'Hello World', 3, 3) FROM DUAL;
SELECT SUBSTR ( 'Hello World', 9, 3) FROM DUAL;
SELECT SUBSTR ( 'Hello World', -3, 3) FROM DUAL;

-- LPAD( )      오른쪽 정렬 후 왼쪽에 문자를 채운다
SELECT LPAD('Hello World', 20, '#' ) FROM DUAL;

-- RPAD( )      왼쪽 정렬 후 오른쪽에 문자를 채운다
SELECT RPAD('Hello World', 20, '#' ) FROM DUAL;

-- LTRIM( ) 
SELECT LTRIM( 'aaaHello Worldaaa', 'a') FROM DUAL;
SELECT LTRIM( '   Hello World   ') FROM DUAL;

-- RTRIM( )
SELECT RTRIM( 'aaaHello Worldaaa', 'a' ) FROM DUAL;
SELECT RTRIM( '   Hello World   ' ) FROM DUAL;

SELECT LAST_NAME FROM employees;

SELECT LAST_NAME AS 이름, LTRIM(LAST_NAME, 'A') AS 변환 FROM employees;


-- TRIM
SELECT TRIM('   Hello World   ') FROM DUAL;

-- 앞뒤의 특정 문자 제거
SELECT LAST_NAME, TRIM( 'A' FROM LAST_NAME ) FROM employees;



-- NVL( ) NULL을 0 또는 다른 값으로 변환하는 함수
SELECT LAST_NAME, MANAGER_ID, NVL( TO_CHAR ( MANAGER_ID ) , 'CEO') REVISED_ID FROM EMPLOYEES;

--decode()    if문이나 case문과 같이 여러 경우를 선택할 수 있도록 하는 함수
--DECODE 함수는 단순한 조건에 기반하여 값을 반환합니다. 구문은 DECODE(expression, search1, result1, ..., searchN, resultN, default) 
--여기서 expression은 검사할 값을 나타내고, search와 result는 각각 조건과 해당 조건이 참일 때 반환할 값
--default는 모든 search 조건이 거짓일 때 반환할 기본 값 출력

SELECT LAST_NAME, DEPARTMENT_ID,
DECODE(DEPARTMENT_ID,
    90, '경영지원실',
    60, '프로그래머',
    100, '인사부','기타') 부서 FROM EMPLOYEES;

-- Q EMPLOYEES 테이블에서 COMMISSION_PCT가 NULL이 아닌 경우, 'A' NULL인 경우 'N'을 표시하는 쿼리를 작성
SELECT COMMISSION_PCT AS  COMMISSION, DECODE(COMMISSION_PCT,NULL,'N','A') AS 변환
FROM EMPLOYEES ORDER BY 변환 DESC;


--case()
--decode() 함수와 유사하나 decode() 함수는 단순한 조건 비교에 사용되는 반면
--case() 함수는 다양한 비교연산자로 조건을 제시할 수 있다.
--CASE 문은 조건에 따라 다른 값을 반환하는 데 사용되며, DECODE보다 복잡한 조건을 표현할 수 있다. 
--구문은 CASE WHEN condition THEN result ... ELSE default END이다. 
SELECT LAST_NAME, DEPARTMENT_ID,
CASE WHEN DEPARTMENT_ID = 90 THEN '경영지원'
WHEN DEPARTMENT_ID = 60 THEN '프로그래머'
WHEN DEPARTMENT_ID = 100 THEN '인사부'
ELSE '기타' END AS 소속 FROM EMPLOYEES;


-- Q EMPLOYEES 테이블에서 SALARY가 20000 이상이면 'A', 10000과 20000 미만 사이면 'B',
-- 그 이하면 'C'로 표시하는 쿼리를 작성하시오
SELECT LAST_NAME, SALARY,
CASE 
WHEN SALARY >= 20000 THEN 'A'
WHEN SALARY > 10000 AND SALARY < 20000 THEN 'B' 
ELSE 'C' END AS 봉급 FROM EMPLOYEES;


--INSERT
--테이블에 데이터를 입력하는 방법은 두 가지 유형이 있으며 한 번에 한 건만 입력된다.
--a. INSERT INTO 테이블명 (COLUMN_LIST) VALUES (COLUMN_LIST에 넣을 VALUE_LIST);
--b. INSERT INTO 테이블명 VALUES (전체 COLUMN에 넣을 VALUE_LIST);

-- CONCATENATION : 콤마 대신에 사용하면 문자열이 연결되어 출력된다.
SELECT LAST_NAME, ' IS A ',JOB_ID FROM EMPLOYEES;
SELECT LAST_NAME || ' IS A ' || JOB_ID FROM EMPLOYEES;

-- UNION
-- UNION( 합집합 ) INTERSECT ( 교집합 ) MINUS( 차집합 ), UNION ALL( 겹치는 것까지 포함 )
-- 두 개의 쿼리문을 사용해야한다. 데이터 타입을 일치 시켜야 한다
SELECT FIRST_NAME 이름, SALARY 급여, HIRE_DATE FROM EMPLOYEES
WHERE SALARY < 5000 
UNION
SELECT FIRST_NAME 이름, SALARY 급여, HIRE_DATE FROM EMPLOYEES
WHERE HIRE_DATE < '05/01/01';

SELECT FIRST_NAME 이름, SALARY 급여, HIRE_DATE FROM EMPLOYEES
WHERE SALARY < 5000 
MINUS
SELECT FIRST_NAME 이름, SALARY 급여, HIRE_DATE FROM EMPLOYEES
WHERE HIRE_DATE < '05/01/01';

SELECT FIRST_NAME 이름, SALARY 급여, HIRE_DATE FROM EMPLOYEES
WHERE SALARY < 5000 
INTERSECT
SELECT FIRST_NAME 이름, SALARY 급여, HIRE_DATE FROM EMPLOYEES
WHERE HIRE_DATE < '05/01/01';

SELECT FIRST_NAME 이름, SALARY 급여, HIRE_DATE FROM EMPLOYEES
WHERE SALARY < 5000 
UNION ALL
SELECT FIRST_NAME 이름, SALARY 급여, HIRE_DATE FROM EMPLOYEES
WHERE HIRE_DATE < '05/01/01';


--CREATE VIEW 명령어는 오라클 SQL에서 테이블의 특정 부분이나 조인된 결과를 논리적인 뷰(view)로 만들 때 사용
--뷰는 데이터를 요약하거나 복잡한 조인을 단순화하며, 사용자에게 필요한 데이터만을 보여주는 데 유용
--뷰는 실제 테이블 데이터를 저장하지 않고, 대신 쿼리 결과를 저장
--뷰의 주요 특징
--쿼리 단순화: 복잡한 쿼리를 뷰로 저장함으로써 사용자는 복잡한 쿼리문을 반복해서 작성할 필요 없이 간단하게 뷰를 참조할 수 있다.
--데이터 추상화: 뷰는 기본 테이블의 구조를 숨기고 사용자에게 필요한 데이터만을 보여줄 수 있어, 데이터 추상화를 제공.
--보안 강화: 뷰를 사용하면 특정 데이터에 대한 접근을 제한할 수 있으며, 사용자가 볼 수 있는 데이터의 범위를 제어할 수 있다.
--데이터 무결성 유지: 뷰를 사용하여 데이터를 수정하더라도, 이 변경사항이 기본 테이블의 데이터 무결성 규칙을 위반하지 않도록 관리할 수 있다.

CREATE VIEW EMPLOYEE_DETAILS AS
SELECT EMPLOYEE_ID, LAST_NAME, DEPARTMENT_ID FROM EMPLOYEES;

SELECT * FROM EMPLOYEE_DETAILS;

-- Q EMPLOYEES 테이블에서 SALARY가 10000원 이상인 직원만을 포함하는 뷰 
-- SPECIAL_EMPLOYEE를 생성하는 SQL 명령문을 작성하시오.
CREATE VIEW SPECIAL_EMPLOYEE AS 
SELECT * FROM EMPLOYEES WHERE SALARY >= 10000;

SELECT * FROM SPECIAL_EMPLOYEE;

-- Q EMPLOYEES 테이블에서 각 부서별 직원 수를 포함하는 뷰를 생성하세요.
CREATE VIEW DEPARTMENT_EMPLOYEE_COUNT AS
SELECT DEPARTMENT_ID, COUNT(*) AS 부서별_직원수 FROM EMPLOYEES
GROUP BY DEPARTMENT_ID ORDER BY 부서별_직원수;

SELECT * FROM DEPARTMENT_EMPLOYEE_COUNT;

-- Q EMPLOYEES 테이블에서 근속기간이 10년 이상인 직원을 포함하는 뷰를 생성하세요
CREATE VIEW QOINMUL AS 
SELECT LAST_NAME, ROUND(SYSDATE-HIRE_DATE) AS 근속기간
FROM EMPLOYEES WHERE ROUND(SYSDATE-HIRE_DATE) > 365 * 10;

SELECT * FROM QOINMUL;

SELECT LAST_NAME, ROUND(SYSDATE-HIRE_DATE) AS 근속기간
FROM EMPLOYEES WHERE ROUND(SYSDATE-HIRE_DATE) > 365 * 10 ORDER BY 근속기간;


--TCL (Transaction Control Language)
--COMMIT: 현재 트랜잭션 내에서 수행된 모든 변경(INSERT, UPDATE, DELETE 등)을 데이터베이스에 영구적으로 저장.
--COMMIT 명령을 실행하면, 트랜잭션은 완료되며, 그 이후에는 변경 사항을 되돌릴 수 없다.
--ROLLBACK: 현재 트랜잭션 내에서 수행된 변경들을 취소하고, 데이터베이스를 트랜잭션이 시작하기 전의 상태로 되돌린다. 
--오류가 발생했거나 다른 이유로 트랜잭션을 취소해야 할 경우에 사용된다.
--SAVEPOINT: 트랜잭션 내에서 중간 체크포인트를 생성합니다. 오류가 발생할 경우, ROLLBACK을 사용하여 최근의 SAVEPOINT까지 되돌릴 수 있다.
--트랜잭션을 콘트롤하는 TCL(TRANSACTION CONTROL LANGUAGE)

CREATE TABLE MEMBERS (
MEMBER_ID NUMBER PRIMARY KEY,
NAME VARCHAR2(100),
EMAIL VARCHAR2(100),
JOIN_DATE DATE,
STATUS VARCHAR2(20));

INSERT INTO members (member_id, name, email, join_date, status) VALUES (1, 'John Doe', 'john@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (2, 'Jane Doe', 'jane@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (3, 'Mike Smith', 'mike@example.com', SYSDATE, 'Inactive');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (4, 'Alice Johnson', 'alice@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (5, 'Bob Brown', 'bob@example.com', SYSDATE, 'Inactive');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (6, 'Bob Brown', 'bob@example.com', SYSDATE, 'Inactive');

SELECT * FROM MEMBERS;

SAVEPOINT SP1;

INSERT INTO members (member_id, name, email, join_date, status) VALUES (7, 'LEE RIW', 'LEE@GOOGLE.com', SYSDATE, 'Inactive');

ROLLBACK TO SP1;

COMMIT;

--부서별 급여 현황
--테이블생성, 부서별 급여와 총 급여를 확인 할 수 있음.
--(급여의 합 평균 최솟값 최댓값, 총 직원수, 급여전체총합, 직원평균급여, 부서평균급여)
--table 만들기 부서별 급여를 대략적으로 보기
--사용할 테이블 확인
select * from jobs;
select * from departments;
select * from employees;
select * from job_history;

--부서 목록 확인
SELECT department_id
from employees
group by department_id
order by department_id DESC;
-- 부서 목록 department_id : 10,20,30,40,50,60,70,80,90,100,110 그 외 나머지(120~200등..)는 없고 null 값이 있음.
--department_id 가 null 인 사람은 모두 job_id 에 맞는 department_id 를 부여해주려고함(데이터 무결성)
--1. department_id 가 null 값인 사람 찾기
select *
from employees
where department_id IS NULL;
--한명 밖에 없음. department_id : null, employee_id : 178, Job_id : SA_REP

--2. job_id 가 SA_REP 인 department_id 찾기 (직업에 맞는 부서 찾기)
select job_id, department_id
from job_history
where job_id IN 'SA_REP';
--SA_REP 의 department_id 는 80

--3. 수정 전 savepoint 생성
SAVEPOINT null_to_80;
------------------------SAVEPOINT---------------------------------

--4. 제약조건primary key 인 employee_id 로 찾아서 derpartment_id 를 80으로 수정
UPDATE employees
SET department_id = 80
WHERE employee_id = 178;

select * from employees where employee_id = 178;
--ROLLBACK null_to_80; -- savepoint로 가기
--commit;
--수정끝


-- 탐구성 및 년차별 샐러리
-- 각 부서마다 팀원은 몇명이고 어떤 포지션들이 있고 구성은 어떻게 되는지
-- ROLLUP은 다차원적인 집계 결과를 도출 : 사용 각 부서 및 직무별 직원 수를 집계
SELECT E.DEPARTMENT_ID, D.DEPARTMENT_NAME, NVL(E.JOB_ID,'TOTAL') JOB_ID, COUNT(*) 직원수
FROM EMPLOYEES E LEFT OUTER JOIN DEPARTMENTSD ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY ROLLUP((E.DEPARTMENT_ID, D.DEPARTMENT_NAME), E.JOB_ID) ORDER BY E.DEPARTMENT_ID;

-- JOB ID 별 몇년차는 얼마 받는지 각 년차별로 샐러리 평균
SELECT JOB_ID, 연차, ROUND(AVG(SALARY)) 평균급여
FROM (SELECT JOB_ID, FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12) AS 연차, SALARY FROM EMPLOYEES)
GROUP BY JOB_ID, 연차 ORDER BY JOB_ID, 연차;



