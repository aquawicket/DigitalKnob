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


rem #####################################################################
rem # buildApp()
rem #
rem #
:buildApp
%setlocal%

	%dk_call% dk_title "Building %Target_App% - %Target_Tuple% - %Target_Type%"
	%dk_call% dk_echo
	%dk_call% dk_echo "####################################################################"
	%dk_call% dk_echo " Building %Target_App% - %Target_Tuple% - %Target_Type% - %Target_Level%"
	%dk_call% dk_echo "####################################################################"
	%dk_call% dk_echo

	%dk_call% dk_assertVar Target_Type
	if /i "%Target_Type%" equ "All"		%dk_call% DKBuilder/buildAll
	if /i "%Target_Type%" equ "Release"	%dk_call% DKBuilder/buildRelease
	if /i "%Target_Type%" equ "Debug"		%dk_call% DKBuilder/buildDebug

	%dk_call% dk_echo
	%dk_call% dk_echo "####################################################################"
	%dk_call% dk_echo " Done Building %Target_App% - %Target_Tuple% - %Target_Type% - %Target_Level%"
	%dk_call% dk_echo "####################################################################"
	%dk_call% dk_echo
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% buildApp
%endfunction%
