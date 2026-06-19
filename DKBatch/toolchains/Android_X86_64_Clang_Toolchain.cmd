rem # https://android.googlesource.com/platform/ndk/+/master/docs/BuildSystemMaintainers.md

rem ### FIXME ###
exit /b 1



%dk_call% dk_echo "#####################################################################"
%dk_call% dk_echo "################ Android_X86_64_Clang_toolchain.cmd #################"
%dk_call% dk_echo "#####################################################################"

set CMAKE_GENERATOR="Unix Makefiles"








rem  %dk_call% dk_validate 			ANDROID_NDK					%dk_call% dk_depend android-ndk
rem %dk_call% dk_set 				ANDROID_ABI					x86_64
rem %dk_call% dk_set 				ANDROID_CPP_FEATURES		"rtti exceptions"
rem %dk_call% dk_set 				ANDROID_STL					"c++_static"
rem %dk_call% dk_set 				ANDROID_STL_FORCE_FEATURES	1
rem %dk_call% dk_set 				ANDROID_TOOLCHAIN			"clang"
rem %dk_call% dk_set 				CMAKE_TOOLCHAIN_FILE		"%ANDROID_NDK%/buil/cmake/android.toolchain.cmd"
rem %dk_call% dk_set 				CMAKE_GENERATOR				"Unix Makefiles"
rem if defined Windows_Host (
rem %dk_call% dk_validate 		MSYS2_MAKE_PROGRAM			%dk_call% dk_depend msys2
rem %dk_call% dk_set 			CMAKE_MAKE_PROGRAM			"%MSYS2_BIN%/make.exe"
rem 	%dk_call% dk_set 			CMAKE_MAKE_PROGRAM			"%ANDROID_NDK%/prebuilt/%Android_Host_Tag%/bin/make%exe%"
rem ) else (	
rem 	%dk_call% dk_set 			CMAKE_MAKE_PROGRAM			"make"
rem )
rem %dk_call% dk_set 				CMAKE_C_COMPILER			"%ANDROID_NDK%/toolchains/llvm/prebuilt/%Android_Host_Tag%/bin/clang%exe%"
rem %dk_call% dk_set 				CMAKE_CXX_COMPILER			"%ANDROID_NDK%/toolchains/llvm/prebuilt/%Android_Host_Tag%/bin/clang++%exe%"
rem %dk_call% dk_set 				CMAKE_ANDROID_STL_TYPE		"%ANDROID_STL%"
rem %dk_call% dk_append 			CMAKE_C_FLAGS				-DANDROID -DANDROID_ARM64 -std=c17
rem %dk_call% dk_append 			CMAKE_CXX_FLAGS				-DANDROID -DANDROID_ARM64 -std=c++1z
rem %dk_call% dk_set				CMAKE_GENERATOR				"Unix Makefiles"