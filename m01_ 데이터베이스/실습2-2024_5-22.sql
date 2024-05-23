

-- [�ǽ�]
-- ���� HR�� �ִ� 7�� ���̺���� �м��ؼ� �λ������ �ǹ��ִ� �λ���Ʈ 5�� �̻��� ����ϼ���
-- �λ���� ������ ���� KPI 2���� �����ϰ� �̰͵��� ���̺���� �����Ϳ� �ݿ��� �� �ٽ� �м��ؼ� �ݿ� ���θ� ����


SELECT * FROM EMPLOYEES;
SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM job_history;
SELECT * FROM locations;
SELECT * FROM regions;
SELECT * FROM jobs;


-- CASE1 : �Ի�⵵���� ���� �⵵������ �ٹ������ ���ϰ� �׿� ���� ���� �ް� ����
SELECT 
    LAST_NAME,
    HIRE_DATE,
    TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) AS �ٹ����,
    CASE
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 22 THEN '�Ѵ� �����ް�'
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 20 THEN '2�� �����ް�'
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 18 THEN '1�� �����ް�'
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 17 THEN '3�� �����ް�'
        ELSE '�ް� ����'
    END AS �ް�
FROM EMPLOYEES ORDER BY �ٹ���� DESC;

-- CASE2 : �ٹ��ϼ��� ���� ���� ���� ���� �ٹ��ϼ��� ����ϴٸ� �ٹ��ϼ��� �޿��� ����
-- �޿��� (�ڽ��� �޿��� ����� �޿����� ��������̴�) 
SELECT 
    EMPLOYEE_ID AS �����ȣ,
    LAST_NAME AS �̸�,
    SALARY,
    HIRE_DATE AS �Ի���,
    CASE
        WHEN TRUNC(SYSDATE - HIRE_DATE) >= 8000 THEN '�ӿ�'
        WHEN TRUNC(SYSDATE - HIRE_DATE) >= 7000 AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES) THEN '������'
        WHEN TRUNC(SYSDATE - HIRE_DATE) >= 7000 THEN '����'
        WHEN TRUNC(SYSDATE - HIRE_DATE) >= 5000 AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES) THEN '����'
        WHEN TRUNC(SYSDATE - HIRE_DATE) >= 5000 THEN '����'
        WHEN TRUNC(SYSDATE - HIRE_DATE) >= 3000 AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES) THEN '�븮'
        ELSE '���'
    END AS ����
FROM 
    EMPLOYEES ORDER BY SALARY;

-- CASE 3 : ������ ��Ȱ�� ����� �޿� ���� ��� : ���� �ٸ� ������ ��Ȱ�� ������ ����Ͽ� ���� group by  group by EMPLOYEE_ID, LAST_NAME, HIRE_DATE group by EMPLOYEE_ID, LAST_NAME, HIRE_DATE �������� �޿����� �߰������� �޿��� �����ϴ� ���
-- REGION_ID ( 1: ���� 2: �Ƹ޸�ī 3: �ƽþ� 4: ������ī)
SELECT 
    country_NAME,salary �޿�,
    CASE 
        WHEN REGION_ID = 1 THEN trunc(salary * 1.05)  -- ���� ���: 105%�� �޿�
        WHEN REGION_ID = 2 THEN trunc(salary * 1.1)  -- �Ƹ޸�ī ���: 110%�� �޿�
        WHEN REGION_ID = 3 THEN trunc(salary * 1.15)  -- �ƽþ� ���: 115%�� �޿�
        WHEN REGION_ID = 4 THEN trunc(salary * 1.2)  -- ������ī ���: 120%�� �޿�
        ELSE salary  -- ��Ÿ ����� �⺻ �޿� �״�� �����Ͽ� ����
    END AS "������ �޿�(salary)"
FROM countries, employees;

-- CASE 4 : ������ ���� ����� 10���� ������ �ش� ��޿� �´� �޿��� ���� �󿩱��� �����Ѵ�. 

SELECT max(max_salary) "���� �� �ִ� �޿�", min(max_salary) "���� �� �ּ� �޿�" from jobs;

