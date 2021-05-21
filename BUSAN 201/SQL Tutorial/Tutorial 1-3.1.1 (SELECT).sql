--3.1.1 Simple SELECT exercise
--a)
SELECT SalesOrderID
FROM AdventureWorksLT2012.SalesLT.SalesOrderDetail

--b)
--i)
SELECT CustomerID, FirstName, LastName
FROM SalesLT.Customer
ORDER BY CustomerID ASC
--Defult value is ascending order so we can skip it.

--ii)
SELECT CustomerID, FirstName, LastName
FROM SalesLT.Customer
ORDER BY CustomerID DESC

--iii)
SELECT CustomerID, FirstName, LastName
FROM SalesLT.Customer
ORDER BY FirstName 

--iv)
SELECT CustomerID, FirstName, LastName
FROM SalesLT.Customer
ORDER BY MiddleName

--c)
SELECT AddressID, City, CountryRegion, PostalCode
FROM SalesLT.Address

--d)
SELECT Phone --data type is nvarchar(25)
FROM SalesLT.Customer

--e)
SELECT DISTINCT PostalCode --data type is nvarchar(15)
FROM SalesLT.Address

--f)
SELECT AddressID, AddressLine1, AddressLine2, CountryRegion, StateProvince, City
FROM SalesLT.Address
ORDER BY CountryRegion, StateProvince, City ASC

--g)
SELECT ThumbNailPhoto
FROM SalesLT.Product

SELECT TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE DATA_TYPE = 'VARBINARY'


--h)
SELECT rowguid
FROM SalesLT.Customer

SELECT rowguid
FROM SalesLT.CustomerAddress

SELECT rowguid
FROM SalesLT.Product

SELECT rowguid
FROM SalesLT.ProductDescription

SELECT rowguid
FROM SalesLT.ProductModel

SELECT rowguid
FROM SalesLT.ProductModelProductDescription

SELECT rowguid
FROM SalesLT.SalesOrderDetail

SELECT rowguid
FROM SalesLT.SalesOrderHeader


