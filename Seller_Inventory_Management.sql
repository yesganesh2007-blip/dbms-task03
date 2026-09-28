CREATE DATABASE IF NOT EXISTS flipkart_db;
USE flipkart_db;

CREATE TABLE IF NOT EXISTS Category (
    Category_ID INT AUTO_INCREMENT PRIMARY KEY,
    Category_Name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Product (
    Product_ID INT AUTO_INCREMENT PRIMARY KEY,
    Product_Name VARCHAR(150) NOT NULL,
    Category_ID INT,
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0),
    FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID)
);

CREATE TABLE Seller (
    Seller_ID INT AUTO_INCREMENT PRIMARY KEY,
    Seller_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15) NOT NULL UNIQUE,
    Address VARCHAR(255) NOT NULL
);

ALTER TABLE Product ADD COLUMN Seller_ID INT;

ALTER TABLE Product ADD CONSTRAINT fk_product_seller FOREIGN KEY (Seller_ID) REFERENCES Seller(Seller_ID);

CREATE TABLE Inventory (
    Inventory_ID INT AUTO_INCREMENT PRIMARY KEY,
    Product_ID INT NOT NULL,
    Seller_ID INT NOT NULL,
    Stock_Quantity INT NOT NULL CHECK (Stock_Quantity >= 0),
    Stock_Status VARCHAR(20) NOT NULL CHECK (Stock_Status IN ('In Stock', 'Out of Stock', 'Low Stock')),
    Last_Updated DATE NOT NULL,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Seller_ID) REFERENCES Seller(Seller_ID)
);

INSERT INTO Category (Category_Name) VALUES ('Electronics');
INSERT INTO Category (Category_Name) VALUES ('Fashion');
INSERT INTO Category (Category_Name) VALUES ('Home Appliances');

INSERT INTO Product (Product_Name, Category_ID, Price) VALUES ('Samsung Galaxy M14', 1, 12999.00);
INSERT INTO Product (Product_Name, Category_ID, Price) VALUES ('boAt Airdopes 141', 1, 1299.00);
INSERT INTO Product (Product_Name, Category_ID, Price) VALUES ('Dell Inspiron Laptop', 1, 45999.00);
INSERT INTO Product (Product_Name, Category_ID, Price) VALUES ('Puma Running Shoes', 2, 2499.00);
INSERT INTO Product (Product_Name, Category_ID, Price) VALUES ('Levis Denim Jeans', 2, 1799.00);
INSERT INTO Product (Product_Name, Category_ID, Price) VALUES ('Fastrack Wrist Watch', 2, 1999.00);
INSERT INTO Product (Product_Name, Category_ID, Price) VALUES ('Prestige Mixer Grinder', 3, 3299.00);
INSERT INTO Product (Product_Name, Category_ID, Price) VALUES ('Philips Air Fryer', 3, 6999.00);
INSERT INTO Product (Product_Name, Category_ID, Price) VALUES ('LG Microwave Oven', 3, 8999.00);
INSERT INTO Product (Product_Name, Category_ID, Price) VALUES ('Mi Power Bank 20000mAh', 1, 1499.00);

INSERT INTO Seller (Seller_Name, Email, Phone, Address) VALUES ('Sri Electronics', 'srielectronics@gmail.com', '9840012345', 'Chennai, Tamil Nadu');
INSERT INTO Seller (Seller_Name, Email, Phone, Address) VALUES ('Fashion Hub', 'fashionhub@gmail.com', '9840012346', 'Coimbatore, Tamil Nadu');
INSERT INTO Seller (Seller_Name, Email, Phone, Address) VALUES ('Home Needs Store', 'homeneeds@gmail.com', '9840012347', 'Madurai, Tamil Nadu');
INSERT INTO Seller (Seller_Name, Email, Phone, Address) VALUES ('Gadget World', 'gadgetworld@gmail.com', '9840012348', 'Bengaluru, Karnataka');
INSERT INTO Seller (Seller_Name, Email, Phone, Address) VALUES ('Trendy Wears', 'trendywears@gmail.com', '9840012349', 'Hyderabad, Telangana');

UPDATE Product SET Seller_ID = 1 WHERE Product_ID IN (1, 2, 10);
UPDATE Product SET Seller_ID = 4 WHERE Product_ID IN (3);
UPDATE Product SET Seller_ID = 2 WHERE Product_ID IN (4, 5);
UPDATE Product SET Seller_ID = 5 WHERE Product_ID IN (6);
UPDATE Product SET Seller_ID = 3 WHERE Product_ID IN (7, 8, 9);

