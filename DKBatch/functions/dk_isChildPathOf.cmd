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
rem # dk_isChildPathOf(haystack, needle, rtn_var)
rem #
rem #   https://en.wikipedia.org/wiki/Dirname
rem #
:dk_isChildPathOf
%setlocal%

	set "_haystack_=%~1"
    set "_haystack_=%_haystack_:/=\%"									&rem replace all '/' with '\'
	set "_haystack_=%_haystack_::=%"									&rem remove all ':'
    if "%_haystack_:~0,1%" equ "\" set "_haystack_=%_haystack_:~1%"		&rem remove first character if it's a '\'
	
    set "_needle_=%~2"
    set "_needle_=%_needle_:/=\%"
    set "_needle_=%_needle_::=%"
    if "%_needle_:~0,1%" equ "\" set "_needle_=%_needle_:~1%"

    if "x!_haystack_:%_needle_%=!x" neq "x%_haystack_%x" (
        if "%~3" neq "" endlocal & (
			set "dk_isChildPathOf=true"
			if "%~3" neq "" set "%3=%dk_isChildPathOf%"
		)
        set "_haystack_="
        set "_needle_="
        exit /b 0
    )
   
    if "%~3" neq "" endlocal & (
		set "dk_isChildPathOf=false"
		if "%~3" neq "" set "%3=%dk_isChildPathOf%"
	)
    set "_haystack_="
    set "_needle_="
    exit /b 1
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%


    rem ###### Using if return value
    %dk_call% dk_echo
    set "childPath=C:/Program Files/Internet Explorer/en-US"
    set "parentPath=C:/Program Files"
    %dk_call% dk_isChildPathOf "%childPath%" "%parentPath%" result
    if /i "%result%" equ "true" (%dk_call% dk_echo "the path is a child of the parentPath") else (%dk_call% dk_echo "the path is NOT a child of the parentPath")
   
    %dk_call% dk_echo
	set "childPath=/%USERPROFILE:\=/%/Digital Knob/nonexistant"
    set "parentPath=Administrator/Digital Knob"
    %dk_call% dk_isChildPathOf "%childPath%" "%parentPath%" result
    if /i "%result%" equ "true" (%dk_call% dk_echo "the path is a child of the parentPath") else (%dk_call% dk_echo "the path is NOT a child of the parentPath")
    rem FIXME: ERRORLEVEL is still 1
   
   
    rem ###### Using if ERRORLEVEL
    %dk_call% dk_echo
    set "childPath=%USERPROFILE:\=/%/Digital Knob/DKPowershell/functions"
    set "parentPath=/C/Users/Administrator/Digital Knob"
    %dk_call% dk_isChildPathOf "%childPath%" "%parentPath%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_echo "the path is a child of the parentPath") else (%dk_call% dk_echo "the path is NOT a child of the parentPath")
   
    %dk_call% dk_echo
    set "childPath=/%USERPROFILE:\=/%/Digital Knob/"
    set "parentPath=C:/"
    %dk_call% dk_isChildPathOf "%childPath%" "%parentPath%"
    if NOT ERRORLEVEL 1 (%dk_call% dk_echo "the path is a child of the parentPath") else (%dk_call% dk_echo "the path is NOT a child of the parentPath")
    rem FIXME: ERRORLEVEL is still 1
   
   
    rem ###### Using && and || conditionals
    %dk_call% dk_echo
    set "childPath=C:/Users/"
    set "parentPath=D:/"
    %dk_call% dk_isChildPathOf "%childPath%" "%parentPath%" && (%dk_call% dk_echo "the path is a child of the parentPath") || (%dk_call% dk_echo "the path is NOT a child of the parentPath")

    %dk_call% dk_echo
    set "childPath=/%USERPROFILE:\=/%/Digital Knob/DKBash/functions"
    set "parentPath=%USERPROFILE:\=/%/Digital Knob/DKBash"
    %dk_call% dk_isChildPathOf "%childPath%" "%parentPath%" && (%dk_call% dk_echo "the path is a child of the parentPath") || (%dk_call% dk_echo "the path is NOT a child of the parentPath")
    rem FIXME: ERRORLEVEL is still 1
%endfunction%
