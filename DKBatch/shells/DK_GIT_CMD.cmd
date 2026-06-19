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
::# DK_GIT_CMD environment
::#
:DK_GIT_CMD
	%dk_call% dk_validate git %dk_call% dk_depend git
	set "PATH=%git%\bin;%PATH%"
	%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
	%dk_call% dk_validate cmd.exe %dk_call% dk_depend cmd
	cd "%DKBRANCH_DIR%"


	::%dk_call% dk_clearScreen
	%dk_call% dk_title "Digitalknob DK_GIT_CMD"
	%dk_call% dk_echo "############ DK_GIT_CMD environment ############"
	%dk_call% dk_echo ""
	%cmd.exe% /V:ON /k
%endfunction%