INSERT INTO Inventory (Product_ID, Seller_ID, Stock_Quantity, Stock_Status, Last_Updated) VALUES (1, 1, 50, 'In Stock', '2026-09-20');
INSERT INTO Inventory (Product_ID, Seller_ID, Stock_Quantity, Stock_Status, Last_Updated) VALUES (2, 1, 0, 'Out of Stock', '2026-09-18');
INSERT INTO Inventory (Product_ID, Seller_ID, Stock_Quantity, Stock_Status, Last_Updated) VALUES (10, 1, 8, 'Low Stock', '2026-09-21');
INSERT INTO Inventory (Product_ID, Seller_ID, Stock_Quantity, Stock_Status, Last_Updated) VALUES (3, 4, 15, 'In Stock', '2026-09-19');
INSERT INTO Inventory (Product_ID, Seller_ID, Stock_Quantity, Stock_Status, Last_Updated) VALUES (4, 2, 30, 'In Stock', '2026-09-22');
INSERT INTO Inventory (Product_ID, Seller_ID, Stock_Quantity, Stock_Status, Last_Updated) VALUES (5, 2, 5, 'Low Stock', '2026-09-20');
INSERT INTO Inventory (Product_ID, Seller_ID, Stock_Quantity, Stock_Status, Last_Updated) VALUES (6, 5, 0, 'Out of Stock', '2026-09-17');
INSERT INTO Inventory (Product_ID, Seller_ID, Stock_Quantity, Stock_Status, Last_Updated) VALUES (7, 3, 20, 'In Stock', '2026-09-23');
INSERT INTO Inventory (Product_ID, Seller_ID, Stock_Quantity, Stock_Status, Last_Updated) VALUES (8, 3, 12, 'In Stock', '2026-09-21');
INSERT INTO Inventory (Product_ID, Seller_ID, Stock_Quantity, Stock_Status, Last_Updated) VALUES (9, 3, 3, 'Low Stock', '2026-09-19');

INSERT INTO Seller (Seller_Name, Email, Phone, Address) VALUES ('Tech Bazaar', 'techbazaar@gmail.com', '9840012350', 'Pune, Maharashtra');

UPDATE Product SET Seller_ID = 6 WHERE Product_ID = 10;

SELECT Seller.Seller_Name, Product.Product_Name
FROM Seller
JOIN Product ON Seller.Seller_ID = Product.Seller_ID
ORDER BY Seller.Seller_Name;

SELECT Seller.Seller_Name, COUNT(Product.Product_ID) AS Total_Products
FROM Seller
LEFT JOIN Product ON Seller.Seller_ID = Product.Seller_ID
GROUP BY Seller.Seller_Name;

UPDATE Seller SET Phone = '9840099999', Address = 'Anna Nagar, Chennai, Tamil Nadu' WHERE Seller_ID = 1;

SELECT Product.Product_Name, Inventory.Stock_Quantity, Inventory.Stock_Status
FROM Inventory
JOIN Product ON Inventory.Product_ID = Product.Product_ID
WHERE Inventory.Stock_Status = 'In Stock';

SELECT Product.Product_Name, Seller.Seller_Name
FROM Inventory
JOIN Product ON Inventory.Product_ID = Product.Product_ID
JOIN Seller ON Inventory.Seller_ID = Seller.Seller_ID
WHERE Inventory.Stock_Status = 'Out of Stock';

SELECT Product.Product_Name, Inventory.Stock_Quantity
FROM Inventory
JOIN Product ON Inventory.Product_ID = Product.Product_ID
WHERE Inventory.Stock_Quantity < 10;

UPDATE Inventory SET Stock_Quantity = 25, Stock_Status = 'In Stock', Last_Updated = CURDATE() WHERE Inventory_ID = 2;

DELETE FROM Inventory WHERE Stock_Status = 'Out of Stock' AND Last_Updated < '2026-09-19';

SELECT Seller.Seller_Name, Product.Product_Name, Inventory.Stock_Quantity
FROM Seller
JOIN Product ON Seller.Seller_ID = Product.Seller_ID
JOIN Inventory ON Product.Product_ID = Inventory.Product_ID AND Product.Seller_ID = Inventory.Seller_ID
ORDER BY Seller.Seller_Name;

SELECT Stock_Status, COUNT(*) AS Total_Items
FROM Inventory
GROUP BY Stock_Status;

SELECT COUNT(*) AS Total_Available_Products
FROM Inventory
WHERE Stock_Status = 'In Stock';

SELECT COUNT(*) AS Total_Out_Of_Stock_Products
FROM Inventory
WHERE Stock_Status = 'Out of Stock';

SELECT Product.Product_Name, Inventory.Stock_Quantity
FROM Inventory
JOIN Product ON Inventory.Product_ID = Product.Product_ID
ORDER BY Inventory.Stock_Quantity DESC
LIMIT 1;

SELECT AVG(Stock_Quantity) AS Average_Inventory_Quantity
FROM Inventory;
