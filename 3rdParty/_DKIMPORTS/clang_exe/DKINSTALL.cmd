rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ############ clang ############
rem # https://packages.msys2.org/package/mingw-w64-x86_64-clang?repo=mingw64
rem #
:DKINSTALL
%setlocal%
	
	%dk_call% dk_validate Host_Tuple	%dk_call% dk_Host_Tuple
	%dk_call% dk_validate Target_Tuple	%dk_call% DKBuilder/Target_Tuple
	%dk_call% dk_validate msys2 		%dk_call% dk_depend msys2
	%dk_call% dk_installPackage clang
	
	if defined Android (
		%dk_call% dk_validate ANDROID_NDK 		%dk_call% dk_depend android-ndk
		%dk_call% dk_set clang_exe   			"%ANDROID_NDK%/toolchains/llvm/prebuilt/%Android_Host_Tag%/bin/clang.exe"
	) else if defined Linux_Host (
		if EXIST "/usr/bin/clang" (
			%dk_call% dk_set clang_exe			"usr/bin/clang"
		) else if EXIST "/usr/local/bin/clang" (
			%dk_call% dk_set clang_exe			"/usr/local/bin/clang"
		)
	) else if defined Windows_Arm64_Clang (
		%dk_call% dk_set clang_exe   			"!msys2!/clangarm64/bin/clang.exe"
		%dk_call% dk_set clang++_exe   			"!msys2!/clangarm64/bin/clang++.exe"
	) else if defined Windows_X86_Clang (
		%dk_call% dk_set clang_exe   			"!msys2!/clang32/bin/clang.exe"
		%dk_call% dk_set clang++_exe   			"!msys2!/clang32/bin/clang++.exe"
	) else if defined Windows_X86_64_Clang (
		%dk_call% dk_set clang_exe   			"!msys2!/clang64/bin/clang.exe"
		%dk_call% dk_set clang++_exe   			"!msys2!/clang64/bin/clang++.exe"
	) else if defined Windows_X86_Gcc (
		%dk_call% dk_set clang_exe   			"!msys2!/mingw32/bin/clang.exe"
		%dk_call% dk_set clang++_exe   			"!msys2!/mingw32/bin/clang++.exe"
	) else if defined Windows_X86_64_Gcc (
		%dk_call% dk_set clang_exe   			"!msys2!/mingw64/bin/clang.exe"
		%dk_call% dk_set clang++_exe   			"!msys2!/mingw64/bin/clang++.exe"
	) else if defined Windows_X86_64_Ucrt (
		%dk_call% dk_set clang_exe   			"!msys2!/ucrt64/bin/clang.exe"
		%dk_call% dk_set clang++_exe   			"!msys2!/ucrt64/bin/clang++.exe"
	)

	:return
	endlocal & (
		set "clang_exe=%clang_exe:\=/%"
		set "clang++_exe=%clang++_exe:\=/%"
	)
	rem %dk_call% dk_debug "clang_exe = %clang_exe%"
	rem %dk_call% dk_debug "clang++_exe = %clang++_exe%"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate clang_exe %dk_call% dk_depend clang_exe
	%dk_call% dk_debug "clang_exe = %clang_exe%"
	
	%dk_call% dk_validate clang_exe %dk_call% dk_depend clang_exe
	%dk_call% dk_debug "clang_exe = %clang_exe%"
%endfunction%