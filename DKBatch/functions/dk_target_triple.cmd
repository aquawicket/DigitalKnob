@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::###############################################################################
::# dk_target_triple()
::#
::#	Set the cached target variables
::#   This information is pulled from the folder name of the CMAKE_BINARY_DIR
::#   i.e.  win_x86_64_clang
::#
::#	If the CMAKE_BINARY_DIR is missing the <TARGET_OS> or the <TARGET_ARCH>, dk_target_triple_SET will be called to get those variables
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
:dk_target_triple
::setlocal enableDelayedExpansion
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
		!dk_call! dk_dirname TARGET_DIR TARGET_TRIPLE_DIR		&rem  TARGET_TRIPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang
	) else if "!TARGET_DIR!" equ "Release" (
		rem ### Get RELEASE ###
		!dk_call! dk_set target_type RELEASE 					&rem 	    target_type = RELEASE
		!dk_call! dk_set !target_type! 1						&rem 			RELEASE = 1	
		rem !dk_call! dk_set TARGET_TYPE Release				&rem 		TARGET_TYPE = Release
		!dk_call! dk_dirname !TARGET_DIR! TARGET_TRIPLE_DIR		&rem  TARGET_TRIPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang
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
		!dk_call! dk_set TARGET_TRIPLE_DIR !TARGET_DIR!			&:: TARGET_TRIPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang
	:else
		!dk_call! dk_target_triple_SET
		!dk_call! dk_set TARGET_TRIPLE_DIR !TARGET_DIR!/!target_triple!
	:endif

	if exist !TARGET_TRIPLE_DIR! (goto TARGET_TRIPLE_DIR_EXISTS)
		!dk_call! dk_warning "TARGET_TRIPLE_DIR:!TARGET_TRIPLE_DIR! does not exits."
		!dk_call! dk_debug "Creating directory . . .!TARGET_TRIPLE_DIR!"
		!dk_call! dk_makeDirectory !TARGET_TRIPLE_DIR!
	:TARGET_TRIPLE_DIR_EXISTS
	!dk_call! dk_assertPath TARGET_TRIPLE_DIR
		
	::### Set DK_PROJECT_DIR ###
	!dk_call! dk_dirname !TARGET_TRIPLE_DIR! DK_PROJECT_DIR
	!dk_call! dk_set DK_PROJECT_DIR !DK_PROJECT_DIR!
	!dk_call! dk_assertPath DK_PROJECT_DIR

	::### Set target_triple/TARGET_TRIPLE, <target_os>_<target_arch>_<target_env>/<TARGET_OS>_<TARGET_ARCH>_<TARGET_ENV> ###
	!dk_call! dk_basename !TARGET_TRIPLE_DIR! target_triple		&:: target_triple 	= win_x86_64_clang
	!dk_call! dk_set target_triple !target_triple!				&:: Globalize the variable
	!dk_call! dk_set target_triple !target_triple!				&:: target_triple	= win_x86_64_clang
	!dk_call! dk_toUpper !target_triple! TARGET_TRIPLE			&:: TARGET_TRIPLE	= WIN_X86_64_CLANG
	!dk_call! dk_set TARGET_TRIPLE !TARGET_TRIPLE!				&:: Globalize the variable
	!dk_call! dk_set TARGET_TRIPLE !TARGET_TRIPLE!				&::	TARGET_TRIPLE = WIN_X86_64_CLANG
	!dk_call! dk_set !target_triple! 1						    &:: win_x86_64_clang = 1
	!dk_call! dk_set !TARGET_TRIPLE! 1						    &:: WIN_X86_64_CLANG = 1

	::### Set target_os / TARGET_OS / <target_os>_target / <TARGET_OS>_TARGET
	%dk_call% dk_containsCI "!TARGET_TRIPLE!" "android" 		&& !dk_call! dk_set target_os android
	%dk_call% dk_containsCI "!TARGET_TRIPLE!" "emscripten" 		&& !dk_call! dk_set target_os emscripten
	%dk_call% dk_containsCI "!TARGET_TRIPLE!" "ios" 			&& !dk_call! dk_set target_os ios
	%dk_call% dk_containsCI "!TARGET_TRIPLE!" "iossim" 			&& !dk_call! dk_set target_os iossim 
	%dk_call% dk_containsCI "!TARGET_TRIPLE!" "linux" 			&& !dk_call! dk_set target_os linux
	%dk_call% dk_containsCI "!TARGET_TRIPLE!" "mac" 			&& !dk_call! dk_set target_os mac
	%dk_call% dk_containsCI "!TARGET_TRIPLE!" "raspberry" 		&& !dk_call! dk_set target_os raspberry
	%dk_call% dk_containsCI "!TARGET_TRIPLE!" "windows" 		&& !dk_call! dk_set target_os windows
	%dk_call% dk_containsCI "!TARGET_TRIPLE!" "win"				&& !dk_call! dk_set target_os win
	%dk_call% dk_containsCI "!TARGET_TRIPLE!" "cosmopolitan"	&& !dk_call! dk_set target_os cosmopolitan
	if not defined target_os (
		!dk_call! dk_warning "The target target_triple:!target_triple! does not contain a valid target_os"
		!dk_call! dk_unset target_triple
		!dk_call! dk_unset TARGET_TRIPLE 
		!dk_call! dk_target_triple_SET
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
	%dk_call% dk_containsCI "!target_triple!" "arm64" 			&& !dk_call! dk_set target_arch arm64
	%dk_call% dk_containsCI "!target_triple!" "arm32" 			&& !dk_call! dk_set target_arch arm32
	%dk_call% dk_containsCI "!target_triple!" "x86_64" 			&& !dk_call! dk_set target_arch x86_64
	%dk_call% dk_containsCI "!target_triple!" "x86" 			&& !dk_call! dk_set target_arch x86
	%dk_call% dk_containsCI "!target_triple!" "cosmopolitan" 	&& !dk_call! dk_set target_arch cosmopolitan	
	if not defined target_arch (
		!dk_call! dk_warning "The target target_triple:!target_triple! does not contain a valid target_arch"
		!dk_call! dk_target_triple_SET
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
	%dk_call% dk_containsCI "!target_triple!" "clang" 			&& !dk_call! dk_set target_env clang
	%dk_call% dk_containsCI "!target_triple!" "mingw" 			&& !dk_call! dk_set target_env mingw
	%dk_call% dk_containsCI "!target_triple!" "ucrt"  			&& !dk_call! dk_set target_env ucrt
	%dk_call% dk_containsCI "!target_triple!" "msvc"  			&& !dk_call! dk_set target_env msvc
	%dk_call% dk_containsCI "!target_triple!" "cosmopolitan" 	&& !dk_call! dk_set target_env cosmopolitan
	if not defined target_env (
		!dk_call! dk_warning "The target target_triple:!target_triple! does not contain a valid target_env"
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
			!dk_call! dk_fatal "The target target_triple:!target_triple! does not contain a valid target_env or msystem"
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
	setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_target_triple
%endfunction%
