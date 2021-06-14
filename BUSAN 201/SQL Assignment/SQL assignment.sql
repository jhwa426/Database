--SQL Assignment (Case sensitive)

--Q1
SELECT Color
FROM SalesLT.Product
WHERE Color = 'Black' or Color = 'Yellow'

--Q2
SELECT ProductID, Weight, ListPrice
FROM SalesLT.Product
WHERE Weight > 1500.00 AND ListPrice >= 846.44

--Q3
SELECT Name
FROM SalesLT.Product
WHERE Name LIKE '%Black%' OR Name LIKE '%Silver%'

--Q4
SELECT ProductID
FROM SalesLT.Product
WHERE (Color LIKE '%Multi%' OR Color LIKE '%No Colour%') AND (Weight IS NOT NULL) AND (Size IS NULL)

--RESOLVE
SELECT *
FROM SalesLT.Product
WHERE (Color LIKE '%Multi%' OR Color LIKE '%No Colour%' OR Color IS NULL) AND (Weight IS NOT NULL) AND (Size IS NULL)

--Q5
SELECT *
FROM SalesLT.Product
WHERE SellStartDate > '2005-01-01' AND (SellEndDate IS NULL AND DiscontinuedDate IS NULL)

--RESOLVE
SELECT *
FROM SalesLT.Product
WHERE YEAR(SellStartDate) = '2005' AND (SellEndDate IS NULL AND DiscontinuedDate IS NULL)


--Q6
SELECT *
FROM SalesLT.CustomerAddress
WHERE AddressType = 'Billing' OR AddressType = 'Shipping'

SELECT *
FROM SalesLT.Address
WHERE CountryRegion = 'Canada'

--Answer
SELECT ca.AddressType, a.CountryRegion
FROM SalesLT.Address a
	JOIN SalesLT.CustomerAddress ca ON ca.AddressID = a.AddressID
WHERE CountryRegion = 'Canada' AND (AddressType = 'Billing' OR AddressType = 'Shipping')

--Q7
--Company name
SELECT CompanyName
FROM SalesLT.Customer

--Sales order number
SELECT SalesOrderNumber
FROM SalesLT.SalesOrderHeader

--Sales order detail id
SELECT SalesOrderDetailID
FROM SalesLT.SalesOrderDetail

--Product name
SELECT Name
FROM SalesLT.Product

--Product model name
SELECT Name
FROM SalesLT.ProductModel

--Answer (FIRST TRY)
SELECT SH.SalesOrderNumber, C.CompanyName, P.Name [Product name] , PM.Name [Model name]
FROM SalesLT.SalesOrderHeader SH
	JOIN SalesLT.SalesOrderDetail SD ON SH.SalesOrderID = SD.SalesOrderID
	JOIN SalesLT.Customer C ON SH.CustomerID = C.CustomerID
	JOIN SalesLT.Product P ON SD.ProductID = P.ProductID
	JOIN SalesLT.ProductModel PM ON P.ProductModelID = PM.ProductModelID
WHERE (P.Name LIKE '%Tire%' AND PM.Name LIKE '%Tire%') AND (P.Name NOT LIKE '%Tube%' AND PM.Name NOT LIKE '%Tube%')
ORDER BY SH.SalesOrderID ASC


--Answer (SECOND TRY)
SELECT SH.SalesOrderNumber, C.CompanyName, P.Name [Product name] , PM.Name [Model name]
FROM SalesLT.Product P 
	JOIN SalesLT.ProductModel PM ON P.ProductModelID = PM.ProductModelID
	JOIN SalesLT.SalesOrderDetail OD ON P.ProductID = OD.ProductID
	JOIN SalesLT.SalesOrderHeader SH ON OD.SalesOrderID = SH.SalesOrderID
	JOIN SalesLT.Customer C ON SH.CustomerID = C.CustomerID
WHERE P.Name LIKE '%Tire%' AND P.Name NOT LIKE '%Tube%'
ORDER BY SH.SalesOrderID ASC


--Q8)

--Sales order detail id
SELECT SalesOrderDetailID
FROM SalesLT.SalesOrderDetail

--Order qty
SELECT OrderQty
FROM SalesLT.SalesOrderDetail

--Unit price
SELECT UnitPrice
FROM SalesLT.SalesOrderDetail

--Line Total
SELECT LineTotal
FROM SalesLT.SalesOrderDetail

--Product name
SELECT Name
FROM SalesLT.Product

