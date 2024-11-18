@echo off
if not defined DKINIT call "!DKBATCH_FUNCTIONS_DIR_!DK.cmd" !~0 !*
::if not defined dk_target_triple (set "dk_target_triple=1") else (goto:eof)

::###############################################################################
::# dk_target_triple()
::#
::#	Set the cached target variables
::#   This information is pulled from the folder name of the CMAKE_BINARY_DIR
::#   i.e.  win_x86_64_clang
::#
::#	If the CMAKE_BINARY_DIR is missing the <OS> or the <ARCH>, dk_setTargetTriple will be called to get those variables
::#
::#	os   				= android, emscripten, ios, iossim, linux, mac, raspberry, windows 
::#	OS   				= ANDROID, EMSCRIPTEN, IOS, IOSSIM, LINUX, MAC, RASPBERRY, WINDOWS
::#	arch				= arm32, arm64, x86, x86_64
::#	ARCH				= ARM32, ARM64, X86, X86_64
::#	env					= clang, cosmo, mingw, msvc, ucrt
::#	ENV					= CLANG, COSMO, MINGW, MSVC, UCRT
::#   <os>_<arch>			= android_arm64, emscripten_arm64, ios_arm64, iossim_arm64, linux_arm64, mac_arm64, raspberry_arm64, windows_arm64
::#   <os>_<arch>_<env>	= android_arm64_clang, emscripten_arm64_clang, ios_arm64_clang, iossim_arm64_clang, linux_arm64_clang, mac_arm64_clang, raspberry_arm64_clang, windows_arm64_clang
::#
:dk_target_triple
	call dk_debugFunc 0

	::### Get TARGET_DIR ###
	!dk_call! dk_getFullPath "!CMAKE_BINARY_DIR!" TARGET_DIR
	!dk_call! dk_printVar TARGET_DIR 								&:: TARGET_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang/Debug

	::### Set target_type / TARGET_TYPE ###
	if "!TARGET_DIR!" equ "Debug" (	
		rem ### Get DEBUG ###
		!dk_call! dk_set TYPE DEBUG						        &rem 			   TYPE	= DEBUG
		!dk_call! dk_set !TYPE! 1								&rem 			  DEBUG = 1	
		rem !dk_call! dk_set TARGET_TYPE Debug					&rem 		TARGET_TYPE	= Debug
		!dk_call! dk_dirname TARGET_DIR TARGET_TRIPLE_DIR		&rem  TARGET_TRIPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang
	) else if "!TARGET_DIR!" equ "Release" (
		rem ### Get RELEASE ###
		!dk_call! dk_set TYPE RELEASE 						    &rem 			   TYPE = RELEASE
		!dk_call! dk_set !TYPE! 1								&rem 			RELEASE = 1	
		rem !dk_call! dk_set TARGET_TYPE Release				&rem 		TARGET_TYPE = Release
		!dk_call! dk_dirname !TARGET_DIR! TARGET_TRIPLE_DIR		&rem  TARGET_TRIPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang
	)
	if  "!TARGET_DIR!" equ "android" 		goto if
	if	"!TARGET_DIR!" equ "emscripten" 	goto if
	if	"!TARGET_DIR!" equ "ios" 			goto if
	if	"!TARGET_DIR!" equ "iossim"			goto if
	if	"!TARGET_DIR!" equ "linux" 			goto if
	if	"!TARGET_DIR!" equ "mac"			goto if
	if	"!TARGET_DIR!" equ "raspberry" 		goto if
	if	"!TARGET_DIR!" equ "windows"		goto if
	if	"!TARGET_DIR!" equ "cosmo"			goto if
	goto else
	:if
		!dk_call! dk_set TARGET_TRIPLE_DIR !TARGET_DIR!			&:: TARGET_TRIPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang
	:else
		!dk_call! dk_setTargetTriple
		!dk_call! dk_set TARGET_TRIPLE_DIR !TARGET_DIR!/!triple!
	:endif

	if exist !TARGET_TRIPLE_DIR! goto TARGET_TRIPLE_DIR_EXISTS
		!dk_call! dk_warning "TARGET_TRIPLE_DIR:!TARGET_TRIPLE_DIR! does not exits."
		!dk_call! dk_debug "Creating directory . . .!TARGET_TRIPLE_DIR!"
		!dk_call! dk_makeDirectory !TARGET_TRIPLE_DIR!
	:TARGET_TRIPLE_DIR_EXISTS
	!dk_call! dk_assertPath TARGET_TRIPLE_DIR
		
	::### Set DK_PROJECT_DIR ###
	!dk_call! dk_dirname !TARGET_TRIPLE_DIR! DK_PROJECT_DIR
	!dk_call! dk_set DK_PROJECT_DIR !DK_PROJECT_DIR!
	!dk_call! dk_assertPath DK_PROJECT_DIR

	::### Set triple/TRIPLE, <os>_<arch>_<env>/<OS>_<ARCH>_<ENV> ###
	!dk_call! dk_basename !TARGET_TRIPLE_DIR! triple	&:: triple 	= win_x86_64_clang
	!dk_call! dk_set triple !triple!					&:: Globalize the variable
	!dk_call! dk_set target_triple !triple!				&:: target_triple	= win_x86_64_clang
	!dk_call! dk_toUpper !triple! TRIPLE				&:: TRIPLE	= WIN_X86_64_CLANG
	!dk_call! dk_set TRIPLE !TRIPLE!					&:: Globalize the variable
	!dk_call! dk_set TARGET_TRIPLE !TRIPLE!				&::	TARGET_TRIPLE = WIN_X86_64_CLANG
	!dk_call! dk_set !triple! 1						    &:: win_x86_64_clang = 1
	!dk_call! dk_set !TRIPLE! 1						    &:: WIN_X86_64_CLANG = 1
	!dk_call! dk_printVar triple 
	!dk_call! dk_printVar TRIPLE 


	::### Set os / OS / <os>_target / <OS>_TARGET
	if "!triple!" equ "android" (
		!dk_call! dk_set os android
	) else if "!triple!" equ "emscripten" (
		!dk_call! dk_set os emscripten
	) else if "!triple!" equ "iossim" (
		!dk_call! dk_set os iossim 
	) else if "!triple!" equ "ios" (
		!dk_call! dk_set os ios
	) else if "!triple!" equ "linux" (
		!dk_call! dk_set os linux
	) else if "!triple!" equ "mac" (
		!dk_call! dk_set os mac
	) else if "!triple!" equ "raspberry" (
		!dk_call! dk_set os raspberry
	) else if "!triple!" equ "windows" (
		!dk_call! dk_set os windows
	) else if "!triple!" equ "win" (
		!dk_call! dk_set os win
	) else if "!triple!" equ "cosmo" (
		!dk_call! dk_set os cosmo
	) else (
		!dk_call! dk_warning "The target triple:!triple! does not contain a valid os"
		!dk_call! dk_unset triple
		!dk_call! dk_unset TRIPLE 
		!dk_call! dk_setTargetTriple
	)
	if defined os (
		!dk_call! dk_toUpper !os! OS
		!dk_call! dk_set OS !OS! 
		::!dk_call! dk_set target_os !os!
		::!dk_call! dk_set TARGET_OS !OS!
		!dk_call! dk_set !os! 1
		!dk_call! dk_set !OS! 1
		::!dk_call! dk_set !os!_target 1
		::!dk_call! dk_set !OS!_TARGET 1
	)

	::### Get arch / ARCH
	if "!triple!" equ "arm64" (
		!dk_call! dk_set arch arm64
	) else if "!triple!" equ "arm32" (
		!dk_call! dk_set arch arm32
	) else if "!triple!" equ "x86_64" (
		!dk_call! dk_set arch x86_64
	) else if "!triple!" equ "x86" (
		!dk_call! dk_set arch x86
	) else if "!triple!" equ "cosmo" (
		!dk_call! dk_set arch cosmo	
	) else (
		!dk_call! dk_warning "The target triple:!triple! does not contain a valid arch"
		!dk_call! dk_setTargetTriple
	)
	if defined arch (
		!dk_call! dk_toUpper !arch! ARCH
		!dk_call! dk_set ARCH !ARCH!
		::!dk_call! dk_set target_arch !arch!)
		::!dk_call! dk_set TARGET_ARCH !ARCH!)
		!dk_call! dk_set !arch! 1
		!dk_call! dk_set !ARCH! 1
		::!dk_call! dk_set !arch!_target 1)
		::!dk_call! dk_set !ARCH!_TARGET 1)
	)

	::### Set evn / ENV 
	if "!triple!" equ "clang" (
		!dk_call! dk_set env clang
	) else if "!triple!" MATCHES "mingw" (
		!dk_call! dk_set env mingw
	) else if "!triple!" MATCHES "ucrt" (
		!dk_call! dk_set env ucrt
	) else if "!triple!" MATCHES "msvc" (
		!dk_call! dk_set env msvc
	) else if "!triple!" MATCHES "cosmo" (
		!dk_call! dk_set env cosmo
	) else (
		!dk_call! dk_warning "The target triple:!triple! does not contain a valid env"
	)
	if defined env (
		!dk_call! dk_toUpper !env! ENV
		!dk_call! dk_set ENV !ENV!
		rem !dk_call! dk_set target_env !env!
		rem !dk_call! dk_set TARGET_ENV !ENV!
		!dk_call! dk_set !env! 1
		!dk_call! dk_set !ENV! 1
		rem !dk_call! dk_set !env!_target 1
		rem !dk_call! dk_set !ENV!_TARGET 1
	)

	::### Set MSYSTEM
	if defined !ENV! (
		if defined CLANG if defined ARM64 (
			!dk_call! dk_set msystem "!env!!arch!"	&rem msystem = clangarm64
			!dk_call! dk_set MSYSTEM "!ENV!!ARCH!"	&rem MSYSTEM = CLANGARM64
		) else if X86_64 (
			!dk_call! dk_set msystem "!env!64"		&rem msystem = clang64, mingw64, ucrt64
			!dk_call! dk_set MSYSTEM "!ENV!64"		&rem MSYSTEM = CLANG64, MINGW64, UCRT64
		) else if X86)
			!dk_call! dk_set msystem "!env!32"		&rem msystem = clang32, mingw32
			!dk_call! dk_set MSYSTEM "!ENV!32"		&rem MSYSTEM = CLANG32, MINGW32
		) else if cosmo OR COSMO)
		::	!dk_call! dk_set msystem "!env!"		&rem cosmo
		::	!dk_call! dk_set MSYSTEM "!ENV!"		&rem COSMO
		) else if msvc OR MSVC)
		::	!dk_call! dk_set msystem "msvc"			&rem cosmo
		::	!dk_call! dk_set MSYSTEM "MSVC"			&rem COSMO
		) else (
			!dk_call! dk_fatal "The target triple:!triple! does not contain a valid env or msystem"
		)
		!dk_call! dk_set !MSYSTEM! 1)				&rem CLANGARM64, CLANG64, CLANG32, MINGW64, MINGW32, UCRT64 = 1
	)
		
	::### Set os_arch / OS_ARCH ###
	!dk_call! dk_set os_arch "!os!_!arch!"
	!dk_call! dk_set OS_ARCH "!OS!_!ARCH!"
	&rem !dk_call! dk_set target_os_arch "!os_arch!"
	&rem !dk_call! dk_set TARGET_OS_ARCH "!OS_ARCH!"
	!dk_call! dk_set !os_arch! 1
	!dk_call! dk_set !OS_ARCH! 1
	&rem !dk_call! dk_set !os_arch!_target 1
	&rem !dk_call! dk_set !OS_ARCH!_TARGET 1

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
	dk_debugFunc 0

	dk_TARGET_TRIPLE
%endfunction%
