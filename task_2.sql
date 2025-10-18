-- task_2.sql
-- Creates all tables for the alx_book_store database

USE alx_book_store;

-- AUTHORS TABLE
CREATE TABLE IF NOT EXISTS Authors (
    author_id INT NOT NULL AUTO_INCREMENT,
    author_name VARCHAR(215) NOT NULL,
    PRIMARY KEY (author_id)
) ENGINE=InnoDB;

-- BOOKS TABLE
CREATE TABLE IF NOT EXISTS Books (
    book_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(130) NOT NULL,
    author_id INT NOT NULL,
    price DOUBLE,
    publication_date DATE,
    PRIMARY KEY (book_id),
    INDEX idx_books_author (author_id),
    CONSTRAINT fk_books_author FOREIGN KEY (author_id)
        REFERENCES Authors(author_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- CUSTOMERS TABLE
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT NOT NULL AUTO_INCREMENT,
    customer_name VARCHAR(215) NOT NULL,
    email VARCHAR(215) NOT NULL,
    address TEXT,
    PRIMARY KEY (customer_id),
    UNIQUE KEY uq_customers_email (email)
) ENGINE=InnoDB;

-- ORDERS TABLE
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    PRIMARY KEY (order_id),
    INDEX idx_orders_customer (customer_id),
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ORDER DETAILS TABLE
CREATE TABLE IF NOT EXISTS Order_Details (
    orderdetailid INT NOT NULL AUTO_INCREMENT,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity DOUBLE,
    PRIMARY KEY (orderdetailid),
    INDEX idx_od_order (order_id),
    INDEX idx_od_book (book_id),
    CONSTRAINT fk_od_order FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_od_book FOREIGN KEY (book_id)
        REFERENCES Books(book_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;
