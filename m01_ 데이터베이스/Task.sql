

-- 2024�� 5�� 17��

-- TASK1_0517 ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��' �� ������ �˻��ϼ��� (3���� ���)
SELECT * FROM BOOK WHERE (publisher = '�½�����') OR (publisher='���ѹ̵��');

SELECT * FROM BOOK WHERE publisher IN('�½�����','���ѹ̵��');

SELECT * FROM BOOK WHERE (publisher = '�½�����') UNION SELECT * FROM BOOK WHERE (publisher='���ѹ̵��');

-- TASK2_0517 ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��' �� �ƴ� ������ �˻�
SELECT * FROM BOOK WHERE publisher NOT IN('�½�����','���ѹ̵��');

-- TASK3_0517 �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻��ϼ���
SELECT bookname FROM BOOK WHERE bookname LIKE '%�౸%' AND PRICE > 20000;

--Task4_0517. 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT customer.name, orders.custid, SUM(orders.saleprice) AS "�� �Ǹž�"
FROM orders, customer WHERE orders.custid = 2 AND orders.custid=customer.custid
GROUP BY customer.name, orders.custid;

SELECT customer.name, orders.custid, SUM(orders.saleprice) AS "�� �Ǹž�"
FROM orders INNER JOIN customer ON orders.custid = customer.custid
WHERE orders.custid = 2 GROUP BY customer.name, orders.custid;

--Task5_0517. ������ 8,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�. 
--��, �� �� �̻� ������ ���� ���Ͻÿ�.
SELECT custid, COUNT(*) AS �������� FROM orders WHERE saleprice >= 8000 
GROUP BY custid HAVING COUNT(*) >=2; 

--Task6_0517. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
SELECT name, saleprice FROM customer, orders WHERE customer.custid = orders.custid;

--Task7_0517. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
SELECT custid, SUM(saleprice) "�� �Ǹž�" FROM orders GROUP BY custid
ORDER BY custid;

SELECT name, SUM(saleprice) AS "�� �Ǹž�" FROM customer C, orders O
WHERE c.custid = o.custid GROUP BY c.name ORDER BY c.name;

--------------------------------------------------------------------------------------------------------------------------------

-- 2024�� 5�� 20��

