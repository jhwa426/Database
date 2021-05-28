-- 1. CASE Statement

-- It goes through the conditions in a sequential mode. 
-- The “WHEN” indicates a condition; “THEN” indicates the value to return if the corresponding condition is met. 
-- Once a condition is true, it will stop reading and return the result. 
-- If no conditions are true, it returns the value in the ELSE clause.


-- 1.1. Example: Display the product id, name, text description of size and the size recorded in the database 
-- for the first 20 products 
-- This is an example of "searched" type case statement
-- Syntax: 
-- CASE  
--     WHEN Boolean_expression THEN result_expression [ ...n ]   
--     [ ELSE else_result_expression ]   
-- END  

SELECT TOP 20
    ProductID
    ,Name
    ,CASE
        WHEN Size = 'S' THEN 'Small'
        WHEN Size = 'M' THEN 'Medium'
        WHEN Size LIKE '%L' THEN 'Biggish'
        ELSE 'Not any of the above'
     END AS [Text Description]
    ,Size --included for comparison
FROM SalesLT.Product

--PRAC)
SELECT
	ProductID
	,Name
	,CASE
		WHEN Size = 'XL' THEN 'My size'
		ELSE 'Not any of the above'
	END AS [COMMENT]
	,Size
FROM.SalesLT.Product
WHERE SIZE = 'XL'

-- This is another example using the "simple" type of case statement (NOT THE FOCUS OF COURSE)
-- "simple" type only have equality tests in the WHEN conditions.
SELECT TOP 20
    ProductID
    ,Name
    ,CASE Size
        WHEN  'S' THEN 'Small'
        WHEN 'M' THEN 'Medium'
        WHEN 'L' THEN 'Large'
		WHEN 'XL' THEN 'Extra Large'
        ELSE 'Other Sizes'
     END AS [Text Description]
    ,Size --included for comparison
FROM SalesLT.Product

-- 1.2. A CASE expression is unique in that it can appear in the middle of other expressions or clauses. 
-- It can look strange. 

-- Example: Display a text description of title and the frist and last names of the customers 
-- ordered by ascending order of customerID but displaying the female titles first by manipulating the customer ids

SELECT CASE 
	WHEN Title LIKE 'mr.' THEN 'Mister' 
	WHEN Title LIKE 'ms.'  THEN 'Miss'
	WHEN Title LIKE 'sr.'  THEN 'Señor'
	WHEN Title LIKE 'sra.'  THEN 'Señora'
	ELSE 'No Title'
END  AS Titles, FirstName,LastName 
FROM SalesLT.Customer
ORDER BY 
		CASE 
			WHEN Title LIKE 'ms.' THEN -1 * CustomerID
			WHEN Title LIKE 'sra.' THEN -1 * CustomerID -- manipulate the customer id for sorting
            ELSE CustomerID 
		END


-- Example: Display the product id, list price and a text categorisation of the list price 
-- ordered by ascending order of list price 
SELECT ProductID,[Name],ListPrice,
	CASE
		WHEN ListPrice >= 1 AND ListPrice <= 500 THEN 'Cheap'
		WHEN ListPrice > 501 AND ListPrice < 3000 THEN 'Higher price'
		ELSE 'Even higher price'
	END AS [price range]
FROM SalesLT.Product
ORDER BY ListPrice

-- So can we take one step further and count number of products under each text categorisation?

-- Example: Display a text categorisation of the list price and a count of products in each list price text category 
-- ordered by the count of products in each list price text category
SELECT 
	CASE
		WHEN ListPrice >= 1 AND ListPrice <= 500 THEN 'Cheap'
		WHEN ListPrice > 501 AND ListPrice < 3000 THEN 'Higher price'
		ELSE 'Even higher price'
	END AS [price range], 
	COUNT(*) [No of Products of each range]
FROM SalesLT.Product
GROUP BY 
	CASE
		WHEN ListPrice >= 1 AND ListPrice <= 500 THEN 'Cheap'
		WHEN ListPrice > 501 AND ListPrice < 3000 THEN 'Higher price'
		ELSE 'Even higher price'
	END
ORDER BY [No of Products of each range]


---------------------------------------------------------------------------------
--PRAC)
SELECT ProductID,[Name],ListPrice,
	CASE
		WHEN ListPrice >= 1 AND ListPrice <= 500 THEN 'Cheap'
		WHEN ListPrice > 501 AND ListPrice < 3000 THEN 'Higher price'
		ELSE 'Even higher price'
	END AS [Price range]
FROM SalesLT.Product

--PRAC2)
SELECT 
	CASE
		WHEN ListPrice >= 1 AND ListPrice <= 500 THEN 'Cheap'
		WHEN ListPrice > 501 AND ListPrice < 3000 THEN 'Higher price'
		ELSE 'Even higher price'
	END AS [Price range],
	COUNT(*) AS [No of Products of each range]
FROM SalesLT.Product
GROUP BY 
	CASE
		WHEN ListPrice >= 1 AND ListPrice <= 500 THEN 'Cheap'
		WHEN ListPrice > 501 AND ListPrice < 3000 THEN 'Higher price'
		ELSE 'Even higher price'
	END
ORDER BY [No of Products of each range]
---------------------------------------------------------------------------------



-- What is the business purpose of this query?
-- You can use CASE with calculation too
SELECT
    ProductID
    ,Name
    ,ListPrice --included for comparison
    ,ListPrice * CASE
                    WHEN Size = 'S' THEN 1
                    WHEN Size = 'M' THEN 2
					WHEN Size ='L' OR Size = 'XL' THEN 3
                    --WHEN Size LIKE '%L' THEN 3
                    ELSE 0
                 END AS [modified price]
FROM SalesLT.Product
WHERE Size IS NOT NULL
ORDER BY CASE
            WHEN Name LIKE '%S' THEN -1 * ProductID
            ELSE ProductID
         END ASC, ListPrice DESC

-- Display ProductID, product Name, list price and a modified list price for all products with Size. 
-- The price is modified based on Size: 
-- for S size, modified price = original list price; 
-- for M size, modified price = two times of original list price; 
-- for any kind of L size (XL/L), modified price = three times of original list price; 
-- for those with a numeric value of size, modified price becomes 0.
-- Finally, order the results by ascending order of ProductID but displaying those in S size first


--PRAC)
SELECT ProductID, Name, ListPrice, Size,
	ListPrice * CASE
					WHEN SIZE = 'S' THEN 1
					WHEN Size = 'M' THEN 2
					WHEN Size ='L' OR Size = 'XL' THEN 3
					ELSE 0
				END AS [Modified price]
FROM SalesLT.Product
WHERE Size IS NOT NULL
ORDER BY CASE
			WHEN Name LIKE '%S'THEN -1 * ProductID
			ELSE ProductID
		END ASC,ListPrice DESC