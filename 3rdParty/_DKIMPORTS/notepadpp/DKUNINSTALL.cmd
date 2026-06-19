rem shebang
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
rem # DKUNINSTALL()
rem #
:DKUNINSTALL
rem %setlocal%
	
	%dk_call% dk_fileVariables "%~dp0/dkconfig.txt"
	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_importVariables !notepadpp_%Host_Tuple%_Import! INSTALL_ROOT %DKTOOLS_DIR%

	rem ### Uninstall Context Menu ###
	%dk_call% dk_uninstall notepadpp/contextMenu
	
	rem ### Uninstall File Associations ###
	%dk_call% dk_uninstall notepadpp/fileAssoc
	
	rem FIXME: kill notepad++.exe process
	%dk_call% dk_delete "%notepadpp%"
%endfunction%