SELECT max_salary,
    CASE 
        WHEN grade = 1 THEN max_salary * 0.05  -- ��� 1���� ���� �޿��� 0.05�踦 ����
        WHEN grade = 2 THEN max_salary * 0.03  -- ��� 2���� ���� �޿��� 0.03�踦 ����
        WHEN grade = 3 THEN max_salary * 0.01  -- ��� 3���� ���� �޿��� 0.01�踦 ����
        WHEN grade = 4 THEN max_salary * 0 -- ��� 4���� ���� �޿��� ������ �ݾ��� ����
    END AS "�󿩱�"
FROM ( SELECT max_salary, width_bucket(max_salary, 5000, 40001, 4) AS grade FROM jobs);

-- CASE 5 : ���� ��¥�� �������� �Ի� 20���� �̻��� ���ʽ� 10000 �����ϴ� ���� 
-- �ٹ��� ��¥ ��� �Ŀ� �ش� ����� 20�� �̻��� ���ʽ� ���� ����� ���� Ȯ��.
SELECT first_name || ' ' || last_name AS "�̸�", sysdate,hire_date,trunc((sysdate - hire_date)/365) AS "�ٹ��Ⱓ(��)",
    CASE
        WHEN trunc((sysdate - hire_date)/365) >= 20 THEN 10000
        ELSE 0
    END AS "���ʽ� ����"
FROM employees
ORDER BY trunc((sysdate - hire_date)/365) DESC;

-- CASE 6 : �������� ���� �� �ؿ� �ִ� ���� ������ �����ϰ�, �ش� ���������� �޿��� �����ִ� ����.
SELECT e1.first_name || ' ' || e1.last_name AS "���", 
       e2.first_name || ' ' || e2.last_name AS "���� ����",
       j.JOB_TITLE AS "������", e2.SALARY AS "�޿�"
FROM employees e1
JOIN employees e2 ON e1.EMPLOYEE_ID = e2.MANAGER_ID
JOIN jobs j ON e2.JOB_ID = j.JOB_ID
ORDER BY JOB_TITLE; 

-- CASE 7 : �ٷγ⿡ ���� ���� ���� ���� 
SELECT 
    EMPLOYEE_ID,
    CASE 
        WHEN hire_date > ADD_MONTHS(SYSDATE, -12) THEN 14  -- 1�� �̸�
        WHEN hire_date <= ADD_MONTHS(SYSDATE, -12) AND hire_date > ADD_MONTHS(SYSDATE, -36) THEN 14 + 3  -- 1�� �̻� ~ 3�� �̸�
        WHEN hire_date <= ADD_MONTHS(SYSDATE, -36) AND hire_date > ADD_MONTHS(SYSDATE, -60) THEN 14 + 5  -- 3�� �̻� ~ 5�� �̸�
        ELSE 14 + 7  -- 5�� �̻�   
    END AS ����
FROM employees;

SELECT 
    EMPLOYEE_ID,
    CASE 
        WHEN hire_date > TO_DATE('2006-01-01', 'YYYY-MM-DD') THEN 14  -- 1�� �̸�
        WHEN hire_date <= TO_DATE('2006-01-01', 'YYYY-MM-DD') AND hire_date > ADD_MONTHS(TO_DATE('2006-01-01', 'YYYY-MM-DD'), -24) THEN 14 + 3  -- 1�� �̻� ~ 3�� �̸�
        WHEN hire_date <= ADD_MONTHS(TO_DATE('2006-01-01', 'YYYY-MM-DD'), -24) AND hire_date > ADD_MONTHS(TO_DATE('2006-01-01', 'YYYY-MM-DD'), -48) THEN 14 + 5  -- 3�� �̻� ~ 5�� �̸�
        ELSE 14 + 7  -- 5�� �̻�
    END AS ����
FROM employees
ORDER BY ����;


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Ȯ�� ����----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM JOBS;
SELECT * FROM departments;
SELECT DEPARTMENT_NAME FROM departments;
SELECT * FROM leadership_effect;
SELECT * FROM countries;
SELECT COUNTRY_ID, COUNTRY_NAME, REGION_ID FROM countries -- ( 1: ���� 2: �Ƹ޸�ī 3: �ƽþ� 4: ������ī)
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

