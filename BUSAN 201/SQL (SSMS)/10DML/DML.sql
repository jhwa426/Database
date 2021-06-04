-- 1. DML

-- Prerequisite: download "03-ProductCostPriceHistory-random-generator.sql" from Canvas modules and open it in SSMS
-- by using the menu: File > Open > File ... > (choose the file and click) Open ;
-- Execute the script to add the table SalesLT.ProductCostPriceHistory to AdventureWorksLT2012 database;
-- We will use this database to demonstrate the DML examples

-- 1.1. INSERT
-- In SSMS, right-click any table in AdventureWorksLT2012 > Script Table as > INSERT TO > New Query Editor Window ;
-- This generates a template for writing an INSERT statement.
-- In SSMS, right-click any table in AdventureWorksLT2012 > Edit Top 200 Rows (or Top n rows).
-- This generates a visual editor that allows you to insert rows without writing SQL queries.

-- There are two main types of inserts: 
-- 1.1.1. values of rows are specified explicitly

-- Syntax: INSERT INTO table_name VALUES (value1, value2, value3, ...)
-- When you provide values for all the columns in the table in the default order of columns
INSERT INTO [SalesLT].[ProductCostPriceHistory]
VALUES ('2AF7F488-B796-4FC7-82B4-7790793FC510', 680, 1.0, 2.0, NULL)

INSERT INTO [SalesLT].[ProductCostPriceHistory]
VALUES
    (NEWID(), 700, 1.0, 2.0, NULL)

INSERT INTO [SalesLT].[ProductCostPriceHistory]
	(ProductID,ListPrice,StandardCost)
VALUES
    (700, 1.0, 2.0)

INSERT INTO [SalesLT].[ProductCostPriceHistory]
VALUES
    ('CA9990B1-49E5-4CA6-8EE3-284417A9F0ED', 680, 1.0, 2.0, NULL),
    ('C6E0C6B2-54DC-4F11-9940-AA9F8234F45A', 680, 1.0, 2.0, '2017-12-31')

-- Syntax: INSERT INTO table_name VALUES (value1, value2, value3, ...)
-- When you provide values for some columns in the table
INSERT INTO [SalesLT].[ProductCostPriceHistory]
	(ProductID, CostPriceHistoryID, ListPrice, StandardCost) --EndDate not specified (END DATE IS NULL)
VALUES (680, 'E9DA6030-28BA-47AE-8F36-DAA9F31CB070', 2.0, 1.0)

-- 1.1.2. values of rows are given by a SELECT statement (essentially a sub-query)

INSERT INTO [SalesLT].[ProductCostPriceHistory]
SELECT NEWID(), ProductID,ListPrice,StandardCost, SellEndDate
FROM SalesLT.Product
WHERE Weight <150

-- 1.2. UPDATE
-- In SSMS, right-click any table in AdventureWorksLT2012 > Script Table as > UPDATE TO > New Query Editor Window ;
-- This generates a template for writing an UPDATE statement.
-- Note a WHERE clause is automatically added to the template.
-- In SSMS, right-click any table in AdventureWorksLT2012 > Edit Top 200 Rows (or Top n rows).
-- This generates a visual editor that allows you to update rows without writing SQL queries.

UPDATE [SalesLT].[ProductCostPriceHistory]
SET
    ListPrice = 77.0,
    EndDate = NULL
WHERE CostPriceHistoryID = '8c8a28ad-3e48-48df-82d1-022deb2f48a3'

-- Check update
SELECT *
FROM [SalesLT].[ProductCostPriceHistory]
WHERE CostPriceHistoryID = '8c8a28ad-3e48-48df-82d1-022deb2f48a3'

-- 1.3. DELETE
-- Everytime you DELETE, transaction log will record your action (Management -> SQL Server Logs)
-- In SSMS, right-click any table in AdventureWorksLT2012 > Script Table as > DELETE TO > New Query Editor Window ;
-- This generates a template for writing a DELETE statement.
-- Note a WHERE clause is automatically added to the template.
-- In SSMS, right-click any table in AdventureWorksLT2012 > Edit Top 200 Rows (or Top n rows).
-- This generates a visual editor that allows you to delete rows without writing SQL queries.

DELETE [SalesLT].[ProductCostPriceHistory]
WHERE CostPriceHistoryID = '8c8a28ad-3e48-48df-82d1-022deb2f48a3'

-- Check deletion
SELECT *
FROM [SalesLT].[ProductCostPriceHistory]
WHERE CostPriceHistoryID = '8c8a28ad-3e48-48df-82d1-022deb2f48a3'

-- TRUNCATE
-- Removes all rows from a table or specified partitions of a table, 
-- without logging the individual row deletions. 
-- TRUNCATE TABLE is similar to the DELETE statement with no WHERE clause; 
-- however, TRUNCATE TABLE is faster and uses fewer system and transaction log resources

TRUNCATE TABLE SalesLT.ProductCostPriceHistory