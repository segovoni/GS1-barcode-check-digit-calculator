------------------------------------------------------------------------
-- Project: GS1 Check Digit Calculator for SQL Server and Azure SQL DB -
-- https://github.com/segovoni/GS1-barcode-check-digit-calculator      -
--                                                                     -
-- License: Apache License Version 2.0, January 2004                   -
-- http://www.apache.org/licenses/                                     -
--                                                                     -
-- File: GS1 check digit calculator classes                            -
--                                                                     -
-- Author: Sergio Govoni                                               -
-- https://www.linkedin.com/in/sgovoni/                                -
--                                                                     -
------------------------------------------------------------------------

USE [tempdb];
GO

DECLARE @Msg NVARCHAR(MAX);
SELECT @Msg = 'Installed at ' + CONVERT(NVARCHAR, GETDATE(), 121);
RAISERROR(@Msg, 0, 1);
GO

IF OBJECT_ID('GS1CDC.DropAllObjects', 'P') IS NOT NULL
  EXEC GS1CDC.DropAllObjects;
GO

CREATE SCHEMA GS1CDC;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE GS1CDC.DropAllObjects
AS
BEGIN
  DECLARE @cmd NVARCHAR(MAX) = '';

  WITH ObjectsInfo([name], [type]) AS
    (
      SELECT
        QUOTENAME(SCHEMA_NAME(Obj.[schema_id])) + '.' + QUOTENAME(Obj.[name])
        ,Obj.[type]
      FROM
        sys.objects AS Obj
      WHERE
        (Obj.[schema_id] = SCHEMA_ID('GS1CDC'))
    ),
    DropStatements(seq, cmd) AS
    (
      SELECT
        [no] = 10,
        cmd = 'DROP ' + CASE [type]
                          WHEN 'P' THEN 'PROCEDURE'
                          WHEN 'PC' THEN 'PROCEDURE'
                          WHEN 'U' THEN 'TABLE'
                          WHEN 'IF' THEN 'FUNCTION'
                          WHEN 'TF' THEN 'FUNCTION'
                          WHEN 'FN' THEN 'FUNCTION'
                          WHEN 'V' THEN 'VIEW'
                        END + ' ' + name + ';'
      FROM
        ObjectsInfo
      UNION ALL
      SELECT
        999999
        ,'DROP SCHEMA ' + QUOTENAME([name]) +';'
      FROM
        sys.schemas
      WHERE
        (schema_id = SCHEMA_ID(PARSENAME('GS1CDC', 1)))
    )
    SELECT
      @cmd = @cmd + cmd + CHAR(13) + CHAR(10)
    FROM
      DropStatements
    ORDER BY
      [seq];
  EXEC(@cmd);
END;
GO

-- GTIN-8
CREATE FUNCTION GS1CDC.Private_GetEAN8CheckDigit
(
  @ACode AS VARCHAR(7)
)
RETURNS INTEGER
AS BEGIN
  RETURN (10 - (3* CAST(SUBSTRING(@ACode, 1, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 2, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 3, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 4, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 5, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 6, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 7, 1) AS INTEGER)
               )%10
         )%10
END;
GO

-- GTIN-12
CREATE FUNCTION GS1CDC.Private_GetEAN12CheckDigit
(
  @ACode AS VARCHAR(11)
)
RETURNS INTEGER
AS BEGIN
  RETURN (10 - (3* CAST(SUBSTRING(@ACode, 1, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 2, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 3, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 4, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 5, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 6, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 7, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 8, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 9, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 10, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 11, 1) AS INTEGER)
               )%10
         )%10
END;
GO

-- GTIN-13
CREATE FUNCTION GS1CDC.Private_GetEAN13CheckDigit
(
  @ACode AS VARCHAR(12)
)
RETURNS INTEGER
AS BEGIN
  RETURN (10 - (CAST(SUBSTRING(@ACode, 1, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 2, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 3, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 4, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 5, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 6, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 7, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 8, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 9, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 10, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 11, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 12, 1) AS INTEGER)
               )%10
         )%10
END;
GO

-- GTIN14
CREATE FUNCTION GS1CDC.Private_GetEAN14CheckDigit
(
  @ACode AS VARCHAR(13)
)
RETURNS INTEGER
AS BEGIN
  RETURN (10 - (3* CAST(SUBSTRING(@ACode, 1, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 2, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 3, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 4, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 5, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 6, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 7, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 8, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 9, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 10, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 11, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 12, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 13, 1) AS INTEGER)
               )%10
         )%10
END;
GO

-- SSCC
CREATE FUNCTION GS1CDC.Private_GetSSCCCheckDigit
(
  @ACode AS VARCHAR(17)
)
RETURNS INTEGER
AS BEGIN
  RETURN (10 - (3* CAST(SUBSTRING(@ACode, 1, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 2, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 3, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 4, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 5, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 6, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 7, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 8, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 9, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 10, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 11, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 12, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 13, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 14, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 15, 1) AS INTEGER)
                + CAST(SUBSTRING(@ACode, 16, 1) AS INTEGER)
                + 3* CAST(SUBSTRING(@ACode, 17, 1) AS INTEGER)
               )%10
         )%10
END;
GO

CREATE FUNCTION GS1CDC.GetCheckDigit
(
  @ACode VARCHAR(17)
)
RETURNS INTEGER
AS BEGIN
  DECLARE @LCheckDigit INTEGER;
  SET @LCheckDigit = -1;

  IF LEN(@ACode) = 7
    SELECT @LCheckDigit = GS1CDC.Private_GetGS1EAN8CheckDigit(@ACode);
  ELSE IF LEN(@ACode) = 11
    SELECT @LCheckDigit = GS1CDC.Private_GetGS1EAN12CheckDigit(@ACode);
  ELSE IF LEN(@ACode) = 12
    SELECT @LCheckDigit = GS1CDC.Private_GetGS1EAN13CheckDigit(@ACode);
  ELSE IF LEN(@ACode) = 13
    SELECT @LCheckDigit = GS1CDC.Private_GetGS1EAN14CheckDigit(@ACode);
  ELSE IF LEN(@ACode) = 17
    SELECT @LCheckDigit = GS1CDC.Private_GetGS1SSCCCheckDigit(@ACode);
  ELSE BEGIN
    RETURN CAST('The number you entered is not supported as GS1 key. Please try again!' AS INTEGER);
  END
  RETURN @LCheckDigit;
END;
GO

CREATE PROCEDURE GS1CDC.Uninstall
AS
BEGIN
  EXEC GS1CDC.DropAllObjects;
END;
GO

--SELECT GS1CDC.GetCheckDigit('629104150021')
--SELECT GS1CDC.GetCheckDigit('621')