-- Additional CASE 1 : �� ���������� �������� �������� �򰡵鿡 ���� ����� ����ϱ�.
SELECT 
    c.COUNTRY_NAME,
    AVG(le.performance_rating) AS "�� �������� �� ����", 
    AVG(le.communication_skills_rating) AS "Ŀ�´����̼� ��ų ����",
    AVG(le.decision_making_skills_rating) AS "�ǻ� ���� �ɷ� ����",
    AVG(le.conflict_resolution_skills_rating) AS "���� �ذ� �ɷ� ����",
    AVG(le.coaching_skills_rating) AS "��Ī ��ų ����"
    
FROM 
    leadership_effect le
JOIN
    countries c ON le.country_id = c.country_ID
GROUP BY 
    c.COUNTRY_NAME
ORDER BY 
    c.COUNTRY_NAME;


-- Additional CASE 2 �ſ��� ����� ���� ��ȸ ����ϱ� �ſ�������(������)

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

-- KDI-2 �ſ����� �߰��ϰ� �ſ��޿� ���� ���� ���� ��ȸ ( �ٹ��ϼ��� ���� �������� �ٸ� ) 
-- AAA: �޿��� 5����� ���� ���� AA : �޿��� 4����� ���� A : �޿��� 3����� ����
-- B :  �޿��� 2����� ���� C: �޿��� 1.5����� ����
-- �ٹ��ϼ��� 8000�̻� 1%, 7500�̻� 1.5%, 7000�̻� 2%, 6500�̻� 2.5%, 6000�̻� 3%
SELECT 
    E.EMPLOYEE_ID AS �����ȣ,
    E.LAST_NAME AS ����̸�,
    E.SALARY AS �޿�,
    C.CREDIT_RATING AS �ſ�����,
CASE 
    WHEN C.CREDIT_RATING >= 800 THEN 'AAA'
    WHEN C.CREDIT_RATING >= 700 THEN 'AA'
    WHEN C.CREDIT_RATING >= 600 THEN 'A'
    WHEN C.CREDIT_RATING >= 500 THEN 'B'
    WHEN C.CREDIT_RATING >= 400 THEN 'C'
    ELSE '���� �Ұ���'
END AS �ſ���,
CASE
    WHEN C.CREDIT_RATING >= 800 THEN E.SALARY * 5 
    WHEN C.CREDIT_RATING >= 700 THEN E.SALARY * 4
    WHEN C.CREDIT_RATING >= 600 THEN E.SALARY * 3
    WHEN C.CREDIT_RATING >= 500 THEN E.SALARY * 2
    WHEN C.CREDIT_RATING >= 400 THEN E.SALARY * 1.5
    ELSE 0
END AS ����ݾ�,
TRUNC(SYSDATE - E.HIRE_DATE) AS �ٹ��ϼ�,
CASE --C.CREDIT_RATING >= 400 > ���� �����ڿ��Ը� �������� ���̱� ����
    WHEN TRUNC(SYSDATE - E.HIRE_DATE) >= 8000 AND C.CREDIT_RATING >= 400 THEN 1.0   
    WHEN TRUNC(SYSDATE - E.HIRE_DATE) >= 7500 AND C.CREDIT_RATING >= 400 THEN 1.5
    WHEN TRUNC(SYSDATE - E.HIRE_DATE) >= 7000 AND C.CREDIT_RATING >= 400 THEN 2.0
    WHEN TRUNC(SYSDATE - E.HIRE_DATE) >= 6500 AND C.CREDIT_RATING >= 400 THEN 2.5
    WHEN TRUNC(SYSDATE - E.HIRE_DATE) >= 6000 AND C.CREDIT_RATING >= 400 THEN 3.0
    ELSE 0
END AS ������
FROM 
    EMPLOYEES E
JOIN
    CREDIT_RATING C ON E.EMPLOYEE_ID = C.EMPLOYEE_ID;

