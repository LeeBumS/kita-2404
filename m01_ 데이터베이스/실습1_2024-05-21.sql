-- 실습 - 2인 1조
-- 학교 관리를 위하여 테이블 2개 이상으로 DB 구촉하고 3개 이상 활용할 수 있는 케이스를 만드세요
DROP TABLE SCHOOL_STUDENT;
DROP TABLE SCHOOL_TEACHER;
DROP TABLE ADMINI_STAFF;
DROP TABLE SECURITY_STAFF;

-- 학생 테이블
CREATE TABLE SCHOOL_STUDENT(
school_id NUMBER PRIMARY KEY,
name VARCHAR2(40) NOT NULL,
age NUMBER NOT NULL,
address VARCHAR2(100),
kor NUMBER(3),
math NUMBER(3),
eng NUMBER(3),
science NUMBER(3),
phone VARCHAR2(30),
class VARCHAR2(5),
gender VARCHAR2(50) NOT NULL);

-- 선생님 테이블
CREATE TABLE SCHOOL_TEACHER(
school_id NUMBER PRIMARY KEY,
name VARCHAR2(40) NOT NULL,
age NUMBER NOT NULL,
address VARCHAR2(100),
phone VARCHAR2(30),
class VARCHAR2(5),
subject VARCHAR2(20),
gender VARCHAR2(50) NOT NULL);

-- 행정 직원 테이블
CREATE TABLE admini_staff (
    schoolid NUMBER PRIMARY KEY,
    name VARCHAR2 (40),
    age NUMBER NOT NULL,
    address VARCHAR2 (100),
    phone VARCHAR2 (40),
    gender VARCHAR2 (50) NOT NULL,
    department VARCHAR2 (50),
    dandn VARCHAR2 (50) 
);
    
-- 보안 직원 테이블    
CREATE TABLE security_staff (
    schoolid NUMBER PRIMARY KEY,
    name VARCHAR2 (40),
    age NUMBER NOT NULL,
    address VARCHAR2 (100),
    phone VARCHAR2 (40),
    gender VARCHAR2 (50) NOT NULL,
    area VARCHAR2(50) DEFAULT '정문' CHECK (area IN ('정문', '후문')),
    FOREIGN KEY (schoolid) REFERENCES admini_staff(schoolid),
    dandn VARCHAR2 (50)
); 

