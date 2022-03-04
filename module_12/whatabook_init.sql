/*
    Title: whatabook.init.sql
    Author: Grant Roberts
    Date: 2/22/2022
    Description: WhatABook database initialization script.
*/

-- drop test user if exists 
DROP USER IF EXISTS 'whatabook_user'@'localhost';

-- create whatabook_user and grant them all privileges to the whatabook database 
CREATE USER 'whatabook_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'MySQL8IsGreat!';

-- grant all privileges to the whatabook database to user whatabook_user on localhost 
GRANT ALL PRIVILEGES ON whatabook.* TO'whatabook_user'@'localhost';

-- drop contstraints if they exist
ALTER TABLE wishlist DROP FOREIGN KEY fk_book;
ALTER TABLE wishlist DROP FOREIGN KEY fk_user;

-- drop tables if they exist
DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS wishlist;
DROP TABLE IF EXISTS user;

/*
    Create table(s)
*/
CREATE TABLE store (
    store_id    INT             NOT NULL    AUTO_INCREMENT,
    locale      VARCHAR(500)    NOT NULL,
    PRIMARY KEY(store_id)
);

CREATE TABLE book (
    book_id     INT             NOT NULL    AUTO_INCREMENT,
    book_name   VARCHAR(200)    NOT NULL,
    author      VARCHAR(200)    NOT NULL,
    details     VARCHAR(500),
    PRIMARY KEY(book_id)
);

CREATE TABLE user (
    user_id         INT         NOT NULL    AUTO_INCREMENT,
    first_name      VARCHAR(75) NOT NULL,
    last_name       VARCHAR(75) NOT NULL,
    PRIMARY KEY(user_id) 
);

CREATE TABLE wishlist (
    wishlist_id     INT         NOT NULL    AUTO_INCREMENT,
    user_id         INT         NOT NULL,
    book_id         INT         NOT NULL,
    PRIMARY KEY (wishlist_id),
    CONSTRAINT fk_book
    FOREIGN KEY (book_id)
        REFERENCES book(book_id),
    CONSTRAINT fk_user
    FOREIGN KEY (user_id)
        REFERENCES user(user_Id)
);

/*
    insert store record 
*/
INSERT INTO store(locale)
    VALUES('1010 N 192nd Ct, Elkhorn, NE 68022');

/*
    insert book records 
*/
INSERT INTO book(book_name, author, details)
    VALUES('Permenant Record', 'Edward Snowden', 'Book by Edward Snowden');

INSERT INTO book(book_name, author, details)
    VALUES('Sandworm', 'Andy Greenburg', 'A New Era of Cyberwar and the Hunt for the Kremlins Most Dangerous Hackers');

INSERT INTO book(book_name, author, details)
    VALUES('Cyber War...and Peace', 'Nicholas Shevelyov', "Building Digital Trust Today with History as Our Guide");

INSERT INTO book(book_name, author)
    VALUES('Social Engineering: The Science of Human Hacking', 'Christopher Hadnagy');

INSERT INTO book(book_name, author)
    VALUES('The Art of Deception: Controlling the Human Element of Security', 'Kevin Mitnick');

INSERT INTO book(book_name, author)
    VALUES('The Art of Invisibility: The Worlds Most Famous Hacker Teaches You How to Be Safe in the Age of Big Brother and Big Data', 'Kevin Mitnick');

INSERT INTO book(book_name, author)
    VALUES('The Smartest Person in the Room: The Root Cause and New Solution for Cybersecurity', 'Christian Espinosa');

INSERT INTO book(book_name, author)
    VALUES('Burners & Black Markets - How to Be Invisible', 'Lance Henderson');

INSERT INTO book(book_name, author)
    VALUES('Human Hacking: Win Friends, Influence People, and Leave Them Better Off for Having Met You', 'Christopher Hadnagy');

/*
    insert user
*/ 
INSERT INTO user(first_name, last_name) 
    VALUES('Grant', 'Roberts');

INSERT INTO user(first_name, last_name)
    VALUES('Shyanne', 'Roberts');

INSERT INTO user(first_name, last_name)
    VALUES('Grayson', 'Roberts');

/*
    insert wishlist records 
*/
INSERT INTO wishlist(user_id, book_id) 
    VALUES (
        (SELECT user_id FROM user WHERE first_name = 'Grant'), 
        (SELECT book_id FROM book WHERE book_name = 'Sandworm')
    );

INSERT INTO wishlist(user_id, book_id)
    VALUES (
        (SELECT user_id FROM user WHERE first_name = 'Shyanne'),
        (SELECT book_id FROM book WHERE book_name = 'Social Engineering: The Science of Human Hacking')
    );

INSERT INTO wishlist(user_id, book_id)
    VALUES (
        (SELECT user_id FROM user WHERE first_name = 'Grayson'),
        (SELECT book_id FROM book WHERE book_name = 'Cyber War...and Peace')
    );
