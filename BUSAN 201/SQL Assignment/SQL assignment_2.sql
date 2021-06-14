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
SELECT *
FROM SalesLT.Product
WHERE (Color LIKE '%Multi%' OR Color LIKE '%No Colour%' OR Color IS NULL) AND (Weight IS NOT NULL) AND (Size IS NULL)

--Q5
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

--Q8
--Answer
SELECT SOD.SalesOrderID, P.Name, PD.Description, PMPD.Culture, PD.rowguid
FROM SalesLT.ProductModelProductDescription PMPD
	JOIN SalesLT.ProductDescription PD ON PMPD.ProductDescriptionID = PD.ProductDescriptionID
	JOIN SalesLT.ProductModel PM ON PMPD.ProductModelID = PM.ProductModelID
	JOIN SalesLT.Product P ON PM.ProductModelID = P.ProductModelID
	JOIN SalesLT.SalesOrderDetail SOD ON P.ProductID = SOD.ProductID
WHERE PMPD.Culture = 'en' AND SOD.UnitPriceDiscount = 0.00
ORDER BY SOD.SalesOrderDetailID ASC

--Q9
SELECT *
FROM SalesLT.Address A
	FULL OUTER JOIN SalesLT.CustomerAddress CA ON CA.AddressID = A.AddressID
	FULL OUTER JOIN SalesLT.Customer C ON CA.CustomerID = C.CustomerID
WHERE A.CountryRegion LIKE '%United Kingdom%' AND C.CustomerID IS NULL
ORDER BY A.AddressID ASC

--Q10)
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
ORDER BY COUNT(City) DESC, City

--Q12
SELECT SalesOrderID, COUNT(ProductID) AS [Number of product]
FROM SalesLT.SalesOrderDetail
GROUP BY SalesOrderID
HAVING COUNT(ProductID) > 9

--Q13
SELECT SalesOrderID, SUM(OrderQty) AS [Number of product]
FROM SalesLT.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(OrderQty) >= 15

--Q14
SELECT SUM(P.Weight * SOD.OrderQty) AS [TOTAL WEIGHT]
FROM SalesLT.SalesOrderDetail SOD 
	JOIN SalesLT.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
WHERE ((YEAR(SOH.DueDate) = 2017) AND (MONTH(SOH.DueDate) = 7 OR MONTH(SOH.DueDate) = 11 OR MONTH(SOH.DueDate) = 1)) AND SOH.ShipMethod = 'Unknown'

--Q15
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

--Method2
SELECT ISNULL(P.Color, 'No Colour') AS [NEW COLOR] ,ROUND(SUM(SOD.LineTotal),2) AS [TOTAL]
FROM SalesLT.SalesOrderDetail SOD 
	JOIN SalesLT.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
WHERE YEAR(SOH.OrderDate) = 2017
GROUP BY ISNULL(P.Color, 'No Colour')
ORDER BY ROUND(SUM(SOD.LineTotal),2) DESC

--Q16 (UNSOLVED)
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

--Q18 (UNSOLVED)




--Q19
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
WHERE SOH.OrderDate <= '2017-07-31'
		AND P.SellStartDate <= '2017-07-31' 
		AND (P.SellEndDate IS NULL OR P.SellEndDate > '2017-07-31')
		AND (P.DiscontinuedDate IS NULL OR P.DiscontinuedDate > '2017-07-31')
GROUP BY P.ProductID
HAVING SUM(SOD.OrderQty) > 39