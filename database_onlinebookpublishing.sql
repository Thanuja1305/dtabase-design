create database onlineBookPublishing;


use onlineBookPublishing;


-- AUTHOR
CREATE TABLE Author (
    author_id INT PRIMARY KEY,
    name VARCHAR(255),
    biography TEXT
);

-- CUSTOMER
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255)
);

-- SHIPPING ADDRESS
CREATE TABLE ShippingAddress (
    address_id INT PRIMARY KEY,
    customer_id INT,
    address TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- PUBLISHER
CREATE TABLE Publisher (
    publisher_id INT PRIMARY KEY,
    name VARCHAR(255),
    contact_details TEXT
);

-- BOOK
CREATE TABLE Book (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    ISBN VARCHAR(20)
);

-- EDITION
CREATE TABLE Edition (
    edition_id INT PRIMARY KEY,
    book_id INT,
    edition_number INT,
    publication_year YEAR,
    price DECIMAL(10,2),
    publisher_id INT,
    FOREIGN KEY (book_id) REFERENCES Book(book_id),
    FOREIGN KEY (publisher_id) REFERENCES Publisher(publisher_id)
);

-- GENRE
CREATE TABLE Genre (
    genre_id INT PRIMARY KEY,
    genre_name VARCHAR(100)
);

-- BOOK_AUTHOR (many-to-many)
CREATE TABLE BookAuthor (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id),
    FOREIGN KEY (author_id) REFERENCES Author(author_id)
);

-- BOOK_GENRE (many-to-many)
CREATE TABLE BookGenre (
    book_id INT,
    genre_id INT,
    PRIMARY KEY (book_id, genre_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id),
    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
);

-- ORDER
CREATE TABLE `Order` (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    shipment_status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- ORDER_ITEM (edition in orders)
CREATE TABLE OrderItem (
    order_id INT,
    edition_id INT,
    quantity INT,
    discount DECIMAL(5,2),
    PRIMARY KEY (order_id, edition_id),
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id),
    FOREIGN KEY (edition_id) REFERENCES Edition(edition_id)
);

-- PAYMENT
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    payment_date DATE,
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id)
);

-- WISHLIST (customer - edition)
CREATE TABLE Wishlist (
    customer_id INT,
    edition_id INT,
    PRIMARY KEY (customer_id, edition_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (edition_id) REFERENCES Edition(edition_id)
);
