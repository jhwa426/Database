--3.9.1 SET exercise
--a)
SELECT ProductID
FROM SalesLT.SalesOrderDetail
EXCEPT
SELECT ProductID
FROM SalesLT.Product

/*EXCEPT works similarly to UNION; it shows the rows resulted from the first SELECT statement but not the second one.
Are there any products customer ordered but we don't have it? (maybe because the data entry is incorrect)? */

SELECT ProductID
FROM SalesLT.Product
EXCEPT
SELECT ProductID
FROM SalesLT.SalesOrderDetail

--b)
--Prints without duplicate rows
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(Color) = 'RED'
UNION
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(SIZE) = 'M'
UNION
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(SIZE) = '62'
/* total rows of 3 sets: 60
total rows of result: 56
4 duplicate rows*/

--Prints with duplicate rows
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(Color) = 'RED'
UNION ALL
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(Size) = 'M'
UNION ALL
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(Size) = '62'

--c)
--Prints without duplicate rows
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(Color) = 'RED'
UNION
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(SIZE) = 'M'
UNION
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(SIZE) = '62'
UNION
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(Color) = 'BLACK'

--Prints with duplicate rows
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(Color) = 'RED'
UNION ALL
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(Size) = 'M'
UNION ALL
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(Size) = '62'
UNION ALL
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(Color) = 'BLACK'

--d)
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(Color) = 'BLACK'
UNION
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(Color) = 'WHITE'
INTERSECT
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(Size) = 'M'


SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(Color) = 'BLACK'
INTERSECT --  keep only rows in common to query 1 and query 2
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(Size) = 'M'
UNION -- combine rows from both queries
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(Color) = 'WHITE'

--e)
SELECT AddressID
FROM SalesLT.Address
EXCEPT
SELECT AddressID
FROM SalesLT.CustomerAddress

--f)	For two sets A and B, how can you use set operators to find all values which only exist in either A or B, but not in both? 
---I.e. you are finding the complement of A intersect B. See De Morgan’s law for set theory.
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(Color) = 'RED'
UNION 
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(Size) = '60' /*45 ROWS*/
EXCEPT 
SELECT ProductID, Color, Size
FROM SalesLT.Product
WHERE UPPER(Size) = '60' AND UPPER(Color) = 'RED'; /*41 ROWS*/