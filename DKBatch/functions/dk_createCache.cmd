@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_createCache()
::#
::#
:dk_createCache
    %dk_call% dk_debugFunc 0
 setlocal
 
    echo creating cache...
    ::%dk_call% dk_printVar target_app
    ::%dk_call% dk_printVar target_triple
    ::%dk_call% dk_printVar target_type
        
    :: https://stackoverflow.com/a/5143293/688352
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
    %dk_call% dk_fileWrite "%DKCACHE_DIR%\cache" %target_app%
    %dk_call% dk_fileAppend "%DKCACHE_DIR%\cache" %target_triple%
    %dk_call% dk_fileAppend "%DKCACHE_DIR%\cache" %target_type%
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
    %dk_call% dk_createCache
%endfunction%
