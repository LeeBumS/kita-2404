SELECT * FROM employees;


-- Q ����� 120���� ����� ���, �̸�, ����(JOB_ID), ������(JOB_TITLE)�� ���,
SELECT E.EMPLOYEE_ID ���, E.FIRST_NAME �̸�, E.LAST_NAME ��, E.JOB_ID ����, J.JOB_TITLE ������
FROM EMPLOYEES E INNER JOIN JOBS J ON E.JOB_ID = J.JOB_ID WHERE E.EMPLOYEE_ID = 120;

-- FIRST_NAME || ' ' || LAST_NAME AS �̸� : FIRST_NAME�� LAST_NAME�� �������� �����Ͽ�
-- �ϳ��� ���ڿ��� ��ġ��, �� ����� ��Ī�� �̸� '�̸�'���� ����
SELECT E.EMPLOYEE_ID ���, FIRST_NAME || ' ' || LAST_NAME AS �̸�, J.JOB_ID ����, J.JOB_TITLE ������
FROM EMPLOYEES E, JOBS J  WHERE E.EMPLOYEE_ID = 120 AND E.JOB_ID = J.JOB_ID;

-- Q 2005�� ��ݱ⿡ �Ի��� ������� �̸�(FULL NAME)�� ���
SELECT FIRST_NAME || ' ' || LAST_NAME AS �̸�, HIRE_DATE �Ի��� FROM employees WHERE TO_CHAR(HIRE_DATE,'YY/MM')
BETWEEN '05/01' AND '05/06';

-- _�� ���ϵ�ī�尡 �ƴ� ���ڷ� ����ϰ� ���� �� ESCAPE �ɼ��� ���
SELECT * FROM employees WHERE JOB_ID LIKE '%\_A%';
SELECT * FROM employees WHERE JOB_ID LIKE '%\_A%' ESCAPE '\';
SELECT * FROM employees WHERE JOB_ID LIKE '%#_A%' ESCAPE '#';

-- IN : OR ��� ���
SELECT * FROM employees WHERE MANAGER_ID = 101 OR MANAGER_ID = 102 OR MANAGER_ID = 103;
SELECT * FROM employees WHERE MANAGER_ID IN (101,102,103);

-- Q ���� SA_MAN, IT_PROG, ST_MAN �� ����� ���
SELECT * FROM employees WHERE JOB_ID IN('SA_MAN', 'IT_PROG', 'ST_MAN');

-- IS NULL / IS NOT NULL
-- NULL �������� Ȯ���� ��� = �� �����ڸ� ������� �ʰ� IS NULL�� ����Ѵ�
SELECT * FROM employees WHERE COMMISSION_PCT IS NULL;
SELECT * FROM employees WHERE COMMISSION_PCT IS NOT NULL;


-- ORDER BY
-- ORDER BY �ø��� [ ASC | DESC ]
SELECT * FROM employees ORDER BY SALARY ASC;
SELECT * FROM employees ORDER BY SALARY DESC;
SELECT * FROM employees ORDER BY SALARY ASC, LAST_NAME DESC;

-- DUAL ���̺�
-- MOD ������
SELECT * FROM employees WHERE MOD ( EMPLOYEE_ID, 2 ) = 1;
SELECT MOD( 10, 3 ) FROM DUAL;


-- ROUND()
SELECT ROUND( 355.95555 ) FROM DUAL;
SELECT ROUND( 355.95555, 2 ) FROM DUAL;
SELECT ROUND( 355.95555, -2 ) FROM DUAL;

-- TRUNC() ���� �Լ�, ������ �ڸ��� ���ϸ� ���� ��� ����
SELECT TRUNC( 45.5555, 1 ) FROM DUAL;

-- CEIL() ������ �ø�
SELECT CEIL ( 45.111 ) FROM DUAL; 

-- Q HR EMPLOYEES ���̺��� �̸�, �޿�, 10% �λ�� �޿��� ����ϼ���
SELECT LAST_NAME �̸�, SALARY �޿�, SALARY * 1.1 "�λ�� �޿�" FROM employees;

-- Q EMPLOYEES_ID�� Ȧ���� ������ EMPLPYEE_ID�� LAST_NAME�� ����ϼ���.
SELECT EMPLOYEE_ID �����ȣ, LAST_NAME �̸� FROM employees 
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM employees WHERE MOD( EMPLOYEE_ID, 2 ) = 1);

