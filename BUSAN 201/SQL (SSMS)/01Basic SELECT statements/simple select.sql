-- 1. Using SELECT to retrieve rows and columns

-- 1.1. Retrieve all rows (no WHERE clause specified) and a subset of columns (CustomerID) 
-- from the Customer table in the AdventureWorksLT2012 database's SalesLT schema
SELECT CustomerID
FROM AdventureWorksLT2012.SalesLT.Customer

-- You can omit the database name here when it is already selected
SELECT CustomerID, NameStyle, Title, FirstName, LastName, CompanyName
FROM SalesLT.Customer

-- 1.2. Retrieve all rows (no WHERE clause specified) and all columns (using the *) from the Customer table
SELECT * -- avoid using this
FROM SalesLT.Customer

-- 1.3. Use alias column to rename the retrieved column
-- The CustomerID column is retrieved aand renamed to id; the CompanyName column is retrieved and renamed to "company name"
-- Use [] or quotation marks ("",'') to enclose the alias when it contains spaces or is a reserved word (predefined in SQL)
SELECT CustomerID AS id, CompanyName AS [company Name]
FROM SalesLT.Customer

SELECT CustomerID AS id, CompanyName AS 'company Name'
FROM SalesLT.Customer

SELECT CustomerID AS id, CompanyName AS "company Name"
FROM SalesLT.Customer

-- AS can be omitted
SELECT CustomerID AS id, CompanyName [company Name]
FROM SalesLT.Customer

-- 1.4. Use DISTINCT with SELECT to retrieve a list of all unique titles from the Customer table
SELECT DISTINCT Title
FROM SalesLT.Customer

-- When DISTINCT is used with multiple columns, 
-- the combination of values in all specified columns is used to evaluate uniqueness
SELECT DISTINCT Title, FirstName
FROM SalesLT.Customer

-- Compare the results of the above codes with those below, how many rows are retrieved?
SELECT Title, FirstName
FROM SalesLT.Customer

-- 1.5. Use ORDER BY with SELECT to order the query result set by the specified column list.
-- The order in which rows are returned in a result set are not guaranteed unless ORDER BY clause is specified.
-- ASC means ascending order; DESC means descending order. 
SELECT ProductNumber, [Name], ListPrice
FROM [SalesLT].[Product]
ORDER BY ListPrice DESC

-- When not specified, the order is ASC by default.
SELECT ProductNumber, [Name], ListPrice - StandardCost [profit margin]
FROM [SalesLT].[Product]
ORDER BY [profit margin]

-- When multiple sort columns are specified, 
-- the sequence of the sort columns in the ORDER BY clause defines the organization of the sorted result set.
-- The example below shows that the result set is sorted by the first column (Size) and then 
-- that ordered list is sorted by the second column (Weight).
-- Weight is enclosed in [] because it is a reserved word (predefined keyword)
SELECT ProductNumber, [Name],Size, [Weight]
FROM [SalesLT].[Product]
ORDER BY Size, [Weight] DESC

-- Use TOP or OFFSET and FETCH to limit the rows returned to a specified range

-- 1.5.1. TOP limits the rows returned in a query result set to a specified number of rows.
-- When TOP is used with ORDER BY clause, the result set is limited to the first N number of ordered rows;
-- Otherwise, TOP returns the first N number of rows in an undefined order.
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

-- 1.5.2. OFFSET specifies the number of rows to skip before it starts to return rows from the query expression.
-- Syntax of OFFSET: OFFSET {integer_constant | ofset_row_count_expression} {ROW | ROWS}
-- ROW and ROWS can be used interchangeably.
SELECT CustomerID, FirstName, LastName
FROM SalesLT.Customer
ORDER BY FirstName
OFFSET 10 ROWS

-- FETCH specifies the number of rows to return after the OFFSET clause has been processed
-- Syntax: FETCH {FIRST|NEXT} {integer_constant|fetch_row_count_expression} {ROW| ROWS} ONLY
-- ROW and ROWS can be used interchangeably; FIRST and NEXT can be used interchangeably.
SELECT CustomerID, FirstName, LastName
FROM SalesLT.Customer
ORDER BY FirstName
OFFSET 1 ROW
FETCH NEXT 10 ROWS ONLY

SELECT CustomerID, FirstName, LastName
FROM SalesLT.Customer
ORDER BY FirstName
OFFSET 1 ROW
FETCH FIRST 5 ROWS ONLY
