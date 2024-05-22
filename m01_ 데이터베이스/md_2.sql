SELECT BOOKID FROM BOOK;

SELECT * FROM customer;
SELECT * FROM orders;
SELECT * FROM imported_book;


-- �ߺ����� ���
SELECT DISTINCT publisher FROM BOOK;

-- Q ������ 10,000�� �̻��� ������ �˻�
SELECT * FROM BOOK WHERE price > 10000;

-- Q ������ 10,000 �̻� 20,000 ������ ������ �˻��ϼ��� (2���� ���)
SELECT * FROM BOOK WHERE price > 10000 AND price <= 20000;

SELECT * FROM BOOK WHERE price BETWEEN 10000 AND 20000;


-- lIKE�� ��Ȯ�� '�౸�� ����'�� ��ġ�ϴ� �ุ ����
SELECT bookname, publisher FROM BOOK WHERE bookname LIKE '�౸�� ����';

-- %: 0�� �̻��� ������ ����
-- _: ��Ȯ�� 1���� ������ ����
-- '�౸' �� ���Ե� ���ǻ�

--'�౸'�� ���Ե� ���ǻ�
SELECT bookname, publisher FROM BOOK WHERE bookname LIKE '%�౸%';

-- �����̸��� ���� �� ���� ��ġ�� '��'��� ���ڿ��� ���� ����
SELECT bookname, publisher FROM BOOK WHERE bookname LIKE '%_��%';

-- ORDER BY : �⺻ �ø����� ���� (default)  
SELECT * FROM BOOK ORDER BY PRICE;

-- �������� 
SELECT * FROM book ORDER BY PRICE DESC;

-- Q ������ ���ݼ����� �˻��ϰ�, ������ ������ �̸������� �˻��ϼ���
SELECT * FROM book ORDER BY PRICE,BOOKNAME;


SELECT SUM(SALEPRICE) AS  "�� �Ǹž�" FROM ORDERS WHERE CUSTID = 2;


-- GROUP BY: �����͸� Ư�� ���ؿ� ���� �׷�ȭ�ϴµ� ���, �̸� ���� ���� �Լ�(SUM, AVG, MAX, MIN, COUNT)�� �̿�, ���
SELECT SUM(SALEPRICE) AS TOTAL, AVG(SALEPRICE) AS AVERAGE, MIN(SALEPRICE) AS MINNUM, MAX(SALEPRICE) AS MAXINUM FROM ORDERS;

-- ���Ǹž��� custid �������� �׷�ȭ
SELECT custid, COUNT(*) AS ��������, SUM(SALEPRICE) AS "�� �Ǹž�" FROM ORDERS GROUP BY CUSTID;

-- BOOKID�� 5���� ū ����
SELECT custid, COUNT(*) AS ��������, SUM(SALEPRICE) AS "�� �Ǹž�" 
FROM ORDERS WHERE BOOKID > 5 GROUP BY CUSTID;

-- ���������� 2���� ū ����
SELECT custid, COUNT(*) AS ��������, SUM(SALEPRICE) AS "�� �Ǹž�" 
FROM ORDERS WHERE BOOKID > 5 GROUP BY CUSTID HAVING COUNT(*) > 2;


-- Q ���� �̸��� ���� �ֹ��� ������ �̸��� ���ϼ���.
SELECT c.name AS customer_name, b.bookname FROM customer C, book B,
orders O WHERE c.custid = o.custid AND o.bookid = b.bookid;

SELECT c.name AS customer_name, b.bookname AS book_name
FROM Customer c
JOIN Orders o ON c.custid = o.custid
JOIN Book b ON o.bookid = b.bookid;

-- Q ������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
SELECT c.name AS customer_name, b.bookname AS book_name
FROM Customer c
JOIN Orders o ON c.custid = o.custid
JOIN Book b ON o.bookid = b.bookid
WHERE b.price = 20000;


-- JOIN�� �� �� �̻��� ���̺��� �����Ͽ� ���õ� �����͸� ������ �� ���
-- ���� ���� (Inner Join)
SELECT customer.name, orders.saleprice FROM customer INNER JOIN orders ON
customer.custid = orders.custid;

-- ���� �ܺ� ���� (LEFT OUTER JOIN) : �� ���� ���̺� ��ġ�ϴ� �����Ͱ� ���� ��� NULL���� ���
SELECT customer.name, orders.saleprice FROM customer LEFT OUTER 
JOIN orders ON customer.custid = orders.custid;

--������ �ܺ� ���� (Right Outer Join) : ù ��° ���̺� ��ġ�ϴ� �����Ͱ� ���� ��� NULL ���� ���
SELECT customer.name, orders.saleprice FROM customer 
RIGHT OUTER JOIN orders ON customer.custid = orders.custid;


--FULL OUTER JOIN : ��ġ�ϴ� �����Ͱ� ���� ��� �ش� ���̺����� NULL ���� ���
SELECT customer.name, orders.saleprice FROM customer
FULL OUTER JOIN orders ON customer.custid=orders.custid;

--CROSS JOIN : �� ���̺� ���� ��� ������ ������ ����
SELECT customer.name, orders.saleprice FROM customer CROSS JOIN orders;


