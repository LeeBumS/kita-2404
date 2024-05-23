

-- 2024년 5월 17일

-- TASK1_0517 출판사가 '굿스포츠' 혹은 '대한미디어' 인 도서를 검색하세요 (3가지 방법)
SELECT * FROM BOOK WHERE (publisher = '굿스포츠') OR (publisher='대한미디어');

SELECT * FROM BOOK WHERE publisher IN('굿스포츠','대한미디어');

SELECT * FROM BOOK WHERE (publisher = '굿스포츠') UNION SELECT * FROM BOOK WHERE (publisher='대한미디어');

-- TASK2_0517 출판사가 '굿스포츠' 혹은 '대한미디어' 가 아닌 도서를 검색
SELECT * FROM BOOK WHERE publisher NOT IN('굿스포츠','대한미디어');

-- TASK3_0517 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하세요
SELECT bookname FROM BOOK WHERE bookname LIKE '%축구%' AND PRICE > 20000;

--Task4_0517. 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT customer.name, orders.custid, SUM(orders.saleprice) AS "총 판매액"
FROM orders, customer WHERE orders.custid = 2 AND orders.custid=customer.custid
GROUP BY customer.name, orders.custid;

SELECT customer.name, orders.custid, SUM(orders.saleprice) AS "총 판매액"
FROM orders INNER JOIN customer ON orders.custid = customer.custid
WHERE orders.custid = 2 GROUP BY customer.name, orders.custid;

--Task5_0517. 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 
--단, 두 권 이상 구매한 고객만 구하시오.
SELECT custid, COUNT(*) AS 도서수량 FROM orders WHERE saleprice >= 8000 
GROUP BY custid HAVING COUNT(*) >=2; 

--Task6_0517. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT name, saleprice FROM customer, orders WHERE customer.custid = orders.custid;

--Task7_0517. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
SELECT custid, SUM(saleprice) "총 판매액" FROM orders GROUP BY custid
ORDER BY custid;

SELECT name, SUM(saleprice) AS "총 판매액" FROM customer C, orders O
WHERE c.custid = o.custid GROUP BY c.name ORDER BY c.name;

--------------------------------------------------------------------------------------------------------------------------------

-- 2024년 5월 20일

