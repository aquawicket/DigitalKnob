@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_clearCmakeCache()
::#
::#
:dk_clearCmakeCache
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_info "Deleting CMake cache files. . ."
    
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_validate DKAPPS_DIR     "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate DKPLUGINS_DIR  "%dk_call% dk_DKBRANCH_DIR"
	
	%dk_call% dk_cd "%DK3RDPARTY_DIR%"
    for /r %%i in (CMakeCache.*) do del "%%i"
    for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i"
	
	%dk_call% dk_cd "%DKAPPS_DIR%"
    for /r %%i in (CMakeCache.*) do del "%%i"
    for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i"
	
	%dk_call% dk_cd "%DKPLUGINS_DIR%"
    for /r %%i in (CMakeCache.*) do del "%%i"
    for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i"

%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_clearCmakeCache
%endfunction%
