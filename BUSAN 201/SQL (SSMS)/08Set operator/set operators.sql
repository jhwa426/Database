-- 2. Set operators

-- Set operators combine results from two or more queries into a single result set
 
-- Compare with SELECT 'Mother', 'Father'
SELECT 'Mother' AS Name
UNION
SELECT 'Father'

SELECT 'Mother' 
UNION
SELECT 'Father' AS Name

-- What if our business purpose is to display the child and parent product names with an added category type tag
-- based on whether a parent product category is included?

-- We can use the CASE statement that we just learned
SELECT
	CASE 
		WHEN ParentProductCategoryID IS NOT NULL THEN 'Child' 
		WHEN ParentProductCategoryID IS NULL THEN 'Parent'
		END  AS CategoryType,Name
FROM SalesLT.ProductCategory

-- If we want to use UNION for the business purpose ...
-- This gives the same result as the the previous query
SELECT
    'Child' AS CategoryType,
     Name
FROM SalesLT.ProductCategory
WHERE ParentProductCategoryID IS NOT NULL
UNION 
SELECT
    'Parent',
    Name
FROM SalesLT.ProductCategory
WHERE ParentProductCategoryID IS NULL

-- Example: display the product ids, product names 
-- and list prices of products which contain the word 'road' in the product name or 
-- has a list price greater than 1000, ordered by product ids
SELECT ProductID, Name, ListPrice 
FROM SalesLT.Product
WHERE UPPER(Name) LIKE '%ROAD%' 
UNION --ALL
SELECT ProductID, Name, ListPrice 
FROM SalesLT.Product
WHERE ListPrice> 1000 
ORDER BY 1 -- ProductID

-- From the example above, think about the following:
-- (1) What if we use UNION ALL instead of UNION?
-- UNION Used to combine the results of two or more SELECT statements without returning any duplicate rows
-- UNION ALL returns the duplicate rows as well
-- (2) How to do sorting?
-- Individual result set ordering is not allowed with Set operators
-- ORDER BY can appear once at the end of the query (better to use ORDER BY with column positions)

-- You can also use the logical operator OR
-- Below gives the same result as the previous query
SELECT ProductID, Name 
FROM SalesLT.Product
WHERE UPPER(Name ) LIKE '%ROAD%'  OR ListPrice> 1000 

-- Example: display the product ids, product names 
-- and list prices of products which contain the word 'road' in the product name and 
-- has a list price greater than 1000
-- If we use INTERSECT ...
SELECT ProductID, Name, ListPrice
FROM SalesLT.Product
WHERE UPPER(Name ) LIKE '%ROAD%' 
INTERSECT 
SELECT ProductID, Name, ListPrice 
FROM SalesLT.Product
WHERE ListPrice> 1000 

-- You can also use the logical operator AND
-- Below gives the same result as the previous query
SELECT ProductID, Name, ListPrice 
FROM SalesLT.Product
WHERE UPPER(Name ) LIKE '%ROAD%'  AND ListPrice> 1000 

-- Example: display the product ids, product names 
-- and list prices of products which contain the word 'road' in the product name but does not 
-- have a list price greater than 1000
-- If we use EXCEPT ...
SELECT ProductID, Name, ListPrice
FROM SalesLT.Product
WHERE UPPER(Name ) LIKE '%ROAD%' 
EXCEPT 
SELECT ProductID, Name, ListPrice 
FROM SalesLT.Product
WHERE ListPrice> 1000 

-- You can also achieve this using logical operators in WHERE clause
-- Below gives the same result as the previous query
SELECT ProductID, Name, ListPrice 
FROM SalesLT.Product
WHERE UPPER(Name) LIKE '%ROAD%' AND ListPrice <= 1000

-- Last example: what will be shown below (when a subset EXCEPT a superset)?
SELECT ProductID
FROM SalesLT.SalesOrderDetail
EXCEPT
SELECT ProductID
FROM SalesLT.Product


--EXTRA NOTE
SELECT SalesPerson
FROM SalesLT.Customer
WHERE CustomerID < 100
UNION 
SELECT SalesPerson 
FROM SalesLT.Customer
WHERE CustomerID > 10000

--COMAPRE WITH THIS BELOW

SELECT SalesPerson
FROM SalesLT.Customer
WHERE CustomerID < 100 OR CustomerID > 10000
--They are diffrent because of duplicate rows

SELECT DISTINCT SalesPerson
FROM SalesLT.Customer
WHERE CustomerID < 100 OR CustomerID > 10000

