# Technical Interview Homework

# Introduction
The purpose of this exercise is to assess the candidate’s ability to evaluate and contribute to a database and extract data from it that satisfy stated requirements. Some tasks are harder than others, some are open to a little interpretation to encourage creativity, and it is not necessary to complete all tasks perfectly.  Also note that you may need to make some assumptions about the data provided.

# Instructions
  1.	Download and install Microsoft SQL Server 2014 Express Edition (available for download at https://www.microsoft.com/en-us/download/details.aspx?id=42299 at the time of this writing).
  1.	Use the 2014 Adventure Works database (available for download at https://msftdbprodsamples.codeplex.com/downloads/get/880661 at the time of this writing).
  1.	Fork the following repository: https://github.com/Praeses/techinterview-DB.
  1.	Create a series of scripts for the following tasks.
  1.	Create a pull request prior to the due date.

# Tasks
  1.	There is a Sales.ShoppingCartItem table with a ShoppingCartID, but no ShoppingCart table.  Write a script to create and populate this table.
  1.	Write a stored procedure that returns the email address or addresses for an individual
    1. This stored procedure should take in a BusinessEntityID parameter.
    1. It should return one column of email addresses separated by semicolons.
  1.	Write a view that returns all products that are not currently in inventory.  It should have one column: the ProductID.
  1.	Write a stored procedure that returns the percentage of the time each sales person has met his or her quota. 
    1. This stored procedure should take in no parameters.
    1. It should return columns:
      1. BusinessEntityID
      1. Name
      1. Percentage
  1.	There’s a new requirement that stores be able to have more than one sales person.  Write a script to update the database to accommodate this.
