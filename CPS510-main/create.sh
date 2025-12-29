#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 -S "hkhambat/06179254@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF

CREATE TABLE Author (
   author_id NUMBER PRIMARY KEY ,
   author_name VARCHAR2(255) NOT NULL
);

CREATE TABLE Category (
   category_id NUMBER PRIMARY KEY ,
   category_name VARCHAR2(255) NOT NULL
);

CREATE TABLE Publisher (
   publisher_id NUMBER PRIMARY KEY ,
   publisher_name VARCHAR2(255) NOT NULL
);

CREATE TABLE Patron (
   patron_id NUMBER PRIMARY KEY ,
   patron_name VARCHAR2(255) NOT NULL ,
   patron_surname VARCHAR2(255) NOT NULL ,
   patron_email VARCHAR2(255) UNIQUE
);

CREATE TABLE Book (
   book_id NUMBER PRIMARY KEY ,
   title VARCHAR2(255) NOT NULL ,
   category_id NUMBER NOT NULL ,
   FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE Book_author (
   book_id NUMBER NOT NULL,
   author_id NUMBER NOT NULL ,
   PRIMARY KEY(book_id , author_id) ,
   FOREIGN KEY (book_id) REFERENCES book(book_id),
   FOREIGN KEY (author_id) REFERENCES author(author_id)
);

CREATE TABLE Book_Copy (
   copy_id NUMBER PRIMARY KEY ,
   year_published NUMBER(4,0) NOT NULL,
   publisher_id NUMBER NOT NULL ,
   book_id NUMBER NOT NULL ,
   FOREIGN KEY (book_id) REFERENCES book(book_id),
   FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

CREATE TABLE Checkout (
   checkout_id NUMBER PRIMARY KEY ,
   start_time DATE DEFAULT SYSDATE ,
   end_time DATE NOT NULL ,
   book_id NUMBER NOT NULL,
   copy_id NUMBER NOT NULL ,
   patron_id NUMBER NOT NULL ,
   is_returned CHAR(1) CHECK (is_returned IN ('Y', 'N')) ,
   FOREIGN KEY (book_id) REFERENCES book(book_id),
   FOREIGN KEY (copy_id) REFERENCES book_copy(copy_id),
   FOREIGN KEY (patron_id) REFERENCES patron(patron_id)
);

CREATE TABLE Hold (
   hold_id NUMBER PRIMARY KEY ,
   start_time DATE DEFAULT SYSDATE ,
   end_time DATE NOT NULL ,
   patron_id NUMBER NOT NULL ,
   copy_id NUMBER NOT NULL ,
   FOREIGN KEY (copy_id) REFERENCES book_copy(copy_id),
   FOREIGN KEY (patron_id) REFERENCES patron(patron_id)
);

CREATE TABLE Waitlist (
   book_id NUMBER NOT NULL,
   patron_id NUMBER NOT NULL ,
   PRIMARY KEY (book_id, patron_id),
   FOREIGN KEY (book_id) REFERENCES book(book_id),
   FOREIGN KEY (patron_id) REFERENCES patron(patron_id)
);

CREATE TABLE Notification (
   notification_id NUMBER PRIMARY KEY ,
   time_sent DATE DEFAULT SYSDATE ,
   notification_type VARCHAR2(50) NOT NULL ,
   patron_id NUMBER NOT NULL ,
   FOREIGN KEY (patron_id) REFERENCES patron(patron_id)
);

CREATE VIEW Checkedout(checkout_id, book_id, copy_id, patron_id)
AS(SELECT checkout_id, book_id, copy_id, patron_id
FROM CHECKOUT
WHERE IS_RETURNED = 'N');


CREATE VIEW List_Science_Fiction(book_title)
AS(SELECT title
FROM BOOK
JOIN CATEGORY ON BOOK.category_id = CATEGORY.category_id
WHERE CATEGORY.category_name = 'science fiction');

CREATE VIEW COUNT_COPIES(title, copy_id, book_id)
AS(SELECT title, BOOK_COPY.copy_id, BOOK_COPY.book_id
FROM BOOK
JOIN BOOK_COPY ON BOOK.book_id = BOOK_COPY.book_id
WHERE BOOK.title = 'The Catcher in the Rye');
SELECT COUNT(copy_id) AS Number_of_copies FROM COUNT_COPIES;
