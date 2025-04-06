-- 5장

-- 행 개수 구하기
SELECT COUNT(*) FROM sample51;
SELECT COUNT(*) FROM sample51 WHERE name='A';

SELECT COUNT(no), COUNT(name) FROM sample51;

-- 모든 행 개수 구하기
SELECT ALL name FROM sample51;
-- 중복값 제외한 행 개수 구하기
SELECT DISTINCT name FROM sample51;

-- 중복 제거하지 않은 개수와 중복 제거한 개수 구하기  
SELECT COUNT(ALL name), COUNT(DISTINCT name) FROM sample51;

-- SUM 함수 사용
SELECT SUM(quantity) FROM sample51;

-- AVG 함수
SELECT AVG(quantity), SUM(quantity)/COUNT(quantity) FROM sample51;
-- NULL값을 0으로 변환 후 AVG 함수 사용
SELECT AVG(CASE WHEN quantity IS NULL THEN 0 ELSE quantity END) AS avgnull0 FROM sample51;

-- MIN, MAX 함수 사용
SELECT MIN(quantity), MAX(quantity), MIN(name), MAX(name) FROM sample51;

-- name 열로 그룹화
SELECT name FROM sample51 GROUP BY name;
SELECT name, COUNT(name), SUM(quantity) FROM sample51 GROUP BY name;

-- HAVING 구로 조건 지정
SELECT name, COUNT(name) FROM sample51 GROUP BY name HAVING COUNT(name)=1;

-- 복수 열의 그룹화
SELECT MIN(no), name, SUM(quantity) FROM sample51 GROUP BY name;

-- 결과값 정렬
SELECT name, COUNT(name), SUM(quantity) FROM sample51 GROUP BY name ORDER BY SUM(quantity) DESC;

-- 최솟값을 가지는 행 삭제 (인라인 뷰로 임시 테이블 만들어 에러 피하기)
DELETE FROM sample54 WHERE a=(SELECT a FROM (SELECT MIN(a) AS a FROM sample54) AS x);

-- SELECT 구에서 서브쿼리 사용하기
SELECT
    (SELECT COUNT(*) FROM sample51) AS sq1,
    (SELECT COUNT(*) FROM sample54) AS sq2;

-- SET 구에서 서브쿼리 사용하기
UPDATE sample54 SET a=(SELECT MAX(a) FROM sample54);

-- FROM 구에서 서브쿼리 사용하기
SELECT * FROM (SELECT * FROM sample54) AS sq;
SELECT * FROM (SELECT * FROM (SELECT * FROM sample54) sq1) sq2;

-- VALUES 구에서 서브쿼리 사용하기기
INSERT INTO sample541 VALUES (
    (SELECT COUNT(*) FROM sample51),
    (SELECT COUNT(*) FROM sample54)
);

-- SELECT 결과를 INSERT하기
INSERT INTO sample541 SELECT 1,2;

-- 테이블 행 복사
INSERT INTO sample542 SELECT * FROM sample543;

-- EXISTS 이용해 '있음' 갱신
UPDATE sample551 SET a='있음' WHERE EXISTS (SELECT * FROM sample552 WHERE no2=no);

-- NOT EXISTS 이용해 '없음' 갱신
UPDATE sample551 SET a='없음' WHERE NOT EXISTS (SELECT * FROM sample552 WHERE no2=no);

-- 열에 테이블명 붙이기
UPDATE sample551 SET a='있음' WHERE EXISTS (SELECT * FROM sample552 WHERE sample552.no2= sample551.no);

-- IN 사용하여 조건식 기술
SELECT * FROM sample551 WHERE no IN (3, 5);

-- IN의 오른쪽을 서브쿼리로 지정
SELECT * FROM sample551 WHERE no IN (SELECT no2 FROM sample552);

-- 6장

-- 테이블 만들기
CREATE TABLE sample62 (
    no INTEGER NOT NULL,
    a VARCHAR(30),
    b DATE);

-- 테이블 삭제
DROP TABLE 테이블명

-- 테이블의 모든 행 삭제
TRUNCATE TABLE 테이블명 

-- 테이블 열 추가
ALTER TABLE sample62 ADD newcol INTEGER;

-- 테이블 열 속성 변경
ALTER TABLE sample62 MODIFY newcol VARCHAR(20);

-- 테이블 열명 변경 (속성도 함께 변경 가능능)
ALTER TABLE sample62 CHANGE newcol c VARCHAR(20);

-- 테이블 열 삭제
ALTER TABLE sample62 DROP c;

-- 테이블 열에 제약 정의하기
CREATE TABLE sample631 (
    a INTEGER NOT NULL,
    b INTEGER NOT NULL UNIQUE,
    c VARCHAR(30)
);

-- 테이블에 테이블 제약 정의하기+테이블 제약에 이름 붙이기
CREATE TABLE sample632 (
    no INTEGER NOT NULL,
    sub_no INTEGER NOT NULL,
    name VARCHAR(30),
    CONSTRAINT pkey_sample PRIMARY KEY (no, sub_no)
);

-- 열 제약 추가
ALTER TABLE sample631 MODIFY c VARCHAR(30) NOT NULL;

-- 테이블 제약 추가
ALTER TABLE sample631 ADD CONSTRAINT pkey_sample631 PRIMARY KEY(a);

-- 제약 삭제
ALTER TABLE sample631 MODIFY c VARCHAR(30);

-- 테이블 제약 삭제
ALTER TABLE 테이블명 DROP PRIMARY KEY;

-- 기본키 제약 설정 (기본키는 NOT NULL 제약 필수)
CREATE TABLE sample634 (
    p INTEGER NOT NULL,
    a VARCHAR(30),
    CONSTRAINT pkey_sample634 PRIMARY KEY(p)
);

-- 인덱스 작성
CREATE INDEX isample65 ON sample62(no);

-- 인덱스 삭제
DROP INDEX 인덱스명 (스키마 객체의 경우)
DROP INDEX 인덱스명 ON 테이블명 (테이블 내 객체의 경우)
DROP INDEX isample65 ON sample62;

-- EXPLAIN 명령
EXPLAIN SELECT * FROM sample62 WHERE a='a';
EXPLAIN SELECT * FROM sample62 WHERE no>10;

-- 뷰의 작성
CREATE VIEW sample_view_67 AS SELECT * FROM sample54;
CREATE VIEW sample_view_672(n,v,v2) AS SELECT no,a,a*2 FROM sample54;

-- 뷰의 삭제
DROP VIEW 뷰명 