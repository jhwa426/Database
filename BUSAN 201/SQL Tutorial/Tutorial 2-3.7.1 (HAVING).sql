--3.7.1 HAVING exercise
--a)
SELECT CA.CustomerID, C.FirstName, C.LastName ,COUNT(A.AddressID) AS [Number of address]
FROM SalesLT.Address A
	JOIN SalesLT.CustomerAddress CA ON A.AddressID = CA.AddressID
	JOIN SalesLT.Customer C ON C.CustomerID = CA.CustomerID
GROUP BY CA.CustomerID, C.FirstName, C.LastName
HAVING COUNT(A.AddressID) > 1

--ANSWER
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(AddressID) AS [Address Number]
FROM SalesLT.Customer c
LEFT JOIN SalesLT.[CustomerAddress] ca ON c.CustomerID = ca.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING COUNT(AddressID) > 1


--b)
--We can use COUNT(Color) insted of COUNT(ProductID)

--i)
SELECT Color, COUNT(ProductID) AS [Number of color]
FROM SalesLT.Product
GROUP BY Color
HAVING COUNT(ProductID) = 10

--ii)
SELECT Color, COUNT(ProductID) AS [Number of color]
FROM SalesLT.Product
GROUP BY Color
HAVING COUNT(ProductID) < 10

--iii)
SELECT Color, COUNT(Color) AS [Number of color]
FROM SalesLT.Product
GROUP BY Color
HAVING AVG(Weight) >= 500.00 AND Color IS NOT NULL

--iv)
SELECT Color, COUNT(Color) AS [Number of color]
FROM SalesLT.Product
GROUP BY Color
HAVING MAX(Weight) < 500.00 AND Color IS NOT NULL

--c)
--i)
SELECT PC.Name, COUNT(P.ProductID) AS [Number of Product category Name]
FROM SalesLT.ProductCategory PC
	JOIN SalesLT.Product P ON P.ProductCategoryID = PC.ProductCategoryID
GROUP BY PC.Name
HAVING COUNT(P.ProductID) = 10

--ii)
SELECT PC.Name, COUNT(P.ProductID) AS [Number of Product category Name]
FROM SalesLT.ProductCategory PC
	JOIN SalesLT.Product P ON P.ProductCategoryID = PC.ProductCategoryID
GROUP BY PC.Name
HAVING COUNT(P.ProductID) < 10

--iii)
SELECT PC.Name, COUNT(P.ProductID) AS [Number of Product category Name]
FROM SalesLT.ProductCategory PC
	JOIN SalesLT.Product P ON P.ProductCategoryID = PC.ProductCategoryID
GROUP BY PC.Name
HAVING AVG(P.Weight) >= 500.00

--iv)
SELECT PC.Name, COUNT(P.ProductID) AS [Number of Product category Name]
FROM SalesLT.ProductCategory PC
	JOIN SalesLT.Product P ON P.ProductCategoryID = PC.ProductCategoryID
GROUP BY PC.Name
HAVING MAX(P.Weight) < 500.00

--d)
SELECT PC1.Name, COUNT(PC2.Name) AS [Number of subname]
FROM SalesLT.ProductCategory PC1 
	LEFT JOIN SalesLT.ProductCategory PC2 ON PC1.ProductCategoryID = PC2.ParentProductCategoryID
GROUP BY PC1.Name
HAVING COUNT(PC2.Name) = 0

--e)
SELECT AddressLine1+City+StateProvince, COUNT(AddressLine1+City+StateProvince)
FROM SalesLT.Address
GROUP BY AddressLine1+City+StateProvince
HAVING COUNT(AddressLine1+City+StateProvince) > 1

--f)	Add meaningful HAVING clauses to the group queries from the Aggregate function exercises.
--E.G. which customers have more than 1 address

SELECT C.CustomerID, C.FirstName, C.LastName, COUNT(CA.AddressID) AS [Number of addressID]
FROM SalesLT.Customer C 
	LEFT JOIN SalesLT.CustomerAddress CA ON C.CustomerID = CA.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
HAVING COUNT(CA.AddressID) > 1
ORDER BY COUNT(CA.AddressID) DESC
