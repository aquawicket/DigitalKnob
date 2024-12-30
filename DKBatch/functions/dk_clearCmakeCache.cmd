@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_clearCmakeCache(path)
::#
::#
:dk_clearCmakeCache
    call dk_debugFunc 1
 setlocal
	
	set "_path_=%~1"
	set "_path_=%_path_:/=\%"
	
    %dk_call% dk_info "Deleting CMake cache files in %_path_%"
	
	%dk_call% dk_delete "%_path_%\CMakeFiles"
	%dk_call% dk_delete "%_path_%\CMakeCache.txt"
	%dk_call% dk_delete "%_path_%\cmake_install.cmake"

    ::for /r %_path_% %%i in (CMakeCache.*) do @if exist "%%i" del "%%i"
	::for /d /r "%_path_%" %%i in (CMakeFiles) do if exist "%%i" rd /s/q "%%i"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_clearCmakeCache "C:/Users/Administrator/digitalknob/Development/DKApps/HelloWorld/win_x86_64_clang/Debug"
%endfunction%
