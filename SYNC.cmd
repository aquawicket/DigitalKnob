rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	%endfuncion%
	exit /b %errorlevel%
)
%endfuncion%
rem #################################################################################################################################################


rem ################################################################################
rem # SYNC()
rem #
rem #
:SYNC
%setlocal%
  
	rem ###### Folder Locations ######
	set "source=%USERPROFILE:\=/%/Digital Knob"

	for %%i in (Z Y X W V U T S R Q P O N M L K J I H G F E D C B A) do (
		if EXIST "%%i:/DigitalKnob/Development.git" (
			set "USB_Drive=%%i:"
			
		)
	)
	echo USB_Drive = '%USB_Drive%'
	set "USB_DK_Dir=%USB_Drive%\DigitalKnob"

	set "target=%USB_DK_Dir%"
  	
 	set "repo_branch=Development"
	rem %dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	rem set "repo_source=%DKBRANCH_DIR%"
	set "repo_source=%source%/%repo_branch%"
	set "repo_target=%target%/%repo_branch%"
 	set "DKSsh_git_url=ssh://u108565871@access912915170.webspace-data.io/~/DigitalKnob/Development.git"
	
	echo call "%~dp0BACKUP.cmd"
 	call "%~dp0BACKUP.cmd"
 	echo call "%~dp0RESTORE.cmd"
	call "%~dp0RESTORE.cmd"
  
%endfuncion%
exit /b %errorlevel%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	call :SYNC

%endfuncion%
exit /b %errorlevel%
