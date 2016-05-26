/*
4.Write a stored procedure that returns the percentage of the time each sales person has met his or her quota.
	i)This stored procedure should take in no parameters.
	ii)It should return columns:
		a)BusinessEntityID
		b)Name
		c)	Percentage
*/

use AdventureWorks2014;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'uspGetSalesPersonQuotaPercentage')
DROP PROCEDURE uspGetSalesPersonQuotaPercentage
GO

CREATE PROCEDURE uspGetSalesPersonQuotaPercentage
AS
BEGIN
    SET NOCOUNT ON;
	IF OBJECT_ID('tempdb.dbo.#TempSalesQouta') IS NOT NULL
		DROP TABLE #TempSalesQouta;

	IF OBJECT_ID('tempdb.dbo.#TempSalesReachByYear') IS NOT NULL
		DROP TABLE #TempSalesReachByYear;
	SELECT * INTO #TempSalesQouta FROM (
	SELECT pvt.SalesPersonID as BusinessEntityID, pvt.FullName, pvt.JobTitle, pvt.SalesQuota, pvt.[2011], pvt.[2012]

	,pvt.[2013]

	,pvt.[2014]

	FROM (SELECT

	soh.[SalesPersonID]

	,p.[FirstName] + ' ' + COALESCE(p.[MiddleName], '') + ' ' + p.[LastName] AS [FullName]

	,e.[JobTitle]

	,sp.SalesQuota as "SalesQuota"

	,soh.[SubTotal]

	,YEAR(soh.[OrderDate]) AS [FiscalYear]

	FROM [Sales].[SalesPerson] sp

	INNER JOIN [Sales].[SalesOrderHeader] soh

	ON sp.[BusinessEntityID] = soh.[SalesPersonID]

	INNER JOIN [Sales].[SalesTerritory] st

	ON sp.[TerritoryID] = st.[TerritoryID]

	INNER JOIN [HumanResources].[Employee] e

	ON soh.[SalesPersonID] = e.[BusinessEntityID]

	INNER JOIN [Person].[Person] p

	ON p.[BusinessEntityID] = sp.[BusinessEntityID]

	) AS soh

	PIVOT

	(

	SUM([SubTotal])

	FOR [FiscalYear]

	IN ( [2011], [2012],[2013],[2014])

	) AS pvt
	) tempsales

	SELECT * INTO #TempSalesReachByYear FROM (
	SELECT BusinessEntityID, FullName as Name, 
	(CASE WHEN [2011]>=SalesQuota  THEN 1.0 ELSE 0 END) as SQ11, 
	(CASE WHEN [2012]>=SalesQuota  THEN 1.0 ELSE 0 END) as SQ12,
	(CASE WHEN [2013]>=SalesQuota  THEN 1.0 ELSE 0 END) as SQ13,
	(CASE WHEN [2014]>=SalesQuota  THEN 1.0 ELSE 0 END) as SQ14 
	FROM #TempSalesQouta ) sqy

	SELECT BusinessEntityID, Name, (((SQ11+SQ12+SQ13+SQ14)/4)*100) AS Percentage from #TempSalesReachByYear;	
	
END;
GO

--EXEC uspGetSalesPersonQuotaPercentage;