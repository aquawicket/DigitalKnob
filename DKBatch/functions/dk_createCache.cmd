@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*

::################################################################################
::# dk_createCache()
::#
::#
:dk_createCache
    call dk_debugFunc 0
 setlocal
 
    echo creating cache...
    ::%dk_call% dk_printVar APP
    ::%dk_call% dk_printVar TARGET_OS
    ::%dk_call% dk_printVar TYPE
    ::%dk_call% dk_printVar LEVEL
        
    :: https://stackoverflow.com/a/5143293/688352
    %dk_call% dk_fileWrite "%DKBRANCH_DIR%\cache" %APP%
    %dk_call% dk_fileAppend "%DKBRANCH_DIR%\cache" %TARGET_OS%
    %dk_call% dk_fileAppend "%DKBRANCH_DIR%\cache" %TYPE%
    ::%dk_call% dk_fileAppend "%DKBRANCH_DIR%\cache" %LEVEL%
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_createCache
%endfunction%
