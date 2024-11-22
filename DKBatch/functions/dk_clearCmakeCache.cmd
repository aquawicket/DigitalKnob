@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_clearCmakeCache(path)
::#
::#
:dk_clearCmakeCache
    call dk_debugFunc 1
 setlocal
 
    %dk_call% dk_info "Deleting CMake cache files in %~1"
	
	%dk_call% dk_delete "%~1\CMakeFiles"
	%dk_call% dk_delete "%~1\CMakeCache.txt"
	%dk_call% dk_delete "%~1\cmake_install.cmake"

    ::for /r %~1 %%i in (CMakeCache.*) do @if exist "%%i" del "%%i"
	::for /d /r "%~1" %%i in (CMakeFiles) do if exist "%%i" rd /s/q "%%i"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_clearCmakeCache "C:\Users\Administrator\digitalknob\Development\DKApps\HelloWorld\win_x86_64_clang\Debug"
%endfunction%
