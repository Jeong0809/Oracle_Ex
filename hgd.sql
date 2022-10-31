create table book(
book_id number(5),
title varchar2(50),
author varchar2(10),
pub_date date
);

select *
from book;

alter table book add (pubs VARCHAR2(50));

ALTER TABLE book MODIFY ( title VARCHAR2(100));

ALTER TABLE book DROP (author);

RENAME book TO article;

DROP table article;

CREATE TABLE author (
author_id NUMBER(10),
author_name VARCHAR2(100) NOT NULL,
author_desc VARCHAR2(500),
PRIMARY KEY(author_id) --NOT NULL과 UNIQUE가 동시 부여
);

SELECT *
FROM AUTHOR;

CREATE TABLE book (
book_id NUMBER(10),
title VARCHAR2(100) NOT NULL,
pubs VARCHAR2(100),
pub_date DATE,
author_id NUMBER(10),
PRIMARY KEY(book_id),
CONSTRAINT c_book_fk FOREIGN KEY (author_id)
REFERENCES author(author_id)
);

INSERT INTO author
VALUES (1, '박경리', '토지 작가' );

INSERT INTO author( author_id, author_name )
VALUES (2, '이문열');

UPDATE author
SET author_name = '이문열', 
author_desc = '웹툰작가' 
WHERE author_id = 2;

UPDATE author
SET author_name = '기안84', 
author_desc = '웹툰작가' 
WHERE author_id = 1 ;

SELECT * FROM author;

DELETE FROM author
WHERE author_id = 1 ;

CREATE SEQUENCE sep_author_id
INCREMENT BY 1
START WITH 1;

SELECT sep_author_id.NEXTVAL FROM dual;
SELECT sep_author_id.CURRVAL FROM dual;

INSERT INTO author
VALUES (sep_author_id.nextval, '박경리', '토지 작가 ' );

SELECT * FROM USER_SEQUENCES;

SELECT * FROM author;

DROP SEQUENCE seq_author_id;

CREATE SEQUENCE seq_author_id
INCREMENT BY 1
START WITH 1;

INSERT INTO author
VALUES (seq_author_id.currval, '이문열', '경북 영양');

INSERT INTO author
VALUES (seq_author_id.NEXTVAL, '박경리', '경상남도 통영');

INSERT INTO author
VALUES (seq_author_id.NEXTVAL, '유시민', '17대 국회의원');

INSERT INTO author
VALUES (seq_author_id.NEXTVAL, '기안84', '기안동에서 산 84년생');

INSERT INTO author
VALUES (seq_author_id.NEXTVAL, '강풀', '온라인 만화가 1세대');

INSERT INTO author
VALUES (seq_author_id.NEXTVAL, '김영하', '알쓸신잡');

DROP SEQUENCE seq_book_id;

CREATE SEQUENCE seq_book_id
INCREMENT BY 1
START WITH 1;


SELECT *  FROM book;
DELETE FROM book;

INSERT INTO book
VALUES (seq_book_id.NEXTVAL, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);

INSERT INTO book
VALUES (seq_book_id.NEXTVAL, '삼국지', '민음사', '2002-03-01', 1);

INSERT INTO book
VALUES (seq_book_id.NEXTVAL, '토지', '마로니에북스', '2012-08-15', 2);

INSERT INTO book
VALUES (seq_book_id.NEXTVAL, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', 3);

INSERT INTO book
VALUES (seq_book_id.NEXTVAL, '패션왕', '중앙북스(books)', '2012-02-22', 4);

INSERT INTO book
VALUES (seq_book_id.NEXTVAL, '순정만화', '재미주의', '2011-08-03', 5);

INSERT INTO book
VALUES (seq_book_id.NEXTVAL, '오직두사람', '문학동네', '2017-05-04', 6);

INSERT INTO book
VALUES (seq_book_id.NEXTVAL, '26년', '재미주의', '2012-02-04', 5);

SELECT *
FROM book b, author a
WHERE b.author_id = a.author_id;

DROP TABLE Customer;

CREATE  TABLE Customer (
    c_id NUMBER(20) PRIMARY KEY,
    c_name VARCHAR2(100) NOT NULL,
    c_phone_number VARCHAR2(100),
    c_address VARCHAR2(100)
);

CREATE  TABLE Product (
    p_id NUMBER(20) PRIMARY KEY,
    p_name VARCHAR2(100) NOT NULL,
    p_price NUMBER(20),
    p_category VARCHAR2(100)
);

DROP TABLE Shoplist;

CREATE  TABLE Shoplist (
    s_id NUMBER(20) PRIMARY KEY,
    s_date VARCHAR2(100) NOT NULL,
    s_customer_info VARCHAR2(100),
    s_product_into VARCHAR2(100),
    s_quantity VARCHAR2(100),
    s_address VARCHAR2(100),
    s_price NUMBER(20),
    s_totalprice NUMBER(20)
);







