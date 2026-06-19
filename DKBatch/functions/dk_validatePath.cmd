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
rem # dk_validatePath(variable, code) NO_HALT
rem #
rem #    Check if a variable is a valid path, otherwise run code to validate the variable
rem #
:dk_validatePath
rem %setlocal%

    if EXIST "!%~1!" (%return%)
	
    %~2
   
	if /i "%~3" equ "NO_HALT" (%return%)
    if NOT defined %~1		%dk_call% dk_error "dk_validatePath was unable to set the path variable:%~1 with the code provided"
	if NOT EXIST "!%~1!"    %dk_call% dk_error "dk_validatePath was unable to locate the path:%~1 with the code provided"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_validatePath DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
    %dk_call% dk_echo "DIGITALKNOB_DIR = %DIGITALKNOB_DIR%"
	
	%dk_call% dk_validatePath DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
    %dk_call% dk_echo "DKTOOLS_DIR = %DKTOOLS_DIR%"
	
	%dk_call% dk_validatePath DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
    %dk_call% dk_echo "DKDOWNLOAD_DIR = %DKDOWNLOAD_DIR%"
	
rem	%dk_call% dk_validatePath NONEXISTENT_DIR %dk_call% dk_DKDOWNLOAD_DIR
rem  %dk_call% dk_echo "NONEXISTENT_DIR = %NONEXISTENT_DIR%"
%endfunction%
