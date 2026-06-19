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


rem ################################################################################
rem # dk_contains(<haystack>, <needle>, <ret:optional>)
rem #
rem #
:dk_contains
%setlocal%

	set "_haystack_=%~1"
	set "_needle_=%~2"
	
	if "XXX!_haystack_:%_needle_%=!XXX" neq "XXX%_haystack_%XXX" (
		set "_haystack_="
		set "_needle_="
		endlocal & (
			set "dk_contains=true"
			if "%~3" neq "" (set "%~3=true")
		)
		exit /b 0
	)

	set "_haystack_="
	set "_needle_="
	endlocal & (
		set "dk_contains=false"
		if "%~3" neq "" (set "%3=false")
	)
	exit /b 1
%endfunction%












rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal  

	rem ###### Using dk_contains return value
	%dk_call% dk_echo
	%dk_call% dk_set string "There is a needle in this haystack"
	%dk_call% dk_set substring "needle"
	%dk_call% dk_contains "%string%" "%substring%"
	if /i "%dk_contains%" equ "true" (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")

	%dk_call% dk_echo
	%dk_call% dk_set string "There is a needle in this haystack"
	%dk_call% dk_set substring "straw"
	%dk_call% dk_contains "%string%" "%substring%"
	if /i "%dk_contains%" equ "true" (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")
	rem FIXME: ERRORLEVEL is still 1

	rem ###### Using user defined return value
	%dk_call% dk_echo
	%dk_call% dk_set string "There is a needle in this haystack"
	%dk_call% dk_set substring "needle"
	%dk_call% dk_contains "%string%" "%substring%" myResult
	if /i "%myResult%" equ "true" (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")

	%dk_call% dk_echo
	%dk_call% dk_set string "There is a needle in this haystack"
	%dk_call% dk_set substring "straw"
	%dk_call% dk_contains "%string%" "%substring%" myResult
	if /i "%myResult%" equ "true" (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")
	rem FIXME: ERRORLEVEL is still 1

	rem ###### Using if ERRORLEVEL
	%dk_call% dk_echo
	%dk_call% dk_set string "There is a needle in this haystack"
	%dk_call% dk_set substring "needle"
	%dk_call% dk_contains "%string%" "%substring%"
	if NOT ERRORLEVEL 1 (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")

	%dk_call% dk_echo
	%dk_call% dk_set string "There is a needle in this haystack"
	%dk_call% dk_set substring "straw"
	%dk_call% dk_contains "%string%" "%substring%"
	if NOT ERRORLEVEL 1 (%dk_call% dk_echo "string contains substring") else (%dk_call% dk_echo "string does NOT contain substring")
	rem FIXME: ERRORLEVEL is still 1


	rem ###### Using && and || conditionals
	%dk_call% dk_echo
	%dk_call% dk_set string "There is a needle in this haystack"
	%dk_call% dk_set substring "needle"
	%dk_call% dk_contains "%string%" "%substring%" && (%dk_call% dk_echo "string contains substring") || (%dk_call% dk_echo "string does NOT contain substring")

	%dk_call% dk_echo
	%dk_call% dk_set string "There is a needle in this haystack"
	%dk_call% dk_set substring "straw"
	%dk_call% dk_contains "%string%" "%substring%" && (%dk_call% dk_echo "string contains substring") || (%dk_call% dk_echo "string does NOT contain substring")
	rem FIXME: ERRORLEVEL is still 1
%endfunction%
