GOTO START
-- DOS jumps to the ':START' label
-- SQL jumps to the 'START:' label
-- Source https://www.dostips.com

/* Begin of SQL comment, this makes the BATCH script invisible for SQL
:: BATCH starts below here
:START
@echo off
CLS

OSQL.EXE -n -E -w 65536 -d NORTHWIND -i "%~f0"

PAUSE&GOTO:EOF
*/

-- SQL starts below here
START:
GO
SELECT * FROM AUTHOR
GO
