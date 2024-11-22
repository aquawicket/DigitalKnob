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
	
	::for /f "tokens=*" %%G in ('dir /b /s /a:d "C:\Users\Administrator\digitalknob\3rdParty*"') do echo Found %%G
	::for /f "tokens=*" %%G in ('dir /b /s /a:d "%~1*"') do echo Found %%G
	
::	for /f "tokens=*" %%G in ('dir /b /a:d %DK3RDPARTY_DIR%') do (
::      if exist "!DK3RDPARTY_DIR!\%%G\%~2\CMakeFiles"           rd /s/q "!DK3RDPARTY_DIR!\%%G\%~2\CMakeFiles"
::		if exist "!DK3RDPARTY_DIR!\%%G\%~2\CMakeCache.txt"       del "!DK3RDPARTY_DIR!\%%G\%~2\CMakeCache.txt"
::	)
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_clearCmakeCache "C:\Users\Administrator\digitalknob\Development\DKApps\HelloWorld\win_x86_64_clang\Debug"
%endfunction%
