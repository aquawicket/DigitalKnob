:: This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
::
:: For the latest information, see https://github.com/aquawicket/DigitalKnob
::
:: Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
::
:: Permission is hereby granted, free of charge, to any person obtaining a copy
:: of this software and associated documentation files(the "Software"), to deal
:: in the Software without restriction, including without limitation the rights
:: to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
:: copies of the Software, and to permit persons to whom the Software is
:: furnished to do so, subject to the following conditions :
::
:: The above copyright noticeand this permission notice shall be included in all
:: copies or substantial portions of the Software.
::
:: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
:: IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
:: FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
:: AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
:: LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
:: OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
:: SOFTWARE.

:: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/windows-commands
:: https://home.csulb.edu/~murdock/dosindex.html
:: https://ss64.com/nt/

@echo off
::set "STAY_OPEN=1"

::: %DKBATCH_PATH% :::::::::::::::::::::::::::::::::::::
if not defined DKBATCH_PATH ( set "DKBATCH_PATH=%~dp0" )

::: settinge() :::::::::::::::::::::::::::::::::::::::::
if not defined DKSETTNGS ( call %DKBATCH_PATH%settings )

::: %ALL_BUT_FIRST$ ::::::::::::::::::::::::::::::::::::::::::::::
for /f "tokens=1,* delims= " %%a in ("%*") do set ALL_BUT_FIRST=%%b

::: %DKIN% :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "DKIN=if %DEBUG%==1 echo. & echo [94m--^> %~n1^([0m[35m%ALL_BUT_FIRST%[0m[94m^)[0m"

::: %DKEND% ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "DOEND=endlocal & if %DEBUG%==1 echo [94m^<-- %~n1^(^)[0m "
if "%~2"=="DKEND" %DOEND%:[35m!%1![0m & echo. & if "!STAY_OPEN!"=="1" ( goto: eof ) else ( if "!DKLOADED!"=="%~1" ( timeout 30 & exit %ERRORLEVEL% ) else ( goto :eof ) )
set "DKEND=call %0 %%0 DKEND & call return %%0 %%0"

::: NO_RELATIVE_PATHS() :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if %NO_RELATIVE_PATHS%==0 goto :end
cd "%DKBATCH_PATH%CATCH"
set cnt=0
for %%A in (*) do set /a cnt+=1
if "%cnt%" gtr "1" (
	call "%DKBATCH_PATH%SystemFunctions\DKERROR" "ERROR" "%~1" "Extra files found in the CATCH folder Something is using relative paths"
)
:end

::: add %DKEND% to the end of the file if needed :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if not exist "%~1" ( echo [91m cannot find "%~1" [0m & goto :end )
::echo [91m Testins for DKEND in "%~1" [0m
>nul findstr /i /c:"%%DKEND%%" "%~1" || ( echo.>>"%~1" & echo.>>"%~1" &echo %%DKEND%%>>"%~1" )
:end
	
::: prepareLineNumbers() ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
>nul 2>nul (
	call %DKBATCH_PATH%3rdParty\jrepl "(\x25#=\x25)\d*(\x25=#\x25)" "$1+ln+$2" /j /f "%~f1" /o "%~f1.new"
	fc /b "%~f1" "%~f1.new" && del "%~f1.new" || move /y "%~f1.new" "%~f1"
)

:::: DKLOADED() ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if defined DKLOADED (
	%DKIN%
	if %DEBUG_dkbatch.cmd%==1 echo. & echo [94m--^> %~n0^(%*^)[0m
	::TITLE %~n0^(%*^)
	goto :dkbatch_end
)





::#########################################################################
::     DKBATCH first run entry point (NOT LOADED YET)
::#########################################################################

::: %TRY_FATAL% :::::::::::::::::::
set "TRY_FATAL=DKERROR ERROR %1 "

::: %IF_ERROR% :::::::::::::::::::::::::
set "IF_ERROR=call DKERROR IF_ERROR %1 "

::: %ERROR% ::::::::::::::::::::::
set "ERROR=call DKERROR ERROR %1 "

::: %IF_FATAL% :::::::::::::::::::::::::
set "IF_FATAL=call DKERROR IF_FATAL %1 "

::: %FATAL% :::::::::::::::::
set "FATAL=DKERROR ERROR %1 "

::set "REQUIRED_1=if [%%1]==[] echo [91m	%~n0(%*): argument 1 is invalid [0m & goto :EOF"
::set "REQUIRED_2=if [%%2]==[] echo [91m	%~n0(%*): argument 2 is invalid [0m & goto :EOF"
::set "REQUIRED_3=if [%%3]==[] echo [91m	%~n0(%*): argument 3 is invalid [0m & goto :EOF"

set caller=%0
if not "%1"=="" set "caller=%~1"
::if "%1"=="" ( set "caller=%0" ) else ( set "caller=%1" )

if not "%STAY_OPEN%"=="" (
	if not defined in_subprocess (cmd /k set in_subprocess=y ^& "%caller%" %ALL_BUT_FIRST%) & exit )
)

::if not defined in_subprocess (cmd /k set in_subprocess=y ^& %caller% %*) & exit )

::#########################################################################
::     DKBATCH first subprocess creation entry point (NO SUBPROCESS YET)
::#########################################################################

:: Print debug function entry
%DKIN%
if %DEBUG_dkbatch.cmd%==1 echo. & echo [94m--^> %~n0^(%*^)[0m

:: import %DKBATCH% command to global environment variables
if "%DKBATCH%"=="" setx DKBATCH "@echo off & call %0 %%0 %%* & @setlocal enableextensions enabledelayedexpansion"


:: Add dkbatch subfolders to the user PATH environment variable
::: AddDKPaths() ::::::::::::::::::::::::::::::::::::::::::::::::::
setlocal enabledelayedexpansion
set "folders=%DKBATCH_PATH%"
for /d %%D in (%DKBATCH_PATH%*) do ( set "folders=!folders!;%%D" ) 
endlocal & set "PATH=%PATH%;%folders%"
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




set DKLOADED=%1
echo DKLOADED = %DKLOADED%
:dkbatch_end
if %DEBUG_dkbatch.cmd%==1 echo [94m^<-- %~n0^(^)[0m & echo.
