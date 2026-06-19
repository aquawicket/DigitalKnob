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
rem # dk_deleteEmptyDirs(base_path)
rem #
rem #
:dk_deleteEmptyDirs
%setlocal%
	
	echo deleting all empty directories in %~1
	%dk_call% dk_confirm || (%return%)

	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	for /f "delims=" %%d in ('dir "%~1" /ad /b /s ^| sort /r') do @(dir /a-d /b "%%d" | %findstr_str% "." > nul || rd /s /q "%%d")
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_selectFolder
	%dk_call% dk_deleteEmptyDirs "%dk_selectFolder%"
	
%endfunction%

