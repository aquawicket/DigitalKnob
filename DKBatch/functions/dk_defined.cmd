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


rem ##################################################################################
rem # dk_defined(<variable>, optional:<rtn_var>)
rem #
:dk_defined
%setlocal%

    if defined %~1 (
		set "dk_defined=true"
        if "%~2" neq "" (endlocal & call set "%2=true")
        exit /b 0
    )
   
	set "dk_defined=false"
    if "%~2" neq "" (endlocal & call set "%2=false")
    exit /b 1
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    rem ###### Using if return value
    %dk_call% dk_echo
    %dk_call% dk_set _variable_ "is defined"
    %dk_call% dk_defined _variable_ result
    if /i "%result%" equ "true" (echo _variable_ is defined) else (echo _variable_ UNDEFINED)
   
    %dk_call% dk_echo
    %dk_call% dk_unset _variable_
    %dk_call% dk_defined _variable_ result
    if /i "%result%" equ "true" (echo _variable_ is defined) else (echo _variable_ UNDEFINED)
    rem FIXME: ERRORLEVEL is still 1
   
   
    rem ###### Using if ERRORLEVEL
    %dk_call% dk_echo
    %dk_call% dk_set _variable_ "is defined"
    %dk_call% dk_defined _variable_
    if NOT ERRORLEVEL 1 (echo _variable_ is defined) else (echo _variable_ UNDEFINED)
   
    %dk_call% dk_echo
    %dk_call% dk_unset _variable_
    %dk_call% dk_defined _variable_
    if NOT ERRORLEVEL 1 (echo _variable_ is defined) else (echo _variable_ UNDEFINED)
    rem FIXME: ERRORLEVEL is still 1
   
   
    rem ###### Using && and || conditionals
    %dk_call% dk_echo
    %dk_call% dk_set _variable_ "is defined"
    %dk_call% dk_defined _variable_ && (echo _variable_ is defined) || (echo _variable_ UNDEFINED)

    %dk_call% dk_echo
    %dk_call% dk_unset _variable_
    %dk_call% dk_defined _variable_ && (echo _variable_ is defined) || (echo _variable_ UNDEFINED)
   
	rem FIXME: ERRORLEVEL is still 1
	%clearerror%
%endfunction%
