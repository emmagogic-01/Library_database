#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 -S "hkhambat/06179254@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF

SELECT Author_name AS "Author", COUNT(Book.book_id) AS "Number of Books"
FROM Author
JOIN Book_Author ON Author.author_id = Book_Author.author_id
JOIN Book ON Book_Author.book_id = Book.book_id
WHERE Author_name = 'Agatha Christie'
GROUP BY Author_name;

SELECT *
FROM Category
ORDER BY category_name;

SELECT *
FROM Publisher
WHERE publisher_id = 1;

SELECT *
FROM Patron
WHERE patron_email = 'example@example.com';

SELECT Book.title AS "Book Title"
FROM Book
JOIN Category ON Book.category_id = Category.category_id
WHERE category_name = 'Science Fiction';

SELECT *
FROM Book_author
WHERE author_id = 3;

SELECT *
FROM Book_Copy
WHERE publisher_id = 4;

SELECT patron_id
FROM CHECKOUT
WHERE is_returned = 'Y';

SELECT *
FROM Hold
WHERE end_time < TO_DATE('2024-12-31', 'YYYY-MM-DD');

SELECT *
FROM Waitlist
WHERE book_id = 2;

SELECT Notification.notification_type AS "Notification Type", Notification.time_sent AS "Time Sent"
FROM Notification
JOIN Patron ON Notification.patron_id = Patron.patron_id
WHERE Patron.patron_name = 'Jane' AND Patron.patron_surname = 'Smith';

SELECT Book.title AS "Book Title"
FROM Book
JOIN Book_Copy ON Book.book_id = Book_Copy.book_id
GROUP BY Book.title
HAVING COUNT(Book_Copy.copy_id) >= 2;

SELECT DISTINCT p.patron_name || ' ' || p.patron_surname AS "Patron Name"
FROM Patron p
JOIN Checkout c ON p.patron_id = c.patron_id
WHERE EXISTS (
    SELECT *
    FROM Notification n
    WHERE n.patron_id = p.patron_id
    AND n.notification_type = 'end_date_notification'
    AND n.patron_id = c.patron_id
    );

SELECT b.title AS "Book Title"
FROM Book b
JOIN Category c ON b.category_id = c.category_id
WHERE c.category_name = 'Science Fiction'

UNION

SELECT b.title AS "Book Title"
FROM Book b
JOIN Category c ON b.category_id = c.category_id
WHERE c.category_name = 'History';

SELECT book.title AS "Science Fiction Books"
FROM Book
JOIN Category ON book.category_id = category.category_id
where category.category_name = 'Science Fiction'

MINUS

SELECT book.title AS "Returned Science Fiction Books"
FROM Book
JOIN Category ON book.category_id = category.category_id
JOIN Book_Copy ON book.book_id = book_copy.book_id
JOIN Checkout ON book_copy.copy_id = checkout.copy_id
WHERE category.category_name = 'Science Fiction' AND checkout.is_returned = 'Y'

SELECT AVG(Checkout_Count) AS "Average Checkouts Per Patron"
FROM (
    SELECT patron.patron_id, COUNT(checkout.checkout_id) AS Checkout_Count
    FROM Patron
    LEFT JOIN Checkout ON patron.patron_id = checkout.patron_id  --Ensures that patrons with no checkouts are included in the calculation (with a count of 0).
    GROUP BY patron.patron_id
   );
