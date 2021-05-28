--3.6.1 Aggregate exercise
--a)
SELECT SUM(OrderQty)
FROM SalesLT.SalesOrderDetail

--b)
SELECT COUNT(CustomerID) AS [Total number of customer]
FROM SalesLT.Customer

--c)
SELECT COUNT(MiddleName) AS [Total number of customer's middle name]
FROM SalesLT.Customer

--d)
SELECT COUNT(MiddleName) AS [Total number of customer's middle name]
		,COUNT(Suffix) AS [Total number of Suffix]
FROM SalesLT.Customer

--e)
SELECT COUNT(DISTINCT City)
FROM SalesLT.Address

--EX)COUNT EACH CITY
SELECT City, COUNT(City) AS [Total number of city]
FROM SalesLT.Address
GROUP BY City

--f
SELECT COUNT(DISTINCT City + '|' + StateProvince + '|' + CountryRegion)
FROM SalesLT.Address

SELECT COUNT(DISTINCT City + StateProvince + CountryRegion)
FROM SalesLT.Address

--g)
SELECT CountryRegion, COUNT(CountryRegion)
FROM SalesLT.Address
GROUP BY CountryRegion


SELECT City, COUNT(City) AS [Total number of city], CountryRegion, COUNT(CountryRegion) AS [Total number of Country Region]
FROM SalesLT.Address
GROUP BY City, CountryRegion

--ANSWER
SELECT C.CustomerID, C.FirstName, C.LastName, COUNT(CA.AddressID) AS [Address Number]
FROM SalesLT.Customer C
	LEFT JOIN SalesLT.CustomerAddress CA ON C.CustomerID = CA.CustomerID --ALL CUSTOMERS
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY [Address Number] DESC
--ORDER BY COUNT(CA.AddressID) DESC

--h)
SELECT CountryRegion, COUNT(CountryRegion) AS [Total number of Country Region that are not assigned to a customer]
FROM SalesLT.Address A
	LEFT JOIN SalesLT.CustomerAddress CA ON A.AddressID = CA.AddressID
WHERE CA.CustomerID IS NULL
GROUP BY CountryRegion

--i)
SELECT LEFT(FirstName, 1) AS [letter], COUNT(LEFT(FirstName, 1)) AS [Count]
FROM SalesLT.Customer
GROUP BY LEFT(FirstName,1)
ORDER BY letter
--ORDER BY LEFT(FirstName, 1)

--METHOD 2
SELECT SUBSTRING(FirstName, 1, 1) AS [letter], COUNT(SUBSTRING(FirstName, 1, 1)) AS [Count]
FROM SalesLT.Customer
GROUP BY SUBSTRING(FirstName, 1, 1)
ORDER BY letter