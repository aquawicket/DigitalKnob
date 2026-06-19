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
rem # dk_title(string)
rem #
rem #
:dk_title
%setlocal%

	rem ############ SET ############
	if "%~1" neq "" (
		set "dk_title=%~1"
		title !dk_title!
	
	rem ############ GET ############
	) else (
		rem TODO
		echo %dk_title%
	)
	
	:return
	endlocal & (
		set "dk_title=%dk_title%"
	)
	
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem ### SET ###
	%dk_call% dk_title "------------DKBatch: dk_title TEST 1 .............."
	
	rem ### GET ###
	%dk_call% dk_title
	%dk_call% dk_echo "dk_title = %dk_title%"
	%dk_call% dk_pause
	
	
	rem ### SET ###
    %dk_call% dk_title "------------DKBatch: dk_title TEST 2 .............."
	
	rem ### GET ###
	%dk_call% dk_title
	%dk_call% dk_echo "dk_title = %dk_title%"
	%dk_call% dk_pause
	
	
	rem ### SET ###
	%dk_call% dk_title "------------DKBatch: dk_title TEST 3 .............."
	
	rem ### GET ###
	%dk_call% dk_title
	%dk_call% dk_echo "dk_title = %dk_title%"
	%dk_call% dk_pause
%endfunction%
