#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 -S "hkhambat/06179254@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF

INSERT INTO Author (author_id, author_name) VALUES (1, 'J.D. Salinger');
INSERT INTO Author (author_id, author_name) VALUES (2, 'Isaac Asimov');
INSERT INTO Author (author_id, author_name) VALUES (3, 'Agatha Christie');
INSERT INTO Author (author_id, author_name) VALUES (4, 'David McCullough');

INSERT INTO Category (category_id, category_name) VALUES (1, 'Fiction');
INSERT INTO category (category_id, category_name) VALUES (2, 'Science Fiction');
INSERT INTO category (category_id, category_name) VALUES (3, 'Mystery');
INSERT INTO category (category_id, category_name) VALUES (4, 'History');

INSERT INTO Publisher (publisher_id, publisher_name) VALUES (1, 'Little, Brown and Company');
INSERT INTO publisher (publisher_id, publisher_name) VALUES (2, 'Random House');
INSERT INTO publisher (publisher_id, publisher_name) VALUES (3, 'Penguin Books');
SET DEFINE OFF;

INSERT INTO publisher (publisher_id, publisher_name) VALUES (4, 'Simon & Schuster');
SET DEFINE ON;

INSERT INTO Patron (patron_id, patron_name, patron_surname, patron_email) VALUES (1, 'John', 'Doe', 'john.doe@example.com');
INSERT INTO patron (patron_id, patron_name, patron_surname, patron_email) VALUES (2, 'Jane', 'Smith', 'janesmith@example.com');
INSERT INTO patron (patron_id, patron_name, patron_surname, patron_email) VALUES (3, 'Alice', 'Johnson', 'alicejohnson@example.com');

INSERT INTO Book (book_id, title, category_id) VALUES (1, 'The Catcher in the Rye', 1);
INSERT INTO book (book_id, title, category_id) VALUES (2, 'Foundation', 2);
INSERT INTO book (book_id, title, category_id) VALUES (3, 'Murder on the Orient Express', 3);
INSERT INTO book (book_id, title, category_id) VALUES (4, '1776', 4);

INSERT INTO Book_author (book_id, author_id) VALUES (1, 1);
INSERT INTO book_author (book_id, author_id) VALUES (2, 2); 
INSERT INTO book_author (book_id, author_id) VALUES (3, 3); 
INSERT INTO book_author (book_id, author_id) VALUES (4, 4); 

INSERT INTO book_copy (copy_id, book_id, publisher_id, year_published) VALUES (1, 1, 1, 1951);
INSERT INTO book_copy (copy_id, book_id, publisher_id, year_published) VALUES (4, 1, 4, 2024);
INSERT INTO book_copy (copy_id, book_id, publisher_id, year_published) VALUES (2, 2, 2, 1934);
INSERT INTO book_copy (copy_id, book_id, publisher_id, year_published) VALUES (3, 3, 3, 2005);

INSERT INTO Checkout (checkout_id, book_id, copy_id, patron_id, start_time, end_time ,is_returned) VALUES (1, 1, 1, 1, SYSDATE, SYSDATE + 14 , 'Y');
INSERT INTO Checkout (checkout_id, book_id, copy_id, patron_id, start_time, end_time , is_returned) VALUES (2, 2, 2, 2, SYSDATE, SYSDATE + 20 , 'N'); 
INSERT INTO Checkout (checkout_id, book_id, copy_id, patron_id, start_time, end_time , is_returned) VALUES (3, 3, 3, 3, SYSDATE, SYSDATE + 60, 'Y'); 

INSERT INTO hold (hold_id, copy_id, patron_id, start_time, end_time) VALUES (1, 1, 2, SYSDATE, SYSDATE + 7); 
INSERT INTO hold (hold_id, copy_id, patron_id, start_time, end_time) VALUES (2, 2, 3, SYSDATE, SYSDATE + 7);
INSERT INTO hold (hold_id, copy_id, patron_id, start_time, end_time) VALUES (3, 3, 1, SYSDATE, SYSDATE + 7); 

INSERT INTO waitlist (book_id, patron_id) VALUES (1, 1);
INSERT INTO waitlist (book_id, patron_id) VALUES (2, 2);
INSERT INTO waitlist (book_id, patron_id) VALUES (3, 3); 

INSERT INTO notification (notification_id, patron_id, time_sent, notification_type) VALUES (1, 1, SYSDATE, 'availability_notification');
INSERT INTO notification (notification_id, patron_id, time_sent, notification_type) VALUES (2, 2, SYSDATE, 'end_date_notification');
