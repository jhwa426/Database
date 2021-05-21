-- 2. Using SELECT with calculations

-- 2.1. Use mathematic operators: +, -, *, / among numbers
-- The example below uses SELECT with column headings (SalesOrderID, ProductID) and calculations;
-- calculations are renamed using aliases (NonDiscountSales, Discounts);
-- the query result set is limited to 5 rows ordered by Discounts in an ascending order.
SELECT TOP 5
    SalesOrderID,
    ProductID,
    OrderQty * UnitPrice AS NonDiscountSales,
    (OrderQty * UnitPrice) * UnitPriceDiscount AS Discounts
FROM SalesLT.SalesOrderDetail
ORDER BY Discounts ASC

-- The example below retrieve columns (ProductNumber, Name, ListPrice) and a calculation (renamed as "New List Price")
-- from the Product table; the result set is ordered by the ListPrice column in descending order.
SELECT ProductNumber, [Name], ListPrice, ListPrice + 300 as 'New List Price'
FROM [SalesLT].[Product]
ORDER BY ListPrice DESC;

SELECT 
    SalesOrderID,
    ProductID,
    UnitPrice,
    UnitPriceDiscount, 
    (UnitPriceDiscount/UnitPrice) *100 
FROM SalesLT.SalesOrderDetail
ORDER BY UnitPriceDiscount DESC

-- Use TOP to limit the number of rows retrieved.
SELECT TOP 5
    SalesOrderID,
    ProductID,
    OrderQty * UnitPrice AS NonDiscountSales,
    (OrderQty * UnitPrice) * UnitPriceDiscount AS Discounts
FROM SalesLT.SalesOrderDetail
ORDER BY Discounts ASC

-- 2.2. How about using math operators on datetime date type?
-- The codes below retrieve the columns (CustomerID, ModifiedDate) and a calculated new date (ModifiedDate + 1) 
-- which is one day after the ModifiedDate.
-- This takes advantage of how DATETIME are stored in SQL Server.
-- To be safer, dates should be manipulated using date functions rather than arithmetic operators. 
SELECT
    CustomerID, 
    ModifiedDate,
    ModifiedDate + 1
FROM SalesLT.Customer
ORDER BY LastName

-- Use date functions to manipulate datetime instead
SELECT
    CustomerID, 
    ModifiedDate,
    DATEADD(DAY, 1, ModifiedDate)
FROM SalesLT.Customer
ORDER BY LastName

-- 2.3. Use + among character strings to concatenate more than one strings
SELECT  FirstName + ' '+ LastName + ' is served by '+ SalesPerson AS "Sales person details "
FROM   [SalesLT].[Customer]

-- What will happen when a concatenated string contains NULL value?
SELECT Title, FirstName, MiddleName, LastName, Suffix, SalesPerson
FROM  [SalesLT].[Customer]

SELECT  Title + ' '+ FirstName + ' '+ MiddleName + ' '+ LastName + ' '+ Suffix  + ' is served by '+ SalesPerson AS "Sales person details "
FROM   [SalesLT].[Customer]
