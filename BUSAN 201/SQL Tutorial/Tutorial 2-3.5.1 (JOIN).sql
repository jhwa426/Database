--3.5.1 JOIN exercise
--a)
SELECT *
FROM SalesLT.SalesOrderHeader SOH 
	JOIN SalesLT.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID

--b)
SELECT *
FROM SalesLT.SalesOrderDetail SOD
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID

--c)
SELECT *
FROM SalesLT.SalesOrderHeader SOH
	JOIN SalesLT.Customer C ON SOH.CustomerID = C.CustomerID

--d)
SELECT SOH.SalesOrderID, A.AddressID, A.AddressLine1, A.AddressLine2
FROM SalesLT.SalesOrderHeader SOH, SalesLT.Address A
WHERE SOH.BillToAddressID = A.AddressID

--e)
SELECT A.AddressID, A.AddressLine1, A.AddressLine2
FROM SalesLT.SalesOrderHeader SOH 
	JOIN SalesLT.Address A ON SOH.ShipToAddressID = A.AddressID

--f)
SELECT SOH.ShipToAddressID, SA.AddressID, SA.AddressLine1, SA.AddressLine2
	,SOH.BillToAddressID, BA.AddressID, BA.AddressLine1, BA.AddressLine2
FROM SalesLT.SalesOrderHeader SOH 
	JOIN SalesLT.Address SA ON SOH.ShipToAddressID = SA.AddressID
	JOIN SalesLT.Address BA ON SOH.BillToAddressID = BA.AddressID

--g)
SELECT SOH.SalesOrderID, C.CustomerID, BA.AddressID, BA.AddressLine1, BA.AddressLine2
FROM SalesLT.SalesOrderHeader SOH
	JOIN SalesLT.Customer C ON SOH.CustomerID = C.CustomerID
	JOIN SalesLT.Address BA ON SOH.BillToAddressID = BA.AddressID

--h)
SELECT SOH.SalesOrderID, C.CustomerID, SA.AddressID, SA.AddressLine1, SA.AddressLine2
FROM SalesLT.SalesOrderHeader SOH
	JOIN SalesLT.Customer C ON SOH.CustomerID = C.CustomerID
	JOIN SalesLT.Address SA ON SOH.BillToAddressID = SA.AddressID

--i)
SELECT C.CustomerID, CA.AddressType, A.AddressLine1, A.AddressLine2
FROM SalesLT.SalesOrderHeader SOH
	JOIN SalesLT.Customer C ON SOH.CustomerID = C.CustomerID
	JOIN SalesLT.CustomerAddress CA ON C.CustomerID = CA.CustomerID
	JOIN SalesLT.Address A ON CA.AddressID = A.AddressID
WHERE AddressType = 'Main Office'

--j)
SELECT SOH.SalesOrderID, C.CustomerID, CA.AddressType, A.AddressLine1 AS [Office address], BA.AddressLine1 AS [Bill to Address], SA.AddressLine1 as [Bill To Address]
FROM SalesLT.SalesOrderHeader SOH
	JOIN SalesLT.Customer C ON SOH.CustomerID = C.CustomerID
	JOIN SalesLT.CustomerAddress CA ON C.CustomerID = CA.CustomerID
	JOIN SalesLT.Address A ON CA.AddressID = A.AddressID
	JOIN SalesLT.Address BA ON SOH.BillToAddressID = BA.AddressID
	JOIN SalesLT.Address SA ON SOH.ShipToAddressID = SA.AddressID
WHERE CA.AddressType = 'Main Office'

--k)
SELECT A.AddressID, ISNULL(CAST(C.CustomerID AS NVARCHAR(50)) , 'NULL') AS 'Customer ID'
FROM SalesLT.Address A 
	LEFT JOIN SalesLT.CustomerAddress CA ON A.AddressID = CA.AddressID
	LEFT JOIN SalesLT.Customer C ON CA.CustomerID = C.CustomerID

--l)
SELECT A.AddressID, CA.CustomerID AS 'Customer ID'
FROM SalesLT.Address A
	LEFT JOIN SalesLT.CustomerAddress CA ON A.AddressID = CA.AddressID
	LEFT JOIN SalesLT.Customer C ON CA.CustomerID = C.CustomerID
WHERE C.CustomerID IS NULL

--m)
SELECT SOH.SalesOrderID, BA.City AS [Bill To City], SA.City AS [Ship To City]
FROM SalesLT.SalesOrderHeader SOH
	JOIN SalesLT.Address BA ON SOH.BillToAddressID = BA.AddressID
	JOIN SalesLT.Address SA ON SOH.ShipToAddressID = SA.AddressID
WHERE BA.City <> SA.City

--n)
SELECT SalesOrderID
FROM SalesLT.SalesOrderHeader 
WHERE BillToAddressID <> ShipToAddressID

SELECT ShipToAddressID, BillToAddressID
FROM SalesLT.SalesOrderHeader
GROUP BY ShipToAddressID, BillToAddressID


--o)
SELECT C.CustomerID, P.ProductID
FROM SalesLT.SalesOrderDetail SOD
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
	JOIN SalesLT.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	JOIN SalesLT.Customer C ON SOH.CustomerID = C.CustomerID
GROUP BY P.ProductID, C.CustomerID

--ANSWER
SELECT c.CustomerID, p.ProductID
FROM SalesLT.SalesOrderDetail od 
JOIN SalesLT.SalesOrderHeader oh ON oh.SalesOrderID = od.SalesOrderID
JOIN SalesLT.Customer c ON c.CustomerID = OH.CustomerID
JOIN SalesLT.Product p ON od.ProductID = p.ProductID
ORDER BY od.ProductID, c.CustomerID