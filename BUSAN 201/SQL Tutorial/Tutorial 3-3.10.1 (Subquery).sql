--3.10.1 Subquery exercise
--a)
SELECT *
FROM SalesLT.Product
WHERE ListPrice > (SELECT AVG(ListPrice) FROM SalesLT.Product)

--b)
SELECT P.ProductID, P.Name
FROM SalesLT.Product P
WHERE P.ProductID IN (
	SELECT SOD.ProductID
	FROM SalesLT.SalesOrderDetail SOD
	GROUP BY SOD.ProductID
	HAVING COUNT(SOD.ProductID) > 1)

--c)
SELECT P1.ProductID, P1.Size, P1.ListPrice
FROM SalesLT.Product P1
WHERE P1.ListPrice IN (
	SELECT P2.ListPrice
	FROM SalesLT.Product P2
	WHERE UPPER(P2.Size) = 'L') AND UPPER(P1.Size) <> 'L'

--USE SELF JOIN
SELECT P1.ProductID, P1.Size, P1.ListPrice
FROM SalesLT.Product P1
	JOIN SalesLT.Product P2 ON P1.ProductID = P2.ProductID
WHERE UPPER(P1.Size) <> 'L' AND UPPER(P2.Size) = 'L' AND P1.ListPrice = P2.ListPrice

--d)
SELECT P.Name, ListPrice, PC.Name AS [C Name], PC2.[Avg price] / ListPrice * 100
FROM SalesLT.Product P, SalesLT.ProductCategory PC, 
	(SELECT PC.Name, AVG(ListPrice) AS [Avg price]
	FROM SalesLT.Product P, SalesLT.ProductCategory PC
	WHERE P.ProductCategoryID = PC.ProductCategoryID
	GROUP BY PC.Name) PC2
WHERE P.ProductCategoryID = PC.ProductCategoryID AND PC.Name = PC2.Name

--e)