-- Q EMPLOYEES ���̺��� COMMISSION_PCT �� NULL�� ������ ����ϼ���
SELECT COUNT(*) FROM employees WHERE COMMISSION_PCT IS NULL;

-- Q EMPLOYEES ���̺��� DEPARMENT_ID �� ���� ������ �����Ͽ� POSITON�� '����'���� ����ϼ���(POSITION �� �߰�)
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, '����' POSITION 
FROM employees WHERE DEPARTMENT_ID IS NULL;

-- ��¥ ����
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE + 1 FROM DUAL;
SELECT SYSDATE - 1 FROM DUAL;


-- �ٹ��� ��¥ ���
SELECT LAST_NAME, SYSDATE, HIRE_DATE, TRUNC(SYSDATE-HIRE_DATE) �ٹ��Ⱓ FROM EMPLOYEES;

-- ADD_MONTHS( )        Ư�� ���� ���� ���� ��¥�� ���Ѵ�
SELECT LAST_NAME, HIRE_DATE, ADD_MONTHS( HIRE_DATE, 6 ) REVISED_DATE FROM employees;

-- LAST_DAY( )          �ش� ���� ������ ��¥�� ��ȯ�ϴ� �Լ�
SELECT LAST_NAME, HIRE_DATE, LAST_DAY( HIRE_DATE ) FROM employees;

SELECT LAST_NAME, HIRE_DATE, LAST_DAY( ADD_MONTHS( HIRE_DATE, 1 )) FROM employees; 

-- NEXT_DAY( )          �ش� ��¥�� �������� ������ ���� ���Ͽ� �ش��ϴ� ��¥�� ��ȯ
SELECT HIRE_DATE, NEXT_DAY( HIRE_DATE, '��' ) FROM employees;
SELECT HIRE_DATE, NEXT_DAY( HIRE_DATE, 2 ) FROM employees;

-- MONTHS_BETWEEN( )    ��¥�� ��¥ ������ �������� ���Ѵ�
SELECT HIRE_DATE, ROUND( MONTHS_BETWEEN ( SYSDATE, HIRE_DATE ) , 1 ) FROM employees;

-- �� ��ȯ �Լ�  : TO_DATE( )    ���ڿ��� ��¥��
-- '2023-01-01' �̶�� ���ڿ��� ��¥ Ÿ������ ��ȯ
SELECT TO_DATE('2023-01-01', 'YYYY-MM-DD' ) FROM DUAL;

-- TO_CHAR ( ��¥ )       ��¥�� ���ڷ� ��ȯ
SELECT TO_CHAR( SYSDATE, 'YY/MM/DD' ) FROM DUAL;

--����
--YYYY       �� �ڸ� ����
--YY      �� �ڸ� ����
--YEAR      ���� ���� ǥ��
--MM      ���� ���ڷ�
--MON      ���� ���ĺ�����
--DD      ���� ���ڷ�
--DAY      ���� ǥ��
--DY      ���� ��� ǥ��
--D      ���� ���� ǥ��
--AM �Ǵ� PM   ���� ����
--HH �Ǵ� HH12   12�ð�
--HH24      24�ð�
--MI      ��
--SS      ��



-- Q ���� ��¥( SYSDATE ) �� 'YYYY/MM/DD'������ ���ڿ��� ��ȯ�ϼ���
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') "��¥" FROM DUAL;

-- Q '01-01-2023'�̶�� ���ڿ��� ��¥ Ÿ������ ��ȯ�ϼ���
SELECT TO_DATE('01-01-2023', 'MM-DD-YYYY' ) "��¥" FROM DUAL;

-- Q ���� ��¥�� �ð� (SYSDATE)�� 'YYYY-MM-DD HH24:MI:SS' ������ ���ڿ��κ�ȯ�ϼ���
SELECT TO_CHAR( SYSDATE, 'YYYY-MM-DD HH24:MI:SS' ) FROM DUAL;

-- Q '2023-01-01 15:30:00'�̶�� ���ڿ��� ��¥ �� �ð� Ÿ������ ��ȯ�ϼ���
SELECT TO_DATE('2023-01-01 15:30:00', 'YYYY-MM-DD HH24:MI:SS' ) FROM DUAL;


