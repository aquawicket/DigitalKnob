@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_install()
::#
:dk_install
	%dk_call% dk_debugFunc 0
 ::setlocal
 
	%dk_call% dk_validatePath DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
    %dk_call% dk_cmakeEval "dk_load(%DKIMPORTS_DIR%/android-ndk/DKMAKE.cmake)" "ANDROID_GENERATOR;ANDROID_API;ANDROID_NDK;ANDROID_TOOLCHAIN_FILE"
    %dk_call% dk_assertVar ANDROID_GENERATOR
    %dk_call% dk_assertVar ANDROID_API
    %dk_call% dk_assertVar ANDROID_NDK
    %dk_call% dk_assertVar ANDROID_TOOLCHAIN_FILE
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	%dk_call% dk_debugFunc 0
 setlocal
 
	%dk_call% dk_install
%endfunction%