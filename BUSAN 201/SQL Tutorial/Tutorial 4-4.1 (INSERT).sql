----4.1 INSERT exercise
--a)
--DONE

--b, c)
--
--METHOD1
USE [AdventureWorksLT2012]
GO

--This is manually inserting row (Right click and insert new query)
INSERT INTO [SalesLT].[ProductCostPriceHistory]
           ([CostPriceHistoryID]
           ,[ProductID]
           ,[StandardCost]
           ,[ListPrice]
           ,[EndDate])
     VALUES
           ('C721C0A9-C303-41C0-B879-0044B8F63595'
           ,1995
           ,4000
           ,1111
           ,2021-05-12)
-----
--METHOD2
INSERT INTO SalesLT.ProductCostPriceHistory
VALUES ('C721C0A9-C303-41C0-B879-0044B8F63595', 1995, 4000, 1111, 2021-05-1)


--d)

