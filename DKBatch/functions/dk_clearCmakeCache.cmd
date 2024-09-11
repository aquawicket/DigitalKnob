@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_clearCmakeCache()
::#
::#
:dk_clearCmakeCache
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_info "Deleteing CMake cache files. . ."
    
    %dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_getDKPaths"
    cd "%DIGITALKNOB_DIR%"
    for /r %%i in (CMakeCache.*) do del "%%i"
    for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_clearCmakeCache
%endfunction%
