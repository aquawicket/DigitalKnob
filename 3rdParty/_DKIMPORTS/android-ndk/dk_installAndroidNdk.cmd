@echo off
call ../../../DKBatch/functions/DK.cmd

::####################################################################
::# dk_installAndroidNdk()
::#
:dk_installAndroidNdk () {
	call dk_debugFunc
	
	call dk_validate DKIMPORTS_DIR "dk_validateBranch"
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/android-ndk/DKMAKE.cmake')" "ANDROID_GENERATOR;ANDROID_API;ANDROID_NDK;ANDROID_TOOLCHAIN_FILE"
    call dk_printVar ANDROID_GENERATOR
    call dk_printVar ANDROID_API
    call dk_printVar ANDROID_NDK
    call dk_printVar ANDROID_TOOLCHAIN_FILE
    call dk_checkError
goto:eof