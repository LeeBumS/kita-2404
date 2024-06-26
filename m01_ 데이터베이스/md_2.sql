SELECT BOOKID FROM BOOK;

SELECT * FROM customer;
SELECT * FROM orders;
SELECT * FROM imported_book;


-- 중복없이 출력
SELECT DISTINCT publisher FROM BOOK;

-- Q 가격이 10,000원 이상인 도서를 검색
SELECT * FROM BOOK WHERE price > 10000;

-- Q 가격이 10,000 이상 20,000 이하인 도서를 검색하세요 (2가지 방법)
SELECT * FROM BOOK WHERE price > 10000 AND price <= 20000;

SELECT * FROM BOOK WHERE price BETWEEN 10000 AND 20000;


-- lIKE는 정확히 '축구의 역사'와 일치하는 행만 선택
SELECT bookname, publisher FROM BOOK WHERE bookname LIKE '축구의 역사';

-- %: 0개 이상의 임의의 문자
-- _: 정확히 1개의 임의의 문자
-- '축구' 가 포함된 출판사

--'축구'가 포함된 출판사
SELECT bookname, publisher FROM BOOK WHERE bookname LIKE '%축구%';

-- 도서이름의 왼쪽 두 번쨰 위치에 '구'라는 문자열을 갖는 도서
SELECT bookname, publisher FROM BOOK WHERE bookname LIKE '%_구%';

-- ORDER BY : 기본 올림차순 정렬 (default)  
SELECT * FROM BOOK ORDER BY PRICE;

-- 내림차순 
SELECT * FROM book ORDER BY PRICE DESC;

-- Q 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하세요
SELECT * FROM book ORDER BY PRICE,BOOKNAME;


SELECT SUM(SALEPRICE) AS  "총 판매액" FROM ORDERS WHERE CUSTID = 2;


-- GROUP BY: 데이터를 특정 기준에 따라 그룹화하는데 사용, 이를 통해 집계 함수(SUM, AVG, MAX, MIN, COUNT)를 이용, 계산
SELECT SUM(SALEPRICE) AS TOTAL, AVG(SALEPRICE) AS AVERAGE, MIN(SALEPRICE) AS MINNUM, MAX(SALEPRICE) AS MAXINUM FROM ORDERS;

-- 총판매액을 custid 기준으로 그룹화
SELECT custid, COUNT(*) AS 도서수량, SUM(SALEPRICE) AS "총 판매액" FROM ORDERS GROUP BY CUSTID;

-- BOOKID가 5보다 큰 조건
SELECT custid, COUNT(*) AS 도서수량, SUM(SALEPRICE) AS "총 판매액" 
FROM ORDERS WHERE BOOKID > 5 GROUP BY CUSTID;

-- 도서수량이 2보다 큰 조건
SELECT custid, COUNT(*) AS 도서수량, SUM(SALEPRICE) AS "총 판매액" 
FROM ORDERS WHERE BOOKID > 5 GROUP BY CUSTID HAVING COUNT(*) > 2;


-- Q 고객의 이름과 고객이 주문한 도서의 이름을 구하세요.
SELECT c.name AS customer_name, b.bookname FROM customer C, book B,
orders O WHERE c.custid = o.custid AND o.bookid = b.bookid;

SELECT c.name AS customer_name, b.bookname AS book_name
FROM Customer c
JOIN Orders o ON c.custid = o.custid
JOIN Book b ON o.bookid = b.bookid;

-- Q 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT c.name AS customer_name, b.bookname AS book_name
FROM Customer c
JOIN Orders o ON c.custid = o.custid
JOIN Book b ON o.bookid = b.bookid
WHERE b.price = 20000;


-- JOIN은 두 개 이상의 테이블을 연결하여 관련된 데이터를 결합할 떄 사용
-- 내부 조인 (Inner Join)
SELECT customer.name, orders.saleprice FROM customer INNER JOIN orders ON
customer.custid = orders.custid;

