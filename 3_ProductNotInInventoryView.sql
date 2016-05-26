/*
3.Write a view that returns all products that are not currently in inventory. It should have one column: the ProductID.
*/
use AdventureWorks2014;
GO

CREATE VIEW Production.vProductNotInInventory
AS
SELECT DISTINCT ProductID from Production.Product
WHERE ProductID NOT IN (SELECT ProductID from Production.ProductInventory)
OR
ProductID in (SELECT ProductID from Production.ProductInventory WHERE Quantity = 0)


