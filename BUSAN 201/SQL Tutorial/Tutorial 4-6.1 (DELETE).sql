USE [AdventureWorksLT2012]
GO
/*----------DELETE -------------*/

/*a)In SSMS, right-click any table in ADVENTUREWORKSLT2012 > Script Table as > DELETE To > New Query Editor Window. 
This generates a template for writing a DELETE statement.
Note a WHERE clause is automatically added to the template.*/

/*b) Remove the rows inserted/updated above.*/

DELETE FROM SalesLT.ProductCategory 
WHERE Name IN ( 'TestUpdate', 'TestAuto2','ManuallyInsert1','ManuallyInsert2');

SELECT * FROM DBO.BuildVersion;

DELETE FROM dbo.BuildVersion 
WHERE SystemInformationID IN (20, 19);

/*c) In SSMS, right-click any table in ADVENTUREWORKSLT2012 > Edit Top n Rows. 
This presents a visual editor that allows you to delete rows without writing SQL.*/

