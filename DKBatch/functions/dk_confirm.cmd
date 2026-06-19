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
rem # dk_confirm()
rem #
:dk_confirm
%setlocal%

    set /p REPLY="%yellow% Are you sure ? [Y/N] %clr%"
    echo.
	echo.
    if /i "%REPLY%" equ "Y" (
        rem if "%~1" neq "" ( endlocal & %dk_call% dk_set %1 "true" )
        exit /b 0
    )
   
    rem if "%~1" neq "" ( endlocal & %dk_call% dk_set %1 "false" )
    exit /b 1
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    rem ###### Using && and || conditionals
    %dk_call% dk_confirm && (echo "the confimation has passed") || (echo "the confimation has failed")
   
    rem ###### abort in NOT confirmed type code
    rem %dk_call% dk_confirm || (%return%)
	%dk_call% dk_confirm || (%return%)
    echo "passed the confirmation, executing code after confirm"
%endfunction%
