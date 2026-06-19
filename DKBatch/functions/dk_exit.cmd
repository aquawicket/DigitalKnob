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


rem #################### dk_exit settings ##########################################
rem set "dk_exit_PAUSE_ON_EXIT=1"
rem set "dk_exit_PAUSE_ON_ERROR=1"
rem ################################################################################
rem # dk_exit(exit_code)
rem #
rem #		Exit the process or script with an exit_ststus
rem #
:dk_exit
%setlocal%

	if "%~1" neq "%exit_code%" 			(%dk_call% dk_set exit_code %~1)
	if errorlevel 1 					(set "exit_code=%errorlevel%")
    if "%errorlevel%" gtr "%exit_code%" (set "exit_code=%errorlevel%")
    if "%~1" gtr "%exit_code%" 			(set "exit_code=%~1")
   
    if "%dk_exit_PAUSE_ON_EXIT%" equ "1" (
		%dk_call% dk_echo "*** dk_exit_PAUSE_ON_EXIT ***"
		set "PAUSE=1"
	)
	if "%dk_exit_PAUSE_ON_ERROR%" equ "1" (
		if "%exit_code%" neq "0" (
			%dk_call% dk_echo "*** dk_exit_PAUSE_ON_ERROR ***"
			set "PAUSE=1"
		)
	)
	
	%dk_call% dk_echo "exit_code:'%exit_code%'"
	
	if "%PAUSE%" equ "1" (
		%dk_call% dk_pause "Press any key to exit . . ."
	)
    exit %exit_code%
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    rem %dk_call% dk_exit
    rem %dk_call% dk_exit 0
    %dk_call% dk_exit 13
%endfunction%
