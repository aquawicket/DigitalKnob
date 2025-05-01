@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################
::if not defined dk_target_triple_SET (set "dk_target_triple_SET=1") else (goto:eof)

::###############################################################################
::# dk_target_triple_SET()
::#
::#
:dk_target_triple_SET
::%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate Host_Triple "%dk_call% dk_Host_Triple"

	echo: 
	echo  1^) !Host_Triple!
	echo: 
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
	echo:

	%dk_call% dk_keyboardInput input
	if "!input!" equ "0" (
		#%dk_call% dk_echo "repeating last selection"
		#%dk_call% dk_set Target_App	"!_Target_App_!"
		#%dk_call% dk_set Target_Triple	"!_Target_Triple_!"
		#%dk_call% dk_set Target_Type	"!_Target_Type_!"
	) else if "!input!" equ "1" (
		%dk_call% dk_set Target_Triple 	"!Host_Triple!"
		%dk_call% dk_set Target_Os		"!Host_Os!"
		%dk_call% dk_set Target_Arch	"!Host_Arch!"
		if defined host_env (
			%dk_call% dk_set Target_Env	"!Host_Env!"
		)
	) else if "!input!" equ "2" (
		%dk_call% dk_set Target_Os		"Cosmopolitan"
		%dk_call% dk_set Target_Arch	"Cosmopolitan"
		%dk_call% dk_set Target_Env		"Cosmopolitan"
	) else if "!input!" equ "3" (
		%dk_call% dk_set Target_Os		"Android"
		%dk_call% dk_set Target_Arch	"Arm32"
		%dk_call% dk_set Target_Env		"Clang"
	) else if "!input!" equ "4" (
		%dk_call% dk_set Target_Os		"Android"
		%dk_call% dk_set Target_Arch	"Arm64"
		%dk_call% dk_set Target_Env		"Clang"
	) else if "!input!" equ "5" (
		%dk_call% dk_set Target_Os		"Android"
		%dk_call% dk_set Target_Arch	"X86"
		%dk_call% dk_set Target_Env		"Clang"
	) else if "!input!" equ "6" (
		%dk_call% dk_set Target_Os		"Android"
		%dk_call% dk_set Target_Arch	"X86_64"
		%dk_call% dk_set Target_Env		"Clang"
	) else if "!input!" equ "7" (
		%dk_call% dk_set Target_Os		"emscripten"
		%dk_call% dk_set Target_Arch	"X86"
		%dk_call% dk_set Target_Env		"Clang"
	) else if "!input!" equ "8" (
		%dk_call% dk_set Target_Os		"Ios"
		%dk_call% dk_set Target_Arch	"Arm32"
		%dk_call% dk_set Target_Env		"Clang"
	) else if "!input!" equ "9" (
		%dk_call% dk_set Target_Os		"Ios"
		%dk_call% dk_set Target_Arch	"Arm64"
		%dk_call% dk_set Target_Env		"Clang"
	) else if "!input!" equ "10" (
		%dk_call% dk_set Target_Os		"Ios"
		%dk_call% dk_set Target_Arch	"X86"
		%dk_call% dk_set Target_Env		"Clang"
	) else if "!input!" equ "11" (
		%dk_call% dk_set Target_Os		"Ios"
		%dk_call% dk_set Target_Arch	"X86_64"
		%dk_call% dk_set Target_Env		"Clang"
	) else if "!input!" equ "12" (
		%dk_call% dk_set Target_Os		"Iossim"
		%dk_call% dk_set Target_Arch	"Arm32"
		%dk_call% dk_set Target_Env		"Clang"
	) else if "!input!" equ "13" (
		%dk_call% dk_set Target_Os		"Iossim"
		%dk_call% dk_set Target_Arch	"Arm64"
		%dk_call% dk_set Target_Env		"Clang"
	) else if "!input!" equ "14" (
		%dk_call% dk_set Target_Os		"Iossim"
		%dk_call% dk_set Target_Arch	"X86"
		%dk_call% dk_set Target_Env		"Clang"
	) else if "!input!" equ "15" (
		%dk_call% dk_set Target_Os 		"Iossim"
		%dk_call% dk_set Target_Arch 	"X86_64"
		%dk_call% dk_set Target_Env 	"Clang"
	) else if "!input!" equ "16" (
		%dk_call% dk_set Target_Os 		"Linux"
		%dk_call% dk_set Target_Arch 	"Arm32"
		%dk_call% dk_set Target_Env 	"Clang"
	) else if "!input!" equ "17" (
		%dk_call% dk_set Target_Os 		"Linux"
		%dk_call% dk_set Target_Arch 	"Arm64"
		%dk_call% dk_set Target_Env 	"Clang"
	) else if "!input!" equ "18" (
		%dk_call% dk_set Target_Os 		"Linux"
		%dk_call% dk_set Target_Arch 	"X86"
		%dk_call% dk_set Target_Env 	"Clang"
	) else if "!input!" equ "19" (
		%dk_call% dk_set Target_Os 		"Linux"
		%dk_call% dk_set Target_Arch 	"X86_64"
		%dk_call% dk_set Target_Env 	"Clang"
	) else if "!input!" equ "20" (
		%dk_call% dk_set Target_Os 		"Mac"
		%dk_call% dk_set Target_Arch 	"Arm32"
		%dk_call% dk_set Target_Env 	"Clang"
	) else if "!input!" equ "21" (
		%dk_call% dk_set Target_Os 		"Mac"
		%dk_call% dk_set Target_Arch 	"Arm64"
		%dk_call% dk_set Target_Env 	"Clang"
	) else if "!input!" equ "22" (
		%dk_call% dk_set Target_Os 		"Mac"
		%dk_call% dk_set Target_Arch 	"X86"
		%dk_call% dk_set Target_Env 	"Clang"
	) else if "!input!" equ "23" (
		%dk_call% dk_set Target_Os 		"Mac"
		%dk_call% dk_set Target_Arch	"X86_64"
		%dk_call% dk_set Target_Env 	"Clang"
	) else if "!input!" equ "24" (
		%dk_call% dk_set Target_Os 		"Raspberry"
		%dk_call% dk_set Target_Arch 	"Arm32"
		%dk_call% dk_set Target_Env 	"Clang"
	) else if "!input!" equ "25" (
		%dk_call% dk_set Target_Os 		"Raspberry"
		%dk_call% dk_set Target_Arch 	"Arm64"
		%dk_call% dk_set Target_Env 	"Clang"
	) else if "!input!" equ "26" (
		%dk_call% dk_set Target_Os 		"Raspberry"
		%dk_call% dk_set Target_Arch 	"X86"
		%dk_call% dk_set Target_Env 	"Clang"
	) else if "!input!" equ "27" (
		%dk_call% dk_set Target_Os 		"Raspberry"
		%dk_call% dk_set Target_Arch 	"X86_64"
		%dk_call% dk_set Target_Env 	"Clang"
	) else if "!input!" equ "28" (
		%dk_call% dk_set Target_Os 		"Win"
		%dk_call% dk_set Target_Arch 	"Arm32"
		%dk_call% dk_set Target_Env 	"Clang"
	) else if "!input!" equ "29" (
		%dk_call% dk_set Target_Os 		"Win"
		%dk_call% dk_set Target_Arch 	"Arm64"
		%dk_call% dk_set Target_Env 	"Clang"
	) else if "!input!" equ "30" (
		%dk_call% dk_set Target_Os 		"Win"
		%dk_call% dk_set Target_Arch 	"X86"
		%dk_call% dk_set Target_Env 	"Clang"
	) else if "!input!" equ "31" (
		%dk_call% dk_set Target_Os 		"Win"
		%dk_call% dk_set Target_Arch 	"X86"
		%dk_call% dk_set Target_Env 	"Gcc"
	) else if "!input!" equ "32" (
		%dk_call% dk_set Target_Os 		"Win"
		%dk_call% dk_set Target_Arch 	"X86"
		%dk_call% dk_set Target_Env 	"Msvc"
	) else if "!input!" equ "33" (
		%dk_call% dk_set Target_Os 		"Win"
		%dk_call% dk_set Target_Arch 	"X86_64"
		%dk_call% dk_set Target_Env 	"Clang"
	) else if "!input!" equ "34" (
		%dk_call% dk_set Target_Os 		"Win"
		%dk_call% dk_set Target_Arch 	"X86_64"
		%dk_call% dk_set Target_Env 	"Gcc"
	) else if "!input!" equ "35" (
		%dk_call% dk_set Target_Os 		"Win"
		%dk_call% dk_set Target_Arch 	"X86_64"
		%dk_call% dk_set Target_Env 	"Msvc"
	) else if "!input!" equ "36" (
		%dk_call% dk_set Target_Os 		"Win"
		%dk_call% dk_set Target_Arch 	"X86_64"
		%dk_call% dk_set Target_Env 	"Ucrt"
	) else if "!input!" equ "37" (
		%dk_call% dk_exit 0
	) else (
		%dk_call% dk_warning "invalid selection"
	)

	%dk_call% dk_assertVar Target_Os
