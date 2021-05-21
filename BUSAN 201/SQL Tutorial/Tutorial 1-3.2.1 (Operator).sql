--3.2.1 Operator exercise
--a)
SELECT SubTotal + TaxAmt + Freight AS [Total due amount]
FROM SalesLT.SalesOrderHeader

--b)
SELECT (TaxAmt / SubTotal) * 100 AS [The percentage of the tax in sub total]
FROM SalesLT.SalesOrderHeader

--c)
SELECT LastName + ', ' + FirstName + '.' AS [Full name]
FROM SalesLT.Customer

--d)
SELECT PostalCode + 'X' AS [New Postal code]
FROM SalesLT.Address

--e)
--SELECT PostalCode AS [Postal code]
--FROM SalesLT.Address

SELECT PostalCode + 'X' AS [New Postal code]
FROM SalesLT.Address
WHERE PostalCode NOT LIKE '%[A-Za-z]%' -- very useful when dealing with execption %element%

--f)
SELECT '1' + PostalCode AS [New Postal code]
FROM SalesLT.Address
WHERE PostalCode NOT LIKE '%[A-Za-z]%'

--g)
SELECT '1' + PostalCode AS [New Postal code]
FROM SalesLT.Address
WHERE PostalCode LIKE '%[A-Za-z]%'

--h)
--we cannot append number 1 to post code because the data type of post code is nvarchar which is not int value
SELECT 1 + PostalCode AS [New Postal code]
FROM SalesLT.Address
WHERE PostalCode NOT LIKE '%[A-Za-z]%'
--error example
--Conversion failed when converting the nvarchar value '97015-6403' to data type int.
--But we can use CAST function
SELECT 1 +  CAST(PostalCode AS int) AS [New Postal code]
FROM SalesLT.Address
WHERE PostalCode NOT LIKE '%[A-Za-z]%'

--need to fix it soon


--i)
SELECT LineTotal - (UnitPrice * UnitPriceDiscount) AS [Line total exclude discount]
FROM SalesLT.SalesOrderDetail
ORDER BY LineTotal DESC


--Answer
SELECT *
FROM SalesLT.SalesOrderDetail
ORDER BY LineTotal - (UnitPrice * UnitPriceDiscount) DESC

