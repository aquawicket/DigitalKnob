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


rem ####################################################################
rem # dk_clearCmakeCache(path)
rem #
rem #
:dk_clearCmakeCache
%setlocal%

	set "_path_=%~1"

	%dk_call% dk_info "Deleting CMake cache files in %_path_%"

	if EXIST "%_path_%/CMakeFiles"			%dk_call% dk_delete "%_path_%/CMakeFiles"
	if EXIST "%_path_%/CMakeCache.txt"		%dk_call% dk_delete "%_path_%/CMakeCache.txt"
	if EXIST "%_path_%/cmake_install.cmake"	%dk_call% dk_delete "%_path_%/cmake_install.cmake"

	rem for /r %_path_% %%G in (CMakeCache.*) do @if EXIST "%%G" del "%%G"
	rem for /d /r "%_path_%" %%G in (CMakeFiles) do @if EXIST "%%G" rd /s/q "%%G"
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem for /r "%DKBRANCH_DIR:/=\%" %%G in (*.*) do echo "%%G"
	for /r "%DKBRANCH_DIR:/=\%" %%G in (cmake_install.cmake) do @if EXIST "%%G" (
		echo deleting "%%G"
		del "%%G"
	)
	for /d /r "%DKBRANCH_DIR:/=\%" %%G in (CMakeFiles) do @if EXIST "%%G" rd /s/q "%%G"
	
	%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
	%dk_call% dk_clearCmakeCache "%DKBRANCH_DIR%"
	
	
%endfunction%