--Product Description
SELECT Description
FROM SalesLT.ProductDescription

--Answer
SELECT SOD.SalesOrderID, P.Name, PD.Description, PMPD.Culture, PD.rowguid
FROM SalesLT.ProductModelProductDescription PMPD
	JOIN SalesLT.ProductDescription PD ON PMPD.ProductDescriptionID = PD.ProductDescriptionID
	JOIN SalesLT.ProductModel PM ON PMPD.ProductModelID = PM.ProductModelID
	JOIN SalesLT.Product P ON PM.ProductModelID = P.ProductModelID
	JOIN SalesLT.SalesOrderDetail SOD ON P.ProductID = SOD.ProductID
WHERE PMPD.Culture = 'en' AND SOD.UnitPriceDiscount = 0.00
ORDER BY SOD.SalesOrderDetailID ASC


--Q9)
SELECT A.AddressID, A.City, A.CountryRegion
FROM SalesLT.Address A
	JOIN SalesLT.CustomerAddress CA ON A.AddressID = CA.AddressID
	LEFT JOIN SalesLT.Customer C ON CA.CustomerID = C.CustomerID
ORDER BY A.AddressID ASC



--RESOLVE
SELECT A.AddressID, A.City, A.CountryRegion
FROM SalesLT.Address A
	JOIN SalesLT.CustomerAddress CA ON A.AddressID = CA.AddressID
	RIGHT JOIN SalesLT.Customer C ON CA.CustomerID = C.CustomerID
WHERE A.CountryRegion LIKE '%United Kingdom%'
ORDER BY A.AddressID ASC



SELECT A.AddressID, A.City, A.CountryRegion
FROM SalesLT.Address A
	FULL OUTER JOIN SalesLT.CustomerAddress CA ON A.AddressID = CA.AddressID
	JOIN SalesLT.Customer C ON CA.CustomerID = C.CustomerID
WHERE A.CountryRegion LIKE '%United Kingdom%'
ORDER BY A.AddressID ASC



--RESOLVE 2
SELECT *
FROM SalesLT.Address A
	FULL OUTER JOIN SalesLT.CustomerAddress CA ON CA.AddressID = A.AddressID
	FULL OUTER JOIN SalesLT.Customer C ON CA.CustomerID = C.CustomerID
WHERE A.CountryRegion LIKE '%United Kingdom%' AND C.CustomerID IS NULL
ORDER BY A.AddressID ASC


--Q10)
SELECT PC.Name, COUNT(PC.Name)
FROM SalesLT.SalesOrderDetail SOD 
	JOIN SalesLT.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	JOIN SalesLT.Customer C ON SOH.CustomerID = C.CustomerID
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
	JOIN SalesLT.ProductCategory PC ON P.ProductCategoryID = PC.ProductCategoryID
WHERE PC.Name LIKE 'Bike Stands' OR PC.Name LIKE 'Tires and Tubes' OR PC.Name LIKE 'Vests' OR PC.Name LIKE 'Wheels'
GROUP BY PC.Name

--ANSWER
SELECT C.CustomerID, SOH.SalesOrderID, PC.Name
FROM SalesLT.SalesOrderDetail SOD 
	JOIN SalesLT.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	JOIN SalesLT.Customer C ON SOH.CustomerID = C.CustomerID
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
	JOIN SalesLT.ProductCategory PC ON P.ProductCategoryID = PC.ProductCategoryID
WHERE PC.Name LIKE 'Bike Stands' OR PC.Name LIKE 'Tires and Tubes' OR PC.Name LIKE 'Vests' OR PC.Name LIKE 'Wheels'

--RESOLVE
SELECT DISTINCT(C.CustomerID)
FROM SalesLT.SalesOrderDetail SOD 
	JOIN SalesLT.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	JOIN SalesLT.Customer C ON SOH.CustomerID = C.CustomerID
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
	JOIN SalesLT.ProductCategory PC ON P.ProductCategoryID = PC.ProductCategoryID
WHERE PC.Name LIKE 'Bike Stands' OR PC.Name LIKE 'Tires and Tubes' OR PC.Name LIKE 'Vests' OR PC.Name LIKE 'Wheels'

--Q11
SELECT City, COUNT(City) AS [Number of city]
FROM SalesLT.Address
GROUP BY City
ORDER BY City

--RESOLVE
SELECT City, COUNT(City) AS [Number of city]
FROM SalesLT.Address
GROUP BY City
ORDER BY COUNT(City) DESC, City


