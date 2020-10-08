------------------------------------------------------------------------
-- Project: GS1 Check Digit Calculator for SQL Server and Azure SQL DB -
-- https://github.com/segovoni/GS1-barcode-check-digit-calculator      -
--                                                                     -
-- License: Apache License Version 2.0, January 2004                   -
-- http://www.apache.org/licenses/                                     -
--                                                                     -
-- File: GS1 check digit calculator, test cases                        -
--                                                                     -
-- Author: Sergio Govoni                                               -
-- https://www.linkedin.com/in/sgovoni/                                -
--                                                                     -
------------------------------------------------------------------------

USE [GS1CDC];
GO

-- EAN8
IF OBJECT_ID('UnitTestCheckDigitCalculator.[test EAN8]', 'P') IS NOT NULL
  DROP PROCEDURE UnitTestCheckDigitCalculator.[test EAN8];
GO

CREATE PROCEDURE UnitTestCheckDigitCalculator.[test EAN8]
AS
BEGIN
  /*
    Arrange
  */
  DECLARE
    @LBarcodeWithoutCheckDigit CHAR(7)
    ,@LExpected CHAR(8)
    ,@LActual CHAR(8);

  SET @LBarcodeWithoutCheckDigit = '8012347';
  SET @LExpected = '80123477';

  /*
    Act
  */
  SELECT
    @LActual = @LBarcodeWithoutCheckDigit +
               LTRIM(RTRIM(STR(GS1CDC.Private_GetEAN8CheckDigit(@LBarcodeWithoutCheckDigit))));

  /*
    Assert
  */
  EXEC tSQLt.AssertEquals
    @Expected = @LExpected
    ,@Actual = @LActual
    ,@Message = N'The expected data was not returned.';
END;
GO


-- EAN12
IF OBJECT_ID('UnitTestCheckDigitCalculator.[test EAN12]', 'P') IS NOT NULL
  DROP PROCEDURE UnitTestCheckDigitCalculator.[test EAN12];
GO

CREATE PROCEDURE UnitTestCheckDigitCalculator.[test EAN12]
AS
BEGIN
  /*
    Arrange
  */
  DECLARE
    @LBarcodeWithoutCheckDigit CHAR(11)
    ,@LExpected CHAR(12)
    ,@LActual CHAR(12);

  SET @LBarcodeWithoutCheckDigit = '90303818133';
  SET @LExpected = '903038181331';

  /*
    Act
  */
  SELECT
    @LActual = @LBarcodeWithoutCheckDigit +
               LTRIM(RTRIM(STR(GS1CDC.Private_GetEAN12CheckDigit(@LBarcodeWithoutCheckDigit))));

  /*
    Assert
  */
  EXEC tSQLt.AssertEquals
    @Expected = @LExpected
    ,@Actual = @LActual
    ,@Message = N'The expected data was not returned.';
END;
GO


-- EAN13
IF OBJECT_ID('UnitTestCheckDigitCalculator.[test EAN13]', 'P') IS NOT NULL
  DROP PROCEDURE UnitTestCheckDigitCalculator.[test EAN13];
GO

CREATE PROCEDURE UnitTestCheckDigitCalculator.[test EAN13]
AS
BEGIN
  /*
    Arrange
  */
  DECLARE
    @LBarcodeWithoutCheckDigit CHAR(12)
    ,@LExpected CHAR(13)
    ,@LActual CHAR(13);

  SET @LBarcodeWithoutCheckDigit = '709876540145';
  SET @LExpected = '7098765401456';

  /*
    Act
  */
  SELECT
    @LActual = @LBarcodeWithoutCheckDigit +
               LTRIM(RTRIM(STR(GS1CDC.Private_GetEAN13CheckDigit(@LBarcodeWithoutCheckDigit))));

  /*
    Assert
  */
  EXEC tSQLt.AssertEquals
    @Expected = @LExpected
    ,@Actual = @LActual
    ,@Message = N'The expected data was not returned.';
END;
GO

-- EAN14
IF OBJECT_ID('UnitTestCheckDigitCalculator.[test EAN14]', 'P') IS NOT NULL
  DROP PROCEDURE UnitTestCheckDigitCalculator.[test EAN14];
GO

CREATE PROCEDURE UnitTestCheckDigitCalculator.[test EAN14]
AS
BEGIN
  /*
    Arrange
  */
  DECLARE
    @LBarcodeWithoutCheckDigit CHAR(13)
    ,@LExpected CHAR(14)
    ,@LActual CHAR(14);

  SET @LBarcodeWithoutCheckDigit = '7098765401495';
  SET @LExpected = '70987654014951';

  /*
    Act
  */
  SELECT
    @LActual = @LBarcodeWithoutCheckDigit +
               LTRIM(RTRIM(STR(GS1CDC.Private_GetEAN14CheckDigit(@LBarcodeWithoutCheckDigit))));

  /*
    Assert
  */
  EXEC tSQLt.AssertEquals
    @Expected = @LExpected
    ,@Actual = @LActual
    ,@Message = N'The expected data was not returned.';
END;
GO


-- SSCC
IF OBJECT_ID('UnitTestCheckDigitCalculator.[test SSCC]', 'P') IS NOT NULL
  DROP PROCEDURE UnitTestCheckDigitCalculator.[test SSCC];
GO

CREATE PROCEDURE UnitTestCheckDigitCalculator.[test SSCC]
AS
BEGIN
  /*
    Arrange
  */
  DECLARE
    @LBarcodeWithoutCheckDigit CHAR(17)
    ,@LExpected CHAR(18)
    ,@LActual CHAR(18);

  SET @LBarcodeWithoutCheckDigit = '80801820123456789';
  SET @LExpected = '808018201234567890';

  /*
    Act
  */
  SELECT
    @LActual = @LBarcodeWithoutCheckDigit +
               LTRIM(RTRIM(STR(GS1CDC.Private_GetSSCCCheckDigit(@LBarcodeWithoutCheckDigit))));

  /*
    Assert
  */
  EXEC tSQLt.AssertEquals
    @Expected = @LExpected
    ,@Actual = @LActual
    ,@Message = N'The expected data was not returned.';
END;
GO


EXEC tSQLt.Run 'UnitTestCheckDigitCalculator';
GO