INSERT INTO school_student VALUES (1, '유재석', 17,'서울특별시 강남구 압구정동', 85, 73, 95, 86, '010-1234-1234','2반', '남');
INSERT INTO school_student VALUES(2, '김철수', 17, '서울특별시 강남구 청담동', 88, 67, 92, 81, '010-2345-2345', '2반', '남');
INSERT INTO school_student VALUES(3, '박영희', 17, '서울특별시 강남구 논현동', 90, 78, 85, 90, '010-3456-3456', '3반', '여');
INSERT INTO school_student VALUES(4, '이민호', 17, '서울특별시 강남구 삼성동', 75, 88, 78, 85, '010-4567-4567', '1반', '남');
INSERT INTO school_student VALUES(5, '최지연', 17, '서울특별시 강남구 대치동', 82, 81, 91, 89, '010-5678-5678', '2반', '여');
INSERT INTO school_student VALUES(6, '조수민', 17, '서울특별시 강남구 도곡동', 77, 69, 85, 90, '010-6789-6789', '3반', '여');
INSERT INTO school_student VALUES(7, '정우성', 17, '서울특별시 강남구 압구정동', 84, 76, 88, 87, '010-7890-7890', '1반', '남');
INSERT INTO school_student VALUES(8, '한가인', 17, '서울특별시 강남구 청담동', 92, 85, 93, 91, '010-8901-8901', '2반', '여');
INSERT INTO school_student VALUES(9, '강동원', 17, '서울특별시 강남구 논현동', 80, 74, 86, 84, '010-9012-9012', '3반', '남');
INSERT INTO school_student VALUES(10, '김태희', 17, '서울특별시 강남구 삼성동', 89, 90, 95, 92, '010-0123-0123', '1반', '여');
INSERT INTO school_student VALUES(11, '장동건', 17, '서울특별시 강남구 대치동', 91, 77, 89, 86, '010-1234-2345', '2반', '남');
INSERT INTO school_student VALUES(12, '송혜교', 17, '서울특별시 강남구 도곡동', 83, 82, 90, 88, '010-2345-3456', '3반', '여');
INSERT INTO school_student VALUES(13, '현빈', 17, '서울특별시 강남구 압구정동', 85, 79, 87, 84, '010-3456-4567', '1반', '남');
INSERT INTO school_student VALUES(14, '수지', 17, '서울특별시 강남구 청담동', 87, 86, 92, 90, '010-4567-5678', '2반', '여');
INSERT INTO school_student VALUES(15, '이준기', 17, '서울특별시 강남구 논현동', 78, 75, 80, 83, '010-5678-6789', '3반', '남');
INSERT INTO school_student VALUES(16, '아이유', 17, '서울특별시 강남구 삼성동', 90, 88, 94, 89, '010-6789-7890', '1반', '여');
INSERT INTO school_student VALUES(17, '공유', 17, '서울특별시 강남구 대치동', 82, 71, 85, 80, '010-7890-8901', '2반', '남');
INSERT INTO school_student VALUES(18, '전지현', 17, '서울특별시 강남구 도곡동', 84, 87, 93, 88, '010-8901-9012', '3반', '여');
INSERT INTO school_student VALUES(19, '조인성', 17, '서울특별시 강남구 압구정동', 81, 70, 86, 85, '010-9012-0123', '1반', '남');
INSERT INTO school_student VALUES(20, '박보영', 17, '서울특별시 강남구 청담동', 89, 85, 91, 87, '010-0123-1234', '2반', '여');
INSERT INTO school_student VALUES(21, '김우빈', 17, '서울특별시 강남구 논현동', 83, 72, 88, 86, '010-1234-2346', '3반', '남');
INSERT INTO school_student VALUES(22, '오연서', 17, '서울특별시 강남구 삼성동', 90, 91, 93, 94, '010-2345-3457', '1반', '여');
INSERT INTO school_student VALUES(23, '이동욱', 17, '서울특별시 강남구 대치동', 85, 80, 82, 88, '010-3456-4568', '2반', '남');
INSERT INTO school_student VALUES(24, '유인나', 17, '서울특별시 강남구 도곡동', 88, 78, 90, 87, '010-4567-5679', '3반', '여');
INSERT INTO school_student VALUES(25, '차은우', 17, '서울특별시 강남구 압구정동', 87, 85, 89, 90, '010-5678-6780', '1반', '남');
INSERT INTO school_student VALUES(26, '김지원', 17, '서울특별시 강남구 청담동', 92, 88, 94, 91, '010-6789-7891', '2반', '여');
INSERT INTO school_student VALUES(27, '이종석', 17, '서울특별시 강남구 논현동', 84, 76, 87, 85, '010-7890-8902', '3반', '남');
INSERT INTO school_student VALUES(28, '수현', 17, '서울특별시 강남구 삼성동', 93, 89, 95, 92, '010-8901-9013', '1반', '여');
INSERT INTO school_student VALUES(29, '박서준', 17, '서울특별시 강남구 대치동', 81, 77, 83, 86, '010-9012-0124', '2반', '남');
INSERT INTO school_student VALUES(30, '한예슬', 17, '서울특별시 강남구 도곡동', 86, 84, 88, 89, '010-0123-1235', '3반', '여');

SELECT * FROM school_student;

INSERT INTO school_teacher VALUES (1, '장원영', 35, '서울특별시 강남구 청담동', '010-9876-5432', 'A', '국어', '여');
INSERT INTO school_teacher VALUES (2, '김태형', 38, '서울특별시 강서구 화곡동', '010-1234-5678', 'B', '수학', '남');
INSERT INTO school_teacher VALUES (3, '이지훈', 40, '서울특별시 강북구 미아동', '010-9876-5432', 'A', '영어', '남');
INSERT INTO school_teacher VALUES (4, '박서연', 32, '서울특별시 서초구 방배동', '010-8765-4321', 'B', '과학', '여');
INSERT INTO school_teacher VALUES (5, '정수빈', 37, '서울특별시 송파구 거여동', '010-9876-5432', 'A', '국어', '여');
INSERT INTO school_teacher VALUES (6, '김승우', 41, '서울특별시 강동구 천호동', '010-1234-5678', 'B', '수학', '남');
INSERT INTO school_teacher VALUES (7, '최지영', 33, '서울특별시 도봉구 쌍문동', '010-9876-5432', 'A', '영어', '여');
INSERT INTO school_teacher VALUES (8, '이재현', 36, '서울특별시 강서구 마곡동', '010-8765-4321', 'B', '과학', '남');

