@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_clearCmakeCache(path)
::#
::#
:dk_clearCmakeCache
%setlocal%
	%dk_call% dk_debugFunc 1

	set "_path_=%~1"

	%dk_call% dk_info "Deleting CMake cache files in %_path_%"

	if EXIST "%_path_%/CMakeFiles"			%dk_call% dk_delete "%_path_%/CMakeFiles"
	if EXIST "%_path_%/CMakeCache.txt"		%dk_call% dk_delete "%_path_%/CMakeCache.txt"
	if EXIST "%_path_%/cmake_install.cmake"	%dk_call% dk_delete "%_path_%/cmake_install.cmake"

	::for /r %_path_% %%G in (CMakeCache.*) do @if EXIST "%%G" del "%%G"
	::for /d /r "%_path_%" %%G in (CMakeFiles) do @if EXIST "%%G" rd /s/q "%%G"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::for /r "%DKBRANCH_DIR:/=\%" %%G in (*.*) do echo "%%G"
	for /r "%DKBRANCH_DIR:/=\%" %%G in (cmake_install.cmake) do @if EXIST "%%G" (
		echo deleting "%%G"
		del "%%G"
	)
	for /d /r "%DKBRANCH_DIR:/=\%" %%G in (CMakeFiles) do @if EXIST "%%G" rd /s/q "%%G"
	
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_clearCmakeCache "%DKBRANCH_DIR%"
	
	
%endfunction%
