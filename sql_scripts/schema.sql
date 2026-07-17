USE GMALHOT1;
GO

-- 1. Suppliers Table
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100),
    Region VARCHAR(50),
    ContractTerms VARCHAR(50)
);

-- 2. Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    UnitCost DECIMAL(10, 2)
);

-- 3. Shipments Table
CREATE TABLE Shipments (
    ShipmentID INT PRIMARY KEY,
    SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    OrderDate DATE,
    ExpectedDeliveryDate DATE,
    ActualDeliveryDate DATE,
    QuantityOrdered INT,
    QuantityReceived INT,
    ShipmentStatus VARCHAR(20)
);