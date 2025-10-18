DROP DATABASE IF EXISTS `alx_book_store`;
CREATE DATABASE IF NOT EXISTS `alx_book_store`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `alx_book_store`;

CREATE TABLE `Authors` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `author_name` VARCHAR(215) NOT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB;
S TABLE
CREATE TABLE `Books` (
  `book_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(130) NOT NULL,
  `author_id` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `publication_date` DATE,
  PRIMARY KEY (`book_id`),
  INDEX `idx_books_author` (`author_id`),
  CONSTRAINT `fk_books_author` FOREIGN KEY (`author_id`)
    REFERENCES `Authors` (`author_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE `Customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(215) NOT NULL,
  `email` VARCHAR(215) NOT NULL,
  `address` TEXT,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `uq_customers_email` (`email`)
) ENGINE=InnoDB;

CREATE TABLE `Orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `order_date` DATE NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `idx_orders_customer` (`customer_id`),
  CONSTRAINT `fk_orders_customer` FOREIGN KEY (`customer_id`)
    REFERENCES `Customers` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE `Order_Details` (
  `orderdetailid` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  `quantity` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`orderdetailid`),
  INDEX `idx_od_order` (`order_id`),
  INDEX `idx_od_book` (`book_id`),
  CONSTRAINT `fk_od_order` FOREIGN KEY (`order_id`)
    REFERENCES `Orders` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_od_book` FOREIGN KEY (`book_id`)
    REFERENCES `Books` (`book_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB;


INSERT INTO `Authors` (`author_name`) VALUES
  ('Chinua Achebe'),
  ('Chimamanda Ngozi Adichie'),
  ('J.K. Rowling');


INSERT INTO `Books` (`title`, `author_id`, `price`, `publication_date`) VALUES
  ('Things Fall Apart', 1, 12.99, '1958-06-17'),
  ('Half of a Yellow Sun', 2, 14.50, '2006-09-15'),
  ('Harry Potter and the Sorcerer\'s Stone', 3, 19.99, '1997-06-26');

-- CUSTOMERS
INSERT INTO `Customers` (`customer_name`, `email`, `address`) VALUES
  ('Alice N.', 'alice@example.com', '123 Kigali St, Kigali, Rwanda'),
  ('Bob K.', 'bob.k@example.com', '45 Valley Rd, Kigali, Rwanda');

-- ORDERS
INSERT INTO `Orders` (`customer_id`, `order_date`) VALUES
  (1, '2025-10-01'),
  (2, '2025-10-05');

-- ORDER DETAILS
INSERT INTO `Order_Details` (`order_id`, `book_id`, `quantity`) VALUES
  (1, 1, 1),
  (1, 3, 2),
  (2, 2, 1);

-- END OF FILE