--Q12
SELECT ProductID, COUNT(ProductID) AS [Number of product]
FROM SalesLT.SalesOrderDetail
GROUP BY ProductID
HAVING COUNT(ProductID) > 9

--RESOLVE
SELECT SalesOrderID, COUNT(ProductID) AS [Number of product]
FROM SalesLT.SalesOrderDetail
GROUP BY SalesOrderID
HAVING COUNT(ProductID) > 9

--Q13
SELECT ProductID, COUNT(ProductID) AS [Number of product], OrderQty
FROM SalesLT.SalesOrderDetail
WHERE OrderQty >= 15
GROUP BY ProductID, OrderQty

--RESOLVE
SELECT SalesOrderID, COUNT(SalesOrderID) AS [Number of product]
FROM SalesLT.SalesOrderDetail
WHERE OrderQty >= 15
GROUP BY SalesOrderID

--RE2
SELECT SalesOrderID, COUNT(OrderQty) AS [Number of product]
FROM SalesLT.SalesOrderDetail
GROUP BY SalesOrderID
HAVING COUNT(OrderQty) >= 15

--Q13 RESOLVE 3
SELECT SalesOrderID, SUM(OrderQty) AS [Number of product]
FROM SalesLT.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(OrderQty) >= 15
--49

--Q14
SELECT SUM(P.Weight * SOD.OrderQty) AS [TOTAL WEIGHT]
FROM SalesLT.SalesOrderDetail SOD 
	JOIN SalesLT.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
WHERE ((YEAR(SOH.DueDate) = 2017) AND (MONTH(SOH.DueDate) = 7 OR MONTH(SOH.DueDate) = 11 OR MONTH(SOH.DueDate) = 1)) AND SOH.ShipMethod = 'Unknown'

--WHERE (YEAR(SOH.DueDate) = 2017) AND (MONTH(SOH.DueDate) = 7 OR MONTH(SOH.DueDate) = 11 OR MONTH(SOH.DueDate) = 1)
--WHERE (YEAR(SOH.DueDate) = 2017 AND MONTH(SOH.DueDate) = 7) OR (YEAR(SOH.DueDate) = 2017 AND MONTH(SOH.DueDate) = 11) OR (YEAR(SOH.DueDate) = 2017 AND MONTH(SOH.DueDate) = 1)


--Q15
--PRAC1)
SELECT P.Name, P.Color, SOD.LineTotal,
		CASE
			WHEN P.Color IS NULL THEN 'Multi'
			WHEN P.Color = 'No Colour' THEN 'Multi'
			ELSE P.Color
		END AS [NEW COLOR],
		SUM(SOD.LineTotal) AS [REVENUE]
FROM SalesLT.SalesOrderDetail SOD 
	JOIN SalesLT.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
WHERE (YEAR(SOH.DueDate) = 2017)
GROUP BY P.Name, P.Color, SOD.LineTotal
ORDER BY SOD.LineTotal DESC

--PRAC2)
SELECT P.Name, P.Color, SOD.LineTotal,
		CASE
			WHEN P.Color IS NULL THEN 'Multi'
			WHEN P.Color = 'No Colour' THEN 'Multi'
			ELSE P.Color
		END AS [NEW COLOR],
		SUM(SOD.LineTotal) AS [REVENUE]
FROM SalesLT.SalesOrderDetail SOD 
	JOIN SalesLT.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
WHERE (YEAR(SOH.DueDate) = 2017)
GROUP BY P.Name, P.Color, SOD.LineTotal
ORDER BY CASE
			WHEN P.Color IS NULL THEN 'Multi'
			WHEN P.Color = 'No Colour' THEN 'Multi'
			ELSE P.Color
		END, SOD.LineTotal DESC

--Answer
SELECT CASE
		WHEN P.Color IS NULL THEN 'Multi'
		WHEN P.Color = 'No Colour' THEN 'Multi'
		ELSE P.Color
	END AS [NEW COLOR],
	SUM(SOD.LineTotal) AS [REVENUE]
FROM SalesLT.SalesOrderDetail SOD 
	JOIN SalesLT.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
WHERE (YEAR(SOH.DueDate) = 2017)
GROUP BY P.Color, SOD.LineTotal
ORDER BY SOD.LineTotal DESC

--RESOLVE
SELECT CASE
		WHEN P.Color IS NULL THEN 'Multi'
		WHEN P.Color = 'No Colour' THEN 'Multi'
		ELSE P.Color
	END AS [NEW COLOR],
	SUM(SOD.LineTotal) AS [REVENUE]
