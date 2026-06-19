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


rem ####################################################################
rem # dk_DKStorage_Dir()
rem #
rem #
:dk_DKStorage_Dir
%setlocal%

	rem ############ SET ############
	if "%~1" neq "" (
		set "DKStorage_Dir=%~1"
	
	rem ############ GET ############
	) else (
		%dk_call% dk_validatePath DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
		set "DKStorage_Dir=!DIGITALKNOB_DIR!/DKStorage"
	)
		
	%dk_call% dk_mkdir "%DKStorage_Dir%"
	
	:return
	endlocal & (
		set "DKStorage_Dir=%DKStorage_Dir%"
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKStorage_Dir . . ."
	%dk_call% dk_DKStorage_Dir
	%dk_call% dk_echo "DKStorage_Dir = %DKStorage_Dir%"
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKStorage_Dir . . ."
	%dk_call% dk_DKStorage_Dir "C:/DK/myDKStorage"
	%dk_call% dk_echo "DKStorage_Dir = %DKStorage_Dir%"
%endfunction%
