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
rem # dk_uninstall(plugin)
rem #
rem #   this will search for a "plugin" to run in the following search path
rem #  '3rdParty/_IMPORTS/'plugin'/DKUNINSTALL.cmd'
rem #
:dk_uninstall
%setlocal%
	
	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	%dk_call% dk_validate DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
	
	set "CURRENT_PLUGIN=%~1"
	set "dkUninstall=%DKIMPORTS_DIR%/%CURRENT_PLUGIN%/DKUNINSTALL.cmd"	
	if NOT EXIST "%dkUninstall%" (
		call set "dkhttpUninstall=%%dkUninstall:%DIGITALKNOB_DIR%=%DKHTTP_DIGITALKNOB_DIR%%%"
		%dk_call% dk_download "!dkhttpUninstall!" "%dkUninstall%"
	)
	
	%dk_call% dk_allButFirstArgs %*
	endlocal & (
		set "CURRENT_PLUGIN=%~1"
		%dk_call% "%dkUninstall%" %dk_allButFirstArgs%
	)
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	set "bash_exe="
	%dk_call% dk_validate bash_exe %dk_call% dk_depend bash_exe GIT
	echo bash_exe = %bash_exe%
	
	set "bash_exe="
	%dk_call% dk_validate bash_exe %dk_call% dk_depend bash_exe MSYS2
	echo bash_exe = %bash_exe%
%endfunction%

