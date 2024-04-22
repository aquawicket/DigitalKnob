::dk_include_guard()

::####################################################################
::# dk_validate_android_ndk()
::#
::#
:dk_validate_android_ndk () {
	call dk_verbose "dk_validate_android_ndk(%*)"
	
    if "%DKIMPORTS_DIR%"=""   call dk_validate_branch
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/android-ndk/DKMAKE.cmake')" "ANDROID_GENERATOR;ANDROID_API;ANDROID_NDK;ANDROID_TOOLCHAIN_FILE"
    call dk_debug ANDROID_GENERATOR
    call dk_debug ANDROID_API
    call dk_debug ANDROID_NDK
    call dk_debug ANDROID_TOOLCHAIN_FILE
    call dk_checkError
goto:eof