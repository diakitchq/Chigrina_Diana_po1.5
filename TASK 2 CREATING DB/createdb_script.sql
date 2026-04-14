
DROP TABLE IF EXISTS ProductReviews CASCADE;
DROP TABLE IF EXISTS SupportTickets CASCADE;
DROP TABLE IF EXISTS Payments CASCADE;
DROP TABLE IF EXISTS Orders CASCADE;
DROP TABLE IF EXISTS SupportStaff CASCADE;
DROP TABLE IF EXISTS Products CASCADE;
DROP TABLE IF EXISTS PickupPoints CASCADE;
DROP TABLE IF EXISTS Categories CASCADE;
DROP TABLE IF EXISTS Suppliers CASCADE;
DROP TABLE IF EXISTS Customers CASCADE;



CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    CustomerLastName VARCHAR(100) NOT NULL,
    CustomerAddress VARCHAR(255) NOT NULL,
    CustomerDOB DATE NOT NULL,
    CustomerJoin DATE NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL UNIQUE
);

CREATE TABLE Suppliers (
    SuppliersID SERIAL PRIMARY KEY,
    SuppliersName VARCHAR(100) NOT NULL,
    SuppliersRating DECIMAL(2,1),
    SuppliersDateJoined DATE NOT NULL,
    FullNumber VARCHAR(15) NOT NULL UNIQUE
);

CREATE TABLE Categories (
    CategoryID SERIAL PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE,
    CategoryDesc TEXT NOT NULL,
    Status VARCHAR(20) DEFAULT 'Active'
);

CREATE TABLE Products (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    SuppliersID INT NOT NULL,
    CategoryID INT,
    SaleCount INT DEFAULT 0,
    Price NUMERIC(9,2) NOT NULL,
    ProductRating DECIMAL(2,1),
    Stock INT NOT NULL,

    FOREIGN KEY (SuppliersID) REFERENCES Suppliers(SuppliersID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE PickupPoints (
    PointID SERIAL PRIMARY KEY,
    PointAddress VARCHAR(255) NOT NULL,
    PointNumber VARCHAR(15) NOT NULL UNIQUE
);

CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT NOT NULL,
    SuppliersID INT NOT NULL,
    ProductID INT NOT NULL,
    PointID INT NOT NULL,
    SendDate DATE NOT NULL,
    EstArrival DATE NOT NULL,
    Status VARCHAR(20) DEFAULT 'On the way',

    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (SuppliersID) REFERENCES Suppliers(SuppliersID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (PointID) REFERENCES PickupPoints(PointID)
);

CREATE TABLE Payments (
    PaymentID SERIAL PRIMARY KEY,
    OrderID INT NOT NULL,
    PaymentType VARCHAR(20) NOT NULL,
    BonusAdded NUMERIC(10,2) DEFAULT 0,
    PaymentTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE SupportStaff (
    StaffID SERIAL PRIMARY KEY,
    StaffName VARCHAR(100) NOT NULL,
    StaffLastName VARCHAR(100) NOT NULL,
    DateOfJoin DATE NOT NULL,
    Position VARCHAR(100) NOT NULL,
    Salary NUMERIC(9,2) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL UNIQUE
);

CREATE TABLE SupportTickets (
    TicketID SERIAL PRIMARY KEY,
    OrderID INT NOT NULL,
    PaymentID INT NOT NULL,
    StaffID INT NOT NULL,
    Status VARCHAR(20) DEFAULT 'Not resolved',

    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID),
    FOREIGN KEY (StaffID) REFERENCES SupportStaff(StaffID)
);

CREATE TABLE ProductReviews (
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    ReviewText TEXT NOT NULL,
    ReviewRating DECIMAL(2,1),

    PRIMARY KEY (CustomerID, ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);



INSERT INTO Customers (CustomerName, CustomerLastName, CustomerAddress, CustomerDOB, CustomerJoin, PhoneNumber)
VALUES 
('Диана', 'Чигрина', 'Атырау', '2005-05-10', '2026-02-01', '87001111111'),
('Диас', 'Ермеков', 'Алматы', '2004-03-22', '2026-02-05', '87002222222');

INSERT INTO Suppliers (SuppliersName, SuppliersRating, SuppliersDateJoined, FullNumber)
VALUES
('TechKZ', 4.5, '2026-02-01', '87003333333'),
('QazaqHome', 4.0, '2026-02-10', '87004444444');

INSERT INTO Categories (CategoryName, CategoryDesc, Status)
VALUES
('Электроника', 'Техника', 'Active'),
('Дом', 'Товары', 'Active');

INSERT INTO Products (ProductName, SuppliersID, CategoryID, SaleCount, Price, ProductRating, Stock)
VALUES
('Смартфон Samsung', 1, 1, 0, 150000, 4.5, 10),
('Пылесос LG', 2, 2, 0, 80000, 4.0, 5);

INSERT INTO PickupPoints (PointAddress, PointNumber)
VALUES
('Атырау, центр', '111'),
('Алматы, центр', '222');

INSERT INTO Orders (OrderDate, CustomerID, SuppliersID, ProductID, PointID, SendDate, EstArrival, Status)
VALUES
('2026-02-10', 1, 1, 1, 1, '2026-02-11', '2026-02-15', 'On the way'),
('2026-02-12', 2, 2, 2, 2, '2026-02-13', '2026-02-18', 'On the way');

INSERT INTO Payments (OrderID, PaymentType, BonusAdded)
VALUES
(1, 'Card', 100),
(2, 'Cash', 0);

INSERT INTO SupportStaff (StaffName, StaffLastName, DateOfJoin, Position, Salary, PhoneNumber)
VALUES
('Алихан', 'Нуртасов', '2026-02-01', 'Менеджер', 200000, '87005555555'),
('Дана', 'Кайратова', '2026-02-05', 'Оператор', 150000, '87006666666');

INSERT INTO SupportTickets (OrderID, PaymentID, StaffID, Status)
VALUES
(1, 1, 1, 'Not resolved'),
(2, 2, 2, 'Not resolved');

INSERT INTO ProductReviews (CustomerID, ProductID, ReviewText, ReviewRating)
VALUES
(1, 1, 'Очень хороший телефон', 4.5),
(2, 2, 'Хорошо работает', 4.0);

SELECT * FROM Customers;
SELECT * FROM Suppliers;
SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM PickupPoints;
SELECT * FROM Orders;
SELECT * FROM Payments;
SELECT * FROM SupportStaff;
SELECT * FROM SupportTickets;
SELECT * FROM ProductReviews;

