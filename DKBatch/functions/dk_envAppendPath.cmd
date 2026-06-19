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
rem # dk_envAppendPath(path)
rem #
rem #   Func: Appends a path to the %PATH% environment variable
rem #   path: A string containing the new path
rem #
rem #	Example:  %dk_call% dk_envAppendPath C:/Windows/System32 result
rem #			  echo dk_envAppendPath returned: %result%
rem #
:dk_envAppendPath
%setlocal%

	set "dk_envAppendPath=%~1"
	
	%dk_call% dk_contains "%PATH%" "%dk_envAppendPath:/=\%;" && (
		%dk_call% dk_info "environment PATH already contains dk_envAppendPath:'%dk_envAppendPath%'"
		%return%
	)

	:return
	endlocal & (
		set "PATH=%PATH%;%dk_envAppendPath:/=\%"
	)
%endfunction%










rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	echo ### Original ###
	echo PATH = '%PATH%'
	
	echo ### After ###
	%dk_call% dk_envAppendPath "%USERPROFILE:\=/%/Digital Knob/Development/DKCMake"
	echo PATH = '%PATH%'
%endfunction%
