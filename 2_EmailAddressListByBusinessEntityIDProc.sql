/*
2.Write a stored procedure that returns the email address or addresses for an individual
	i)This stored procedure should take in a BusinessEntityID parameter.
	ii)It should return one column of email addresses separated by semicolons.
*/
use AdventureWorks2014;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetPersonEmailaddress')
	DROP PROCEDURE spGetPersonEmailaddress
GO

CREATE PROCEDURE spGetPersonEmailaddress
      @BusinessID INT,
      @EmailAddresses VARCHAR(8000) OUTPUT
AS
BEGIN
		
      SET NOCOUNT ON;
 
      SELECT @EmailAddresses = COALESCE(@EmailAddresses + ';', ' ') + CAST(Emailaddress AS VARCHAR(50))
      FROM Person.EmailAddress 
      WHERE BusinessEntityID = @BusinessID ----(1,2,3,4,5)

	  /*
	  -- Below block of codes is to get all email addresses
	  SELECT @EmailAddresses = COALESCE(@EmailAddresses + ';', ' ') + CAST(Emailaddress AS VARCHAR(50))
      FROM Person.EmailAddress e
	  JOIN Person.EmailAddress ea
	  on e.BusinessEntityID = ea.BusinessEntityID    

	  */
	  IF(@EmailAddresses is null)
		Begin
			Print 'No email to retrieve. Please check input'
		End	
END;

DECLARE @EmailAddressesAll VARCHAR(8000)
EXEC  spGetPersonEmailaddress  1, @EmailAddressesAll OUTPUT
SELECT @EmailAddressesAll AS [Email List]