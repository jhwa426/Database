--PRACTICE ASSIGNMENT
--Q1
SELECT COUNT(Color)
FROM SalesLT.Product
WHERE Color = 'Black' OR Color = 'Yellow'

--Q2
SELECT COUNT(ProductID)
FROM SalesLT.Product
WHERE Weight > 1500.00 AND ListPrice >= 846.44

--Q3
SELECT COUNT(Name)
FROM SalesLT.Product
WHERE Name LIKE '%Black%' OR Name LIKE '%Silver%'

--Q4
SELECT COUNT(*)
FROM SalesLT.Product
WHERE (Color = 'No Colour' OR Color = 'Multi' OR Color IS NULL) AND Weight IS NOT NULL AND Size IS NULL
--NO SINGLE COLOR means that including NULL value

--Q5
SELECT COUNT(*)
FROM SalesLT.Product
WHERE YEAR(SellStartDate) = 2005 AND (DiscontinuedDate IS NULL AND SellEndDate IS NULL)
--A NOR B 는 둘다 아닌것

--Q6
SELECT COUNT(*)
FROM SalesLT.Address A
	JOIN SalesLT.CustomerAddress CA ON A.AddressID = CA.AddressID
WHERE A.CountryRegion = 'Canada' AND (CA.AddressType = 'Billing' OR CA.AddressType = 'Shipping')

--Q7
SELECT C.CompanyName, SOH.SalesOrderNumber, SOD.SalesOrderDetailID, P.Name, PM.Name
FROM SalesLT.SalesOrderHeader SOH
	JOIN SalesLT.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
	JOIN SalesLT.Customer C ON SOH.CustomerID = C.CustomerID
	JOIN SalesLT.ProductModel PM ON P.ProductModelID = PM.ProductModelID
WHERE P.Name LIKE '%Tire%' AND P.Name NOT LIKE '%Tube%'
ORDER BY SOH.SalesOrderID ASC

--Q8
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
	FULL JOIN SalesLT.CustomerAddress CA ON A.AddressID = CA.AddressID
	FULL JOIN SalesLT.Customer C ON C.CustomerID = CA.CustomerID
WHERE A.CountryRegion = 'United Kingdom' AND C.CustomerID IS NULL
ORDER BY A.AddressID ASC

--Q10
SELECT COUNT(DISTINCT(SOH.CustomerID))
FROM SalesLT.SalesOrderHeader SOH
	JOIN SalesLT.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
	JOIN SalesLT.ProductCategory PC ON P.ProductCategoryID = PC.ProductCategoryID
WHERE PC.Name = 'Bike Stands' OR PC.Name = 'Tires and Tubes' OR PC.Name = 'Vests' OR PC.Name = 'Wheels'

--Q11
SELECT City, COUNT(AddressID) AS [Number of city]
FROM SalesLT.Address
GROUP BY City
ORDER BY COUNT(AddressID) DESC, City

--Q12
SELECT SalesOrderID, COUNT(ProductID) AS [TOTAL PRODUCT]
FROM SalesLT.SalesOrderDetail
GROUP BY SalesOrderID
HAVING COUNT(ProductID) > 9
--Diffrent product that is why I used COUNT

--Q13
SELECT SalesOrderID, SUM(OrderQty) AS [TOTAL QTY]
FROM SalesLT.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(OrderQty) >= 15
--UNIT = quentity, it is asking at least 15 units then calculte total qty depends on salesorderID

--Q14
SELECT SUM(P.Weight*SOD.OrderQty)
FROM SalesLT.SalesOrderDetail SOD 
	JOIN SalesLT.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
WHERE ((YEAR(SOH.DueDate) = 2017) AND (MONTH(SOH.DueDate) = 7 OR MONTH(SOH.DueDate) = 11 OR MONTH(SOH.DueDate) = 1))
--The weight is for one unit and I had to multiple qty of the weight of product.

--Q15
SELECT CASE
			WHEN P.Color IS NULL THEN 'No Colour'
			ELSE P.Color
		END AS [NEW COLOUR], ROUND(SUM(SOD.LineTotal),2)
FROM SalesLT.SalesOrderDetail SOD
	JOIN SalesLT.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
WHERE YEAR(SOH.OrderDate) = 2017
GROUP BY CASE
			WHEN P.Color IS NULL THEN 'No Colour'
			ELSE P.Color
		END
ORDER BY ROUND(SUM(SOD.LineTotal),2) DESC

--Q17
SELECT C.CustomerID,
		SUM(CASE
			WHEN SOH.CustomerID IS NULL THEN '0.00'
			ELSE SOH.SubTotal
		END)
FROM SalesLT.Customer C
	LEFT JOIN SalesLT.SalesOrderHeader SOH ON C.CustomerID = SOH.CustomerID 
GROUP BY C.CustomerID
HAVING SUM(CASE
			WHEN SOH.CustomerID IS NULL THEN '0.00'
			ELSE SOH.SubTotal
		END) < 34118.35656

--Q19
SELECT SOD.SalesOrderID, SOH.Freight/SUM(SOD.OrderQty) AS [TOTAL OF FREIGHT]
FROM SalesLT.SalesOrderHeader SOH
	JOIN SalesLT.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOD.SalesOrderID, SOH.Freight
ORDER BY SOH.Freight/SUM(SOD.OrderQty) DESC
--Freight is imposed for one sales order. Therefore, we need to think about qty of product only. 

--Q20
SELECT P.ProductID, SUM(SOD.OrderQty)
FROM SalesLT.SalesOrderDetail SOD
	JOIN SalesLT.Product P ON SOD.ProductID = P.ProductID
	JOIN SalesLT.SalesOrderHeader SOH ON SOH.SalesOrderID = SOD.SalesOrderID
WHERE SOH.OrderDate <= '2017-07-31'
		AND P.SellStartDate <= '2017-07-31' --available product
		AND (P.SellEndDate IS NULL OR P.SellEndDate > '2017-07-31')
		AND (P.DiscontinuedDate IS NULL OR P.DiscontinuedDate > '2017-07-31')
GROUP BY P.ProductID
HAVING SUM(SOD.OrderQty) > 39