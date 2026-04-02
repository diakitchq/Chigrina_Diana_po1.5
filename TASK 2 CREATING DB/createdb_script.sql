	
DROP DATABASE IF EXISTS online_shop;
CREATE DATABASE online_shop;
USE online_shop;


-- TABLE: Customers

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL,
    CustomerLastName VARCHAR(255) NOT NULL,
    CustomerAddress VARCHAR(255) NOT NULL,
    CustomerDOB DATE NOT NULL,
    CustomerJoin DATE NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL UNIQUE
);


-- TABLE: Suppliers

CREATE TABLE Suppliers (
    SuppliersID INT AUTO_INCREMENT PRIMARY KEY,
    SuppliersName VARCHAR(255) NOT NULL,
    SuppliersRating DECIMAL(2,1) CHECK (SuppliersRating <= 5.0),
    SuppliersDateJoined DATE NOT NULL CHECK (SuppliersDateJoined > '2026-01-01'),
    FullNumber VARCHAR(15) NOT NULL UNIQUE
);


-- TABLE: Categories

CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE,
    CategoryDesc TEXT NOT NULL,
    Status ENUM('Active', 'Inactive') DEFAULT 'Active'
);


-- TABLE: Products

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    SuppliersID INT NOT NULL,
    CategoryID INT,
    SaleCount INT DEFAULT 0,
    Price DECIMAL(9,2) NOT NULL CHECK (Price >= 0),
    ProductRating DECIMAL(2,1) CHECK (ProductRating <= 5.0),
    Stock INT NOT NULL CHECK (Stock >= 0),

    FOREIGN KEY (SuppliersID) REFERENCES Suppliers(SuppliersID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);


-- TABLE: PickupPoints

CREATE TABLE PickupPoints (
    PointID INT AUTO_INCREMENT PRIMARY KEY,
    PointAddress VARCHAR(255) NOT NULL,
    PointNumber VARCHAR(15) NOT NULL UNIQUE
);


-- TABLE: Orders

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    OrderDate DATE NOT NULL CHECK (OrderDate > '2026-01-01'),
    CustomerID INT NOT NULL,
    SuppliersID INT NOT NULL,
    ProductID INT NOT NULL,
    PointID INT NOT NULL,
    SendDate DATE NOT NULL,
    EstArrival DATE NOT NULL,
    Status ENUM('On the way', 'Delivered', 'Cancelled') DEFAULT 'On the way',

    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (SuppliersID) REFERENCES Suppliers(SuppliersID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (PointID) REFERENCES PickupPoints(PointID)
);


-- TABLE: Payments

CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    PaymentType ENUM('Cash', 'Card', 'Online') NOT NULL,
    BonusAdded DECIMAL(10,2) DEFAULT 0 CHECK (BonusAdded >= 0),
    PaymentTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


-- TABLE: SupportStaff

CREATE TABLE SupportStaff (
    StaffID INT AUTO_INCREMENT PRIMARY KEY,
    StaffName VARCHAR(255) NOT NULL,
    StaffLastName VARCHAR(255) NOT NULL,
    DateOfJoin DATE NOT NULL CHECK (DateOfJoin > '2026-01-01'),
    Position VARCHAR(255) NOT NULL,
    Salary DECIMAL(9,2) NOT NULL CHECK (Salary >= 0),
    PhoneNumber VARCHAR(15) NOT NULL UNIQUE
);


-- TABLE: SupportTickets

CREATE TABLE SupportTickets (
    TicketID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    PaymentID INT NOT NULL,
    StaffID INT NOT NULL,
    Status ENUM('Resolved', 'Not resolved') DEFAULT 'Not resolved',

    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID),
    FOREIGN KEY (StaffID) REFERENCES SupportStaff(StaffID)
);


-- TABLE: ProductReviews

CREATE TABLE ProductReviews (
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    ReviewText TEXT NOT NULL,
    ReviewRating DECIMAL(2,1) CHECK (ReviewRating <= 5.0),

    PRIMARY KEY (CustomerID, ProductID),

    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
