-- 2. Table DDL

-- The following example creates a temporary table, tests for its existence, 
-- drops it, and tests again for its existence. 
--This example does not use the IF EXISTS syntax which is available beginning with SQL Server 2016 (13.x)

-- A hash symblo (#) at the begining of the table name suggests that this is a temporary table
-- This temporary table is located at System Databases > tempdb > Temporary Tables
-- Note: SQL Server drops a temporary table automatically when you close the connection that created it

CREATE TABLE #temptable (col1 int);
GO

INSERT INTO #temptable
VALUES (10);
GO

SELECT * FROM #temptable;
GO

IF OBJECT_ID(N'tempdb..#temptable', N'U') IS NOT NULL 
DROP TABLE #temptable;
GO

--Test the drop.
SELECT * FROM #temptable;
