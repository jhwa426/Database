--3.3.1 WHERE exercise

--a)
SELECT CustomerID, FirstName, LastName
FROM SalesLT.Customer
WHERE CustomerID <= 1

--b)
SELECT CustomerID
FROM SalesLT.Customer
WHERE CustomerID <= 3

--c)
SELECT CustomerID, NameStyle, FirstName, LastName, CompanyName, EmailAddress, Phone, PasswordHash, PasswordSalt, rowguid, ModifiedDate
FROM SalesLT.Customer

--d)
SELECT *
FROM SalesLT.Customer
WHERE Title IS NULL OR MiddleName IS NULL OR MiddleName IS NULL 

--e)
SELECT *
FROM SalesLT.Customer

--f)
SELECT *
FROM SalesLT.Product
WHERE Weight > 1000.00

--g)
SELECT *
FROM SalesLT.Product
WHERE Name LIKE '%Pedal%'
ORDER BY Weight

SELECT *
FROM SalesLT.Product
WHERE Name LIKE '%Pedal%' AND Weight IS NOT NULL
ORDER BY Weight

--h)
SELECT ProductID, Name, ProductNumber, StandardCost, ListPrice, Size, Weight, ProductCategoryID, ProductModelID, SellStartDate, SellEndDate, DiscontinuedDate, ThumbNailPhoto, ThumbnailPhotoFileName, rowguid, ModifiedDate
FROM SalesLT.Product

--i)
SELECT *
FROM SalesLT.Product
WHERE Color NOT LIKE  'White'

--j)
SELECT *
FROM SalesLT.Product
WHERE SellEndDate IS NOT NULL

--k)
--98 Products

--l)
SELECT *
FROM SalesLT.Product
WHERE Name LIKE 'S%'


--ANSWER
SELECT *
FROM SalesLT.Product
WHERE SIZE LIKE 'S%'

SELECT *
FROM SalesLT.Product
WHERE SIZE = 'S'

SELECT *
FROM SalesLT.Product
WHERE ProductNumber LIKE '%S'