--to_char( ���� )   ���ڸ� ���ڷ� ��ȯ
--9      �� �ڸ��� ���� ǥ��      ( 1111, ��99999�� )      1111   
--0      �� �κ��� 0���� ǥ��      ( 1111, ��099999�� )      001111
--$      �޷� ��ȣ�� �տ� ǥ��      ( 1111, ��$99999�� )      $1111
--.      �Ҽ����� ǥ��         ( 1111, ��99999.99�� )      1111.00
--,      Ư�� ��ġ�� , ǥ��      ( 1111, ��99,999�� )      1,111
--MI      �����ʿ� - ��ȣ ǥ��      ( 1111, ��99999MI�� )      1111-
--PR      �������� <>�� ǥ��      ( -1111, ��99999PR�� )      <1111>
--EEEE      ������ ǥ��         ( 1111, ��99.99EEEE�� )      1.11E+03
--V      10�� n�� ���Ѱ����� ǥ��   ( 1111, ��999V99�� )      111100
--B      ������ 0���� ǥ��      ( 1111, ��B9999.99�� )      1111.00
--L      ������ȭ         ( 1111, ��L9999�� )


SELECT SALARY, TO_CHAR( SALARY, '0999999' ) FROM employees;
SELECT SALARY, TO_CHAR( -SALARY, '999999PR') FROM employees;
-- 1111 -> 1.11E+03
SELECT TO_CHAR( 11111, '9.999EEEE' ) FROM DUAL;
SELECT TO_CHAR( -1111111, '9999999MI') FROM DUAL;

-- WIDTH_BUCKET( )      ������, �ּҰ�, �ִ밪, BUCKET ����
SELECT WIDTH_BUCKET( 92, 0, 100, 10 ) FROM DUAL;
SELECT WIDTH_BUCKET( 100, 0, 100, 10 ) FROM DUAL;

-- EMPLOYEES ���̺��� SALARY�� 5�� ������� ǥ���ϼ���
SELECT MAX(SALARY) MAX, MIN(SALARY) MIN FROM employees;
SELECT SALARY, WIDTH_BUCKET(SALARY, 2100, 24001, 5) AS GRADE FROM employees;



-- ���� �Լ� CHARACTER FUNCTION
-- UPPER()      �빮�ڷ� ����
SELECT UPPER ( 'Hello World' ) FROM DUAL;
-- LOWER()      �ҹ��ڷ� ����
SELECT LOWER ( 'Hello World' ) FROM DUAL;

-- Q LAST_NAME�� SEO�� ������ LAST_NAME �� SALARY�� ���ϼ��� (Seo, SEO, seo ��� ����) 
SELECT LAST_NAME,SALARY FROM employees WHERE LOWER(LAST_NAME) = 'seo'; 

-- INITCAP()    ù���ڸ� �빮��
SELECT JOB_ID, INITCAP( JOB_ID ) FROM employees;

-- LENGTH()     ���ڿ��� ����
SELECT JOB_ID, LENGTH( JOB_ID ) FROM employees;

-- INSTR( )     ���ڿ�, ã�� ����, ã�� ��ġ, ã�� ���� �� �� �� ��
SELECT INSTR( 'Hello World', 'o', 3, 2 ) FROM DUAL;


-- SUBSTR()     ���ڿ�, ������ġ, ����
SELECT SUBSTR ( 'Hello World', 3, 3) FROM DUAL;
SELECT SUBSTR ( 'Hello World', 9, 3) FROM DUAL;
SELECT SUBSTR ( 'Hello World', -3, 3) FROM DUAL;

-- LPAD( )      ������ ���� �� ���ʿ� ���ڸ� ä���
SELECT LPAD('Hello World', 20, '#' ) FROM DUAL;

-- RPAD( )      ���� ���� �� �����ʿ� ���ڸ� ä���
SELECT RPAD('Hello World', 20, '#' ) FROM DUAL;

-- LTRIM( ) 
SELECT LTRIM( 'aaaHello Worldaaa', 'a') FROM DUAL;
SELECT LTRIM( '   Hello World   ') FROM DUAL;

-- RTRIM( )
SELECT RTRIM( 'aaaHello Worldaaa', 'a' ) FROM DUAL;
SELECT RTRIM( '   Hello World   ' ) FROM DUAL;

