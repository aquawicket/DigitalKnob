@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

cd /d "%temp%"

call:jdate tnow "%date%"
for %%F in (*.*) do (
    call:ftime tfile "%%F"
    set /a diff=tnow-tfile
    echo.%%~nxF is !diff! days old
)

ECHO.&PAUSE&GOTO:EOF


::-----------------------------------------------------------------------------------
::-- Functions start below here
::-----------------------------------------------------------------------------------


:ftime JD filename attr -- returns the file time in julian days
::                      -- JD    [out]    - valref file time in julian days
::                      -- attr  [in,opt] - time field to be used, creation/last-access/last-write, see 'dir /?', i.e. /tc, /ta, /tw, default is /tw
:$created 20060101 :$changed 20090322 :$categories DateAndTime
:$source https://www.dostips.com
SETLOCAL
set file=%~2
set attr=%~3
if not defined attr (call:jdate JD "- %~t2"
) ELSE (for /f %%a in ('"dir %attr% /-c "%file%"|findstr "^^[0-9]""') do call:jdate JD "%%a")
( ENDLOCAL & REM RETURN VALUES
    IF "%~1" NEQ "" (SET %~1=%JD%) ELSE (echo.%JD%)
)
EXIT /b


:jdate JD DateStr -- converts a date string to julian day number with respect to regional date format
::                -- JD      [out,opt] - julian days
::                -- DateStr [in,opt]  - date string, e.g. "03/31/2006" or "Fri 03/31/2006" or "31.3.2006"
:$reference https://groups.google.com/group/alt.msdos.batch.nt/browse_frm/thread/a0c34d593e782e94/50ed3430b6446af8#50ed3430b6446af8
:$created 20060101 :$changed 20080219
:$source https://www.dostips.com
SETLOCAL
set DateStr=%~2&if "%~2"=="" set DateStr=%date%
for /f "skip=1 tokens=2-4 delims=(-)" %%a in ('"echo.|date"') do (
    for /f "tokens=1-3 delims=/.- " %%A in ("%DateStr:* =%") do (
        set %%a=%%A&set %%b=%%B&set %%c=%%C))
set /a "yy=10000%yy% %%10000,mm=100%mm% %% 100,dd=100%dd% %% 100"
set /a JD=dd-32075+1461*(yy+4800+(mm-14)/12)/4+367*(mm-2-(mm-14)/12*12)/12-3*((yy+4900+(mm-14)/12)/100)/4
ENDLOCAL & IF "%~1" NEQ "" (SET %~1=%JD%) ELSE (echo.%JD%)
EXIT /b
