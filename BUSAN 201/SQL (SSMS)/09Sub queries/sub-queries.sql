-- 3. Sub-queries
-- Divide & conquer: break down the task into small and manageable pieces

-- Subqueries can be specified in many places

-- 3.1. Example for using subquery in IN operator
-- Business purpose: Display all the details of sales orders where products which have a 
-- ListPrice less than or equals to 10 have been ordered, sorted in ascending order of 
-- sales orderid and product id
SELECT *
FROM SalesLT.SalesOrderDetail
WHERE ProductID IN (
					SELECT ProductID
					FROM SalesLT.Product
					WHERE ListPrice <= 10) -- subquery in the bracket -> higher precedence to execute
ORDER BY SalesOrderID, ProductID

-- The same query can also be written as a join
SELECT sod.*
FROM SalesLT.SalesOrderDetail sod
    JOIN SalesLT.Product p ON sod.ProductID = p.ProductID
WHERE p.ListPrice <= 10
ORDER BY SalesOrderID, ProductID

-- Note the execution plan for both queries is the same. 
-- This implies SQL Server knows to convert the sub-query into a join (which is generally more efficient).

-- 3.2. Example for using in FROM clause

-- 3.2.1 Example: consider the situation where manager approval is required for sales orders with SubTotals of at least $10,000.  
-- Write a query with a CASE expression which shows, for each order, whether approval is needed. 
-- If approval is needed then show the number 1, otherwise show 0 (zero).
SELECT 
    sub.ApprovalNeeded,
    COUNT(sub.SalesOrderID)
FROM (SELECT
            CASE
                WHEN SubTotal >= 10000 THEN 1
                ELSE 0
            END AS ApprovalNeeded,
            SalesOrderID
        FROM SalesLT.SalesOrderHeader) sub
GROUP BY sub.ApprovalNeeded


SELECT SUB.ApprovalNeeded, COUNT(SUB.SalesOrderID)
FROM (SELECT
			CASE
				WHEN SubTotal >= 10000 THEN 1
				ELSE 0
			END AS ApprovalNeeded, SalesOrderID
		FROM SalesLT.SalesOrderHeader) SUB
GROUP BY SUB.ApprovalNeeded



-- 3.2.2. Example: join onto a sub-query
-- Business purpose: Display the Sales order id and product id For all the products 
-- where sales started before the 1st of January 2007
SELECT SalesOrderID, P.ProductID
FROM SalesLT.SalesOrderDetail SOD INNER JOIN 
				(	SELECT ProductID
					FROM SalesLT.Product
					WHERE SellStartDate < '2007-01-01'
				) P
ON SOD.ProductID = P.ProductID



-- 3.3. Anywhere an expression is allowed
-- Business purpose: Select the product id, name and weight of all products 
-- which have a weight which is greater than the weight of the product with number 'FR-R92R-62'
SELECT ProductID, Name, Weight
FROM SalesLT.Product
WHERE Weight > (SELECT Weight
				FROM SalesLT.Product
				WHERE ProductNumber  = 'FR-R92R-62')


-- 3.4. Nested sub-queries: multiple sub-queries can be used together in one single SELECT query
-- CROSS JOIN: cartesian product of two tables
-- Example: 
SELECT 
	*,
    doge.so+very+much_nested+(SELECT CHAR(33)) AS [!]
FROM (
    SELECT WOW.so, sub.very, query.much_nested
    FROM
        (SELECT CHAR(87) AS so) WOW CROSS JOIN 
        (SELECT CHAR(111) AS very) sub CROSS JOIN
        (SELECT CHAR(119) AS much_nested) query
) doge

