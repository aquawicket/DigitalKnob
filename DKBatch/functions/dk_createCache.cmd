@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_createCache()
::#
::#
:dk_createCache
    %dk_call% dk_debugFunc 0
 setlocal
 
    %dk_call% dk_echo "creating cache..."
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	%dk_call% dk_fileWrite "%DKCACHE_DIR%\cache" "%target_app% %target_triple% %target_type%"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
	set "target_app=HelloWorld"
	set "target_triple=WIN_X86_64_CLANG"
	set "target_type=Debug"
    %dk_call% dk_createCache
%endfunction%
