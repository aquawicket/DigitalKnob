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


rem ##################################################################################
rem # dk_rename(from, to)
rem # dk_rename(from, to, OVERWRITE)
rem #
rem # Rename/Move a file or directory to another name/location
rem #
rem # @from		- The source path to move or rename
rem # @to			- The destination path to move or rename to
rem # OVERWRITE	- if OVERWRITE is specified, overwritting existing file or folder is enabled
rem #
:dk_rename
%setlocal%
	
	set "_from_=%~1"
	set "_to_=%~2"
	if /i "%~3" equ "OVERWRITE" (set "OVERWRITE=1") else (set "OVERWRITE=0")
	
	%dk_call% dk_info "Renameing %_from_% to %_to_%"
	
	if NOT EXIST "%_from_%" (
		%dk_call% dk_error "dk_rename: %_from_% NOT found"
		%return%
	)
	
	if EXIST "%_to_%" (
		if "%OVERWRITE%" neq "1" (
			%dk_call% dk_error "dk_rename Cannot rename file. Destiantion already exists and OVERWRITE is NOT set"
			%return%
		)
		%dk_call% dk_delete %_to_%
	)
	
	rem the base directory of the %_to_% path must EXIST.	
	%dk_call% dk_dirname "%_to_%"
	%dk_call% dk_mkdir "%dk_dirname%"
	
	move /Y "%_from_:/=\%" "%_to_:/=\%" 1>nul 2>nul
	
	rem TODO
	rem [ ? = "success" ]
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
	
	%dk_call% dk_fileWrite "%DKCACHE_DIR%/renameMe.file" "dk_rename test"
	%dk_call% dk_rename "%DKCACHE_DIR%/renameMe.file" "%DKCACHE_DIR%/iWasRenamed.txt" OVERWRITE
	
	%dk_call% dk_mkdir "%DKCACHE_DIR%/renameMe"
	%dk_call% dk_rename "%DKCACHE_DIR%/renameMe" "%DKCACHE_DIR%/iWasRenamed" OVERWRITE
%endfunction%