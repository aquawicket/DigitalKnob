@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_readCache(rtn:APP, rtn:triple, rtn:DKBUILD_TYPE)
::#
::#
:dk_readCache
 setlocal enableDelayedExpansion
    call dk_debugFunc 3
    
    if "!DE!" neq "" %dk_call% dk_error "%__FUNCTION__% requires delayed expansion"
    
    %dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
    ::%dk_call% dk_printVar DKCACHE_DIR
    ::if not exist "%DKCACHE_DIR%\cache" %dk_call% dk_warning "%DKCACHE_DIR%\cache does not exist" && %return%
    if not exist "%DKCACHE_DIR%\cache" %return%
    
    set /a count=0
    for /f "tokens=*" %%a in (%DKCACHE_DIR%\cache) do (
        if !count! equ 0 set "_APP_=%%a"
        if !count! equ 1 set "_triple_=%%a"
        if !count! equ 2 set "_BUILD_TYPE_=%%a"
        set /a count+=1
    )
    
    endlocal && set "%1=%_APP_%" && set "%2=%_triple_%" && set "%3=%_BUILD_TYPE_%"
    ::%dk_call% dk_printVar APP
    ::%dk_call% dk_printVar triple
    ::%dk_call% dk_printVar DKBUILD_TYPE
%endfunction%








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
    
    %dk_call% dk_readCache APP triple DKBUILD_TYPE
    %dk_call% dk_printVar APP
    %dk_call% dk_printVar triple
    %dk_call% dk_printVar DKBUILD_TYPE
%endfunction%