-- 왼쪽 외부 조인 (LEFT OUTER JOIN) : 두 번쨰 테이블에 일치하는 데이터가 없는 경우 NULL값이 사용
SELECT customer.name, orders.saleprice FROM customer LEFT OUTER 
JOIN orders ON customer.custid = orders.custid;

--오른쪽 외부 조인 (Right Outer Join) : 첫 번째 테이블에 일치하는 데이터가 없는 경우 NULL 값이 사용
SELECT customer.name, orders.saleprice FROM customer 
RIGHT OUTER JOIN orders ON customer.custid = orders.custid;


--FULL OUTER JOIN : 일치하는 데이터가 없는 경우 해당 테이블에서는 NULL 값이 사용
SELECT customer.name, orders.saleprice FROM customer
FULL OUTER JOIN orders ON customer.custid=orders.custid;

--CROSS JOIN : 두 테이블 간의 모든 가능한 조합을 생성
SELECT customer.name, orders.saleprice FROM customer CROSS JOIN orders;


-- Q 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오
-- ( 2가지 방법 WHERE, JOIN)

SELECT C.name, O.saleprice FROM customer C, orders O WHERE c.custid = o.custid(+);

SELECT customer.name, orders.saleprice FROM customer 
LEFT OUTER JOIN orders  ON customer.custid = orders.custid;

-- 부속 질의
SELECT * FROM book;
SELECT * FROM orders;
SELECT * FROM customer;

-- Q 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
SELECT name FROM customer WHERE custid IN (SELECT custid FROM orders);

--Q. ‘대한미디어’에서 출판한 도서를 구매한 고객의 이름을 보이시오.
SELECT C.name FROM Customer C 
JOIN Orders O ON C.custid = O.custid
JOIN Book B ON O.bookid = B.bookid
WHERE B.publisher = '대한미디어';

SELECT NAME FROM customer 
WHERE custid IN (SELECT CUSTID FROM ORDERS
WHERE BOOKID IN (SELECT BOOKID FROM BOOK
WHERE PUBLISHER = '대한미디어'));

--Q. 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
SELECT B1.BOOKNAME FROM BOOK B1 WHERE B1.PRICE > (SELECT AVG(B2.PRICE)
FROM BOOK B2 WHERE B2.PUBLISHER = B1.PUBLISHER);


--Q. 도서를 주문하지 않은 고객의 이름을 보이시오.
SELECT customer.name FROM customer LEFT OUTER JOIN orders 
ON customer.custid = orders.custid WHERE orders.orderdate IS NULL;

SELECT NAME FROM CUSTOMER WHERE CUSTID NOT IN (SELECT CUSTID FROM ORDERS);

--Q. 주문이 있는 고객의 이름과 주소를 보이시오.
SELECT NAME 고객이름, ADDRESS 주소 FROM CUSTOMER WHERE CUSTID
IN (SELECT CUSTID FROM ORDERS);



--데이터 타입
--숫자형 (Numeric Types)
--NUMBER: 가장 범용적인 숫자 데이터 타입. 정수, 실수, 고정 소수점, 부동 소수점 수를 저장
--NUMBER는 NUMBER(38, 0)와 같은 의미로 해석, Precision 38은 자리수, Scale 0은 소수점 이하 자릿수
--NUMBER(10), NUMBER(8, 2) 
--문자형 (Character Types)
--VARCHAR2(size): 가변 길이 문자열을 저장. size는 최대 문자 길이를 바이트, 혹은 글자수로 지정
--NVARCHAR2(size)의 사이즈를 지정할 때는 바이트 단위 대신 항상 문자 단위로 크기가 지정
--CHAR(size): 고정 길이 문자열을 저장. 지정된 길이보다 짧은 문자열이 입력되면 나머지는 공백으로 채워짐

