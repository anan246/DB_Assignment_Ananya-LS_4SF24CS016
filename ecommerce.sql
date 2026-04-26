CREATE TABLE Users (
    user_id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT
);

CREATE TABLE Category (
    category_id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE Product (
    product_id INTEGER PRIMARY KEY,
    name TEXT,
    price REAL,
    category_id INTEGER,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    order_date TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Order_Items (
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Payment (
    payment_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    amount REAL,
    status TEXT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);



INSERT INTO Users VALUES
(1,'Asha','a@gmail.com'),(2,'Ravi','r@gmail.com'),
(3,'Kiran','k@gmail.com'),(4,'Meena','m@gmail.com'),
(5,'Arjun','a2@gmail.com'),(6,'Neha','n@gmail.com'),
(7,'Rahul','r2@gmail.com'),(8,'Sneha','s@gmail.com'),
(9,'Vikram','v@gmail.com'),(10,'Pooja','p@gmail.com');

INSERT INTO Category VALUES
(1,'Electronics'),(2,'Clothing'),(3,'Books');

INSERT INTO Product VALUES
(1,'Phone',20000,1),(2,'Laptop',50000,1),
(3,'Shirt',1000,2),(4,'Jeans',2000,2),
(5,'Book1',500,3),(6,'Book2',600,3),
(7,'Tablet',15000,1),(8,'Jacket',3000,2),
(9,'Notebook',200,3),(10,'Headphones',1500,1);

INSERT INTO Orders VALUES
(1,1,'2026-01-01'),(2,2,'2026-01-02'),
(3,3,'2026-01-03'),(4,4,'2026-01-04'),
(5,5,'2026-01-05'),(6,6,'2026-01-06'),
(7,7,'2026-01-07'),(8,8,'2026-01-08'),
(9,9,'2026-01-09'),(10,10,'2026-01-10');

INSERT INTO Order_Items VALUES
(1,1,1),(1,3,2),(2,2,1),(3,4,1),(4,5,3),
(5,6,2),(6,7,1),(7,8,1),(8,9,4),(9,10,2);

INSERT INTO Payment VALUES
(1,1,22000,'Paid'),(2,2,50000,'Paid'),
(3,3,2000,'Pending'),(4,4,1500,'Paid'),
(5,5,1200,'Paid'),(6,6,15000,'Pending'),
(7,7,3000,'Paid'),(8,8,800,'Paid'),
(9,9,400,'Pending'),(10,10,1500,'Paid');

SELECT u.name, o.order_id
FROM Users u
JOIN Orders o ON u.user_id = o.user_id;

SELECT o.order_id, p.name, oi.quantity
FROM Order_Items oi
JOIN Product p ON oi.product_id = p.product_id
JOIN Orders o ON oi.order_id = o.order_id;

SELECT SUM(amount) FROM Payment WHERE status = 'Paid';

SELECT * FROM Payment WHERE status = 'Pending';

SELECT category_id, COUNT(*) FROM Product GROUP BY category_id;

SELECT u.name, p.name
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Product p ON oi.product_id = p.product_id;

SELECT order_id, SUM(quantity) AS total_items
FROM Order_Items
GROUP BY order_id;