FROM SalesLT.SalesOrderDetail SOD 
	JOIN SalesLT.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
WHERE (YEAR(SOH.DueDate) = 2017)
GROUP BY P.Color, SOD.LineTotal
ORDER BY SOD.LineTotal DESC

--RESOLVE 2
SELECT CASE
		WHEN P.Color IS NULL THEN 'Multi'
		WHEN P.Color = 'No Colour' THEN 'Multi'
		ELSE P.Color
	END AS [NEW COLOR], SUM(SOD.LineTotal)
FROM SalesLT.SalesOrderDetail SOD 
	JOIN SalesLT.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
WHERE YEAR(SOH.OrderDate) = 2017
GROUP BY (CASE
		WHEN P.Color IS NULL THEN 'Multi'
		WHEN P.Color = 'No Colour' THEN 'Multi'
		ELSE P.Color
	END)
ORDER BY SUM(SOD.LineTotal) DESC

--RESOLVE3
SELECT CASE
		WHEN P.Color IS NULL THEN 'No Colour'
		ELSE P.Color
	END AS [NEW COLOR], ROUND(SUM(SOD.LineTotal),2)
FROM SalesLT.SalesOrderDetail SOD 
	JOIN SalesLT.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
WHERE YEAR(SOH.OrderDate) = 2017
GROUP BY CASE
		WHEN P.Color IS NULL THEN 'No Colour'
		ELSE P.Color
	END 
ORDER BY ROUND(SUM(SOD.LineTotal),2) DESC


--Q16
SELECT PC1.ProductCategoryID, PC1.Name, PC1.ParentProductCategoryID ,SUM(PC1.ProductCategoryID + LEN(PC1.Name) + PC1.ParentProductCategoryID + ParentSubCatCount) AS answerToSubmit
FROM SalesLT.ProductCategory PC1, 
	(SELECT PC2.Name, COUNT(PC2.ParentProductCategoryID) AS [ParentSubCatCount]
	FROM SalesLT.ProductCategory PC2
	GROUP BY PC2.Name
	) ParentSubCatCount
WHERE PC1.ParentProductCategoryID IS NOT NULL
GROUP BY PC1.ProductCategoryID, PC1.Name, PC1.ParentProductCategoryID
HAVING PC1.ProductCategoryID > 1000


--RESOLVE
SELECT PC1.ProductCategoryID, PC1.Name, PC1.ParentProductCategoryID ,SUM(PC1.ProductCategoryID + LEN(PC1.Name) + PC1.ParentProductCategoryID + ParentSubCatCount) AS answerToSubmit
FROM SalesLT.ProductCategory PC1, 
	(SELECT COUNT(ParentProductCategoryID) AS [ParentSubCatCount]
	FROM SalesLT.ProductCategory
	WHERE ProductCategoryID > 1000
	) ParentSubCatCount
WHERE PC1.ParentProductCategoryID IS NOT NULL
GROUP BY PC1.ProductCategoryID, PC1.Name, PC1.ParentProductCategoryID
HAVING PC1.ProductCategoryID > 1000

--SELECT COUNT(ParentProductCategoryID) AS [ParentSubCatCount] FROM SalesLT.ProductCategory WHERE ProductCategoryID > 1000

--ANSWER

SELECT SUM(ProductCatagoryID) + LEN(ProductCategoryName) + ParentProductCategoryID + ParentSubCatCount AS answerToSubmit
FROM (
	SELECT PC1.ProductCategoryID AS [ProductCatagoryID], PC1.Name AS [ProductCategoryName], PC1.ParentProductCategoryID AS [ParentProductCategoryID], SUB.ParentSubCatCount
	FROM SalesLT.ProductCategory PC1
		LEFT JOIN (
			SELECT ParentProductCategoryID, COUNT(ProductCategoryID) AS [ParentSubCatCount]
			FROM SalesLT.ProductCategory 
			WHERE ParentProductCategoryID IS NOT NULL
			GROUP BY ParentProductCategoryID
		) SUB ON PC1.ParentProductCategoryID = SUB. ParentProductCategoryID
	WHERE PC1.ProductCategoryID > 1000
) q16



--Q17
SELECT C.CustomerID, SUM(LineTotal)
FROM SalesLT.SalesOrderHeader SOH 
	JOIN SalesLT.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
	JOIN SalesLT.Customer C ON SOH.CustomerID = C.CustomerID
