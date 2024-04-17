::dk_include_guard()

::####################################################################
::# dk_validate_android_ndk()
::#
::#
:dk_validate_android_ndk () {
	call:dk_verbose "dk_validate_android_ndk(%*)"
	
    call:dk_cmake_eval "include('%DKIMPORTS_DIR%/android-ndk/DKMAKE.cmake')" "ANDROID_GENERATOR;ANDROID_API;ANDROID_NDK;ANDROID_TOOLCHAIN_FILE"
    call:dk_debug ANDROID_GENERATOR
    call:dk_debug ANDROID_API
    call:dk_debug ANDROID_NDK
    call:dk_debug ANDROID_TOOLCHAIN_FILE
    call:dk_check_error
goto:eof