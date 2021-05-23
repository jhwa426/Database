-- 4. Use Scalar Functions to transform input values into a single output value

-- 4.1. String functions

-- UPPER(): returns a character expression with lowercase character data converted to uppercase.
-- LOWER(): returns a character expression after converting uppercase character data to lowercase.
SELECT TOP 10
    UPPER(FirstName),
    LOWER(FirstName),
    FirstName
FROM SalesLT.Customer

SELECT Firstname
FROM SalesLT.Customer
WHERE LOWER(FirstName) LIKE '%donna%'

-- LEN(): returns the number of characters of the specified string expression, excluding trailing spaces.

-- SUBSTRING ( expression ,start , length ): 
-- Returns part of a character expression; 
-- start denotes where the returned characters start 
-- (the numbering is 1 based, meaning that the first character in the expression is 1); 
-- length denotes how many characters of the expression will be returned.

-- REPLACE ( string_expression , string_pattern , string_replacement ) 
-- Replaces all occurrences of a specified string value with another string value; 
-- string_expression is the string to be searched; 
-- string_pattern is the substring to be found (cannot be an empty string); 
-- string_replacement is the replacement string.

SELECT
    sub.[TheText] AS [original text], -- the . retreive the columns from the resultset that the sub query called [sub]
    LEN([TheText]) AS [length], -- inclusive of spaces
    SUBSTRING([TheText], 7, 10) AS [substring example], -- start from position 7, extract 10 characters
    REPLACE([TheText], 'an', 'X') AS [replace example],
    UPPER(SUBSTRING([TheText], 7, 10)) AS [nested example],
    REPLACE(LOWER([TheText]), 'AN', 'x') AS [nested example]
FROM (SELECT 'Busan 201: Data Management' AS [TheText]) AS [sub] --this is a sub-query

-- REVERSE(): returns the reverse order of a string value.
SELECT TOP 5 REVERSE(FirstName)
FROM [SalesLT].[Customer];

-- CHARINDEX ( expressionToFind , expressionToSearch [ , start_location ] )
-- This function searches for one character expression inside a second character expression,
-- returning the starting position of the first expression if found;
-- start_location denotes where the search starts (if not specified/negatie/zero, search starts at the beginning).

-- The example below returns the position of 'a' in the first  names
SELECT CHARINDEX('a', FirstName), FirstName 
FROM [SalesLT].[Customer]

-- The example below returns the starting position of 'an' in the first  names
SELECT CHARINDEX('an', FirstName), FirstName 
FROM [SalesLT].[Customer]

-- The example below returns the starting position of 'in' in the first names but only start searching from position 3 onwards
SELECT CHARINDEX('in', FirstName, 3), FirstName 
FROM [SalesLT].[Customer]

-- Use nested functions to process strings
SELECT EmailAddress, SUBSTRING (EmailAddress, CHARINDEX('@',EmailAddress) + 1, LEN(EmailAddress))
FROM [SalesLT].[Customer]

-- CONCAT(): returns a string resulting from the concatenation of two or more string values in an end-to-end manner.
SELECT CustomerID, LEN(CONCAT(Title, FirstName,LastName)) AS [name length], CONCAT(Title, FirstName,LastName)
FROM [SalesLT].[Customer]
WHERE LEN(CONCAT(Title, FirstName,LastName)) >20

SELECT CustomerID, LEN(CONCAT(Title, FirstName,LastName)) AS [name length], CONCAT(Title, FirstName,LastName)
FROM [SalesLT].[Customer]
WHERE LEN(Title + FirstName +LastName) > 20


-- TRIM ( [ characters FROM ] string ): removes the space character or other specified characters from the start and end of a string.
-- If your server version is before 2017 (ver13.x), then TRIM() is not a built-in function in SQL Server.
-- Thus, you need to use LTRIM() and RTRIM() instead.
-- If your server version is after 2017 (ver14.x), you can directly use TRIM().
-- Non - exam

SELECT CustomerID, LEN(CONCAT(TRIM('.'FROM Title),TRIM(FirstName), TRIM(LastName))) AS [name length], CONCAT(TRIM('.'FROM Title),TRIM(FirstName), TRIM(LastName))
FROM [SalesLT].[Customer]
WHERE LEN(CONCAT(TRIM('.'FROM Title),TRIM(FirstName), TRIM(LastName))) >20


