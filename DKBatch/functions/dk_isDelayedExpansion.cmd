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


set "_DE_=%if_DE% (echo delayed expansion ON) else (echo delayed expansion OFF)"

rem ####################################################################
rem # dk_isDelayedExpansion(<ret>:OPTIONAL)
rem #
rem #
:dk_isDelayedExpansion
%setlocal%
	
    if "!!" equ "" (
      set "dk_isDelayedExpansion=0"
    )  else (
      set "dk_isDelayedExpansion=1"
    )
	
	endlocal & (
		set "dk_isDelayedExpansion=%dk_isDelayedExpansion%"
		if "%~1" neq "" (set "%~1=%dk_isDelayedExpansion%")
		exit /b %dk_isDelayedExpansion%
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_isDelayedExpansion && (echo Delayed expansion is ON) || (echo Delayed expansion is OFF)

%endfunction%