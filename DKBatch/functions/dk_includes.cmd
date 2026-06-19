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
rem # dk_includes(<haystack>, <needle>, <ret>:optional)
rem #
rem #
:dk_includes
%setlocal%

    set "_haystack_=%~1"
    set "_needle_=%~2"
	
	if "x!_haystack_:%_needle_%=!" neq "x%_haystack_%" (
		set "dk_includes=0"
	) else (
		set "dk_includes=1"
	)

	set "_haystack_="
	set "_needle_="
    endlocal & (
		set "dk_includes=%dk_includes%"
		if "%~3" neq "" (set "%~3=%dk_includes%")
		exit /b %dk_includes% 
	)
REM %endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    rem ###### Using if return value
    %dk_call% dk_echo
	set "string=There is a needle in this haystack"
    set "substring=needle"
    %dk_call% dk_includes "%string%" "%substring%" result
    if "%result%" equ "0" (%dk_call% dk_echo "'%string%' CONTAINS '%substring%'") else (%dk_call% dk_echo "'%string%' DOES NOT CONTAIN '%substring%'")
   
    %dk_call% dk_echo
    set "string=There is a needle in this haystack"
    set "substring=straw"
    %dk_call% dk_includes "%string%" "%substring%" result
    if "%result%" equ "0" (%dk_call% dk_echo "'%string%' CONTAINS '%substring%'") else (%dk_call% dk_echo "'%string%' DOES NOT CONTAIN '%substring%'")
    rem FIXME: ERRORLEVEL is still 1
   
   
    rem ###### Using if ERRORLEVEL
    %dk_call% dk_echo
    set "string=There is a needle in this haystack"
    set "substring=needle"
    %dk_call% dk_includes "%string%" "%substring%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_echo "'%string%' CONTAINS '%substring%'") else (%dk_call% dk_echo "'%string%' DOES NOT CONTAIN '%substring%'")
   
    %dk_call% dk_echo
	set "string=There is a needle in this haystack"
    set "substring=straw"
    %dk_call% dk_includes "%string%" "%substring%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_echo "'%string%' CONTAINS '%substring%'") else (%dk_call% dk_echo "'%string%' DOES NOT CONTAIN '%substring%'")
    rem FIXME: ERRORLEVEL is still 1
   
   
    rem ###### Using && and || conditionals
    %dk_call% dk_echo
    set "string=There is a needle in this haystack"
    set "substring=needle"
    %dk_call% dk_includes "%string%" "%substring%" && (%dk_call% dk_echo "'%string%' CONTAINS '%substring%'") || (%dk_call% dk_echo "'%string%' DOES NOT CONTAIN '%substring%'")

    %dk_call% dk_echo
    set "string=There is a needle in this haystack"
    set "substring=straw"
    %dk_call% dk_includes "%string%" "%substring%" && (%dk_call% dk_echo "'%string%' CONTAINS '%substring%'") || (%dk_call% dk_echo "'%string%' DOES NOT CONTAIN '%substring%'")
    rem FIXME: ERRORLEVEL is still 1
	
	rem ###### Using && and || conditionals
    %dk_call% dk_echo
	echo dk_includes "There is a needle in this haystack" "needle"
    %dk_call% dk_includes "There is a needle in this haystack" "needle" && (%dk_call% dk_echo "There is a needle in this haystack' CONTAINS 'needle'") || (%dk_call% dk_echo "'There is a needle in this haystack' DOES NOT CONTAIN 'needle'")

    %dk_call% dk_echo
	echo dk_includes "There is a needle in this haystack" "straw"
    %dk_call% dk_includes "There is a needle in this haystack" "straw" && (%dk_call% dk_echo "'There is a needle in this haystack' CONTAINS 'straw'") || (%dk_call% dk_echo "'There is a needle in this haystack' DOES NOT CONTAIN 'straw'")
    rem FIXME: ERRORLEVEL is still 1
%endfunction%
