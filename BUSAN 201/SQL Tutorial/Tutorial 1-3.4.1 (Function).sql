--3.4.1 Function exercise
--a)
SELECT *
FROM SalesLT.Customer
WHERE LEN(FirstName) > 10

--b)
SELECT *
FROM SalesLT.Customer
WHERE LEN(FirstName+LastName) > 20

SELECT *
FROM SalesLT.Customer
WHERE LEN(CONCAT(FirstName,LastName)) > 20

--c)
SELECT *
FROM SalesLT.Product
WHERE Name LIKE '%Bike%'

--d)
SELECT *
FROM SalesLT.SalesOrderHeader

--answer
SELECT DATEDIFF(YEAR, '2000-01-01', '2008-12-31')
FROM SalesLT.SalesOrderHeader

--e)
SELECT *, DATEDIFF(YEAR, '2000-01-01', '2008-12-31')
FROM SalesLT.SalesOrderHeader

--f)
SELECT ProductID, ProductNumber, Name, Size, Weight
FROM SalesLT.Product
WHERE Size NOT LIKE 'M' AND Size IS NOT NULL AND SellEndDate IS NOT NULL

--g)
SELECT Title, FirstName, MiddleName, LastName, LEN(CONCAT(Title, FirstName, MiddleName, LastName, Suffix))
FROM SalesLT.Customer
WHERE LEN(CONCAT(Title, FirstName, MiddleName, LastName, Suffix)) > 20

--h)
SELECT Title, LEN(Title)
FROM SalesLT.Customer

SELECT MiddleName, LEN(MiddleName)
FROM SalesLT.Customer

--Answer
SELECT Title, FirstName, MiddleName, LastName, LEN(CONCAT(Title, FirstName, MiddleName, LastName, Suffix)) - (2) AS [Namecount]
FROM SalesLT.Customer
WHERE LEN(CONCAT(Title, FirstName, MiddleName, LastName, Suffix)) > 20

--i)
SELECT Title, FirstName, MiddleName, LastName, CONCAT(Title, FirstName, MiddleName, LastName, Suffix) AS [Full Name]
FROM SalesLT.Customer
