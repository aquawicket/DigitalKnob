:: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/windows-commands
:: https://home.csulb.edu/~murdock/dosindex.html
:: https://ss64.com/nt/

@echo off

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if not defined DKBATCH_PATH ( set "DKBATCH_PATH=%~dp0" )
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::
if not defined DKSETTNGS ( call %DKBATCH_PATH%settings )
::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
for /f "tokens=1,* delims= " %%a in ("%*") do set ALL_BUT_FIRST=%%b
set "DKIN=if %DEBUG%==1 echo. & echo [94m--^> %~n1^(%ALL_BUT_FIRST%^)[0m"
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::TODO - try and get the return values printed in the echo below
set "DOEND=endlocal & if %DEBUG%==1 echo [94m^<-- %~n1^(^)[0m & echo."
::set "DOEND=if %DEBUG%==1 echo ^<- %~n1^(^)"
if "%~2"=="DKEND" %DOEND% & goto :EOF
set "DKEND=call %0 %%0 DKEND"
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::
if %NO_RELATIVE_PATHS%==1 goto :NO_RELATIVE_PATHS
goto :end_NO_RELATIVE_PATHS
:NO_RELATIVE_PATHS
cd "%DKBATCH_PATH%CATCH"
set cnt=0
for %%A in (*) do set /a cnt+=1
if "%cnt%" gtr "1" (
	call "%DKBATCH_PATH%SystemFunctions\DKERROR" "ERROR" "%~1" "Extra files found in the CATCH folder Something is using relative paths"
)
:end_NO_RELATIVE_PATHS
:::::::::::::::::::::::::::

:::::::::::::::::::::::::::
if defined DKLOADED (
	::set "PARENT=%PREV%" set "PREV=%~n1"
	%DKIN%
	if %DEBUG_dkbatch.cmd%==1 echo. & echo [94m--^> %~n0^(%*^)[0m
	TITLE %1
	goto :dkbatch_end
)
::::::::::::::::::::::::::

::#########################################################################
::     DKBATCH first run entry point (NOT LOADED YET)
::#########################################################################
set "TRY_FATAL=DKERROR ERROR %1 "
set "IF_ERROR=call DKERROR IF_ERROR %1 "
set "ERROR=call DKERROR ERROR %1 "
set "IF_FATAL=call DKERROR IF_FATAL %1 "
set "FATAL=DKERROR ERROR %1 "

::set "REQUIRED_1=if [%%1]==[] echo [91m	%~n0(%*): argument 1 is invalid [0m & goto :EOF"
::set "REQUIRED_2=if [%%2]==[] echo [91m	%~n0(%*): argument 2 is invalid [0m & goto :EOF"
::set "REQUIRED_3=if [%%3]==[] echo [91m	%~n0(%*): argument 3 is invalid [0m & goto :EOF"

set caller=%0
if not "%1"=="" set "caller=%1"
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %caller% %*) & exit )

::#########################################################################
::     DKBATCH first subprocess creation entry point (NO SUBPROCESS YET)
::#########################################################################

:: Print debug function entry
%DKIN%
if %DEBUG_dkbatch.cmd%==1 echo. & echo [94m--^> %~n0^(%*^)[0m

if %DEBUG%==1 ( 
	echo *****************************
	echo ********** dkbatch **********
	echo *****************************
	echo *** DEBUG MODE ON *** 
	echo:
)

:: import %DKBATCH% command to global environment variables
if "%DKBATCH%"=="" setx DKBATCH "@echo off & call %0 %%0 & @setlocal enableextensions enabledelayedexpansion"
::if "%DKBATCH%"=="" setx DKBATCH "@echo off & call %0 %%0"

:: Add dkbatch subfolders to the user PATH environment variable
::::::::::::::::::::::::::::::::::::::::::::::::
setlocal enabledelayedexpansion
set "folders=%DKBATCH_PATH%"
for /d %%D in (%DKBATCH_PATH%*) do ( set "folders=!folders!;%%D" ) 
endlocal & set "PATH=%PATH%;%folders%"
:::::::::::::::::::::::::::::::::::::::::::::::




set DKLOADED=1
:dkbatch_end
if %DEBUG_dkbatch.cmd%==1 echo [94m^<-- %~n0^(^)[0m & echo.
