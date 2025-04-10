-- 7장

-- 예제 7-1. UNION으로 합집합 구하기
SELECT * FROM sample71_a;
SELECT * FROM sample71_b;

-- 예제 7-2. 두 개의 SELECT 명령을 UNION해서 합집합 구하기
SELECT * FROM sample71_a
UNION
SELECT * FROM sample71_b;

-- UNION﻿을 사용할 때의 ORDER BY
SELECT a AS c FROM sample71_a
UNION
SELECT b AS c FROM sample71_b ORDER BY c;

-- 예제 7-3. 두 개의 SELECT 명령dp UNION ALL을 적용해 합집합 구하기
SELECT * FROM sample71_a
UNION ALL
SELECT * FROM sample71_b;

-- 예제 7-4. sample72_x와 sample72_y
SELECT * FROM sample72_x;
SELECT * FROM sample72_y;

-- 예제 7-5. FROM 구로 곱집합 구하기
SELECT * FROM sample72_x, sample72_y;

-- 예제 7-6. 상품 테이블 작성하기
CREATE TABLE 상품(
    상품코드 CHAR(4) NOT NULL,
    상품명 VARCHAR(30),
    메이커명 VARCHAR(30),
    가격 INTEGER,
    상품분류 VARCHAR(30),
    PRIMARY KEY (상품코드)
);

-- 예제 7-7. 재고수 테이블 작성하기
CREATE TABLE 재고수(
    상품코드 CHAR(4),
    입고날짜 DATE,
    재고수 INTEGER
);

-- 예제 7-8. 상품 테이블과 재고수 테이블을 교차결합하기
SELECT * FROM 상품, 재고수;

-- 예제 7-9. 상품코드가 같은 행을 검색하기
SELECT * FROM 상품, 재고수
    WHERE 상품.상품코드 = 재고수.상품코드;

-- 예제 7-10. 검색할 행과 반환할 열 제한하기
SELECT 상품.상품명, 재고수.재고수 FROM 상품, 재고수
    WHERE 상품.상품코드 = 재고수.상품코드
        AND 상품.상품분류 = '식료품';

-- 예제 7-11. 메이커 테이블 작성하기
CREATE TABLE 메이커(
    메이커코드 CHAR(4) NOT NULL
    메이커명 VARCHAR(30),
    PRIMARY KEY (메이커코드)
);

-- 예제 7-12. 상품테이블과 메이커 테이블을 내부결합하기
SELECT S.상품명, M.메이커명
    FROM 상품2 S INNER JOIN 메이커 M
        ON S.메이커코드 = M.메이커코드;

-- 예제 7-13. 상품 테이블을 자기결합 하기
SELECT S1.상품명, S2.상품명
    FROM 상품 S1 INNER JOIN 상품 S2
        ON S1.상품코드 = S2.상품코드;

-- 예제 7-14. 내부결합에서는 상품코드가 0009인 상품이 제외됨
SELECT 상품3.상품명, 재고수.재고수
    FROM 상품3 INNER JOIN 재고수
    ON 상품3.상품코드 = 재고수.상품코드
    WHERE 상품3.상품분류 = '식료품';

-- 예제 7-15. 외부결합으로 상품코드 0009인 상품도 결과에 포함하기
SELECT 상품3.상품명, 재고수.재고수
    FROM 상품3 LEFT JOIN 재고수
    ON 상품3.상품코드 = 재고수.상품코드
    WHERE 상품3.상품분류 = '식료품';

-- 예제 7-18. Oracle에서 구식 외부결합으로 0009의 상품을 결과에 포함하기
SELECT 상품3.상품명, 재고수.재고수
    FROM 상품3, 재고수
    WHERE 상품3.상품코드 = 재고수.상품코드 (+)
    AND 상품3.상품분류 = '식료품';