GROUP BY C.CustomerID
HAVING SUM(LineTotal) > 34118.5356

--2
SELECT C.CustomerID, SUM(SubTotal), SUM(TaxAmt), SUM(Freight)
FROM SalesLT.SalesOrderHeader SOH 
	JOIN SalesLT.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
	LEFT JOIN SalesLT.Customer C ON SOH.CustomerID = C.CustomerID
GROUP BY C.CustomerID
HAVING SUM(SubTotal) - SUM(TaxAmt) - SUM(Freight)> 34118.5356


--RESOLVE
SELECT C.CustomerID, SUM(SOH.TotalDue) - SUM(SOH.TaxAmt) - SUM(SOH.Freight) AS [NEW]
FROM SalesLT.SalesOrderHeader SOH 
	JOIN SalesLT.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
	JOIN SalesLT.Customer C ON SOH.CustomerID = C.CustomerID
GROUP BY C.CustomerID
HAVING SUM(SOH.TotalDue) - SUM(SOH.TaxAmt) - SUM(SOH.Freight) < 34118.5356

--pr
SELECT CASE
			WHEN SOH.TotalDue IS NULL THEN '0.00'
			ELSE SOH.TotalDue
		END AS [TOTAL], (SUM(SOH.TotalDue) - SUM(SOH.TaxAmt) - SUM(SOH.Freight)) AS [NEW]
FROM SalesLT.SalesOrderHeader SOH 
	JOIN SalesLT.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
	FULL JOIN SalesLT.Customer C ON SOH.CustomerID = C.CustomerID
GROUP BY CASE
			WHEN SOH.TotalDue IS NULL THEN '0.00'
			ELSE SOH.TotalDue
		END
HAVING SUM(SOH.TotalDue) - SUM(SOH.TaxAmt) - SUM(SOH.Freight) < 34118.5356 OR ((SUM(SOH.TotalDue) - SUM(SOH.TaxAmt) - SUM(SOH.Freight)) IS NULL)

--ANSWER
SELECT C.CustomerID, SUM(CASE
							WHEN SOH.SalesOrderID IS NULL THEN 0
							ELSE SubTotal
						END) AS [SUB TOTAL]
FROM SalesLT.Customer C
	LEFT JOIN SalesLT.SalesOrderHeader SOH ON C.CustomerID = SOH.CustomerID
GROUP BY C.CustomerID
HAVING SUM(CASE
				WHEN SOH.SalesOrderID IS NULL THEN 0
				ELSE SubTotal
			END) < 34118.5356


--Q18
SELECT P.ProductID, P.Name, PC.Name, A.StateProvince
FROM SalesLT.SalesOrderDetail SOD
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
	JOIN SalesLT.ProductCategory PC ON P.ProductCategoryID = PC.ProductCategoryID
	JOIN SalesLT.SalesOrderHeader SOH ON SOH.SalesOrderID = SOD.SalesOrderID
	JOIN SalesLT.CustomerAddress CA ON CA.CustomerID = SOH.CustomerID
	JOIN SalesLT.Address A ON A.AddressID = CA.AddressID
WHERE A.StateProvince = 'Quebec' AND PC.Name LIKE '%Bikes%'

--PRAC

SELECT P.ProductID, P.Name, PC.Name, PPC.Name
FROM SalesLT.SalesOrderDetail SOD
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
	JOIN SalesLT.ProductCategory PC ON P.ProductCategoryID = PC.ProductCategoryID
	JOIN SalesLT.ProductCategory PPC ON PC.ParentProductCategoryID = PPC.ProductCategoryID
	JOIN SalesLT.SalesOrderHeader SOH ON SOH.SalesOrderID = SOD.SalesOrderID
	JOIN SalesLT.CustomerAddress CA ON CA.CustomerID = SOH.CustomerID
	JOIN SalesLT.Address A ON A.AddressID = CA.AddressID
WHERE PPC.Name = 'Components' AND  A.StateProvince = 'Quebec' 


--Q19
SELECT SOH.SalesOrderID, SUM(SOH.Freight) AS [TOTAL OF FREIGHT]
FROM SalesLT.SalesOrderDetail SOD
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
	JOIN SalesLT.SalesOrderHeader SOH ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.SalesOrderID 
ORDER BY SUM(SOH.Freight) DESC


--RESOLVE
SELECT SOD.ProductID ,SUM(SOH.Freight) AS [TOTAL OF FREIGHT]
FROM SalesLT.SalesOrderDetail SOD
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
	JOIN SalesLT.SalesOrderHeader SOH ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOD.ProductID
