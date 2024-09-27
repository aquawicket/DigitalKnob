@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installAndroidNdk()
::#
:dk_installAndroidNdk
	call dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
    %dk_call% dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/android-ndk/DKMAKE.cmake')" "ANDROID_GENERATOR;ANDROID_API;ANDROID_NDK;ANDROID_TOOLCHAIN_FILE"
    %dk_call% dk_printVar ANDROID_GENERATOR
    %dk_call% dk_printVar ANDROID_API
    %dk_call% dk_printVar ANDROID_NDK
    %dk_call% dk_printVar ANDROID_TOOLCHAIN_FILE
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installAndroidNdk
%endfunction%