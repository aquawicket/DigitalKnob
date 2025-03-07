@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)
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
	if "!input!"=="0" (
		#%dk_call% dk_echo "repeating last selection"
		#%dk_call% dk_set target_app	"!_target_app_!"
		#%dk_call% dk_set target_triple	"!_target_triple_!"
		#%dk_call% dk_set target_type	"!_target_type_!"
	) else if "!input!"=="1" (
		%dk_call% dk_set target_triple 	"!host_triple!"
		%dk_call% dk_set target_os		"!host_os!"
		%dk_call% dk_set target_arch	"!host_arch!"
		if defined host_env (
			%dk_call% dk_set target_env	"!host_env!"
		)
	) else if "!input!"=="2" (
		%dk_call% dk_set target_os		"cosmopolitan"
		%dk_call% dk_set target_arch	"cosmopolitan"
		%dk_call% dk_set target_env		"cosmopolitan"
	) else if "!input!"=="3" (
		%dk_call% dk_set target_os		"android"
		%dk_call% dk_set target_arch	"arm32"
		%dk_call% dk_set target_env		"clang"
	) else if "!input!"=="4" (
		%dk_call% dk_set target_os		"android"
		%dk_call% dk_set target_arch	"arm64"
		%dk_call% dk_set target_env		"clang"
	) else if "!input!"=="5" (
		%dk_call% dk_set target_os		"android"
		%dk_call% dk_set target_arch	"x86"
		%dk_call% dk_set target_env		"clang"
	) else if "!input!"=="6" (
		%dk_call% dk_set target_os		"android"
		%dk_call% dk_set target_arch	"x86_64"
		%dk_call% dk_set target_env		"clang"
	) else if "!input!"=="7" (
		%dk_call% dk_set target_os		"emscripten"
		%dk_call% dk_set target_arch	"x86"
		%dk_call% dk_set target_env		"clang"
	) else if "!input!"=="8" (
		%dk_call% dk_set target_os		"ios"
		%dk_call% dk_set target_arch	"arm32"
		%dk_call% dk_set target_env		"clang"
	) else if "!input!"=="9" (
		%dk_call% dk_set target_os		"ios"
		%dk_call% dk_set target_arch	"arm64"
		%dk_call% dk_set target_env		"clang"
	) else if "!input!"=="10" (
		%dk_call% dk_set target_os		"ios"
		%dk_call% dk_set target_arch	"x86"
		%dk_call% dk_set target_env		"clang"
	) else if "!input!"=="11" (
		%dk_call% dk_set target_os		"ios"
		%dk_call% dk_set target_arch	"x86_64"
		%dk_call% dk_set target_env		"clang"
	) else if "!input!"=="12" (
		%dk_call% dk_set target_os		"iossim"
		%dk_call% dk_set target_arch	"arm32"
		%dk_call% dk_set target_env		"clang"
	) else if "!input!"=="13" (
		%dk_call% dk_set target_os		"iossim"
		%dk_call% dk_set target_arch	"arm64"
		%dk_call% dk_set target_env		"clang"
	) else if "!input!"=="14" (
		%dk_call% dk_set target_os		"iossim"
		%dk_call% dk_set target_arch	"x86"
		%dk_call% dk_set target_env		"clang"
	) else if "!input!"=="15" (
		%dk_call% dk_set target_os 		"iossim"
		%dk_call% dk_set target_arch 	"x86_64"
		%dk_call% dk_set target_env 	"clang"
	) else if "!input!"=="16" (
		%dk_call% dk_set target_os 		"linux"
		%dk_call% dk_set target_arch 	"arm32"
		%dk_call% dk_set target_env 	"clang"
	) else if "!input!"=="17" (
		%dk_call% dk_set target_os 		"linux"
		%dk_call% dk_set target_arch 	"arm64"
		%dk_call% dk_set target_env 	"clang"
	) else if "!input!"=="18" (
		%dk_call% dk_set target_os 		"linux"
		%dk_call% dk_set target_arch 	"x86"
		%dk_call% dk_set target_env 	"clang"
	) else if "!input!"=="19" (
		%dk_call% dk_set target_os 		"linux"
		%dk_call% dk_set target_arch 	"x86_64"
		%dk_call% dk_set target_env 	"clang"
	) else if "!input!"=="20" (
		%dk_call% dk_set target_os 		"mac"
		%dk_call% dk_set target_arch 	"arm32"
		%dk_call% dk_set target_env 	"clang"
	) else if "!input!"=="21" (
		%dk_call% dk_set target_os 		"mac"
		%dk_call% dk_set target_arch 	"arm64"
		%dk_call% dk_set target_env 	"clang"
	) else if "!input!"=="22" (
		%dk_call% dk_set target_os 		"mac"
		%dk_call% dk_set target_arch 	"x86"
		%dk_call% dk_set target_env 	"clang"
	) else if "!input!"=="23" (
		%dk_call% dk_set target_os 		"mac"
		%dk_call% dk_set target_arch	"x86_64"
		%dk_call% dk_set target_env 	"clang"
	) else if "!input!"=="24" (
		%dk_call% dk_set target_os 		"raspberry"
		%dk_call% dk_set target_arch 	"arm32"
		%dk_call% dk_set target_env 	"clang"
	) else if "!input!"=="25" (
		%dk_call% dk_set target_os 		"raspberry"
		%dk_call% dk_set target_arch 	"arm64"
		%dk_call% dk_set target_env 	"clang"
	) else if "!input!"=="26" (
		%dk_call% dk_set target_os 		"raspberry"
		%dk_call% dk_set target_arch 	"x86"
		%dk_call% dk_set target_env 	"clang"
	) else if "!input!"=="27" (
		%dk_call% dk_set target_os 		"raspberry"
		%dk_call% dk_set target_arch 	"x86_64"
		%dk_call% dk_set target_env 	"clang"
	) else if "!input!"=="28" (
		%dk_call% dk_set target_os 		"win"
		%dk_call% dk_set target_arch 	"arm32"
		%dk_call% dk_set target_env 	"clang"
	) else if "!input!"=="29" (
		%dk_call% dk_set target_os 		"win"
		%dk_call% dk_set target_arch 	"arm64"
		%dk_call% dk_set target_env 	"clang"
	) else if "!input!"=="30" (
		%dk_call% dk_set target_os 		"win"
		%dk_call% dk_set target_arch 	"x86"
		%dk_call% dk_set target_env 	"clang"
	) else if "!input!"=="31" (
		%dk_call% dk_set target_os 		"win"
		%dk_call% dk_set target_arch 	"x86"
		%dk_call% dk_set target_env 	"gcc"
	) else if "!input!"=="32" (
		%dk_call% dk_set target_os 		"win"
		%dk_call% dk_set target_arch 	"x86"
		%dk_call% dk_set target_env 	"msvc"
	) else if "!input!"=="33" (
		%dk_call% dk_set target_os 		"win"
		%dk_call% dk_set target_arch 	"x86_64"
		%dk_call% dk_set target_env 	"clang"
	) else if "!input!"=="34" (
		%dk_call% dk_set target_os 		"win"
		%dk_call% dk_set target_arch 	"x86_64"
		%dk_call% dk_set target_env 	"gcc"
	) else if "!input!"=="35" (
		%dk_call% dk_set target_os 		"win"
		%dk_call% dk_set target_arch 	"x86_64"
		%dk_call% dk_set target_env 	"msvc"
	) else if "!input!"=="36" (
		%dk_call% dk_set target_os 		"win"
		%dk_call% dk_set target_arch 	"x86_64"
		%dk_call% dk_set target_env 	"ucrt"
	) else if "!input!"=="37" (
		%dk_call% dk_exit 0
	) else (
		%dk_call% dk_warning "invalid selection"
	)

	%dk_call% dk_assertVar target_os
	%dk_call% dk_toUpper !target_os! TARGET_OS
	::%dk_call% dk_set TARGET_OS !TARGET_OS!
	::%dk_call% dk_set !target_os! 1
	%dk_call% dk_set !TARGET_OS! 1
	%dk_call% dk_assertVar TARGET_OS

	%dk_call% dk_assertVar target_arch
	%dk_call% dk_toUpper !target_arch! TARGET_ARCH
	::%dk_call% dk_set TARGET_ARCH !TARGET_ARCH!
	::%dk_call% dk_set !target_arch! 1
	%dk_call% dk_set !TARGET_ARCH! 1
	%dk_call% dk_assertVar TARGET_ARCH

	if not defined target_env (
		%dk_call% dk_set target_env clang
	)
	if defined target_env (
		%dk_call% dk_toUpper !target_env! TARGET_ENV
		rem %dk_call% dk_set TARGET_ENV !TARGET_ENV!
		rem %dk_call% dk_set !target_env! 1
		%dk_call% dk_set !TARGET_ENV! 1
		rem %dk_call% dk_set target_triple !target_os!_!target_arch!_!target_env!
		%dk_call% dk_set TARGET_TRIPLE !TARGET_OS!_!TARGET_ARCH!_!TARGET_ENV!
	) else (
		rem %dk_call% dk_set target_triple !target_os!_!target_arch!
		%dk_call% dk_set TARGET_TRIPLE !TARGET_OS!_!TARGET_ARCH!
	)
	::%dk_call% dk_assertVar target_triple
	%dk_call% dk_assertVar TARGET_TRIPLE
	::%dk_call% dk_set !target_triple! 1	
	%dk_call% dk_set !TARGET_TRIPLE! 1	

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

%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
 
	%dk_call% dk_target_triple_SET
%endfunction%