ORDER BY SUM(SOH.Freight) DESC

--PRA
SELECT SOD.ProductID ,SUM(SOH.Freight) AS [TOTAL OF FREIGHT]
FROM SalesLT.SalesOrderDetail SOD
	FULL JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
	JOIN SalesLT.SalesOrderHeader SOH ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOD.ProductID
ORDER BY SUM(SOH.Freight) DESC



SELECT P.Name, SUM(SOH.Freight) AS [TOTAL OF FREIGHT]
FROM SalesLT.Product P
	FULL JOIN SalesLT.SalesOrderDetail SOD ON P.ProductID = SOD.ProductID
	JOIN SalesLT.SalesOrderHeader SOH ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY P.Name
ORDER BY SUM(SOH.Freight) DESC


SELECT SOD.SalesOrderID,SUM(SOH.Freight) AS [TOTAL OF FREIGHT]
FROM SalesLT.SalesOrderDetail SOD
	FULL JOIN SalesLT.SalesOrderHeader SOH ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOD.SalesOrderID
ORDER BY SUM(SOH.Freight) DESC


--RE
SELECT SOD.SalesOrderID,SUM(SOH.Freight) AS [TOTAL OF FREIGHT]
FROM SalesLT.SalesOrderDetail SOD
	FULL JOIN SalesLT.Product P ON P.ProductID = SOD.ProductID
	FULL JOIN SalesLT.SalesOrderHeader SOH ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOD.SalesOrderID
ORDER BY SUM(SOH.Freight) DESC

--ANSWER
SELECT SOD.SalesOrderID, SOH.Freight/SUM(SOD.OrderQty) AS [TOTAL OF FREIGHT]
FROM SalesLT.SalesOrderHeader SOH
	JOIN SalesLT.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOD.SalesOrderID, SOH.Freight
ORDER BY SOH.Freight/SUM(SOD.OrderQty) DESC


--Q20
SELECT P.ProductID, SUM(SOD.OrderQty)
FROM SalesLT.SalesOrderDetail SOD
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
	JOIN SalesLT.SalesOrderHeader SOH ON SOH.SalesOrderID = SOD.SalesOrderID
WHERE SOH.OrderDate <= '2017-07-31' AND P.SellEndDate IS NOT NULL AND P.DiscontinuedDate IS NULL
GROUP BY P.ProductID
HAVING SUM(SOD.OrderQty) > 39

--RESOLVE
SELECT SOD.ProductID, SUM(SOD.OrderQty)
FROM SalesLT.SalesOrderDetail SOD
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
	JOIN SalesLT.SalesOrderHeader SOH ON SOH.SalesOrderID = SOD.SalesOrderID
WHERE (SOH.OrderDate < '2017-08-01' AND P.SellStartDate < '2017-08-01') AND (P.SellEndDate IS NULL AND P.DiscontinuedDate IS NULL)
GROUP BY SOD.ProductID
HAVING SUM(SOD.OrderQty) > 39


SELECT SOD.ProductID, SUM(SOD.OrderQty)
FROM SalesLT.SalesOrderDetail SOD
GROUP BY SOD.ProductID


SELECT *
FROM SalesLT.Product


SELECT SOD.ProductID, SOH.OrderDate, SellStartDate, SellEndDate, DiscontinuedDate
FROM SalesLT.SalesOrderDetail SOD
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
	JOIN SalesLT.SalesOrderHeader SOH ON SOH.SalesOrderID = SOD.SalesOrderID
WHERE (SOH.OrderDate < '2017-08-01' AND P.SellStartDate < '2017-08-01') AND (P.SellEndDate IS NULL AND P.DiscontinuedDate IS NULL)



--LAST
SELECT P.ProductID, SUM(SOD.OrderQty)
FROM SalesLT.SalesOrderDetail SOD
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
	JOIN SalesLT.SalesOrderHeader SOH ON SOH.SalesOrderID = SOD.SalesOrderID
WHERE SOH.OrderDate <= '2017-07-31'
		AND P.SellStartDate <= '2017-07-31' 
		AND (P.SellEndDate IS NULL OR P.SellEndDate > '2017-07-31')
		AND (P.DiscontinuedDate IS NULL OR P.DiscontinuedDate > '2017-07-31')
GROUP BY P.ProductID
HAVING SUM(SOD.OrderQty) > 39

