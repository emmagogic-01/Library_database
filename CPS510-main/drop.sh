#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 -S "hkhambat/06179254@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" << EOF

DROP TABLE Waitlist;
DROP TABLE Notification;
DROP TABLE Hold;
DROP TABLE Checkout;
DROP TABLE Book_Copy;
DROP TABLE Book_Author;
DROP TABLE Book;
DROP TABLE Patron;
DROP TABLE Publisher;
DROP TABLE Category;
DROP TABLE Author;

DROP VIEW Checkedout;
DROP VIEW List_Science_Fiction;
DROP VIEW COUNT_COPIES;
