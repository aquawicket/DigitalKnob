GOTO START
-- DOS jumps to the ':START' label
-- SQL jumps to the 'START:' label
-- Source https://www.dostips.com

/* Begin of SQL comment, this makes the BATCH script invisible for SQL
:: BATCH starts below here
:START
@echo off
CLS

set /p AuthorName=Author Name: 
set /p AuthorCity=Author City: 

rem.-------------------------------------------------------------------------
rem.Execute THIS file in SQL context transmitting arguments per temp table
set Args=

rem.--BEGIN ARGS SECTION ------------------
set Args=%Args% INSERT #ArgsTable VALUES ('AuthorName','%AuthorName%')
set Args=%Args% INSERT #ArgsTable VALUES ('AuthorCity','%AuthorCity%')
rem.--END   ARGS SECTION ------------------

set Args= -q "SET NOCOUNT ON CREATE TABLE #ArgsTable(Arg char(16) PRIMARY KEY, Val char(32)) %Args%"

OSQL.EXE -n -E -w 65536 -d NORTHWIND %Args% -i "%~f0"

PAUSE&GOTO:EOF
*/

-- SQL starts below here
START:
GO

DECLARE @AuthorName varchar(128)
DECLARE @AuthorCity varchar(128)

--Set defaults for values as needed
SET @AuthorName = ''
SET @AuthorCity = ''

--Copy data from temporary table into variables
IF EXISTS (SELECT name, type FROM tempdb..sysobjects WHERE name like '#ArgsTable_%' AND type = 'U')
BEGIN
    SELECT @AuthorName=Val FROM #ArgsTable  WHERE Arg='AuthorName'
    SELECT @AuthorCity=Val FROM #ArgsTable  WHERE Arg='AuthorCity'
END

print @AuthorName
print @AuthorCity

GO
