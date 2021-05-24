-- 1. Using JOINS to select from multiple table sources

-- 1.1. INNER JOIN: return records that have matching values in both tables

-- 1.1.1. Example: Assume we wanted to display the SalesOrderID, SubTotal and the Customer first name, for each sales order
-- We cannot find customer names from the SalesOrderHeader table -> we need the Customer table for that 
SELECT SalesOrderID,
		CustomerID,
		SubTotal
FROM SalesLT.SalesOrderHeader

-- Join SalesOrderHeader table and the Customer table using INNER JOIN 
-- ONLY Customers who have placed orders are displayed in the result
SELECT SalesOrderID,
		SalesLT.Customer.CustomerID,
		FirstName,
		SubTotal
FROM SalesLT.SalesOrderHeader 
		INNER JOIN SalesLT.Customer 
ON SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID -- join condition (table1.PK = table2.FK)
--ON SalesLT.SalesOrderHeader.CustomerID = SalesLT.Customer.CustomerID


--Using alias
SELECT SH.SalesOrderID, C.CustomerID, C.FirstName, C.LastName
FROM SalesLT.SalesOrderHeader SH
	JOIN SalesLT.Customer C ON SH.CustomerID = C.CustomerID


-- The words INNER and OUTER are optional.  ¡°JOIN¡± is a shortcut for ¡°INNER JOIN¡±, 
SELECT SalesOrderID,
		SalesLT.Customer.CustomerID,
		FirstName,
		SubTotal
FROM SalesLT.SalesOrderHeader 
		 JOIN SalesLT.Customer 
ON SalesLT.SalesOrderHeader.CustomerID = SalesLT.Customer.CustomerID

-- You can provide a table alias for the Customer table to make things easier to type
SELECT SalesOrderID,
		C.CustomerID,
		C.FirstName,
		SubTotal
FROM SalesLT.SalesOrderHeader 
		INNER JOIN SalesLT.Customer C
ON SalesLT.SalesOrderHeader.CustomerID = C.CustomerID

SELECT soh.SalesOrderID,
		C.CustomerID,
		C.FirstName,
		SubTotal
FROM SalesLT.SalesOrderHeader soh
		INNER JOIN SalesLT.Customer AS C
ON soh.CustomerID = C.CustomerID


-- 1.1.2. You can join more than two tables
-- Example below shows a three table join; display data from these three tables.

SELECT c.CustomerID, C.FirstName + c.LastName AS [Customer Name],
		ca.AddressID, ca.AddressType,
		a.AddressLine1, a.AddressLine2, a.City
FROM SalesLT.Customer c
    INNER JOIN SalesLT.CustomerAddress ca
	ON c.CustomerID = ca.CustomerID -- this is the first join condition
    INNER JOIN SalesLT.[Address] a 
	ON ca.AddressID = a.AddressID -- this is the second join condition


--Rewrite
SELECT C.CustomerID, C.FirstName + C.LastName AS [Customer Name],
		CA.AddressID, CA.AddressType,
		A.AddressLine1, A.AddressLine2, A.City
FROM SalesLT.CustomerAddress CA
	JOIN SalesLT.Customer C ON CA.CustomerID = C.CustomerID
	JOIN SalesLT.Address A ON CA.AddressID = A.AddressID


-- 1.2. OUTER JOINS
-- When using INNER JOIN, the query below does not return all customers as some customers don¡¯t have addresses recorded
SELECT c.CustomerID,c.FirstName, ca.AddressID
FROM SalesLT.Customer c
	INNER JOIN SalesLT.CustomerAddress ca ON c.CustomerID = ca.CustomerID

-- 1.2.1. If we want to return all customers even those customers who don't have addresses recorded, use LEFT (OUTER) JOIN
-- LEFT JOIN returns everything asked for in the SELECT from the LEFT side table and any matching rows in right table 
SELECT c.CustomerID,c.FirstName, ca.AddressID
FROM SalesLT.Customer c
	LEFT OUTER JOIN SalesLT.CustomerAddress ca ON c.CustomerID = ca.CustomerID

SELECT c.CustomerID,COUNT(ca.AddressID)
FROM SalesLT.Customer c
	LEFT OUTER JOIN SalesLT.CustomerAddress ca ON c.CustomerID = ca.CustomerID
GROUP BY c.CustomerID


-- 1.2.2. returns everything asked for in the SELECT from the RIGHT-side table and any matching rows in left table 
SELECT SalesOrderID,
	C.CustomerID,
	C.FirstName,
	SubTotal
FROM SalesLT.SalesOrderHeader 
		RIGHT OUTER JOIN SalesLT.Customer C
ON SalesLT.SalesOrderHeader.CustomerID = C.CustomerID

-- 1.2.3. FULL OUTER JOIN returns all records when there is a match in either left or right table
SELECT SalesLT.Customer.FirstName, SalesLT.SalesOrderHeader.SalesOrderID
FROM SalesLT.Customer
FULL OUTER JOIN SalesLT.SalesOrderHeader 
ON SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID
ORDER BY SalesLT.Customer.FirstName

-- 1.3. Self join: join a tale to itself. This can be  done if there is a unary relationship in the table
-- inner join with a self-join
SELECT pc.ProductCategoryID , pc.Name, parentpc.ProductCategoryID as [Parent ID], parentpc.Name
	FROM SalesLT.ProductCategory pc
		INNER JOIN SalesLT.ProductCategory parentpc ON pc.ParentProductCategoryID = parentpc.ProductCategoryID

SELECT pc.ProductCategoryID, pc.Name, pc.ParentProductCategoryID
FROM SalesLT.ProductCategory pc

-- left outer join with a self-join
SELECT pc.ProductCategoryID , pc.Name, parentpc.ProductCategoryID as [Parent ID], parentpc.Name
	FROM SalesLT.ProductCategory pc
		LEFT OUTER JOIN SalesLT.ProductCategory parentpc ON pc.ParentProductCategoryID = parentpc.ProductCategoryID

-- right outer join with a self-join	
SELECT pc.ProductCategoryID , pc.Name, parentpc.ProductCategoryID as [Parent ID], parentpc.Name
	FROM SalesLT.ProductCategory pc
		RIGHT OUTER JOIN SalesLT.ProductCategory parentpc ON pc.ParentProductCategoryID = parentpc.ProductCategoryID

-- 1.4. Everything that you already know about SELECT statements still applies
SELECT c.CustomerID, CompanyName, EmailAddress, AddressType, AddressLine1 + ', ' + City + ', ' + UPPER(PostalCode) AS [Address for print]
FROM SalesLT.Customer c
    INNER JOIN SalesLT.CustomerAddress ca ON c.CustomerID = ca.CustomerID
    INNER JOIN SalesLT.[Address] a ON ca.AddressID = a.AddressID
WHERE LOWER(AddressType) <> 'main office'
    AND Suffix IS NULL
ORDER BY SUBSTRING(AddressLine1, CHARINDEX(' ', AddressLine1), 99) --StreetName

SELECT c.CustomerID, CompanyName, EmailAddress, AddressType, AddressLine1
FROM SalesLT.Customer c
    INNER JOIN SalesLT.CustomerAddress ca ON c.CustomerID = ca.CustomerID
    INNER JOIN SalesLT.[Address] a ON ca.AddressID = a.AddressID