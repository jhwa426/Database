-- 2. Aggregate functions, GROUP BY, Having Clause

-- 2.1. Aggregate functions: MIN(), MAX(), AVG(), SUM(), COUNT()
-- Perform a calculation on a set of values [from multiple rows] and return a single value.
-- Aggregate functions ignore null values

-- Example: Display the minimum order quantity, maximum order quantity, minimum unit price, 
-- maximum unit price and maximum modified date for all orders
SELECT
	 MIN(OrderQty) AS [fewest units ordered]
	,MAX(OrderQty) AS [most units ordered] 
	,MIN(UnitPrice) AS [lowest unit price]
	,MAX(UnitPrice) AS [highest unit price]
	,MAX(ModifiedDate) AS [latest date]
FROM SalesLT.SalesOrderDetail

-- Example: Display the sum of SubTotal, sum of tax amount, sum of freight, sum of total due, average of total due,
-- the number of SalesOrderID
-- If no GROUP BY clause is given, then all rows returned are treated as a single group
SELECT 
     SUM([SubTotal])
    ,SUM([TaxAmt])
    ,SUM([Freight])
    ,SUM([TotalDue])
    ,AVG([TotalDue])
    ,COUNT(SalesOrderID)
FROM [SalesLT].[SalesOrderHeader]

-- 2.2. GROUP BY: Group records into summary rows; return one record for each group; can be grouped by one or more columns

-- Some rules:
-- 1) GROUP BY can be translated to ¡°for each unique value of¡±
-- 2) All data returned must either be used in an aggregate function, or included in the GROUP BY clause
-- 3) The order of processing is: FROM, WHERE, GROUP BY

-- Example: Display the number of orders, total quantity ordered, average unit price, order total for each product
-- which has been ordered.
SELECT 
    ProductID
    ,COUNT(SalesOrderID) as [Number of Orders]
    ,SUM(OrderQty) as [Total Quantity Ordered]
    ,AVG(UnitPrice) as [Average Unit Price]
    ,SUM(LineTotal) [Order Total]
FROM SalesLT.SalesOrderDetail
GROUP BY ProductID --for each unique ProductID value after joins and WHERE applied
ORDER BY ProductID

--PRAC1)
SELECT SalesOrderID
		,SUM(TaxAmt) AS [TOTAL TAX]
		,SUM(TotalDue) AS [TOTAL DUE]
FROM SalesLT.SalesOrderHeader
GROUP BY SalesOrderID
ORDER BY [TOTAL DUE] DESC



-- Example: Display the salesperson name and the count of customers that each salesperson serves
SELECT COUNT(CustomerID), SalesPerson
FROM SalesLT.Customer
--ORDER BY SalesPerson
GROUP BY SalesPerson

-- Recall the example we did earlier in the self-join
-- lets try a variation of this self-join 
SELECT parentpc.ProductCategoryID as [Parent ID],
 		parentpc.Name, pc.ProductCategoryID, pc.Name 
FROM SalesLT.ProductCategory pc
		INNER JOIN SalesLT.ProductCategory parentpc 
ON pc.ParentProductCategoryID = parentpc.ProductCategoryID

-- Example: display the parent product category ID, parent product category name and the count of child products 
-- for all products which have a parent product
SELECT parentpc.ProductCategoryID as [Parent ID], parentpc.Name
		,COUNT (pc.ProductCategoryID ) as [Number of Child products]  
FROM SalesLT.ProductCategory pc
		INNER JOIN SalesLT.ProductCategory parentpc 
ON pc.ParentProductCategoryID = parentpc.ProductCategoryID
GROUP BY parentpc.ProductCategoryID,  parentpc.Name -- what happens if Name column is not included?


-- 2.3. Having: can be thought of as a condition (just like a WHERE clause) that gets applied after the GROUP BY clause
-- GROUP BY cannot be used with WHERE; HAVING has to be after group by

-- Example: Display the sales person name and the count of customers that each sales person serves 
-- for all sales people who serve more than 70 customers
SELECT COUNT(CustomerID), SalesPerson
FROM SalesLT.Customer
--WHERE COUNT(CustomerID) > 70
GROUP BY SalesPerson
HAVING COUNT(CustomerID) > 70

-- Can we use column alias here?
SELECT COUNT(CustomerID) AS cid, SalesPerson
FROM SalesLT.Customer
GROUP BY SalesPerson
HAVING COUNT(CustomerID) > 70 -- what if we use cid instead of the original function?

-- The order of processing is:
-- 1) FROM: the product of all tables in the FROM clause is formed.
-- 2) WHERE clause is then evaluated to eliminate rows that do not satisfy the search_condition.
-- 3) GROUP BY: the rows are grouped using the columns in the GROUP BY clause.
-- 4) Having: Groups that do not satisfy the search_condition in the HAVING clause are eliminated.
-- 5) SELECT: the expressions in the SELECT statement target list are evaluated.

-- 2.4. WHERE and HAVING can be used in the same query

-- Example: display first names that have a length between 5 and 7 characters 
-- and that more than 7 customers share the same first name
SELECT FirstName, COUNT(CustomerID) AS frequency
FROM SalesLT.Customer
WHERE LEN(FirstName) BETWEEN 5 AND 7 --this results in less "grouping effort"
GROUP BY FirstName
HAVING COUNT(CustomerID) > 7
    AND LEN(FirstName) BETWEEN 5 AND 7 --this is now redundant
ORDER BY 1 --sorted by the first column
-- == ORDER BY FirstName

-- Example: Display the product ID, product name, average unit price, list price, and product category name for all products
-- which belong to a product category where the name of the category contains the word "bike" 
-- and the average unit price is > 1000
SELECT P.ProductID, P.Name AS [Product Name], AVG(SOD.UnitPrice) AS [Average Unit Price], P.ListPrice, PC.Name AS [Product Category Name]
FROM SalesLT.SalesOrderDetail SOD
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
	JOIN SalesLT.ProductCategory PC ON P.ProductCategoryID = PC.ProductCategoryID
WHERE LOWER(PC.Name) LIKE '%bike%'
GROUP BY P.ProductID, P.Name, P.ListPrice, PC.Name
HAVING AVG(SOD.UnitPrice) > 1000
ORDER BY P.ListPrice - AVG(SOD.UnitPrice) DESC

SELECT [ProductID], AVG(UnitPrice)   
FROM [AdventureWorksLT2012].[SalesLT].[SalesOrderDetail]
GROUP BY ProductID
HAVING AVG(UnitPrice) > 1000

SELECT p.[ProductID], p.[Name], sod.UnitPrice, pc.Name
FROM SalesLT.SalesOrderDetail sod
	JOIN SalesLT.Product p on sod.ProductID = p.ProductID
	JOIN SalesLT.ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID
WHERE LOWER(pc.Name) LIKE '%bike%'