--날짜 및 시간형 (Date and Time Types)
--DATE: 날짜와 시간을 저장. 데이터 타입은 년, 월, 일, 시, 분, 초를 포함
--DATE 타입은 날짜와 시간을 YYYY-MM-DD HH24:MI:SS 형식으로 저장합니다.
--예를 들어, 2024년 5월 20일 오후 3시 45분 30초는 2024-05-20 15:45:30으로 저장

--TIMESTAMP: 날짜와 시간을 더 상세히 나노초 단위까지 저장
--이진 데이터형 (Binary Data Types)
--BLOB: 대량의 이진 데이터를 저장. 이미지, 오디오 파일 등을 저장하는 데 적합
--대규모 객체형 (Large Object Types)
--CLOB: 대량의 문자 데이터를 저장
--NCLOB: 대량의 국가별 문자 집합 데이터를 저장

--문자 인코딩의 의미
--컴퓨터는 숫자로 이루어진 데이터를 처리. 인코딩을 통해 문자(예: 'A', '가', '?')를 
--숫자(코드 포인트)로 변환하여 컴퓨터가 이해하고 저장할 수 있게 한다.
--예를 들어, ASCII 인코딩에서는 대문자 'A'를 65로, 소문자 'a'를 97로 인코딩. 
--유니코드 인코딩에서는 'A'를 U+0041, 한글 '가'를 U+AC00, 이모티콘 '?'를 U+1F60A로 인코딩
--아스키는 7비트를 사용하여 총 128개의 문자를 표현하는 반면 유니코드는 최대 1,114,112개의 문자를 표현

--ASCII 인코딩:
--문자 'A' -> 65 (10진수) -> 01000001 (2진수)
--문자 'B' -> 66 (10진수) -> 01000010 (2진수)

--유니코드(UTF-8) 인코딩: 
--문자 'A' -> U+0041 -> 41 (16진수) -> 01000001 (2진수, ASCII와 동일)
--문자 '가' -> U+AC00 -> EC 95 80 (16진수) -> 11101100 10010101 10000000 (2진수)

--CLOB: CLOB은 일반적으로 데이터베이스의 기본 문자 집합(예: ASCII, LATIN1 등)을 사용하여 텍스트 데이터를 저장. 
--이 때문에 주로 영어와 같은 단일 바이트 문자로 이루어진 텍스트를 저장하는 데 사용.
--NCLOB: NCLOB은 유니코드(UTF-16)를 사용하여 텍스트 데이터를 저장. 따라서 다국어 지원이 필요할 때, \
--즉 다양한 언어로 구성된 텍스트 데이터를 저장할 때 적합. 다국어 문자가 포함된 데이터를 효율적으로 처리할 수 있다.

-- VARCHAR2는 두 가지 방식으로 길이를 정의 : 바이트와 문자
-- 설정 확인 방법
SELECT * FROM v$nls_parameters WHERE parameter = 'NLS_LENGTH_SEMANTICS';

--제약조건 : 
--PRIMARY KEY : 각 행을 고유하게 식별하는 열(또는 열들의 조합). 중복되거나 NULL 값을 허용하지 않는다.
--FOREIGN KEY : 다른 테이블의 기본 키를 참조하는 열. 참조 무결성을 유지
--UNIQUE : 열에 중복된 값이 없어야 함을 지정. NULL값이 허용
--NOT NULL : 열에 NULL 값을 허용하지 않는다.
--CHECK : 열 값이 특정 조건을 만족해야 함을 지정 (예: age > 18)
--DEFAULT : 열에 명시적인 값이 제공되지 않을 경우 사용될 기본값을 지정


-- AUTHOR 테이블 생성
CREATE TABLE authors (
id NUMBER PRIMARY KEY,
first_name VARCHAR2(50) NOT NULL,
last_name VARCHAR2(50) NOT NULL,
nationality VARCHAR2(50));

DROP TABLE AUTHORS;

CREATE TABLE newbook (
bookid NUMBER,
isbn NUMBER(13),
bookname VARCHAR2(50) NOT NULL,
author VARCHAR2(50) NOT NULL,
publisher VARCHAR2(30) NOT NULL,
price NUMBER DEFAULT 10000 CHECK(price > 1000),
published_date DATE,
PRIMARY KEY(bookid));