SELECT * FROM school_teacher;

INSERT INTO admini_staff VALUES (1, '이미숙', 52, '서울특별시 강남구', '010-1928-3746', 'Famale', '식당', 'Day');
INSERT INTO admini_staff VALUES (2, '박준혁', 45, '서울특별시 서대문구', '010-9876-5432', 'Male', '행정', 'Day');
INSERT INTO admini_staff VALUES (3, '김지은', 38, '서울특별시 강서구', '010-1234-5678', 'Female', '학사', 'Night');
INSERT INTO admini_staff VALUES (4, '정우진', 50, '서울특별시 마포구', '010-8765-4321', 'Male', '교무', 'Night');
INSERT INTO admini_staff VALUES (5, '이미선', 41, '서울특별시 서초구', '010-5555-5555', 'Female', '행정', 'Night');
INSERT INTO admini_staff VALUES (6, '최영수', 49, '서울특별시 송파구', '010-1111-1111', 'Male', '보안', 'Day');
INSERT INTO admini_staff VALUES (7, '박현지', 35, '서울특별시 노원구', '010-9999-9999', 'Female', '학사', 'Day');


SELECT * FROM admini_staff;

INSERT INTO security_staff VALUES (1, '이승호', 47, '서울특별시 양천구', '010-3333-3333', 'Male', '정문', 'Day');
INSERT INTO security_staff VALUES (2, '김동희', 53, '서울특별시 서초구', '010-8888-8888', 'Male', '정문', 'Night');
INSERT INTO security_staff VALUES (3, '장성훈', 48, '서울특별시 중랑구', '010-1212-1212', 'Male', '후문', 'Day');


SELECT * FROM security_staff;


-- CASE 1 : 합계 점수가 총합 평균점수보다 높은 정보 조회
SELECT name FROM school_student WHERE (kor + math + eng + science) >
(SELECT AVG(kor + math + eng + science) FROM school_student);

-- CASE 2 : 점수에 따라 A반 B반 조회
SELECT S.NAME,S.CLASS, CASE WHEN (S.kor + S.math + S.eng + S.science) / 4 >= 85 
THEN 'A반' ELSE 'B반' END AS 반 FROM school_student S;



-- CASE 3 : '이승호' 보안 직원의 전화번호와 '김동희'의 전화번호가 서로 바꾸고 정보 조회
UPDATE security_staff
SET phone = CASE WHEN phone = '010-3333-3333' THEN '010-8888-8888'
WHEN phone = '010-8888-8888' THEN '010-3333-3333' END

WHERE phone IN ('010-3333-3333', '010-8888-8888');

SELECT * FROM SECURITY_STAFF;

-- Case 4 : 행정직원 및 보안직원 중에서 1. 낮에 일하는 2. 밤에 일하는 인원을 선별하는 정보 조회
-- Case 4 - 1 : 낮에 일하는 인원
SELECT a.name AS 이름, a.dandn AS 일하는시간
FROM admini_staff a
WHERE a.dandn = 'Day'

UNION ALL

SELECT s.name AS 이름, s.dandn AS 일하는시간
FROM security_staff s
WHERE s.dandn = 'Day';

-- Case 4 - 2 : 밤에 일하는 인원
SELECT a.name AS 이름, a.dandn AS 일하는시간
FROM admini_staff a
WHERE a.dandn = 'Night'

UNION ALL

SELECT s.name AS 이름, s.dandn AS 일하는시간
FROM security_staff s
WHERE s.dandn = 'Night';

SELECT * FROM security_staff;

-- CASE 5 : 함계 점수가 가장 높은 3명에게 장학금 지급 조회 3명까지 
SELECT * FROM (SELECT s.name, SUM(s.kor + s.math + s.eng + s.science) AS "총 점수", s.class FROM school_student s
GROUP BY s.name, s.class
ORDER BY SUM(s.kor + s.math + s.eng + s.science) DESC)
WHERE ROWNUM <= 3;

-- CASE 6 : 같은 동네에서 사는 사람들끼리 묶기 총합점수가 가장 높은순으로
SELECT NAME, ADDRESS, (kor + math + eng + science) AS 총합점수 FROM school_student
WHERE ADDRESS LIKE '%대치동%'
ORDER BY 총합점수 DESC;

