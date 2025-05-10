@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::###############################################################################
::# dk_Target_Tuple()
::#
::#	Set the cached target variables
::#   This information is pulled from the folder name of the CMAKE_BINARY_DIR
::#   i.e.  win_x86_64_clang
::#
::#	If the CMAKE_BINARY_DIR is missing the <TARGET_OS> or the <TARGET_ARCH>, dk_Target_Tuple_SET will be called to get those variables
::#
::#	target_os   							= android, emscripten, ios, iossim, linux, mac, raspberry, windows 
::#	TARGET_OS   							= ANDROID, EMSCRIPTEN, IOS, IOSSIM, LINUX, MAC, RASPBERRY, WINDOWS
::#	target_arch								= arm32, arm64, x86, x86_64
::#	TARGET_ARCH								= ARM32, ARM64, X86, X86_64
::#	target_env								= clang, cosmopolitan, mingw, msvc, ucrt
::#	TARGET_ENV								= CLANG, cosmopolitan, MINGW, MSVC, UCRT
::# <target_os>_<target_arch>				= android_arm64, emscripten_arm64, ios_arm64, iossim_arm64, linux_arm64, mac_arm64, raspberry_arm64, windows_arm64
::# <target_os>_<target_arch>_<target_env>	= android_arm64_clang, emscripten_arm64_clang, ios_arm64_clang, iossim_arm64_clang, linux_arm64_clang, mac_arm64_clang, raspberry_arm64_clang, windows_arm64_clang
::#
:dk_Target_Tuple
::%setlocal%
	%dk_call% dk_debugFunc 0

	::set "CMAKE_BINARY_DIR=C:/Users/Administrator/digitalknob/Development/DKCpp/apps/HelloWorld/win_x86_64_clang/Debug"
	set "default_target_env=clang"

	::### Get TARGET_DIR ###
	if defined CMAKE_BINARY_DIR (%dk_call% dk_realpath "%CMAKE_BINARY_DIR%" TARGET_DIR)

	%dk_call% dk_printVar TARGET_DIR 							&:: TARGET_DIR = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang/Debug

	::### Set target_type / TARGET_TYPE ###
	if "!TARGET_DIR!" equ "Debug" (	
		rem ### Get DEBUG ###
		!dk_call! dk_set target_type DEBUG						&rem 	    target_type	= DEBUG
		!dk_call! dk_set !target_type! 1						&rem 			  DEBUG = 1	
		rem !dk_call! dk_set TARGET_TYPE Debug					&rem 		TARGET_TYPE	= Debug
		!dk_call! dk_dirname TARGET_DIR Target_Tuple_DIR		&rem  Target_Tuple_DIR = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang
	) else if "!TARGET_DIR!" equ "Release" (
		rem ### Get RELEASE ###
		!dk_call! dk_set target_type RELEASE 					&rem 	    target_type = RELEASE
		!dk_call! dk_set !target_type! 1						&rem 			RELEASE = 1	
		rem !dk_call! dk_set TARGET_TYPE Release				&rem 		TARGET_TYPE = Release
		!dk_call! dk_dirname !TARGET_DIR! Target_Tuple_DIR		&rem  Target_Tuple_DIR = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang
	)

	%dk_call% dk_containsCI "!TARGET_DIR!" "android" 		&& goto if
	%dk_call% dk_containsCI "!TARGET_DIR!" "android" 		&& goto if
	%dk_call% dk_containsCI "!TARGET_DIR!" "emscripten" 	&& goto if
	%dk_call% dk_containsCI "!TARGET_DIR!" "ios" 			&& goto if
	%dk_call% dk_containsCI "!TARGET_DIR!" "iossim"			&& goto if
	%dk_call% dk_containsCI "!TARGET_DIR!" "linux" 			&& goto if
	%dk_call% dk_containsCI "!TARGET_DIR!" "mac"			&& goto if
	%dk_call% dk_containsCI "!TARGET_DIR!" "raspberry" 		&& goto if
	%dk_call% dk_containsCI "!TARGET_DIR!" "windows"		&& goto if
	%dk_call% dk_containsCI "!TARGET_DIR!" "cosmopolitan"	&& goto if
	goto else
	:if
		!dk_call! dk_set Target_Tuple_DIR !TARGET_DIR!			&:: Target_Tuple_DIR = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang
	:else
		!dk_call! dk_Target_Tuple_SET
		!dk_call! dk_set Target_Tuple_DIR !TARGET_DIR!/!Target_Tuple!
	:endif

	if exist !Target_Tuple_DIR! (goto Target_Tuple_DIR_EXISTS)
		!dk_call! dk_warning "Target_Tuple_DIR:!Target_Tuple_DIR! does not exits."
		!dk_call! dk_debug "Creating directory . . .!Target_Tuple_DIR!"
		!dk_call! dk_mkdir !Target_Tuple_DIR!
	:Target_Tuple_DIR_EXISTS
	!dk_call! dk_assertPath Target_Tuple_DIR
		
	::### Set DK_PROJECT_DIR ###
	!dk_call! dk_dirname !Target_Tuple_DIR! DK_PROJECT_DIR
	!dk_call! dk_set DK_PROJECT_DIR !DK_PROJECT_DIR!
	!dk_call! dk_assertPath DK_PROJECT_DIR

	::### Set Target_Tuple/Target_Tuple, <target_os>_<target_arch>_<target_env>/<TARGET_OS>_<TARGET_ARCH>_<TARGET_ENV> ###
	!dk_call! dk_basename !Target_Tuple_DIR! Target_Tuple		&:: Target_Tuple 	= win_x86_64_clang
	!dk_call! dk_set Target_Tuple !Target_Tuple!				&:: Globalize the variable
	!dk_call! dk_set Target_Tuple !Target_Tuple!				&:: Target_Tuple	= win_x86_64_clang
	!dk_call! dk_toUpper !Target_Tuple! Target_Tuple			&:: Target_Tuple	= WIN_X86_64_CLANG
	!dk_call! dk_set Target_Tuple !Target_Tuple!				&:: Globalize the variable
	!dk_call! dk_set Target_Tuple !Target_Tuple!				&::	Target_Tuple = WIN_X86_64_CLANG
	!dk_call! dk_set !Target_Tuple! 1						    &:: win_x86_64_clang = 1
	!dk_call! dk_set !Target_Tuple! 1						    &:: WIN_X86_64_CLANG = 1

	::### Set target_os / TARGET_OS / <target_os>_target / <TARGET_OS>_TARGET
	%dk_call% dk_containsCI "!Target_Tuple!" "android" 		&& !dk_call! dk_set target_os android
	%dk_call% dk_containsCI "!Target_Tuple!" "emscripten" 		&& !dk_call! dk_set target_os emscripten
	%dk_call% dk_containsCI "!Target_Tuple!" "ios" 			&& !dk_call! dk_set target_os ios
	%dk_call% dk_containsCI "!Target_Tuple!" "iossim" 			&& !dk_call! dk_set target_os iossim 
	%dk_call% dk_containsCI "!Target_Tuple!" "linux" 			&& !dk_call! dk_set target_os linux
	%dk_call% dk_containsCI "!Target_Tuple!" "mac" 			&& !dk_call! dk_set target_os mac
	%dk_call% dk_containsCI "!Target_Tuple!" "raspberry" 		&& !dk_call! dk_set target_os raspberry
	%dk_call% dk_containsCI "!Target_Tuple!" "windows" 		&& !dk_call! dk_set target_os windows
	%dk_call% dk_containsCI "!Target_Tuple!" "win"				&& !dk_call! dk_set target_os win
	%dk_call% dk_containsCI "!Target_Tuple!" "cosmopolitan"	&& !dk_call! dk_set target_os cosmopolitan
	if not defined target_os (
		!dk_call! dk_warning "The target Target_Tuple:!Target_Tuple! does not contain a valid target_os"
		!dk_call! dk_unset Target_Tuple
		!dk_call! dk_unset Target_Tuple 
		!dk_call! dk_Target_Tuple_SET
	) else (
		!dk_call! dk_toUpper !target_os! TARGET_OS
		!dk_call! dk_set TARGET_OS !TARGET_OS! 
		!dk_call! dk_set target_os !target_os!
		!dk_call! dk_set TARGET_OS !TARGET_OS!
		!dk_call! dk_set !target_os! 1
		!dk_call! dk_set !TARGET_OS! 1
		!dk_call! dk_set !target_os!_target 1
		!dk_call! dk_set !TARGET_OS!_TARGET 1
	)
	::### Get target_arch / TARGET_ARCH
	%dk_call% dk_containsCI "!Target_Tuple!" "arm64" 			&& !dk_call! dk_set target_arch arm64
	%dk_call% dk_containsCI "!Target_Tuple!" "arm32" 			&& !dk_call! dk_set target_arch arm32
	%dk_call% dk_containsCI "!Target_Tuple!" "x86_64" 			&& !dk_call! dk_set target_arch x86_64
	%dk_call% dk_containsCI "!Target_Tuple!" "x86" 			&& !dk_call! dk_set target_arch x86
	%dk_call% dk_containsCI "!Target_Tuple!" "cosmopolitan" 	&& !dk_call! dk_set target_arch cosmopolitan	
	if not defined target_arch (
		!dk_call! dk_warning "The target Target_Tuple:!Target_Tuple! does not contain a valid target_arch"
		!dk_call! dk_Target_Tuple_SET
	) else (
		!dk_call! dk_toUpper !target_arch! TARGET_ARCH
		!dk_call! dk_set TARGET_ARCH !TARGET_ARCH!
		!dk_call! dk_set target_arch !target_arch!)
		!dk_call! dk_set TARGET_ARCH !TARGET_ARCH!)
		!dk_call! dk_set !target_arch! 1
		!dk_call! dk_set !TARGET_ARCH! 1
		!dk_call! dk_set !target_arch!_target 1)
		!dk_call! dk_set !TARGET_ARCH!_TARGET 1)
	)

	::### Set evn / TARGET_ENV 
	%dk_call% dk_containsCI "!Target_Tuple!" "clang" 			&& !dk_call! dk_set target_env clang
	%dk_call% dk_containsCI "!Target_Tuple!" "mingw" 			&& !dk_call! dk_set target_env mingw
	%dk_call% dk_containsCI "!Target_Tuple!" "ucrt"  			&& !dk_call! dk_set target_env ucrt
	%dk_call% dk_containsCI "!Target_Tuple!" "msvc"  			&& !dk_call! dk_set target_env msvc
	%dk_call% dk_containsCI "!Target_Tuple!" "cosmopolitan" 	&& !dk_call! dk_set target_env cosmopolitan
	if not defined target_env (
		!dk_call! dk_warning "The target Target_Tuple:!Target_Tuple! does not contain a valid target_env"
		!dk_call! dk_set target_env !default_target_env!
	) else (
		!dk_call! dk_toUpper !target_env! TARGET_ENV
		!dk_call! dk_set TARGET_ENV !TARGET_ENV!
		!dk_call! dk_set target_env !target_env!
		!dk_call! dk_set TARGET_ENV !TARGET_ENV!
		!dk_call! dk_set !target_env! 1
		!dk_call! dk_set !TARGET_ENV! 1
		!dk_call! dk_set !target_env!_target 1
		!dk_call! dk_set !TARGET_ENV!_TARGET 1
	)

	::### Set MSYSTEM
	if defined !TARGET_ENV! (
		if defined CLANG if defined ARM64 (
			!dk_call! dk_set msystem "!target_env!!target_arch!"	&rem msystem = clangarm64
			!dk_call! dk_set MSYSTEM "!TARGET_ENV!!TARGET_ARCH!"	&rem MSYSTEM = CLANGARM64
		) else if defined X86_64 (
			!dk_call! dk_set msystem "!target_env!64"				&rem msystem = clang64, mingw64, ucrt64
			!dk_call! dk_set MSYSTEM "!TARGET_ENV!64"				&rem MSYSTEM = CLANG64, MINGW64, UCRT64
		) else if defined X86 (
			!dk_call! dk_set msystem "!target_env!32"				&rem msystem = clang32, mingw32
			!dk_call! dk_set MSYSTEM "!TARGET_ENV!32"				&rem MSYSTEM = CLANG32, MINGW32
		) else (
			!dk_call! dk_fatal "The target Target_Tuple:!Target_Tuple! does not contain a valid target_env or msystem"
		)
		!dk_call! dk_set !MSYSTEM! 1								&rem CLANGARM64, CLANG64, CLANG32, MINGW64, MINGW32, UCRT64 = 1
	)
		
	::### Set target_os_arch / TARGET_OS_ARCH ###
	!dk_call! dk_set target_os_arch "!target_os!_!target_arch!"
	!dk_call! dk_set TARGET_OS_ARCH "!TARGET_OS!_!TARGET_ARCH!"
	!dk_call! dk_set target_os_arch "!target_os_arch!"
	!dk_call! dk_set TARGET_OS_ARCH "!TARGET_OS_ARCH!"
	!dk_call! dk_set !target_os_arch! 1
	!dk_call! dk_set !TARGET_OS_ARCH! 1
	!dk_call! dk_set !target_os_arch!_target 1
	!dk_call! dk_set !TARGET_OS_ARCH!_TARGET 1

	::### Set DEBUG_DIR and RELEASE_DIR variables
	if defined IOS (
		!dk_call! dk_set DEBUG_DIR Debug-iphoneos
		!dk_call! dk_set RELEASE_DIR Release-iphoneos
	) else if defined IOSSIM (
		!dk_call! dk_set DEBUG_DIR Debug-iphonesimulator
		!dk_call! dk_set RELEASE_DIR Release-iphonesimulator
	) else (
		!dk_call! dk_set DEBUG_DIR Debug
		!dk_call! dk_set RELEASE_DIR Release
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_Target_Tuple
%endfunction%
