@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
::if not defined dk_target_triple_SET (set "dk_target_triple_SET=1") else (goto:eof)

::###############################################################################
::# dk_target_triple_SET()
::#
::#
:dk_target_triple_SET
::setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"

	echo 
	echo  1^) !host_triple!
	echo 
	echo  2) cosmopolitan
	echo  3) android_arm32_clang
	echo  4) android_arm64_clang
	echo  5) android_x86_clang
	echo  6) android_x86_64_clang
	echo  7) emscripten_x86_clang
	echo  8) ios_arm32_clang
	echo  9) ios_arm64_clang
	echo 10) ios_x86_clang
	echo 11) ios_x86_64_clang
	echo 12) iossim_arm32_clang
	echo 13) iossim_arm64_clang
	echo 14) iossim_x86_clang
	echo 15) iossim_x86_64_clang
	echo 16) linux_arm32_clang
	echo 17) linux_arm64_clang
	echo 18) linux_x86_clang
	echo 19) linux_x86_64_clang
	echo 20) mac_arm32_clang
	echo 21) mac_arm64_clang
	echo 22) mac_x86_clang
	echo 23) mac_x86_64_clang
	echo 24) raspberry_arm32_clang
	echo 25) raspberry_arm64_clang
	echo 26) raspberry_x86_clang
	echo 27) raspberry_x86_64_clang
	echo 28) windows_arm32_clang
	echo 29) windows_arm64_clang
	echo 30) windows_x86_clang
	echo 31) windows_x86_gcc
	echo 32) windows_x86_msvc
	echo 33) windows_x86_64_clang
	echo 34) windows_x86_64_gcc
	echo 35) windows_x86_64_msvc
	echo 36) windows_x86_64_ucrt
	echo 37) Exit
	echo 

	%dk_call% dk_keyboardInput input
	if "!input!" equ "0" (
		#%dk_call% dk_echo "repeating last selection"
		#%dk_call% dk_set app			!_app_!
		#%dk_call% dk_set os			!_os_!
		#%dk_call% dk_set type			!_type_!
	) else if "!input!" equ "1" (
		%dk_call% dk_set target_triple 	!host_triple!
		%dk_call% dk_set os				!host_os!
		%dk_call% dk_set arch			!host_arch!
		if defined host_env (
			%dk_call% dk_set env		!host_env!
		)
	) else if "!input!" equ "2" (
		%dk_call% dk_set os		"cosmopolitan"
		%dk_call% dk_set arch	"cosmopolitan"
		%dk_call% dk_set env	"cosmopolitan"
	) else if "!input!" equ "3" (
		%dk_call% dk_set os		"android"
		%dk_call% dk_set arch	"arm32"
		%dk_call% dk_set env	"clang"
	) else if "!input!" equ "4" (
		%dk_call% dk_set os		"android"
		%dk_call% dk_set arch	"arm64"
		%dk_call% dk_set env	"clang"
	) else if "!input!" equ "5" (
		%dk_call% dk_set os		"android"
		%dk_call% dk_set arch	"x86"
		%dk_call% dk_set env	"clang"
	) else if "!input!" equ "6" (
		%dk_call% dk_set os		"android"
		%dk_call% dk_set arch	"x86_64"
		%dk_call% dk_set env	"clang"
	) else if "!input!" equ "7" (
		%dk_call% dk_set os		"emscripten"
		%dk_call% dk_set arch	"x86"
		%dk_call% dk_set env	"clang"
	) else if "!input!" equ "8" (
		%dk_call% dk_set os		"ios"
		%dk_call% dk_set arch	"arm32"
		%dk_call% dk_set env	"clang"
	) else if "!input!" equ "9" (
		%dk_call% dk_set os		"ios"
		%dk_call% dk_set arch	"arm64"
		%dk_call% dk_set env	"clang"
	) else if "!input!" equ "10" (
		%dk_call% dk_set os		"ios"
		%dk_call% dk_set arch	"x86"
		%dk_call% dk_set env	"clang"
	) else if "!input!" equ "11" (
		%dk_call% dk_set os		"ios"
		%dk_call% dk_set arch	"x86_64"
		%dk_call% dk_set env	"clang"
	) else if "!input!" equ "12" (
		%dk_call% dk_set os		"iossim"
		%dk_call% dk_set arch	"arm32"
		%dk_call% dk_set env	"clang"
	) else if "!input!" equ "13" (
		%dk_call% dk_set os		"iossim"
		%dk_call% dk_set arch	"arm64"
		%dk_call% dk_set env	"clang"
	) else if "!input!" equ "14" (
		%dk_call% dk_set os		"iossim"
		%dk_call% dk_set arch	"x86"
		%dk_call% dk_set env	"clang"
	) else if "!input!" equ "15" (
		%dk_call% dk_set os 	"iossim"
		%dk_call% dk_set arch 	"x86_64"
		%dk_call% dk_set env 	"clang"
	) else if "!input!" equ "16" (
		%dk_call% dk_set os 	"linux"
		%dk_call% dk_set arch 	"arm32"
		%dk_call% dk_set env 	"clang"
	) else if "!input!" equ "17" (
		%dk_call% dk_set os 	"linux"
		%dk_call% dk_set arch 	"arm64"
		%dk_call% dk_set env 	"clang"
	) else if "!input!" equ "18" (
		%dk_call% dk_set os 	"linux"
		%dk_call% dk_set arch 	"x86"
		%dk_call% dk_set env 	"clang"
	) else if "!input!" equ "19" (
		%dk_call% dk_set os 	"linux"
		%dk_call% dk_set arch 	"x86_64"
		%dk_call% dk_set env 	"clang"
	) else if "!input!" equ "20" (
		%dk_call% dk_set os 	"mac"
		%dk_call% dk_set arch 	"arm32"
		%dk_call% dk_set env 	"clang"
	) else if "!input!" equ "21" (
		%dk_call% dk_set os 	"mac"
		%dk_call% dk_set arch 	"arm64"
		%dk_call% dk_set env 	"clang"
	) else if "!input!" equ "22" (
		%dk_call% dk_set os 	"mac"
		%dk_call% dk_set arch 	"x86"
		%dk_call% dk_set env 	"clang"
	) else if "!input!" equ "23" (
		%dk_call% dk_set os 	"mac"
		%dk_call% dk_set arch	"x86_64"
		%dk_call% dk_set env 	"clang"
	) else if "!input!" equ "24" (
		%dk_call% dk_set os 	"raspberry"
		%dk_call% dk_set arch 	"arm32"
		%dk_call% dk_set env 	"clang"
	) else if "!input!" equ "25" (
		%dk_call% dk_set os 	"raspberry"
		%dk_call% dk_set arch 	"arm64"
		%dk_call% dk_set env 	"clang"
	) else if "!input!" equ "26" (
		%dk_call% dk_set os 	"raspberry"
		%dk_call% dk_set arch 	"x86"
		%dk_call% dk_set env 	"clang"
	) else if "!input!" equ "27" (
		%dk_call% dk_set os 	"raspberry"
		%dk_call% dk_set arch 	"x86_64"
		%dk_call% dk_set env 	"clang"
	) else if "!input!" equ "28" (
		%dk_call% dk_set os 	"win"
		%dk_call% dk_set arch 	"arm32"
		%dk_call% dk_set env 	"clang"
	) else if "!input!" equ "29" (
		%dk_call% dk_set os 	"win"
		%dk_call% dk_set arch 	"arm64"
		%dk_call% dk_set env 	"clang"
	) else if "!input!" equ "30" (
		%dk_call% dk_set os 	"win"
		%dk_call% dk_set arch 	"x86"
		%dk_call% dk_set env 	"clang"
	) else if "!input!" equ "31" (
		%dk_call% dk_set os 	"win"
		%dk_call% dk_set arch 	"x86"
		%dk_call% dk_set env 	"gcc"
	) else if "!input!" equ "32" (
		%dk_call% dk_set os 	"win"
		%dk_call% dk_set arch 	"x86"
		%dk_call% dk_set env 	"msvc"
	) else if "!input!" equ "33" (
		%dk_call% dk_set os 	"win"
		%dk_call% dk_set arch 	"x86_64"
		%dk_call% dk_set env 	"clang"
	) else if "!input!" equ "34" (
		%dk_call% dk_set os 	"win"
		%dk_call% dk_set arch 	"x86_64"
		%dk_call% dk_set env 	"gcc"
	) else if "!input!" equ "35" (
		%dk_call% dk_set os 	"win"
		%dk_call% dk_set arch 	"x86_64"
		%dk_call% dk_set env 	"msvc"
	) else if "!input!" equ "36" (
		%dk_call% dk_set os 	"win"
		%dk_call% dk_set arch 	"x86_64"
		%dk_call% dk_set env 	"ucrt"
	) else if "!input!" equ "37" (
		%dk_call% dk_exit 0
	) else (
		%dk_call% dk_warning "invalid selection"
	)

	%dk_call% dk_assertVar os
	%dk_call% dk_toUpper !os! OS
	%dk_call% dk_set OS !OS!
	%dk_call% dk_set !os! 1
	%dk_call% dk_set !OS! 1
	%dk_call% dk_assertVar OS
	%dk_call% dk_printVar os
	%dk_call% dk_printVar OS
	%dk_call% dk_printVar !os!
	%dk_call% dk_printVar !OS!
	%dk_call% dk_assertVar arch
	%dk_call% dk_toUpper !arch! ARCH
	%dk_call% dk_set ARCH !ARCH!
	%dk_call% dk_set !arch! 1
	%dk_call% dk_set !ARCH! 1
	%dk_call% dk_assertVar ARCH
	%dk_call% dk_printVar arch
	%dk_call% dk_printVar ARCH
	%dk_call% dk_printVar !arch!
	%dk_call% dk_printVar !ARCH!

	if not defined env (
		%dk_call% dk_set env clang
	)
	if defined env (
		%dk_call% dk_toUpper !env! ENV
		%dk_call% dk_set ENV !ENV!
		%dk_call% dk_set !env! 1
		%dk_call% dk_set !ENV! 1
		%dk_call% dk_printVar env
		%dk_call% dk_printVar ENV
		%dk_call% dk_printVar !env!
		%dk_call% dk_printVar !ENV!
	)
		
	if defined env (
		%dk_call% dk_set target_triple "!os!_!arch!_!env!"
		%dk_call% dk_set TARGET_TRIPLE "!OS!_!ARCH!_!ENV!"
	) else (
		%dk_call% dk_set target_triple "!os!_!arch!"
		%dk_call% dk_set TARGET_TRIPLE "!OS!_!ARCH!"
	)
	%dk_call% dk_assertVar target_triple
	%dk_call% dk_assertVar TARGET_TRIPLE
	%dk_call% dk_set !target_triple! 1	
	%dk_call% dk_set !TARGET_TRIPLE! 1	
	%dk_call% dk_printVar target_triple
	%dk_call% dk_printVar TARGET_TRIPLE
	%dk_call% dk_printVar !target_triple!
	%dk_call% dk_printVar !TARGET_TRIPLE!	

	::### Set DEBUG_DIR and RELEASE_DIR variables
	if defined IOS (
		%dk_call% dk_set DEBUG_DIR Debug-iphoneos
		%dk_call% dk_set RELEASE_DIR Release-iphoneos
	) else if defined IOSSIM (
		%dk_call% dk_set DEBUG_DIR Debug-iphonesimulator
		%dk_call% dk_set RELEASE_DIR Release-iphonesimulator
	) else (
		%dk_call% dk_set DEBUG_DIR Debug
		%dk_call% dk_set RELEASE_DIR Release
	)
	%dk_call% dk_assertVar DEBUG_DIR
	%dk_call% dk_assertVar RELEASE_DIR
	%dk_call% dk_printVar DEBUG_DIR
	%dk_call% dk_printVar RELEASE_DIR
	rem #else
	rem #	%dk_call% dk_target_triple
	
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
 
	%dk_call% dk_target_triple_SET
%endfunction%