-- Q ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���Ͻÿ�
-- ( 2���� ��� WHERE, JOIN)

SELECT C.name, O.saleprice FROM customer C, orders O WHERE c.custid = o.custid(+);

SELECT customer.name, orders.saleprice FROM customer 
LEFT OUTER JOIN orders  ON customer.custid = orders.custid;

-- �μ� ����
SELECT * FROM book;
SELECT * FROM orders;
SELECT * FROM customer;

-- Q ������ ������ ���� �ִ� ���� �̸��� �˻��Ͻÿ�.
SELECT name FROM customer WHERE custid IN (SELECT custid FROM orders);

--Q. �����ѹ̵����� ������ ������ ������ ���� �̸��� ���̽ÿ�.
SELECT C.name FROM Customer C 
JOIN Orders O ON C.custid = O.custid
JOIN Book B ON O.bookid = B.bookid
WHERE B.publisher = '���ѹ̵��';

SELECT NAME FROM customer 
WHERE custid IN (SELECT CUSTID FROM ORDERS
WHERE BOOKID IN (SELECT BOOKID FROM BOOK
WHERE PUBLISHER = '���ѹ̵��'));

--Q. ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�.
SELECT B1.BOOKNAME FROM BOOK B1 WHERE B1.PRICE > (SELECT AVG(B2.PRICE)
FROM BOOK B2 WHERE B2.PUBLISHER = B1.PUBLISHER);


--Q. ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�.
SELECT customer.name FROM customer LEFT OUTER JOIN orders 
ON customer.custid = orders.custid WHERE orders.orderdate IS NULL;

SELECT NAME FROM CUSTOMER WHERE CUSTID NOT IN (SELECT CUSTID FROM ORDERS);

--Q. �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
SELECT NAME ���̸�, ADDRESS �ּ� FROM CUSTOMER WHERE CUSTID
IN (SELECT CUSTID FROM ORDERS);



--������ Ÿ��
--������ (Numeric Types)
--NUMBER: ���� �������� ���� ������ Ÿ��. ����, �Ǽ�, ���� �Ҽ���, �ε� �Ҽ��� ���� ����
--NUMBER�� NUMBER(38, 0)�� ���� �ǹ̷� �ؼ�, Precision 38�� �ڸ���, Scale 0�� �Ҽ��� ���� �ڸ���
--NUMBER(10), NUMBER(8, 2) 
--������ (Character Types)
--VARCHAR2(size): ���� ���� ���ڿ��� ����. size�� �ִ� ���� ���̸� ����Ʈ, Ȥ�� ���ڼ��� ����
--NVARCHAR2(size)�� ����� ������ ���� ����Ʈ ���� ��� �׻� ���� ������ ũ�Ⱑ ����
--CHAR(size): ���� ���� ���ڿ��� ����. ������ ���̺��� ª�� ���ڿ��� �ԷµǸ� �������� �������� ä����

--��¥ �� �ð��� (Date and Time Types)
--DATE: ��¥�� �ð��� ����. ������ Ÿ���� ��, ��, ��, ��, ��, �ʸ� ����
--DATE Ÿ���� ��¥�� �ð��� YYYY-MM-DD HH24:MI:SS �������� �����մϴ�.
--���� ���, 2024�� 5�� 20�� ���� 3�� 45�� 30�ʴ� 2024-05-20 15:45:30���� ����

--TIMESTAMP: ��¥�� �ð��� �� ���� ������ �������� ����
--���� �������� (Binary Data Types)
--BLOB: �뷮�� ���� �����͸� ����. �̹���, ����� ���� ���� �����ϴ� �� ����
--��Ը� ��ü�� (Large Object Types)
--CLOB: �뷮�� ���� �����͸� ����
--NCLOB: �뷮�� ������ ���� ���� �����͸� ����

--���� ���ڵ��� �ǹ�
--��ǻ�ʹ� ���ڷ� �̷���� �����͸� ó��. ���ڵ��� ���� ����(��: 'A', '��', '?')�� 
--����(�ڵ� ����Ʈ)�� ��ȯ�Ͽ� ��ǻ�Ͱ� �����ϰ� ������ �� �ְ� �Ѵ�.
--���� ���, ASCII ���ڵ������� �빮�� 'A'�� 65��, �ҹ��� 'a'�� 97�� ���ڵ�. 
--�����ڵ� ���ڵ������� 'A'�� U+0041, �ѱ� '��'�� U+AC00, �̸�Ƽ�� '?'�� U+1F60A�� ���ڵ�
--�ƽ�Ű�� 7��Ʈ�� ����Ͽ� �� 128���� ���ڸ� ǥ���ϴ� �ݸ� �����ڵ�� �ִ� 1,114,112���� ���ڸ� ǥ��

--ASCII ���ڵ�:
--���� 'A' -> 65 (10����) -> 01000001 (2����)
--���� 'B' -> 66 (10����) -> 01000010 (2����)

--�����ڵ�(UTF-8) ���ڵ�: 
--���� 'A' -> U+0041 -> 41 (16����) -> 01000001 (2����, ASCII�� ����)
--���� '��' -> U+AC00 -> EC 95 80 (16����) -> 11101100 10010101 10000000 (2����)