SELECT LAST_NAME FROM employees;

SELECT LAST_NAME AS �̸�, LTRIM(LAST_NAME, 'A') AS ��ȯ FROM employees;


-- TRIM
SELECT TRIM('   Hello World   ') FROM DUAL;

-- �յ��� Ư�� ���� ����
SELECT LAST_NAME, TRIM( 'A' FROM LAST_NAME ) FROM employees;



-- NVL( ) NULL�� 0 �Ǵ� �ٸ� ������ ��ȯ�ϴ� �Լ�
SELECT LAST_NAME, MANAGER_ID, NVL( TO_CHAR ( MANAGER_ID ) , 'CEO') REVISED_ID FROM EMPLOYEES;

--decode()    if���̳� case���� ���� ���� ��츦 ������ �� �ֵ��� �ϴ� �Լ�
--DECODE �Լ��� �ܼ��� ���ǿ� ����Ͽ� ���� ��ȯ�մϴ�. ������ DECODE(expression, search1, result1, ..., searchN, resultN, default) 
--���⼭ expression�� �˻��� ���� ��Ÿ����, search�� result�� ���� ���ǰ� �ش� ������ ���� �� ��ȯ�� ��
--default�� ��� search ������ ������ �� ��ȯ�� �⺻ �� ���

SELECT LAST_NAME, DEPARTMENT_ID,
DECODE(DEPARTMENT_ID,
    90, '�濵������',
    60, '���α׷���',
    100, '�λ��','��Ÿ') �μ� FROM EMPLOYEES;

-- Q EMPLOYEES ���̺��� COMMISSION_PCT�� NULL�� �ƴ� ���, 'A' NULL�� ��� 'N'�� ǥ���ϴ� ������ �ۼ�
SELECT COMMISSION_PCT AS  COMMISSION, DECODE(COMMISSION_PCT,NULL,'N','A') AS ��ȯ
FROM EMPLOYEES ORDER BY ��ȯ DESC;


--case()
--decode() �Լ��� �����ϳ� decode() �Լ��� �ܼ��� ���� �񱳿� ���Ǵ� �ݸ�
--case() �Լ��� �پ��� �񱳿����ڷ� ������ ������ �� �ִ�.
--CASE ���� ���ǿ� ���� �ٸ� ���� ��ȯ�ϴ� �� ���Ǹ�, DECODE���� ������ ������ ǥ���� �� �ִ�. 
--������ CASE WHEN condition THEN result ... ELSE default END�̴�. 
SELECT LAST_NAME, DEPARTMENT_ID,
CASE WHEN DEPARTMENT_ID = 90 THEN '�濵����'
WHEN DEPARTMENT_ID = 60 THEN '���α׷���'
WHEN DEPARTMENT_ID = 100 THEN '�λ��'
ELSE '��Ÿ' END AS �Ҽ� FROM EMPLOYEES;


-- Q EMPLOYEES ���̺��� SALARY�� 20000 �̻��̸� 'A', 10000�� 20000 �̸� ���̸� 'B',
-- �� ���ϸ� 'C'�� ǥ���ϴ� ������ �ۼ��Ͻÿ�
SELECT LAST_NAME, SALARY,
CASE 
WHEN SALARY >= 20000 THEN 'A'
WHEN SALARY > 10000 AND SALARY < 20000 THEN 'B' 
ELSE 'C' END AS ���� FROM EMPLOYEES;


--INSERT
--���̺� �����͸� �Է��ϴ� ����� �� ���� ������ ������ �� ���� �� �Ǹ� �Էµȴ�.
--a. INSERT INTO ���̺�� (COLUMN_LIST) VALUES (COLUMN_LIST�� ���� VALUE_LIST);
--b. INSERT INTO ���̺�� VALUES (��ü COLUMN�� ���� VALUE_LIST);

-- CONCATENATION : �޸� ��ſ� ����ϸ� ���ڿ��� ����Ǿ� ��µȴ�.
SELECT LAST_NAME, ' IS A ',JOB_ID FROM EMPLOYEES;
SELECT LAST_NAME || ' IS A ' || JOB_ID FROM EMPLOYEES;

