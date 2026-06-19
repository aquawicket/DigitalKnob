@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem https://reactos.org/archives/public/ros-diffs/2020-September/074204.html
rem https://stackoverflow.com/a/34987886/688352
rem https://stackoverflow.com/a/34987886
setlocal EnableDelayedExpansion
set "ErrCode[9009]=File Not Found"
set "ErrCode[1073750988]=Unbalanced parenthesis."
set "ErrCode[1073750989]=Missing operand."
set "ErrCode[1073750990]=Missing operator."
set "ErrCode[1073750991]=Invalid number.  Numeric constants are either decimal (17), hexadecimal (0x11), or octal (021)."
set "ErrCode[1073750992]=Invalid number.  Numbers are limited to 32-bits of precision."
set "ErrCode[1073750993]=Divide by zero error."
set handleError=2^>lastError.txt ^& call :handleError %%^^errorlevel%%

if "%~1" neq "" (call %~1)
%endfunction%



:handleError
	::for /F "usebackq delims=" %%r in ("lastError.txt") do (set lastError=%%r)
	set "lastError="
	echo EOL>>lastError.txt
	<lastError.txt (
		call :readLoop
	)
	::echo. 2>lastError.txt
	if "%~1" neq "0" (goto:printError)
	if "%lastError%" neq "" (goto:printError)
		
	:printSuccess
	echo %green% SUCCESS:%~1 %clr%
	(call )
	%return%
	
	:printError
	setlocal DisableDelayedExpansion
	set echoNQ=FOR /F "tokens=1,2 " %%! in ("#") DO FOR /F %%! in ("! ! ^^^!") DO ECHO %%"
	%echoNQ% %%" %red% ERROR:%~1: %lastError% %clr% %%"
	pause
	(call )
	%return%
%endfunction%


:readLoop
	set "line="
	(set /p line=)
	if "!line!" equ "EOL" (exit /b 0)
	set lastError=!line!
	goto:readLoop
exit /b 0






rem ############ set /a error codes ############
rem #  1073750988: Unbalanced parentheses
:test_01 
(
	echo.
	echo Running test_01 . . .
	set /a "total=(2+1"
) %handleError%
%endfunction%

rem #  0: No Error
:test_02
(
	echo.
	echo Running test_02 . . .
) %handleError%
%endfunction%

rem #  1073750989: Missing operand
:test_03
(
	echo.
	echo Running test_03 . . .
	set /a "total=5*" 
) %handleError%
%endfunction%

rem #  1073750990: Syntax error
:test_04
(
	echo.
	echo Running test_04 . . .
	set /a "total=7$3" 
) %handleError%
%endfunction%

rem #  1073750991: Invalid number
:test_05
(
	echo.
	echo.Running test_05 . . .
	set /a "total=0xdeadbeeg"
) %handleError%
%endfunction%

rem #  1073750992: Number larger than 32-bits
rem #  largest number allowed is 2,147,483,647
:test_06
(
	echo.
	echo Running test_06 . . .
	set /a "num=2147483648" %handleError%
) 
%endfunction%

rem #  1073750993: Division by zero.
:test_07
(
	echo.
	echo Running test_07 . . .
	set /a 1/0 
) %handleError%
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal enableDelayedExpansion

	%dk_call% test_CatchErrors :test_01
	%dk_call% test_CatchErrors :test_02
	%dk_call% test_CatchErrors :test_03
	%dk_call% test_CatchErrors :test_04
	%dk_call% test_CatchErrors :test_05
	%dk_call% test_CatchErrors :test_06
	%dk_call% test_CatchErrors :test_07
%endfunction%
