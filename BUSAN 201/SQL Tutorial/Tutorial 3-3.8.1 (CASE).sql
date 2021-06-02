--3.8.1 CASE exercise
--a)
SELECT ProductID, Name, Size,
		CASE
			WHEN Size = 'S' THEN 'Small'
			WHEN Size = 'M' THEN 'Medium'
			WHEN Size = '%L'  THEN 'Big size'
			WHEN Size IS NULL THEN '0'
		END AS [NEW SIZE]
FROM SalesLT.Product

--ANSWER
SELECT ProductID, Name, Size,
		CASE
			WHEN Size IS NULL THEN '0'
			ELSE Size
		END AS [NEW SIZE]
FROM SalesLT.Product

--b)
--i)
SELECT CASE WHEN SubTotal >= 10000.00 THEN 1
	ELSE 0
	END AS [ApprovalNeeded]
FROM SalesLT.SalesOrderHeader

--ii)
SELECT CASE WHEN SubTotal >= 10000.00 THEN 1
	ELSE 0
	END AS [ApprovalNeeded], COUNT(*)
FROM SalesLT.SalesOrderHeader
GROUP BY CASE
			WHEN SubTotal >= 10000.00 THEN 1
			ELSE 0
		END

--c)
SELECT SalesOrderID,
	SUM(CASE WHEN UnitPriceDiscount <> 0 THEN 1
	ELSE 0
	END) AS [unitsOnDiscount],
	SUM(CASE WHEN UnitPriceDiscount = 0 THEN 1
	ELSE 0
	END) AS [unitsNOTOnDiscount]
FROM SalesLT.SalesOrderDetail
GROUP BY SalesOrderID
ORDER BY SalesOrderID

--PRAC
SELECT SalesOrderID,
	SUM(CASE WHEN UnitPriceDiscount > 0.00 THEN 1
	ELSE 0
	END) AS [unitsOnDiscount],
	SUM(CASE WHEN UnitPriceDiscount = 0.00 THEN 1
	ELSE 0
	END) AS [unitsNOTOnDiscount]
FROM SalesLT.SalesOrderDetail
GROUP BY SalesOrderID
ORDER BY SalesOrderID