-- UNION
-- UNION( ������ ) INTERSECT ( ������ ) MINUS( ������ ), UNION ALL( ��ġ�� �ͱ��� ���� )
-- �� ���� �������� ����ؾ��Ѵ�. ������ Ÿ���� ��ġ ���Ѿ� �Ѵ�
SELECT FIRST_NAME �̸�, SALARY �޿�, HIRE_DATE FROM EMPLOYEES
WHERE SALARY < 5000 
UNION
SELECT FIRST_NAME �̸�, SALARY �޿�, HIRE_DATE FROM EMPLOYEES
WHERE HIRE_DATE < '05/01/01';

SELECT FIRST_NAME �̸�, SALARY �޿�, HIRE_DATE FROM EMPLOYEES
WHERE SALARY < 5000 
MINUS
SELECT FIRST_NAME �̸�, SALARY �޿�, HIRE_DATE FROM EMPLOYEES
WHERE HIRE_DATE < '05/01/01';

SELECT FIRST_NAME �̸�, SALARY �޿�, HIRE_DATE FROM EMPLOYEES
WHERE SALARY < 5000 
INTERSECT
SELECT FIRST_NAME �̸�, SALARY �޿�, HIRE_DATE FROM EMPLOYEES
WHERE HIRE_DATE < '05/01/01';

SELECT FIRST_NAME �̸�, SALARY �޿�, HIRE_DATE FROM EMPLOYEES
WHERE SALARY < 5000 
UNION ALL
SELECT FIRST_NAME �̸�, SALARY �޿�, HIRE_DATE FROM EMPLOYEES
WHERE HIRE_DATE < '05/01/01';


--CREATE VIEW ��ɾ�� ����Ŭ SQL���� ���̺��� Ư�� �κ��̳� ���ε� ����� ������ ��(view)�� ���� �� ���
--��� �����͸� ����ϰų� ������ ������ �ܼ�ȭ�ϸ�, ����ڿ��� �ʿ��� �����͸��� �����ִ� �� ����
--��� ���� ���̺� �����͸� �������� �ʰ�, ��� ���� ����� ����
--���� �ֿ� Ư¡
--���� �ܼ�ȭ: ������ ������ ��� ���������ν� ����ڴ� ������ �������� �ݺ��ؼ� �ۼ��� �ʿ� ���� �����ϰ� �並 ������ �� �ִ�.
--������ �߻�ȭ: ��� �⺻ ���̺��� ������ ����� ����ڿ��� �ʿ��� �����͸��� ������ �� �־�, ������ �߻�ȭ�� ����.
--���� ��ȭ: �並 ����ϸ� Ư�� �����Ϳ� ���� ������ ������ �� ������, ����ڰ� �� �� �ִ� �������� ������ ������ �� �ִ�.
--������ ���Ἲ ����: �並 ����Ͽ� �����͸� �����ϴ���, �� ��������� �⺻ ���̺��� ������ ���Ἲ ��Ģ�� �������� �ʵ��� ������ �� �ִ�.

CREATE VIEW EMPLOYEE_DETAILS AS
SELECT EMPLOYEE_ID, LAST_NAME, DEPARTMENT_ID FROM EMPLOYEES;

SELECT * FROM EMPLOYEE_DETAILS;

-- Q EMPLOYEES ���̺��� SALARY�� 10000�� �̻��� �������� �����ϴ� �� 
-- SPECIAL_EMPLOYEE�� �����ϴ� SQL ��ɹ��� �ۼ��Ͻÿ�.
CREATE VIEW SPECIAL_EMPLOYEE AS 
SELECT * FROM EMPLOYEES WHERE SALARY >= 10000;

SELECT * FROM SPECIAL_EMPLOYEE;

-- Q EMPLOYEES ���̺��� �� �μ��� ���� ���� �����ϴ� �並 �����ϼ���.
CREATE VIEW DEPARTMENT_EMPLOYEE_COUNT AS
SELECT DEPARTMENT_ID, COUNT(*) AS �μ���_������ FROM EMPLOYEES
GROUP BY DEPARTMENT_ID ORDER BY �μ���_������;

SELECT * FROM DEPARTMENT_EMPLOYEE_COUNT;

-- Q EMPLOYEES ���̺��� �ټӱⰣ�� 10�� �̻��� ������ �����ϴ� �並 �����ϼ���
CREATE VIEW QOINMUL AS 
SELECT LAST_NAME, ROUND(SYSDATE-HIRE_DATE) AS �ټӱⰣ
FROM EMPLOYEES WHERE ROUND(SYSDATE-HIRE_DATE) > 365 * 10;

