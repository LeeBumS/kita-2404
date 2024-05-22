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




































































































































































































































