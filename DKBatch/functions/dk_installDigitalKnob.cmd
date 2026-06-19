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


rem ############################################################################
rem # dk_installDigitalKnob()
rem #
rem #
:dk_installDigitalKnob
%setlocal%
 
	%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR

	echo ############ Install DK languages ############
	call %DKBRANCH_DIR%/DKBash/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKBatch/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKC/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKCMake/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKCpp/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKCSharp/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKHta/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKHtml/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKJava/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKJavascript/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKPhp/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKPowershell/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKPython/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKVbs/DKINSTALL.cmd

	echo ############ Install 3rdParty #############

%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_installDigitalKnob
%endfunction%

