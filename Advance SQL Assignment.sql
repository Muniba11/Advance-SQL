-- SQL Advance Assignment --


-- Question.6 --
WITH ProductRevenue AS (
    SELECT 
        p.ProductName,
        SUM(p.Price * s.Quantity) AS Revenue
    FROM Products p
    JOIN Sales s ON p.ProductID = s.ProductID
    GROUP BY p.ProductName
)
SELECT * FROM ProductRevenue
WHERE Revenue > 3000;


-- Question.7 --
CREATE VIEW vw_CategorySummary AS
SELECT 
    Category,
    COUNT(*) AS TotalProducts,
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category;


-- Question.8 --
CREATE VIEW vw_ProductDetails AS
SELECT ProductID, ProductName, Price
FROM Products;
-- Updating --
UPDATE vw_ProductDetails
SET Price = 1500
WHERE ProductID = 1;


-- Question.9 --
CREATE PROCEDURE GetProductsByCategory
    @CategoryName VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM Products
    WHERE Category = @CategoryName;
END;
-- Execute --
EXEC GetProductsByCategory 'Electronics';


-- Question.10 --
CREATE TABLE ProductArchive (
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    DeletedAt DATETIME
);
CREATE TRIGGER trg_AfterDeleteProducts
ON Products
AFTER DELETE
AS
BEGIN
    INSERT INTO ProductArchive
    SELECT 
        ProductID,
        ProductName,
        Category,
        Price,
        GETDATE()
    FROM deleted;
END;



