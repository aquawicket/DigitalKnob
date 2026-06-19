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
rem # dk_deleteDigitalKnob()
rem #
rem #
:dk_deleteDigitalKnob
%setlocal%
 
	
	echo ### Deleting DigitalKnob directory ###
	%dk_call% dk_validate DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
	echo Do you want to delete the DigitalKnob folder ?
	%dk_call% dk_confirm || (exit /b 0)
	
	rem ### Backup the DigitalKnob directory
	echo A backup will be create at '%DIGITALKNOB_DIR%_BACKUP'
	%dk_call% dk_copy "%DIGITALKNOB_DIR%" "%DIGITALKNOB_DIR%_BACKUP" OVERWRITE

	rem ###### Deleting DIGITALKNOB_DIR ######
rem	echo ((goto) 2^>nul ^& cd "%SystemDrive%\" ^&^& rmdir /s /q "%DIGITALKNOB_DIR:/=\%") > "%TEMP%\delete_DK.cmd"
rem	echo ((goto) 2^>nul ^& del "%TEMP%\delete_DK.cmd" ^& %clearerror%) >> "%TEMP%\delete_DK.cmd"
rem	start "" /MIN "%TEMP%\delete_DK.cmd" & exit
	
	(
		cd "%USERPROFILE%"
		start "" /b rd /s /q "%DIGITALKNOB_DIR:/=\%"
		exit
	)

%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_deleteDigitalKnob
%endfunction%

