::# https://android.googlesource.com/platform/ndk/+/master/docs/BuildSystemMaintainers.md

::### FIXME ###
exit /b 1



%dk_call% dk_echo "#####################################################################"
%dk_call% dk_echo "################ Android_X86_64_Clang_Toolchain.cmd #################"
%dk_call% dk_echo "#####################################################################"

set CMAKE_GENERATOR="Unix Makefiles"








rem  %dk_call% dk_validate 		ANDROID_NDK					"%dk_call% dk_depend android-ndk"
::%dk_call% dk_set 				ANDROID_ABI					x86_64
::%dk_call% dk_set 				ANDROID_CPP_FEATURES		"rtti exceptions"
::%dk_call% dk_set 				ANDROID_STL					"c++_static"
::%dk_call% dk_set 				ANDROID_STL_FORCE_FEATURES	1
::%dk_call% dk_set 				ANDROID_TOOLCHAIN			"clang"
::%dk_call% dk_set 				CMAKE_TOOLCHAIN_FILE		"%ANDROID_NDK%/buil/cmake/android.toolchain.cmd"
::%dk_call% dk_set 				CMAKE_GENERATOR				"Unix Makefiles"
::if defined Windows_Host (
rem %dk_call% dk_validate 		MSYS2_MAKE_PROGRAM			"%dk_call% dk_depend msys2"
rem %dk_call% dk_set 			CMAKE_MAKE_PROGRAM			"%MSYS2_BIN%/make.exe"
::	%dk_call% dk_set 			CMAKE_MAKE_PROGRAM			"%ANDROID_NDK%/prebuilt/%Android_Host_Tag%/bin/make%exe%"
::) else (	
::	%dk_call% dk_set 			CMAKE_MAKE_PROGRAM			"make"
::)
::%dk_call% dk_set 				CMAKE_C_COMPILER			"%ANDROID_NDK%/toolchains/llvm/prebuilt/%Android_Host_Tag%/bin/clang%exe%"
::%dk_call% dk_set 				CMAKE_CXX_COMPILER			"%ANDROID_NDK%/toolchains/llvm/prebuilt/%Android_Host_Tag%/bin/clang++%exe%"
::%dk_call% dk_set 				CMAKE_ANDROID_STL_TYPE		"%ANDROID_STL%"
rem  %dk_call% dk_append 		CMAKE_C_FLAGS				-DANDROID -DANDROID_ARM64 -std=c17
rem  %dk_call% dk_append 		CMAKE_CXX_FLAGS				-DANDROID -DANDROID_ARM64 -std=c++1z
::%dk_call% dk_set				CMAKE_GENERATOR				"Unix Makefiles"