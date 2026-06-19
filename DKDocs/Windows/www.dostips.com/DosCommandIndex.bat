@ECHO OFF
REM.-- Prepare the Command Processor
SETLOCAL ENABLEEXTENSIONS

REM --
REM -- Copyright note
REM -- This script is provided as is.  No waranty is made, whatso ever.
REM -- You may use and modify the script as you like, but keep the version history with
REM -- recognition to https://www.dostips.com in it.
REM --

REM Version History:
REM         XX.XXX      YYYYMMDD Author Description
SET "version=01.000"  &:20051201 p.h.   initial version, origin https://www.dostips.com
SET "version=01.001"  &:20060122 p.h.   Fix missing exclamation marks in documentation (https://www.dostips.com)
SET "version=01.002"  &:20060218 p.h.   replaced TEXTAREA with PRE XMP (https://www.dostips.com)
SET "version=01.003"  &:20060218 p.h.   php embedding (https://www.dostips.com)
SET "version=01.004"  &:20060723 p.h.   fix page links for FireFox (https://www.dostips.com)
SET "version=01.005"  &:20061015 p.h.   invoke HELP via '"call" help', allows overriding help command with a help.bat file (https://www.dostips.com)
SET "version=01.006"  &:20061015 p.h.   cleanup progress indicator (https://www.dostips.com)
SET "version=01.007"  &:20080316 p.h.   use codepage 1252 to support european users (https://www.dostips.com)
SET "version=02.000"  &:20080316 p.h.   use FOR command to generate HTML, avoids most escape characters (https://www.dostips.com)
SET "version=02.001"  &:20100201 p.h.   now using css and xhtml
SET "version=02.002"  &:20130829 p.h.   excluding new SC command in Win7 and Vista to avoid hanging
REM !! For a new version entry, copy the last entry down and modify Date, Author and Description
SET "version=%version: =%"

for /f "delims=: tokens=2" %%a in ('chcp') do set "restore_codepage=%%a"
chcp 1252>NUL

set "z=%~dpn0.htm"

rem echo.^<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"^> >"%z%"
echo.^<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"^> >"%z%"

set "title=DOS Command Index"
for /f "tokens=*" %%a in ('ver') do set "winver=%%a"

echo.Creating the header ...
for %%A in (
            "<html lang='en-US' xml:lang='en-US' xmlns='https://www.w3.org/1999/xhtml'>"
            "<head>"
            "<style type='text/css'>"
            "  h1              {text-align:center;}"
            "  h2              {text-align:center;}"
            "  table.center    {margin-left: auto;margin-right: auto;}"
            "  td              {text-align:left;}"
            "  div.center      {text-align:center;}"
            "  div.sourcebatch {background: #DDDDDD;}"
            "  div.helptext    {background: #F8F8FF;}"
            "  div.top         {float: right;}"
            "</style>"
            "<title>%title%</title>"
            "<meta http-equiv='Content-Type' content='text/html; charset=ISO-8859-1' />"
            "</head>"
            "<body bgcolor='#FFFFCC'>"
            "<font color='darkblue'>"
            "<h1>%title%</h1>"
            "<div class='center'>"
            "<table class='center' border='1' cellspacing='1' cellpadding='3'>"
            "    <tr><td>Windows Version</td><td>:</td><td>%winver%</td></tr>"
            "    <tr><td>Document Source</td><td>:</td><td>"
            "        <a href='https://www.dostips.com/'><b>https://www.dostips.com</a><br />"
            "        <a href='https://www.dostips.com/%~n0.php'><b>https://www.dostips.com/%~nx0.php</a>"
            "        </td></tr>"
            "    <tr><td>Created by</td><td>:</td><td><a href='https://www.dostips.com/%~nx0'>"
            "        <b>%~nx0</b></a><br /><a href='#%~n0'><b>Source Code below</b></a></td></tr>"
            "</table>"
            "</div>"
            "<br /><br />"
            "<table class='center'>"
            ) do echo.%%~A>>"%z%"
        
echo.Creating the index ...
set /a cnt=0
for /f "tokens=1,*" %%a in ('"help|findstr /v /b /c:" " /c:"For more" /c:"SC""') do (
	if "%%b" NEQ "" (
		for %%A in (
				"    <tr><td><a href='#%%a'>%%a</a></td><td>%%b</td></tr>"
				) do echo.%%~A>>"%z%"
		set /a cnt+=1
	)
)
for %%A in (
            "</table>"
            "<br /><br />"
            ) do echo.%%~A>>"%z%"

echo.Extracting HELP text ...
call:initProgress cnt
for /f "tokens=1,*" %%a in ('"help|findstr /v /b /c:" " /c:"For more" /c:"SC""') do (
	if "%%b" NEQ "" (
		echo.Processing %%a
		for %%A in (
				"<div class='top'><a href='#'>TOP</a></div>"
				"<h2><a name='%%a'>%%a</a></h2>"
				"<div class='helptext'><pre><xmp>"
				) do echo.%%~A>>"%z%"
		call help %%a >>"%z%" 2>&1
		echo ^</xmp^> >>"%z%"
		for %%A in (
				"</pre></div>"
				) do echo.%%~A>>"%z%"
		call:tickProgress
	)
)

echo.Injecting source script ...
for %%A in (
            ""
            "<br /><br />"
            "<div class='center'>"
            "<div class='top'><a href='#'>TOP</a></div>"
            "<a name='%~n0'><h2>DOS Batch Script Source that created this Document</h2></a>"
            "This %title% has been created automatically by the following DOS batch script:"
            "<br /><br />"
            "</div>"
            "<div class='sourcebatch'><pre><xmp>"
            ) do echo.%%~A>>"%z%"
type "%~f0" >>"%z%"

echo.Creating the footer ...
echo ^</xmp^> >>"%z%"
for %%A in (
            "</pre></div>"
            ""
            "</font>"
            "</body>"
            "</html>"
            ) do echo.%%~A>>"%z%"


chcp %restore_codepage%>NUL
explorer "%z%"

:SKIP
REM.-- End of application
FOR /l %%a in (5,-1,1) do (TITLE %title% -- closing in %%as&ping -n 2 -w 1 127.0.0.1>NUL)
TITLE Press any key to close the application&ECHO.&GOTO:EOF


::-----------------------------------------------------------
::helper functions follow below here
::-----------------------------------------------------------


:initProgress -- initialize an internal progress counter and display the progress in percent
::            -- %~1: in  - progress counter maximum, equal to 100 percent
::            -- %~2: in  - title string formatter, default is '[P] completed.'
set /a "ProgressCnt=-1"
set /a "ProgressMax=%~1"
set "ProgressFormat=%~2"
if "%ProgressFormat%"=="" set "ProgressFormat=[PPPP]"
set "ProgressFormat=%ProgressFormat:[PPPP]=[P] completed.%"
call :tickProgress
GOTO:EOF


:tickProgress -- display the next progress tick
set /a "ProgressCnt+=1"
SETLOCAL
set /a "per=100*ProgressCnt/ProgressMax"
set "per=%per%%%"
call title %%ProgressFormat:[P]=%per%%%
GOTO:EOF
