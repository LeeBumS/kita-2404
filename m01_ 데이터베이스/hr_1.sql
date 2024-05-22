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




































































































































































































