DESC NEWBOOK;

INSERT INTO NEWBOOK VALUES(2, 978123456789, 'SQL Guide', 'John Doe', 'TechBooks', 15000, TO_DATE('2024-05-20', 'YYYY-MM-DD'));

SELECT * FROM newbook;

-- 테이블 제약조건 수정, 추가, 속성 추가, 삭제, 수정
ALTER TABLE NEWBOOK MODIFY (ISBN VARCHAR2(50));
ALTER TABLE NEWBOOK ADD AUTHOR_ID NUMBER;
ALTER TABLE NEWBOOK DROP COLUMN AUTHOR_ID;

DELETE FROM NEWBOOK;

-- ON DELETE CASCADE 옵션이 설정되어 있어, NEWCUSTOMER 테이블에서 어떤 고객의 레코드가 삭제되면,
-- 해당 고객의 모든 주문이 NEWORDERS 테이블에서도 자동으로 삭제
CREATE TABLE NEWCUSTOMER(
CUSTID NUMBER PRIMARY KEY,
NAME VARCHAR2(40),
ADDRESS VARCHAR2(40),
PHONE VARCHAR2(30));

CREATE TABLE NEWORDERS(
ORDERID NUMBER,
CUSTID NUMBER NOT NULL,
BOOKID NUMBER NOT NULL, 
SALEPRICE NUMBER,
ORDERDATE DATE,
PRIMARY KEY(ORDERID),
FOREIGN KEY(CUSTID) REFERENCES NEWCUSTOMER(CUSTID) ON DELETE CASCADE);

DESC neworders;

INSERT INTO newcustomer VALUES(1, 'KEVIN', '역삼동','010-1234-1234');
INSERT INTO neworders VALUES(10,1,100,1000,SYSDATE);

SELECT * FROM newcustomer;
SELECT * FROM neworders;
SELECT * FROM customer;

DELETE FROM newcustomer;
DELETE FROM neworders;


-- 절대값 
SELECT ABS(-78), ABS(+78) FROM DUAL;

-- 반올림 
SELECT ROUND(4.875,1) FROM DUAL;

-- Q 고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오
SELECT * FROM orders;
SELECT CUSTID AS 고객번호, ROUND(AVG(SALEPRICE), -2) AS 평균주문금액 FROM orders
GROUP BY CUSTID;

-- Q '굿스포츠'에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 보이시오.
SELECT BOOKNAME 제목, LENGTH(BOOKNAME) 글자수, LENGTHB(BOOKNAME) 바이트수 
FROM BOOK WHERE publisher = '굿스포츠';

-- SUBSTR(NAME,1,1) 함수는 문자열 NAME의 첫번째 글자부터 시작하여 한 글자를 반환
-- GROUP BY 절에서는 별칭이 아닌 SUBSTR(NAME,1,1) 표현식을 사용해야 함


SELECT SYSDATE FROM DUAL;

-- Q DMBS 서버에 설정된 현재 날짜와 시간, 요일을 확인하시오
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS DAY') SYSDATE1 FROM DUAL;


-- Q 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 '연락처없음'으로 표시하시오
-- NVL 함수는 값이 NULL인 경우 지정값을 출력하고, NULL이 아니면 원래 값을 그대로 출력한다.
-- 함수 : NVL("값", "지정값")
SELECT NAME 이름, NVL(PHONE, '연락처없음') 전화번호 FROM CUSTOMER;

-- Q 고객목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오
-- ROWNUM : 오라클에서 자동으로 제공하는 가상 열로 쿼리가 진행되는 동안 각 행에 일련번호를 자동으로 할당
SELECT ROWNUM 순번, CUSTID 고객번호, NAME 이름, PHONE 전화번호 FROM CUSTOMER
WHERE ROWNUM < 3;













































