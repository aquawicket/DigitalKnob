@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
::if not defined dk_setTargetTriple (set "dk_setTargetTriple=1") else (goto:eof)

::###############################################################################
::# dk_setTargetTriple()
::#
::#
:dk_setTargetTriple
	call dk_debugFunc 0


	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"

	%dk_call% dk_echo ""
	%dk_call% dk_echo " 1) !host_triple!"
	%dk_call% dk_echo ""
	%dk_call% dk_echo " 2) cosmopolitan"
	%dk_call% dk_echo " 3) Android arm32"
	%dk_call% dk_echo " 4) Android arm64"
	%dk_call% dk_echo " 5) Android x86"
	%dk_call% dk_echo " 6) Android x86_64"
	%dk_call% dk_echo " 7) Emscripten"
	%dk_call% dk_echo " 8) Ios arm32"
	%dk_call% dk_echo " 9) Ios arm64"
	%dk_call% dk_echo "10) Ios x86"
	%dk_call% dk_echo "11) Ios x86_64"
	%dk_call% dk_echo "12) Iossim arm32"
	%dk_call% dk_echo "13) Iossim arm64"
	%dk_call% dk_echo "14) Iossim x86"
	%dk_call% dk_echo "15) Iossim x86_64"
	%dk_call% dk_echo "16) Linux arm32"
	%dk_call% dk_echo "17) Linux arm64"
	%dk_call% dk_echo "18) Linux x86"
	%dk_call% dk_echo "19) Linux x86_64"
	%dk_call% dk_echo "20) Mac arm32"
	%dk_call% dk_echo "21) Mac arm64"
	%dk_call% dk_echo "22) Mac x86"
	%dk_call% dk_echo "23) Mac x86_64"
	%dk_call% dk_echo "24) Raspberry arm32"
	%dk_call% dk_echo "25) Raspberry arm64"
	%dk_call% dk_echo "26) Raspberry x86"
	%dk_call% dk_echo "27) Raspberry x86_64"
	%dk_call% dk_echo "28) Windows arm32"
	%dk_call% dk_echo "29) Windows arm64 (clang)"
	%dk_call% dk_echo "30) Windows x86 (gcc)"
	%dk_call% dk_echo "31) Windows x86 (clang)"
	%dk_call% dk_echo "32) Windows x86 (msvc)"
	%dk_call% dk_echo "33) Windows x86_64 (gcc)"
	%dk_call% dk_echo "34) Windows x86_64 (clang)"
	%dk_call% dk_echo "35) Windows x86_64 (ucrt)"
	%dk_call% dk_echo "36) Windows x86_64 (msvc)"
	%dk_call% dk_echo "37) Exit"
	%dk_call% dk_echo ""

	%dk_call% dk_keyboardInput input
	if "!input!" equ "0" (
		#%dk_call% dk_echo "repeating last selection"
		#%dk_call% dk_set app 		!_app_!
		#%dk_call% dk_set os 		!_os_!
		#%dk_call% dk_set type 		!_type_!
	) else if "!input!" equ "1" (
		%dk_call% dk_set triple 	!host_triple!
		%dk_call% dk_set os     	!host_os!
		%dk_call% dk_set arch  		!host_arch!
		if defined host_env (
			%dk_call% dk_set env  	!host_env!
		)
	) else if "!input!" equ "2" (
		%dk_call% dk_set os "cosmo"
		%dk_call% dk_set arch "cosmo"
		%dk_call% dk_set env "cosmo"
	) else if "!input!" equ "3" (
		%dk_call% dk_set os "android"
		%dk_call% dk_set arch "arm32"
	) else if "!input!" equ "4" (
		%dk_call% dk_set os "android"
		%dk_call% dk_set arch "arm64"
	) else if "!input!" equ "5" (
		%dk_call% dk_set os "android"
		%dk_call% dk_set arch "x86"
	) else if "!input!" equ "6" (
		%dk_call% dk_set os "android"
		%dk_call% dk_set arch "x86_64"
	) else if "!input!" equ "7" (
		%dk_call% dk_set os "emscripten"
		%dk_call% dk_set arch "x86"
	) else if "!input!" equ "8" (
		%dk_call% dk_set os "ios"
		%dk_call% dk_set arch "arm32"
	) else if "!input!" equ "9" (
		%dk_call% dk_set os "ios"
		%dk_call% dk_set arch "arm64"
	) else if "!input!" equ "10" (
		%dk_call% dk_set os "ios"
		%dk_call% dk_set arch "x86"
	) else if "!input!" equ "11" (
		%dk_call% dk_set os "ios"
		%dk_call% dk_set arch "x86_64"
	) else if "!input!" equ "12" (
		%dk_call% dk_set os "iossim"
		%dk_call% dk_set arch "arm32"
	) else if "!input!" equ "13" (
		%dk_call% dk_set os "iossim"
		%dk_call% dk_set arch "arm64"
	) else if "!input!" equ "14" (
		%dk_call% dk_set os "iossim"
		%dk_call% dk_set arch "x86"
	) else if "!input!" equ "15" (
		%dk_call% dk_set os "iossim"
		%dk_call% dk_set arch "x86_64"
	) else if "!input!" equ "16" (
		%dk_call% dk_set os "linux"
		%dk_call% dk_set arch "arm32"
	) else if "!input!" equ "17" (
		%dk_call% dk_set os "linux"
		%dk_call% dk_set arch "arm64"
	) else if "!input!" equ "18" (
		%dk_call% dk_set os "linux"
		%dk_call% dk_set arch "x86"
	) else if "!input!" equ "19" (
		%dk_call% dk_set os "linux"
		%dk_call% dk_set arch "x86_64"
	) else if "!input!" equ "20" (
		%dk_call% dk_set os "mac"
		%dk_call% dk_set arch "arm32"
	) else if "!input!" equ "21" (
		%dk_call% dk_set os "mac"
		%dk_call% dk_set arch "arm64"
	) else if "!input!" equ "22" (
		%dk_call% dk_set os "mac"
		%dk_call% dk_set arch "x86"
	) else if "!input!" equ "23" (
		%dk_call% dk_set os "mac"
		%dk_call% dk_set arch "x86_64"
	) else if "!input!" equ "24" (
		%dk_call% dk_set os "raspberry"
		%dk_call% dk_set arch "arm32"
	) else if "!input!" equ "25" (
		%dk_call% dk_set os "raspberry"
		%dk_call% dk_set arch "arm64"
	) else if "!input!" equ "26" (
		%dk_call% dk_set os "raspberry"
		%dk_call% dk_set arch "x86"
	) else if "!input!" equ "27" (
		%dk_call% dk_set os "raspberry"
		%dk_call% dk_set arch "x86_64"
	) else if "!input!" equ "28" (
		%dk_call% dk_set os "win"
		%dk_call% dk_set arch "arm32"
	) else if "!input!" equ "29" (
		%dk_call% dk_set os "win"
		%dk_call% dk_set arch "arm64"
		%dk_call% dk_set env "clang"
	) else if "!input!" equ "30" (
		%dk_call% dk_set os "win"
		%dk_call% dk_set arch "x86"
		%dk_call% dk_set env "mingw"
	) else if "!input!" equ "31" (
		%dk_call% dk_set os "win"
		%dk_call% dk_set arch "x86"
		%dk_call% dk_set env "clang"
	) else if "!input!" equ "32" (
		%dk_call% dk_set os "win"
		%dk_call% dk_set arch "x86"
		%dk_call% dk_set env "msvc"
	) else if "!input!" equ "33" (
		%dk_call% dk_set os "win"
		%dk_call% dk_set arch "x86_64"
		%dk_call% dk_set env "mingw"
	) else if "!input!" equ "34" (
		%dk_call% dk_set os "win"
		%dk_call% dk_set arch "x86_64"
		%dk_call% dk_set env "clang"
	) else if "!input!" equ "35" (
		%dk_call% dk_set os "win"
		%dk_call% dk_set arch "x86_64"
		%dk_call% dk_set env "ucrt"
	) else if "!input!" equ "36" (
		%dk_call% dk_set os "win"
		%dk_call% dk_set arch "x86_64"
		%dk_call% dk_set env "msvc"
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
		%dk_call% dk_set triple "!os!_!arch!_!env!"
		%dk_call% dk_set TRIPLE "!OS!_!ARCH!_!ENV!"
	) else (
		%dk_call% dk_set triple "!os!_!arch!"
		%dk_call% dk_set TRIPLE "!OS!_!ARCH!"
	)
	%dk_call% dk_assertVar triple
	%dk_call% dk_assertVar TRIPLE
	%dk_call% dk_set !triple! 1	
	%dk_call% dk_set !TRIPLE! 1	
	%dk_call% dk_printVar triple
	%dk_call% dk_printVar TRIPLE
	%dk_call% dk_printVar !triple!
	%dk_call% dk_printVar !TRIPLE!	

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
	call dk_debugFunc 0
	
	%dk_call% dk_setTargetTriple
%endfunction%