--Task1_0520. 10개의 속성으로 구성되는 테이블 2개를 작성하세요. 단 FOREIGN KEY를 적용하여 한쪽 테이블의 데이터를 삭제 시 
--다른 테이블의 관련되는 데이터도 모두 삭제되도록 하세요. (모든 제약조건을 사용)
--단, 각 테이블에 5개의 데이터를 입력하고 두번째 테이블에 첫번째 데이터를 참조하고 있는 속성을 선택하여 데이터 삭제 
DROP table mart;
DROP table department;
create table mart(
    custid number primary key
    , name varchar2(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , frequency number -- 방문 빈도
    , amount_num number
    , amount_price number
    , parking varchar2(20) -- 주차여부
    , family number -- 가족 구성원 수
);

alter table mart drop column amount_num;
alter table mart modify (name varchar2(30));
alter table mart modify (phone varchar2(20));

DESC mart;
insert into mart values(1, '고길동', 32, '남', '010-1234-1234', '서울 강남', 5, 1500000, 'N', 3);
insert into mart values(2, '손흥민', 31, '남', '010-7777-1234', '강원 춘천', 5, 200000000, 'Y', 4);
insert into mart values(3, '이순신', 57, '남', '010-1592-1234', '경남 통영', 5, 270000, 'N', 1);
insert into mart values(4, '아이유', 30, '여', '010-0516-1234', '서울 서초', 5, 750000000, 'Y', 4);
insert into mart values(5, '임영웅', 30, '남', '010-0517-1235', '서울 역삼', 5, 75000000, 'Y', 2);

select * from mart;

create table department(
    custid number primary key
    , name varchar(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , use_store varchar2(100) -- 자주 찾는 매장
    , amount_num number
    , amount_price number
    , valet varchar2(20) -- 발렛파킹 서비스 사용여부
    , rounge varchar2(20) -- vip 라운지 사용여부
    , foreign key (custid) references mart(custid) on delete cascade
);

alter table department modify (amount_price check (amount_price > 100000000));
alter table department modify (rounge default 'Y');
alter table department modify (valet default 'Y');
alter table department modify (phone varchar2(100));
alter table department drop column amount_num;
--alter table department add (custid number);
select * from department;

insert into department values(1, '손흥민', 31, '남', '010-7777-1234', '강원 춘천', 'LV', 900000000,'','');
insert into department values(2, '아이유', 30, '여', '010-0516-1234', '서울 서초', 'GUCCI', 1500000000,'','');
insert into department values(3, '박지성', 31, '남', '010-7775-1235', '강원 춘천', 'LV', 900000000,'','');
insert into department values(4, '박세리', 30, '여', '010-0516-1234', '서울 서초', 'GUCCI', 1500000000,'','');
insert into department values(5, '임영웅', 30, '남', '010-0517-1235', '서울 역삼', 'ROLEX', 150000000,'','');

DELETE mart
WHERE custid = 1;

--Task2_0520. Customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경하시오.
UPDATE Customer SET address = 
(SELECT address FROM Customer WHERE name = '김연아')
WHERE name = '박세리';

SELECT * FROM customer;

-- 다시 부산으로 변견
UPDATE customer SET ADDRESS = '대한민국 부산' WHERE NAME = '박세리';

--Task3_0520. 도서 제목에 ‘야구’가 포함된 도서를 ‘농구’로 변경한 후 도서 목록, 가격을 보이시오.
UPDATE Book SET bookname = REPLACE(bookname, '야구', '농구')
WHERE bookname LIKE '%야구%';
SELECT bookname, price
FROM Book;

SELECT BOOKID, REPLACE(BOOKNAME, '야구','농구') BOOKNAME, PUBLISHER,PRICE FROM BOOK;

--Task4_0520. 마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
-- SUBSTR(NAME,1,1) 함수는 문자열 NAME의 첫번째 글자부터 시작하여 한 글자를 반환
-- GROUP BY 절에서는 별칭이 아닌 SUBSTR(NAME,1,1) 표현식을 사용해야 함
SELECT SUBSTR(NAME,1,1) 성, COUNT(*) 인원 
FROM CUSTOMER GROUP BY SUBSTR(NAME,1,1);

--Task5_0520. 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
SELECT orderid, orderdate, orderdate + 10 AS confirmation_date FROM Orders;

SELECT ORDERID, ORDERDATE AS 주문일, ORDERDATE + 10 AS 확정일자 FROM ORDERS;

--마당서점은 주문일로부터 2개월 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
SELECT ORDERID, ORDERDATE AS 주문일, ADD_MONTHS(ORDERDATE, 2) AS 확정일자 FROM ORDERS;

--Task6_0520. 마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오. 
--단 주문일은 ‘yyyy-mm-dd 요일’ 형태로 표시한다.
SELECT ORDERID 주문번호, TO_CHAR(ORDERDATE, 'YYYY-MM-DD DAY') 주문일, CUSTID 고객번호, BOOKID 도서번호
FROM ORDERS WHERE ORDERDATE = '2020-07-07';

-- WHRER ORDERDATE = TO_DATE('20/07/07', 'YY/MM/DD')
-- WHRER ORDERDATE = TO_DATE('20/07/07', 'DD/MM/YY')

--Task7_0520. 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
SELECT orderid, saleprice
FROM Orders WHERE saleprice < (SELECT AVG(saleprice) FROM Orders);

SELECT orderid, saleprice
FROM Orders WHERE saleprice <= (SELECT AVG(saleprice)
AS avg_amount FROM Orders);

SELECT O1.ORDERID, O1.SALEPRICE FROM ORDERS O1 
WHERE O1.SALEPRICE < (SELECT AVG(O2.SALEPRICE) FROM ORDERS O2); 

-- 서브쿼리를 O2라는 별칭으로 지정, SALEPRCIE의 평균 값을 AVG_SALEPRICE로 계산
SELECT O1.ORDERID, O1.SALEPRICE FROM ORDERS O1 JOIN (SELECT AVG(SALEPRICE) AS AVG_SALEPRICE
FROM ORDERS) O2 ON O1.SALEPRICE < O2.AVG_SALEPRICE;

--Task8_0520. 대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice) AS 총판매액 FROM ORDERS WHERE CUSTID IN (SELECT CUSTID 
FROM CUSTOMER WHERE ADDRESS LIKE '%대한민국%');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 


-- 2024년 5월 23일
--Task1_0523. 
--orders라는 테이블을 생성하고, order_id, customer_id, order_date, amount, status라는 속성을 설정하세요.
--데이터를 5개 입력하세요.
--입력한 데이터 중 2개를 수정하세요.
--수정한 데이터를 취소하기 위해 롤백을 사용하세요.
--3개의 새로운 데이터를 입력하고, 그 중 마지막 데이터 입력만 취소한 후 나머지를 커밋하세요.
DROP TABLE ORDERS;

CREATE TABLE orders (
order_id NUMBER PRIMARY KEY,
customer_id VARCHAR2(100),
order_date DATE,
amount VARCHAR2(100),
STATUS VARCHAR2(20));

INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (1, '유재석',  SYSDATE, '대',  'Active');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (2, '김종국',  SYSDATE, '중','Active');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (3, '양세찬',  SYSDATE, '소', 'Inactive');


SELECT * FROM orders;

SAVEPOINT TASK1;

INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (4, '송지효', SYSDATE, '대',  'Active');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (5, '지석진', SYSDATE, '소', 'Inactive');

ROLLBACK TO TASK1;

COMMIT;





























