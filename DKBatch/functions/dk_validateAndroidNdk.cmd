call dk_includeGuard

::####################################################################
::# dk_validateAndroidNdk()
::#
::#
:dk_validateAndroidNdk () {
	call dk_debugFunc
	
    if "%DKIMPORTS_DIR%"=""   call dk_validateBranch
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/android-ndk/DKMAKE.cmake')" "ANDROID_GENERATOR;ANDROID_API;ANDROID_NDK;ANDROID_TOOLCHAIN_FILE"
    call dk_debug ANDROID_GENERATOR
    call dk_debug ANDROID_API
    call dk_debug ANDROID_NDK
    call dk_debug ANDROID_TOOLCHAIN_FILE
    call dk_checkError
goto:eof