SELECT * FROM QOINMUL;

SELECT LAST_NAME, ROUND(SYSDATE-HIRE_DATE) AS �ټӱⰣ
FROM EMPLOYEES WHERE ROUND(SYSDATE-HIRE_DATE) > 365 * 10 ORDER BY �ټӱⰣ;


--TCL (Transaction Control Language)
--COMMIT: ���� Ʈ����� ������ ����� ��� ����(INSERT, UPDATE, DELETE ��)�� �����ͺ��̽��� ���������� ����.
--COMMIT ����� �����ϸ�, Ʈ������� �Ϸ�Ǹ�, �� ���Ŀ��� ���� ������ �ǵ��� �� ����.
--ROLLBACK: ���� Ʈ����� ������ ����� ������� ����ϰ�, �����ͺ��̽��� Ʈ������� �����ϱ� ���� ���·� �ǵ�����. 
--������ �߻��߰ų� �ٸ� ������ Ʈ������� ����ؾ� �� ��쿡 ���ȴ�.
--SAVEPOINT: Ʈ����� ������ �߰� üũ����Ʈ�� �����մϴ�. ������ �߻��� ���, ROLLBACK�� ����Ͽ� �ֱ��� SAVEPOINT���� �ǵ��� �� �ִ�.
--Ʈ������� ��Ʈ���ϴ� TCL(TRANSACTION CONTROL LANGUAGE)

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

--�μ��� �޿� ��Ȳ
--���̺����, �μ��� �޿��� �� �޿��� Ȯ�� �� �� ����.
--(�޿��� �� ��� �ּڰ� �ִ�, �� ������, �޿���ü����, ������ձ޿�, �μ���ձ޿�)
--table ����� �μ��� �޿��� �뷫������ ����
--����� ���̺� Ȯ��
select * from jobs;
select * from departments;
select * from employees;
select * from job_history;

--�μ� ��� Ȯ��
SELECT department_id
from employees
group by department_id
order by department_id DESC;
-- �μ� ��� department_id : 10,20,30,40,50,60,70,80,90,100,110 �� �� ������(120~200��..)�� ���� null ���� ����.
--department_id �� null �� ����� ��� job_id �� �´� department_id �� �ο����ַ�����(������ ���Ἲ)
--1. department_id �� null ���� ��� ã��
select *
from employees
where department_id IS NULL;
--�Ѹ� �ۿ� ����. department_id : null, employee_id : 178, Job_id : SA_REP

--2. job_id �� SA_REP �� department_id ã�� (������ �´� �μ� ã��)
select job_id, department_id
from job_history
where job_id IN 'SA_REP';
--SA_REP �� department_id �� 80

--3. ���� �� savepoint ����
SAVEPOINT null_to_80;
------------------------SAVEPOINT---------------------------------

--4. ��������primary key �� employee_id �� ã�Ƽ� derpartment_id �� 80���� ����
UPDATE employees
SET department_id = 80
WHERE employee_id = 178;

select * from employees where employee_id = 178;
--ROLLBACK null_to_80; -- savepoint�� ����
--commit;
--������


-- Ž���� �� ������ ������
-- �� �μ����� ������ ����̰� � �����ǵ��� �ְ� ������ ��� �Ǵ���
-- ROLLUP�� ���������� ���� ����� ���� : ��� �� �μ� �� ������ ���� ���� ����
SELECT E.DEPARTMENT_ID, D.DEPARTMENT_NAME, NVL(E.JOB_ID,'TOTAL') JOB_ID, COUNT(*) ������
FROM EMPLOYEES E LEFT OUTER JOIN DEPARTMENTSD ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY ROLLUP((E.DEPARTMENT_ID, D.DEPARTMENT_NAME), E.JOB_ID) ORDER BY E.DEPARTMENT_ID;

-- JOB ID �� ������� �� �޴��� �� �������� ������ ���
SELECT JOB_ID, ����, ROUND(AVG(SALARY)) ��ձ޿�
FROM (SELECT JOB_ID, FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12) AS ����, SALARY FROM EMPLOYEES)
GROUP BY JOB_ID, ���� ORDER BY JOB_ID, ����;