-- 4.2. Use scalar mathematic functions

-- ABS(): return the absolute value
SELECT ABS (-2.0)

-- MAX(), MIN(): return the maximum /minimum value
SELECT MAX(TaxAmt)  --min
FROM [SalesLT].[SalesOrderHeader]

-- ROUND ( numeric_expression , length [ ,function ] ) 
-- Returns a numeric value, rounded to the specified length or precision.
-- When length is a positive number, numeric_expression is rounded to the number of decimal places specified by length.
-- When length is a negative number, numeric_expression is rounded on the left side of the decimal point as specified by length.
-- function specifies the type of operation. When function is omitted or is zero (default), numeric_expression is rounded.
-- When a value other than 0 is specified, numeric_expression is truncated.

-- The example below shows when the third argument is 0 it is rounding
SELECT ROUND(235.416, 2, 0)  

-- The example below shows when the third argument is anything other than 0 it is truncating
SELECT ROUND(235.416, 2, 1)

-- RAND ( [ seed ] ) returns a pseudo-random float value from 0 through 1, exclusive.

-- The example below generates a random number between 0 and 1
SELECT RAND(); 

-- The example below sets the seed number. For any given seed value, the results will always be the same.
SELECT RAND(8);

-- COUNT() returns the number of rows
SELECT COUNT(customerId)
FROM SalesLT.Customer

-- 4.3. Use scalar date functions allow manipulation of dates, times, and datetimes:

-- CURRENT_TIMESTAMP returns the current database system timestamp as a datetime value, without the database time zone offset.
SELECT CURRENT_TIMESTAMP;

-- GETDATE() returns the current database system timestamp as a datetime value, without the database time zone offset.
SELECT GETDATE()

-- DAY(), MONTH(), YEAR(): returns an integer that represents the day/month/year of the specified date
SELECT DAY('2020-02-13')

SELECT MONTH('2020-02-13')

SELECT YEAR('2020-02-13')

-- nested functions
SELECT YEAR(GETDATE())

SELECT SalesOrderID
      ,OrderDate
      ,DueDate
      ,ShipDate
FROM SalesLT.SalesOrderHeader
WHERE GETDATE() >= DueDate OR GETDATE() <= ShipDate


-- 4.4 CAST is necessary to convert a value from one datatype to another
-- Syntax: CAST ( expression AS data_type [ ( length ) ] ) 

-- What will happen if we concatenate a string and a number?
-- Conversion fails because it tries to convert a string value to int
SELECT FirstName + ' ' + LastName + '''s customer ID is ' + CustomerID 
FROM SalesLT.Customer

-- Use cast to convert CustomerID from a number to string
SELECT FirstName + ' ' + LastName + '''s customer ID is ' + CAST(CustomerID AS VARCHAR(10))
FROM SalesLT.Customer

-- What are the data type of Size and Weight?
SELECT [Name], Size+  Weight , Color AS description 
FROM SalesLT.Product

-- Null values can also cause problems
SELECT Name, Size, Weight,
	CAST(Size AS NVARCHAR(10)) + CAST(Weight AS NVARCHAR(10)), Color AS description
FROM SalesLT.Product

-- ISNULL ( check_expression , replacement_value ) is used to handle NULL values
-- ISNULL() replaces NULL with the specified replacement value.
SELECT Name,
    ISNULL(CAST(Size AS NVARCHAR(10)),' ') + ISNULL(CAST(Weight AS NVARCHAR(10)),' '), Color AS description 
FROM SalesLT.Product

-- COALESCE() evaluates the arguments in order and returns the current value of the first expression 
-- that initially doesn't evaluate to NULL.

-- The example below returns the first non-null value in the list
SELECT Name, 
	CAST(Size AS NVARCHAR(10)), CAST(Weight AS NVARCHAR(10)), Color AS description
FROM SalesLT.Product


SELECT Name,
    COALESCE(CAST(Size AS NVARCHAR(10)), CAST(Weight AS NVARCHAR(10)), Color, '') AS description
FROM SalesLT.Product

SELECT COALESCE(NULL,NULL,'AAA',NULL,NULL,'BBB',NULL,NULL)