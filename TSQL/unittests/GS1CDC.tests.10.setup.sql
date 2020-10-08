------------------------------------------------------------------------
-- Project: GS1 Check Digit Calculator for SQL Server and Azure SQL DB -
-- https://github.com/segovoni/GS1-barcode-check-digit-calculator      -
--                                                                     -
-- License: Apache License Version 2.0, January 2004                   -
-- http://www.apache.org/licenses/                                     -
--                                                                     -
-- File: GS1 check digit calculator, setup DB and tSQLt framework      -
--                                                                     -
-- Author: Sergio Govoni                                               -
-- https://www.linkedin.com/in/sgovoni/                                -
--                                                                     -
------------------------------------------------------------------------

USE [master];
GO

-- Drop database if exists
IF (DB_ID('GS1CDC') IS NOT NULL)
BEGIN
  ALTER DATABASE [GS1CDC]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE [GS1CDC];
END;
GO

-- Create database
CREATE DATABASE [GS1CDC];
GO


-- Enable CLR at the SQL Server instance level
-- tSQLt framework requires this option
EXEC sp_configure 'clr enabled', 1;
RECONFIGURE;
GO

EXEC sp_configure 'clr enabled';
GO


USE [GS1CDC];
GO

-- Enable TRUSTWORTHY property at the database level
-- in each database you want to install tSQLt framework
ALTER DATABASE [GS1CDC] SET TRUSTWORTHY ON;
GO


/*
  1. Download the tSQLt framework from https://tsqlt.org/

  2. Execute tSQLt.class.sql in the database you want to install
     tSQLt framework
*/

SELECT * FROM tSQLt.Info();
GO

-- Create new test class for Check Digit Calculator
EXEC tSQLt.NewTestClass 'UnitTestCheckDigitCalculator';
GO