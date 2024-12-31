@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_readCache(rtn:target_app, rtn:target_triple, rtn:target_type)
::#
::#
:dk_readCache
 setlocal enableDelayedExpansion
    %dk_call% dk_debugFunc 3
    
    if "!DE!" neq "" %dk_call% dk_error "%__FUNCTION__% requires delayed expansion"
    
    %dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
    ::%dk_call% dk_printVar DKCACHE_DIR
    ::if not exist "%DKCACHE_DIR%\cache" %dk_call% dk_warning "%DKCACHE_DIR%\cache does not exist" && %return%
    if not exist "%DKCACHE_DIR%\cache" %return%
    
    set /a count=0
    for /f "tokens=*" %%a in (%DKCACHE_DIR%\cache) do (
        if !count! equ 0 set "_target_app_=%%a"
        if !count! equ 1 set "_target_triple_=%%a"
        if !count! equ 2 set "_target_type_=%%a"
        set /a count+=1
    )
    
    endlocal && set "%1=%_target_app_%" && set "%2=%_target_triple_%" && set "%3=%_target_type_%"
    ::%dk_call% dk_printVar target_app
    ::%dk_call% dk_printVar target_triple
    ::%dk_call% dk_printVar target_type
%endfunction%








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
    
    %dk_call% dk_readCache target_app target_triple target_type
    %dk_call% dk_printVar target_app
    %dk_call% dk_printVar target_triple
    %dk_call% dk_printVar target_type
%endfunction%
