/*1.There is a Sales.ShoppingCartItem table with a ShoppingCartID, but no ShoppingCart table. Write a script to create and populate this table. */

/* ShoppingCartID is set as a Primary Key with data type being nvarchar which may not affect query performance when the rows are less like 10k records
But, as the records to be fetched is huge, then nvarchar may alter the query performance interms of execution time. 

ShoppingCartID type could be altered to INT IDENTITY(1,1) NOT NULL. So, an existing index is first dropped and later created back as it was before but with int data type for better indexing
*/
use AdventureWorks2014;
GO
DROP INDEX Sales.ShoppingCartItem.IX_ShoppingCartItem_ShoppingCartID_ProductID;

ALTER TABLE Sales.ShoppingCartItem ALTER COLUMN ShoppingCartID int NOT NULL;

CREATE INDEX IX_ShoppingCartItem_ShoppingCartID_ProductID ON Sales.ShoppingCartItem
(
	ShoppingCartID ASC,
	ProductID ASC
);

CREATE TABLE Sales.ShoppingCart(
	ShoppingCartID int NOT NULL,
	CustomerID int NOT NULL,
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	ModifiedDate datetime NOT NULL DEFAULT GETDATE(),
 CONSTRAINT PK_ShoppingCart_ShoppingCartID PRIMARY KEY CLUSTERED (ShoppingCartID),
 CONSTRAINT FK_ShoppingCart_Customer_CustomerID FOREIGN KEY(CustomerID)
 REFERENCES Sales.Customer(CustomerID)
);

-- DateModified gets the default
INSERT INTO Sales.ShoppingCart(ShoppingCartID, CustomerID,DateCreated)
VALUES (N'14951', '1', '2013-11-09 17:54:07.603'), (N'20621', N'2', '2013-11-09 17:54:07.603'), (N'1', N'3', '2013-11-09 17:54:07.603');