rem	%dk_call% dk_assertVar target_os
rem	%dk_call% dk_assertVar TARGET_OS
rem %dk_call% dk_toCamel !Target_Os! Target_Os
rem %dk_call% dk_toLower !Target_Os! target_os
	%dk_call% dk_toUpper !Target_Os! TARGET_OS
rem	%dk_call% dk_set !Target_Os! 1
rem	%dk_call% dk_set !target_os! 1
	%dk_call% dk_set !TARGET_OS! 1
	
	%dk_call% dk_assertVar Target_Arch
rem %dk_call% dk_assertVar target_arch
rem %dk_call% dk_assertVar TARGET_ARCH
rem %dk_call% dk_toUpper !Target_Arch! Target_Arch
rem %dk_call% dk_toUpper !Target_Arch! target_arch
	%dk_call% dk_toUpper !Target_Arch! TARGET_ARCH
rem %dk_call% dk_set !Target_Arch! 1
rem %dk_call% dk_set !target_arch! 1
	%dk_call% dk_set !TARGET_ARCH! 1

	if not defined Target_Env (
		%dk_call% dk_set Target_Env Clang
	rem %dk_call% dk_set target_env clang
	rem %dk_call% dk_set TARGET_ENV CLANG
	)
	if defined Target_Env (
	rem %dk_call% dk_toCamel !Target_Env! Target_Env
	rem %dk_call% dk_toLower !Target_Env! target_env
		%dk_call% dk_toUpper !Target_Env! TARGET_ENV
	rem %dk_call% dk_set !Target_Env! 1
	rem %dk_call% dk_set !target_env! 1
		%dk_call% dk_set !TARGET_ENV! 1
	rem %dk_call% dk_set Target_Triple !Target_Os!_!Target_Arch!_!Target_Env!
	rem %dk_call% dk_set target_triple !target_os!_!target_arch!_!target_env!
		%dk_call% dk_set TARGET_TRIPLE !TARGET_OS!_!TARGET_ARCH!_!TARGET_ENV!
	) else (
	rem %dk_call% dk_set Target_Triple !Target_Os!_!Target_Arch!
	rem %dk_call% dk_set target_triple !target_os!_!target_arch!
		%dk_call% dk_set TARGET_TRIPLE !TARGET_OS!_!TARGET_ARCH!
	)
rem %dk_call% dk_assertVar Target_Triple
rem %dk_call% dk_assertVar target_triple
	%dk_call% dk_assertVar TARGET_TRIPLE
rem %dk_call% dk_set !Target_Triple! 1
rem %dk_call% dk_set !target_triple! 1	
	%dk_call% dk_set !TARGET_TRIPLE! 1	

	::###### Set DEBUG_DIR and RELEASE_DIR variables ######
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
