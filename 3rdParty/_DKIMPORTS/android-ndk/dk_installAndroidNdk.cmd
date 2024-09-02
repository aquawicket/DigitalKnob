@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0

::####################################################################
::# dk_installAndroidNdk()
::#
:dk_installAndroidNdk
	call dk_debugFunc 0
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/android-ndk/DKMAKE.cmake')" "ANDROID_GENERATOR;ANDROID_API;ANDROID_NDK;ANDROID_TOOLCHAIN_FILE"
    call dk_printVar ANDROID_GENERATOR
    call dk_printVar ANDROID_API
    call dk_printVar ANDROID_NDK
    call dk_printVar ANDROID_TOOLCHAIN_FILE
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installAndroidNdk
goto:eof