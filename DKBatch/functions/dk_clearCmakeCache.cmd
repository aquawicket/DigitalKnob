@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_clearCmakeCache(path)
::#
::#
:dk_clearCmakeCache
setlocal
	%dk_call% dk_debugFunc 1

	set "_path_=%~1"

	%dk_call% dk_info "Deleting CMake cache files in %_path_%"

	if exist "%_path_%\CMakeFiles"			%dk_call% dk_delete "%_path_%\CMakeFiles"
	if exist "%_path_%\CMakeCache.txt"		%dk_call% dk_delete "%_path_%\CMakeCache.txt"
	if exist "%_path_%\cmake_install.cmake"	%dk_call% dk_delete "%_path_%\cmake_install.cmake"

	::for /r %_path_% %%i in (CMakeCache.*) do @if exist "%%i" del "%%i"
	::for /d /r "%_path_%" %%i in (CMakeFiles) do if exist "%%i" rd /s/q "%%i"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_clearCmakeCache "C:/Users/Administrator/digitalknob/Development/DKCpp/apps/HelloWorld/win_x86_64_clang/Debug"
%endfunction%
