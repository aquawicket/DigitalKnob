@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_deleteTempFiles()
::#
::#
:dk_deleteTempFiles
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_info "Deleteing .tmp files . . ."
    %dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_getDKPaths"
    cd "%DIGITALKNOB_DIR%"
    for /r %%i in (*.tmp) do del "%%i"
    for /r %%i in (*.TMP) do del "%%i"
    ::%dk_call% dk_checkError
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_deleteTempFiles
%endfunction%
