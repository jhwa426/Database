-- 3. Use WHERE Clause to filter rows that specify specified search conditions

-- 3.1. Filter rows by using a simple equality expression
SELECT
	CustomerID, 
	FirstName
FROM SalesLT.Customer
WHERE FirstName = 'Donna';

-- SQL server is by default case insensitive but it is possible to configure certain columns to be case sensitive
SELECT
	CustomerID, 
	FirstName
FROM SalesLT.Customer
WHERE FirstName = 'dOnNa';

-- 3.2. Filter rows by using a comparisn operator 
SELECT
    CustomerID, 
    FirstName
FROM SalesLT.Customer
WHERE CustomerID >= 29847;

SELECT
    CustomerID, 
    FirstName,
    LastName,
    ModifiedDate
FROM SalesLT.Customer
WHERE ModifiedDate < '2005-08-01'

-- Note: when comparing with NULL value, use IS NULL or IS NOT NULL instead of comparison operators
SELECT CustomerID, Title, FirstName, LastName
FROM SalesLT.Customer
WHERE Title IS NULL

-- 3.3. Filter rows that contain a value as part of a string
-- LIKE determines whether a specific character string matches a specified pattern.
-- A pattern is a string with wildcards (symbols to replace or represent one or more characters).

-- 3.3.1. Use LIKE with the % wildcard character
-- % represent any string with zero or more characters
-- The example below retrieves the CustomerID and FirstName of a Customer whose FirstName starts with "d".
SELECT
    CustomerID, 
    FirstName
FROM SalesLT.Customer
WHERE FirstName LIKE 'D%' 

-- The example below retrieves the CustomerID and FirstName of a Customer whose FirstName ends with "d".
SELECT
    CustomerID, 
    FirstName
FROM SalesLT.Customer
WHERE FirstName LIKE '%D' 

-- 3.3.2. Use LIKE with the _ wildcard character
-- _ represents any single character
-- The example below retrieves the CustomerID and FirstName of a Customer whose FirstName's second to third characters are "on"
SELECT
    CustomerID, 
    FirstName
FROM SalesLT.Customer
WHERE FirstName LIKE '_on%' 

-- 3.3.3. Use LIKE with the [] wildcard characters
-- [] any single character within the specified range
-- The example below retrieves the CustomerID and FirstName of a Customer whose FirstName's second character is "o" and
-- third character is either "b" or "n"; the third character is also the ending character of FirstName.
SELECT
    CustomerID, 
    FirstName
FROM SalesLT.Customer
WHERE FirstName LIKE '_o[bn]'

-- 3.3.4. Use NOT LIKE with wildcard characters
-- The example below retrieves the CustomerID and FirstName of a Customer whose FirstName doesn't start with "L".
SELECT 
	CustomerID,
	FirstName
FROM [SalesLT].[Customer]
WHERE FirstName NOT LIKE 'L%'

-- 3.4. Use common logical operators AND, OR and NOT
-- Refer to the basic boolean algebra truth table on Slide 29

-- 3.4.1. AND: the first condition AND the second condition must be true to return a value
SELECT CustomerID, Title, FirstName, LastName
FROM [SalesLT].[Customer]
WHERE Title NOT LIKE 'ms.' AND LastName LIKE 'h%' 
 
-- 3.4.2. OR: either the first condition can be true OR the second condition can be true and a value will be returned
-- Brackets are not necessary here. 
-- Refer to Slide 31 for operator precedence: BEDMAS then comparison operators then NOT then AND then OR 
SELECT CustomerID
FROM SalesLT.Customer
WHERE (CustomerID = 1) OR (CustomerID > 30000) 

-- 3.5. Use other logical operators

-- 3.5.1. BETWEEN AND: specify a range to test (inclusive)
SELECT CustomerID, Title, FirstName, LastName
FROM SalesLT.Customer
WHERE CustomerID BETWEEN 20000 AND 30000 

-- 3.5.2. NOT LIKE
-- The example below selects the customers who do not have the title Ms. OR Mr. 
SELECT CustomerID, Title, FirstName, LastName
FROM SalesLT.Customer
WHERE Title NOT LIKE 'ms.' AND Title NOT LIKE 'mr.'

-- Note the use of AND, what happens if you use OR?
SELECT CustomerID, Title, FirstName, LastName
FROM SalesLT.Customer
WHERE Title NOT LIKE 'ms.' OR Title NOT LIKE 'mr.'

-- 3.5.3. Operator precedence
-- Refer to Slide 31 for operator precedence: BEDMAS then comparison operators then NOT then AND then OR 

-- How to select the customers who either have the title Ms. or Mr. and also have a cutomer id in the range of 20000 to 30000?
-- Does the query below give your required result? 
-- Note how operator precedence means that for customer with id 1 the where condition is evaluated as ((F) AND F) OR T = F OR T = T
SELECT CustomerID, Title, FirstName, LastName
FROM SalesLT.Customer
WHERE (CustomerID BETWEEN 20000 AND 30000) AND Title LIKE 'ms.' OR Title LIKE 'mr.'

-- Use brackets to set the proper precedence 
SELECT CustomerID, Title, FirstName, LastName
FROM SalesLT.Customer
WHERE (CustomerID BETWEEN 20000 AND 30000) AND (Title LIKE 'ms.' OR Title LIKE 'mr.')

-- When comparing with NULL value, use IS NULL or IS NOT NULL instead of comparison operators
SELECT CustomerID, Title, FirstName, LastName, Suffix
FROM SalesLT.Customer
WHERE Title IS NOT NULL AND Suffix IS NULL
 
-- 3.5.4. IN determines whether a specified value matches any value in a subquery or a list.
-- The example below selects the rows where CustomerID lies in the list (100, 200, 300, 400)
SELECT *
FROM SalesLT.Customer
WHERE CustomerID IN (100, 200, 300, 400)

-- The example below selects the rows where CustomerID lies in the subquery
SELECT *
FROM SalesLT.Customer
WHERE CustomerID IN (
    SELECT CustomerID
    FROM SalesLT.SalesOrderHeader --this is a sub-query
	)