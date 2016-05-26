/*
5.There’s a new requirement that stores be able to have more than one sales person. Write a script to update the database to accommodate this.​
*/

use AdventureWorks2014
GO
--Dropping index on SalesPersonID
DROP INDEX IX_Store_SalesPersonID ON Sales.Store

ALTER TABLE Sales.Store ALTER COLUMN SalesPersonID int NOT NULL


-- Dropping XML Index
DROP INDEX PXML_Store_Demographics ON Sales.Store 

ALTER TABLE sales.customer
DROP CONSTRAINT FK_Customer_Store_StoreID

ALTER TABLE sales.store
DROP CONSTRAINT PK_Store_BusinessEntityID

ALTER TABLE sales.store
ADD CONSTRAINT PK_Store_BusinessEntityID PRIMARY KEY (BusinessEntityID,SalesPersonID);


INSERT INTO Sales.Store(BusinessEntityID,Name, SalesPersonID) VALUES(292, 'Next-Door Bike Store', 276);
INSERT INTO Sales.Store(BusinessEntityID,Name, SalesPersonID) VALUES(292, 'Next-Door Bike Store', 277);

GO