--Task1_0520. 10���� �Ӽ����� �����Ǵ� ���̺� 2���� �ۼ��ϼ���. �� FOREIGN KEY�� �����Ͽ� ���� ���̺��� �����͸� ���� �� 
--�ٸ� ���̺��� ���õǴ� �����͵� ��� �����ǵ��� �ϼ���. (��� ���������� ���)
--��, �� ���̺� 5���� �����͸� �Է��ϰ� �ι�° ���̺� ù��° �����͸� �����ϰ� �ִ� �Ӽ��� �����Ͽ� ������ ���� 
DROP table mart;
DROP table department;
create table mart(
    custid number primary key
    , name varchar2(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , frequency number -- �湮 ��
    , amount_num number
    , amount_price number
    , parking varchar2(20) -- ��������
    , family number -- ���� ������ ��
);

alter table mart drop column amount_num;
alter table mart modify (name varchar2(30));
alter table mart modify (phone varchar2(20));

DESC mart;
insert into mart values(1, '��浿', 32, '��', '010-1234-1234', '���� ����', 5, 1500000, 'N', 3);
insert into mart values(2, '�����', 31, '��', '010-7777-1234', '���� ��õ', 5, 200000000, 'Y', 4);
insert into mart values(3, '�̼���', 57, '��', '010-1592-1234', '�泲 �뿵', 5, 270000, 'N', 1);
insert into mart values(4, '������', 30, '��', '010-0516-1234', '���� ����', 5, 750000000, 'Y', 4);
insert into mart values(5, '�ӿ���', 30, '��', '010-0517-1235', '���� ����', 5, 75000000, 'Y', 2);

select * from mart;

create table department(
    custid number primary key
    , name varchar(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , use_store varchar2(100) -- ���� ã�� ����
    , amount_num number
    , amount_price number
    , valet varchar2(20) -- �߷���ŷ ���� ��뿩��
    , rounge varchar2(20) -- vip ����� ��뿩��
    , foreign key (custid) references mart(custid) on delete cascade
);

alter table department modify (amount_price check (amount_price > 100000000));
alter table department modify (rounge default 'Y');
alter table department modify (valet default 'Y');
alter table department modify (phone varchar2(100));
alter table department drop column amount_num;
--alter table department add (custid number);
select * from department;

insert into department values(1, '�����', 31, '��', '010-7777-1234', '���� ��õ', 'LV', 900000000,'','');
insert into department values(2, '������', 30, '��', '010-0516-1234', '���� ����', 'GUCCI', 1500000000,'','');
insert into department values(3, '������', 31, '��', '010-7775-1235', '���� ��õ', 'LV', 900000000,'','');
insert into department values(4, '�ڼ���', 30, '��', '010-0516-1234', '���� ����', 'GUCCI', 1500000000,'','');
insert into department values(5, '�ӿ���', 30, '��', '010-0517-1235', '���� ����', 'ROLEX', 150000000,'','');

DELETE mart
WHERE custid = 1;

--Task2_0520. Customer ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� �����Ͻÿ�.
UPDATE Customer SET address = 
(SELECT address FROM Customer WHERE name = '�迬��')
WHERE name = '�ڼ���';

SELECT * FROM customer;

-- �ٽ� �λ����� ����
UPDATE customer SET ADDRESS = '���ѹα� �λ�' WHERE NAME = '�ڼ���';

--Task3_0520. ���� ���� ���߱����� ���Ե� ������ ���󱸡��� ������ �� ���� ���, ������ ���̽ÿ�.
UPDATE Book SET bookname = REPLACE(bookname, '�߱�', '��')
WHERE bookname LIKE '%�߱�%';
SELECT bookname, price
FROM Book;

SELECT BOOKID, REPLACE(BOOKNAME, '�߱�','��') BOOKNAME, PUBLISHER,PRICE FROM BOOK;

--Task4_0520. ���缭���� �� �߿��� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.
-- SUBSTR(NAME,1,1) �Լ��� ���ڿ� NAME�� ù��° ���ں��� �����Ͽ� �� ���ڸ� ��ȯ
-- GROUP BY �������� ��Ī�� �ƴ� SUBSTR(NAME,1,1) ǥ������ ����ؾ� ��
SELECT SUBSTR(NAME,1,1) ��, COUNT(*) �ο� 
FROM CUSTOMER GROUP BY SUBSTR(NAME,1,1);

--Task5_0520. ���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.
SELECT orderid, orderdate, orderdate + 10 AS confirmation_date FROM Orders;

SELECT ORDERID, ORDERDATE AS �ֹ���, ORDERDATE + 10 AS Ȯ������ FROM ORDERS;

--���缭���� �ֹ��Ϸκ��� 2���� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.
SELECT ORDERID, ORDERDATE AS �ֹ���, ADD_MONTHS(ORDERDATE, 2) AS Ȯ������ FROM ORDERS;

--Task6_0520. ���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�. 
--�� �ֹ����� ��yyyy-mm-dd ���ϡ� ���·� ǥ���Ѵ�.
SELECT ORDERID �ֹ���ȣ, TO_CHAR(ORDERDATE, 'YYYY-MM-DD DAY') �ֹ���, CUSTID ����ȣ, BOOKID ������ȣ
FROM ORDERS WHERE ORDERDATE = '2020-07-07';

-- WHRER ORDERDATE = TO_DATE('20/07/07', 'YY/MM/DD')
-- WHRER ORDERDATE = TO_DATE('20/07/07', 'DD/MM/YY')

--Task7_0520. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
SELECT orderid, saleprice
FROM Orders WHERE saleprice < (SELECT AVG(saleprice) FROM Orders);

SELECT orderid, saleprice
FROM Orders WHERE saleprice <= (SELECT AVG(saleprice)
AS avg_amount FROM Orders);

SELECT O1.ORDERID, O1.SALEPRICE FROM ORDERS O1 
WHERE O1.SALEPRICE < (SELECT AVG(O2.SALEPRICE) FROM ORDERS O2); 

-- ���������� O2��� ��Ī���� ����, SALEPRCIE�� ��� ���� AVG_SALEPRICE�� ���
SELECT O1.ORDERID, O1.SALEPRICE FROM ORDERS O1 JOIN (SELECT AVG(SALEPRICE) AS AVG_SALEPRICE
FROM ORDERS) O2 ON O1.SALEPRICE < O2.AVG_SALEPRICE;

--Task8_0520. ���ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(saleprice) AS ���Ǹž� FROM ORDERS WHERE CUSTID IN (SELECT CUSTID 
FROM CUSTOMER WHERE ADDRESS LIKE '%���ѹα�%');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 


-- 2024�� 5�� 23��
--Task1_0523. 
--orders��� ���̺��� �����ϰ�, order_id, customer_id, order_date, amount, status��� �Ӽ��� �����ϼ���.
--�����͸� 5�� �Է��ϼ���.
--�Է��� ������ �� 2���� �����ϼ���.
--������ �����͸� ����ϱ� ���� �ѹ��� ����ϼ���.
--3���� ���ο� �����͸� �Է��ϰ�, �� �� ������ ������ �Է¸� ����� �� �������� Ŀ���ϼ���.
DROP TABLE ORDERS;

CREATE TABLE orders (
order_id NUMBER PRIMARY KEY,
customer_id VARCHAR2(100),
order_date DATE,
amount VARCHAR2(100),
STATUS VARCHAR2(20));

INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (1, '���缮',  SYSDATE, '��',  'Active');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (2, '������',  SYSDATE, '��','Active');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (3, '�缼��',  SYSDATE, '��', 'Inactive');


SELECT * FROM orders;

SAVEPOINT TASK1;

INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (4, '����ȿ', SYSDATE, '��',  'Active');
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES (5, '������', SYSDATE, '��', 'Inactive');

ROLLBACK TO TASK1;

COMMIT;





























