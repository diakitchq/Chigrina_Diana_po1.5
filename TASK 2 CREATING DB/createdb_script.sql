DROP DATABASE IF EXISTS online_shop;
CREATE DATABASE online_shop;
USE online_shop;

-- Customers
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) UNIQUE
);

-- Suppliers
CREATE TABLE Suppliers (
    SuppliersID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

-- Categories
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);

-- Products
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL,
    SuppliersID INT,
    CategoryID INT,

    FOREIGN KEY (SuppliersID) REFERENCES Suppliers(SuppliersID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Orders
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT,
    ProductID INT,

    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Payments
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    PaymentType VARCHAR(20),

    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