--CLOB: CLOB�� �Ϲ������� �����ͺ��̽��� �⺻ ���� ����(��: ASCII, LATIN1 ��)�� ����Ͽ� �ؽ�Ʈ �����͸� ����. 
--�� ������ �ַ� ����� ���� ���� ����Ʈ ���ڷ� �̷���� �ؽ�Ʈ�� �����ϴ� �� ���.
--NCLOB: NCLOB�� �����ڵ�(UTF-16)�� ����Ͽ� �ؽ�Ʈ �����͸� ����. ���� �ٱ��� ������ �ʿ��� ��, \
--�� �پ��� ���� ������ �ؽ�Ʈ �����͸� ������ �� ����. �ٱ��� ���ڰ� ���Ե� �����͸� ȿ�������� ó���� �� �ִ�.

-- VARCHAR2�� �� ���� ������� ���̸� ���� : ����Ʈ�� ����
-- ���� Ȯ�� ���
SELECT * FROM v$nls_parameters WHERE parameter = 'NLS_LENGTH_SEMANTICS';

--�������� : 
--PRIMARY KEY : �� ���� �����ϰ� �ĺ��ϴ� ��(�Ǵ� ������ ����). �ߺ��ǰų� NULL ���� ������� �ʴ´�.
--FOREIGN KEY : �ٸ� ���̺��� �⺻ Ű�� �����ϴ� ��. ���� ���Ἲ�� ����
--UNIQUE : ���� �ߺ��� ���� ����� ���� ����. NULL���� ���
--NOT NULL : ���� NULL ���� ������� �ʴ´�.
--CHECK : �� ���� Ư�� ������ �����ؾ� ���� ���� (��: age > 18)
--DEFAULT : ���� ������� ���� �������� ���� ��� ���� �⺻���� ����


-- AUTHOR ���̺� ����
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

-- ���̺� �������� ����, �߰�, �Ӽ� �߰�, ����, ����
ALTER TABLE NEWBOOK MODIFY (ISBN VARCHAR2(50));
ALTER TABLE NEWBOOK ADD AUTHOR_ID NUMBER;
ALTER TABLE NEWBOOK DROP COLUMN AUTHOR_ID;

DELETE FROM NEWBOOK;

-- ON DELETE CASCADE �ɼ��� �����Ǿ� �־�, NEWCUSTOMER ���̺��� � ���� ���ڵ尡 �����Ǹ�,
-- �ش� ���� ��� �ֹ��� NEWORDERS ���̺����� �ڵ����� ����
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

INSERT INTO newcustomer VALUES(1, 'KEVIN', '���ﵿ','010-1234-1234');
INSERT INTO neworders VALUES(10,1,100,1000,SYSDATE);

SELECT * FROM newcustomer;
SELECT * FROM neworders;
SELECT * FROM customer;

DELETE FROM newcustomer;
DELETE FROM neworders;


-- ���밪 
SELECT ABS(-78), ABS(+78) FROM DUAL;

-- �ݿø� 
SELECT ROUND(4.875,1) FROM DUAL;

-- Q ���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�
SELECT * FROM orders;
SELECT CUSTID AS ����ȣ, ROUND(AVG(SALEPRICE), -2) AS ����ֹ��ݾ� FROM orders
GROUP BY CUSTID;

-- Q '�½�����'���� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���̽ÿ�.
SELECT BOOKNAME ����, LENGTH(BOOKNAME) ���ڼ�, LENGTHB(BOOKNAME) ����Ʈ�� 
FROM BOOK WHERE publisher = '�½�����';

-- SUBSTR(NAME,1,1) �Լ��� ���ڿ� NAME�� ù��° ���ں��� �����Ͽ� �� ���ڸ� ��ȯ
-- GROUP BY �������� ��Ī�� �ƴ� SUBSTR(NAME,1,1) ǥ������ ����ؾ� ��


SELECT SYSDATE FROM DUAL;

-- Q DMBS ������ ������ ���� ��¥�� �ð�, ������ Ȯ���Ͻÿ�
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS DAY') SYSDATE1 FROM DUAL;


-- Q �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̽ÿ�. ��, ��ȭ��ȣ�� ���� ���� '����ó����'���� ǥ���Ͻÿ�
-- NVL �Լ��� ���� NULL�� ��� �������� ����ϰ�, NULL�� �ƴϸ� ���� ���� �״�� ����Ѵ�.
-- �Լ� : NVL("��", "������")
SELECT NAME �̸�, NVL(PHONE, '����ó����') ��ȭ��ȣ FROM CUSTOMER;

-- Q ����Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� �� �� ���̽ÿ�
-- ROWNUM : ����Ŭ���� �ڵ����� �����ϴ� ���� ���� ������ ����Ǵ� ���� �� �࿡ �Ϸù�ȣ�� �ڵ����� �Ҵ�
SELECT ROWNUM ����, CUSTID ����ȣ, NAME �̸�, PHONE ��ȭ��ȣ FROM CUSTOMER
WHERE ROWNUM < 3;













































