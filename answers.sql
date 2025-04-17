-- Question 1: Achieving 1NF

-- First Normal Form (1NF) requires that each column contains only atomic (indivisible) values.
-- The original ProductDetail table had multiple products in one column, which violates 1NF.
-- To fix this, I created a new table (ProductDetail_1NF) where each product is stored in its own row,
-- ensuring that each field contains only a single value, making the structure compliant with 1NF.

CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Inserting normalized data
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Question 2: Achieving 2NF

-- Second Normal Form (2NF) requires that all non-key attributes be fully dependent on the entire primary key.
-- In the original OrderDetails table, CustomerName depends only on OrderID (a partial dependency), not on the full composite key (OrderID, Product).
-- To achieve 2NF, I separated the data into two tables:
-- 1. Orders: contains unique OrderID and CustomerName (eliminating partial dependency).
-- 2. OrderDetails_2NF: contains OrderID, Product, and Quantity, with OrderID acting as a foreign key.
-- This restructuring ensures that all non-key fields are fully functionally dependent on the whole primary key, satisfying 2NF.

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert unique order info
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Table for OrderDetails (clean 2NF structure)
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert product quantities
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);
