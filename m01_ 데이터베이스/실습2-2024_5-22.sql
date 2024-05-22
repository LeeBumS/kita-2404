

--[�ǽ�]
-- ���� HR�� �ִ� 7�� ���̺���� �м��ؼ� �λ������ �ǹ��ִ� �λ���Ʈ 5�� �̻��� ����ϼ���
-- �λ���� ������ ���� KPI 2���� �����ϰ� �̰͵��� ���̺���� �����Ϳ� �ݿ��� �� �ٽ� �м��ؼ� �ݿ� ���θ� ����

SELECT * FROM EMPLOYEES;
SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM job_history;
SELECT * FROM locations;
SELECT * FROM regions;
SELECT * FROM jobs;


-- CASE1 : ������ ���
SELECT EMPLOYEE_ID, LAST_NAME, ROUND(CASE WHEN SALARY > (SELECT AVG(SALARY) 
FROM EMPLOYEES) THEN SALARY * 0.1 ELSE SALARY * 0.05 END) AS ������ FROM EMPLOYEES ORDER BY ������ DESC;

-- CASE : �ٹ������ ���� ����
SELECT 
    LAST_NAME,
    HIRE_DATE,
    TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) AS �ٹ����,
    CASE
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 20 THEN '�Ѵ� �����ް�'
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 18 THEN '2�� �����ް�'
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 16 THEN '1�� �����ް�'
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 14 THEN '3�� �����ް�'
        ELSE '�ް� ����'
    END AS �ް�
FROM EMPLOYEES ORDER BY �ٹ���� DESC;

-- CASE : ����
SELECT 
    EMPLOYEE_ID AS �����ȣ,
    LAST_NAME AS �̸�,
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
    EMPLOYEES;
    

-- CASE: ���� ������
SELECT 
    e.EMPLOYEE_ID AS �����ȣ,
    e.LAST_NAME AS �̸�,
    e.JOB_ID,
    e.SALARY AS �޿�,
    e.HIRE_DATE AS �Ի���
FROM EMPLOYEES e WHERE (e.JOB_ID, e.SALARY, e.HIRE_DATE) IN (SELECT JOB_ID,MAX(SALARY) AS MAX_SALARY,
MIN(HIRE_DATE) AS MIN_HIRE_DATE FROM EMPLOYEES GROUP BY JOB_ID) ORDER BY �����ȣ DESC;

-- CASE: Ŀ�̼� ���ؿ��� ���� ���� ������ �޴� ������ �ĺ�
SELECT 
    EMPLOYEE_ID AS �����ȣ,
    LAST_NAME AS �̸�,
    COMMISSION_PCT AS Ŀ�̼�,
    SALARY AS �޿�
FROM EMPLOYEES WHERE (COMMISSION_PCT, SALARY) IN (SELECT COMMISSION_PCT,
MAX(SALARY) AS MAX_SALARY FROM EMPLOYEES GROUP BY 
COMMISSION_PCT);

















































































































