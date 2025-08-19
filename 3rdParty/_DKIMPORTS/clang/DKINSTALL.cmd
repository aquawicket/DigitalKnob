@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############ clang ############
::# https://packages.msys2.org/package/mingw-w64-x86_64-clang?repo=mingw64
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate Host_Tuple	"%dk_call% dk_Host_Tuple"
	%dk_call% dk_validate Target_Tuple	"%dk_call% Target_Tuple"

	::if /i "%Host_Os%" equ "Windows" (
		%dk_call% dk_validate MSYS2 "%dk_call% dk_depend msys2"
	::)

	%dk_call% dk_installPackage clang
	
	if defined Android (
		%dk_call% dk_validate ANDROID_NDK 		"%dk_call% dk_depend android-ndk"
		%dk_call% dk_set CLANG_C_COMPILER   	"${ANDROID_NDK}/toolchains/llvm/prebuilt/${Android_Host_Tag}/bin/clang${exe}"
		%dk_call% dk_set CLANG_CXX_COMPILER  	"${ANDROID_NDK}/toolchains/llvm/prebuilt/${Android_Host_Tag}/bin/clang++${exe}"
	) else if defined Linux_Host (
		if EXIST "/usr/bin/clang" (
			%dk_call% dk_set CLANG_C_COMPILER	"usr/bin/clang"
		) else if EXIST "/usr/local/bin/clang" (
			%dk_call% dk_set CLANG_C_COMPILER	"/usr/local/bin/clang"
		)

		if EXIST "/usr/bin/clang++" (
			%dk_call% dk_set CLANG_CXX_COMPILER	"/usr/bin/clang++"
		) else if EXIST "/usr/local/bin/clang++" (
			%dk_call% dk_set CLANG_CXX_COMPILER	"/usr/local/bin/clang++"
		)
	) else if defined Windows_Arm64_Clang (
		%dk_call% dk_validate MSYS2 			"%dk_call% dk_depend msys2"
		rem %dk_call% dk_set CLANGARM64_BIN		"!MSYS2!/clangarm64/bin"
		%dk_call% dk_set CLANG_C_COMPILER   	"!MSYS2!/clangarm64/bin/clang.exe"
		%dk_call% dk_set CLANG_CXX_COMPILER 	"!MSYS2!/clangarm64/bin/clang++.exe"
		%dk_call% dk_set CLANG_RC_COMPILER  	"!MSYS2!/clangarm64/bin/windres.exe"
	) else if defined Windows_X86_Clang (
		%dk_call% dk_validate MSYS2 			"%dk_call% dk_depend msys2"
		rem %dk_call% dk_set CLANG32_BIN		"!MSYS2!/clang32/bin"
		%dk_call% dk_set CLANG_C_COMPILER   	"!MSYS2!/clang32/bin/clang.exe"
		%dk_call% dk_set CLANG_CXX_COMPILER		"!MSYS2!/clang32/bin/clang++.exe"
		%dk_call% dk_set CLANG_RC_COMPILER  	"!MSYS2!/clang32/bin/windres.exe"
	) else if defined Windows_X86_64_Clang (
		%dk_call% dk_validate MSYS2 			"%dk_call% dk_depend msys2"
		rem %dk_call% dk_set CLANG64_BIN		"!MSYS2!/clang64/bin"
		%dk_call% dk_set CLANG_C_COMPILER   	"!MSYS2!/clang64/bin/clang.exe"
		%dk_call% dk_set CLANG_CXX_COMPILER 	"!MSYS2!/clang64/bin/clang++.exe"
		%dk_call% dk_set CLANG_RC_COMPILER  	"!MSYS2!/clang64/bin/windres.exe"
	) else if defined Windows_X86_Gcc (
		%dk_call% dk_validate MSYS2 			"%dk_call% dk_depend msys2"
		rem %dk_call% dk_set MINGW32_BIN		"!MSYS2!/mingw32/bin"
		%dk_call% dk_set CLANG_C_COMPILER   	"!MSYS2!/mingw32/bin/clang.exe"
		%dk_call% dk_set CLANG_CXX_COMPILER 	"!MSYS2!/mingw32/bin/clang++.exe"
		%dk_call% dk_set CLANG_RC_COMPILER  	"!MSYS2!/mingw32/bin/windres.exe"
	) else if defined Windows_X86_64_Gcc (
		%dk_call% dk_validate MSYS2 			"%dk_call% dk_depend msys2"
		rem %dk_call% dk_set MINGW64_BIN		"!MSYS2!/mingw64/bin"
		%dk_call% dk_set CLANG_C_COMPILER   	"!MSYS2!/mingw64/bin/clang.exe"
		%dk_call% dk_set CLANG_CXX_COMPILER 	"!MSYS2!/mingw64/bin/clang++.exe"
		%dk_call% dk_set CLANG_RC_COMPILER  	"!MSYS2!/mingw64/bin/windres.exe"
	) else if defined Windows_X86_64_Ucrt (
		%dk_call% dk_validate MSYS2 			"%dk_call% dk_depend msys2"
		rem %dk_call% dk_set UCRT64_BIN			"!MSYS2!/ucrt64/bin"
		%dk_call% dk_set CLANG_C_COMPILER   	"!MSYS2!/ucrt64/bin/clang.exe"
		%dk_call% dk_set CLANG_CXX_COMPILER 	"!MSYS2!/ucrt64/bin/clang++.exe"
		%dk_call% dk_set CLANG_RC_COMPILER  	"!MSYS2!/ucrt64/bin/windres.exe"
	)

%endfunction%

