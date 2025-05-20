@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

dk_echo(STATUS "#####################################################################")
dk_echo(STATUS "################ Android_X86_64_Clang_Toolchain.cmake ###############")
dk_echo(STATUS "#####################################################################")
# https://android.googlesource.com/platform/ndk/+/master/docs/BuildSystemMaintainers.md

dk_exit()

dk_validate(ANDROID_NDK					"dk_depend(android-ndk)")
dk_set(ANDROID_ABI						x86_64)
dk_set(ANDROID_CPP_FEATURES				"rtti exceptions")
dk_set(ANDROID_STL						c++_static)
dk_set(ANDROID_STL_FORCE_FEATURES		1)
dk_set(ANDROID_TOOLCHAIN				clang)

dk_set(CMAKE_TOOLCHAIN_FILE				"${ANDROID_NDK}/buil/cmake/android.toolchain.cmake")
dk_set(CMAKE_GENERATOR					"Unix Makefiles")
if(Windows_Host)
	#dk_validate(MSYS2_MAKE_PROGRAM		"dk_depend(msys2)")
	#dk_set(CMAKE_MAKE_PROGRAM			"${MSYS2_BIN}/make.exe")
	dk_set(CMAKE_MAKE_PROGRAM			"${ANDROID_NDK}/prebuilt/${Android_Host_Tag}/bin/make${exe}")
else()
	dk_set(CMAKE_MAKE_PROGRAM			"make")
endif()
dk_set(CMAKE_C_COMPILER					"${ANDROID_NDK}/toolchains/llvm/prebuilt/${Android_Host_Tag}/bin/clang${exe}")
dk_set(CMAKE_CXX_COMPILER				"${ANDROID_NDK}/toolchains/llvm/prebuilt/${Android_Host_Tag}/bin/clang++${exe}")
dk_set(CMAKE_ANDROID_STL_TYPE			${ANDROID_STL})
dk_append(CMAKE_C_FLAGS					-DANDROID -DANDROID_ARM64 -std=c17)
dk_append(CMAKE_CXX_FLAGS				-DANDROID -DANDROID_ARM64 -std=c++1z)
