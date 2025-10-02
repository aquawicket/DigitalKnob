@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# main()
::#
::#
:main
%setlocal%
	%dk_call% dk_debugFunc 0

	::############ Host_Os ############
	%dk_call% dk_validate Host_Os 			"%dk_call% dk_Host_Os"
	%dk_call% dk_validate DKDESKTOP_DIR		"%dk_call% dk_DKDESKTOP_DIR"
	%dk_call% dk_validate DIGITALKNOB_DIR	"%dk_call% dk_DIGITALKNOB_DIR"
	%dk_call% dk_validate DKBRANCH_DIR		"%dk_call% dk_DKBRANCH_DIR"
	
	if NOT EXIST "%DKDESKTOP_DIR%/DigitalKnob.lnk" (
		%dk_call% dk_createShortcut "%DIGITALKNOB_DIR%" "%DKDESKTOP_DIR%/DigitalKnob.lnk"
	)
	
	%dk_call% dk_quickAccessPin "%DIGITALKNOB_DIR%"
	
	if NOT EXIST "%DKBRANCH_DIR%/DKBatch/functions/DKBuilder/DKBuilder.cmd" (
		%dk_call% dk_download "%DKHTTP_DKBRANCH_DIR%/DKBatch/functions/DKBuilder/DKBuilder.cmd" "%DKBRANCH_DIR%/DKBatch/functions/DKBuilder/DKBuilder.cmd"
	)
	
	if NOT EXIST "%DKDESKTOP_DIR%/DKBuilder.cmd" (
		%dk_call% dk_createSymlink "%DKBRANCH_DIR%/DKBatch/functions/DKBuilder/DKBuilder.cmd" "%DKDESKTOP_DIR%/DKBuilder.cmd"
	)

	%dk_call% dk_unset pickUpdate
	%dk_call% dk_unset Target_App
	%dk_call% dk_unset Target_Os
	%dk_call% dk_unset Target_Arch
	%dk_call% dk_unset Target_Env
	%dk_call% dk_unset Target_Tuple
	%dk_call% dk_unset Target_Type

	:while_loop
		if EXIST "%BUILD_LIST_FILE%" (
			if NOT defined BUILD_MATRIX[0][0] (
				%dk_call% dk_fileToMatrix "%BUILD_LIST_FILE%" BUILD_MATRIX
			)
			
			if NOT defined _line_ (set /a _line_=0)
			:skipLine
			call set "comment_check=%%BUILD_MATRIX[!_line_!][0]%%"
			if "!comment_check:~0,1!" equ "#" (
				set /a _line_+=1
				goto :skipLine
			)

			if defined BUILD_MATRIX[!_line_!][0] (
				set "pickUpdate=1"
				call set "Target_App=%%BUILD_MATRIX[!_line_!][0]%%"
				call set "Target_Os=%%BUILD_MATRIX[!_line_!][1]%%"
				call set "Target_Arch=%%BUILD_MATRIX[!_line_!][2]%%"
				call set "Target_Env=%%BUILD_MATRIX[!_line_!][3]%%"
				call set "Target_Type=%%BUILD_MATRIX[!_line_!][4]%%"
				set /a _line_+=1
			) else (
				set "BUILD_LIST_FILE="
			)
		)

		if NOT defined pickUpdate		%dk_call% DKBuilder/pickUpdate		& goto :while_loop
		if NOT defined Target_App		%dk_call% DKBuilder/Target_App		& goto :while_loop
		if NOT defined Target_Os		%dk_call% DKBuilder/Target_Os		& goto :while_loop
		if NOT defined Target_Arch		%dk_call% DKBuilder/Target_Arch		& goto :while_loop
		if NOT defined Target_Env		%dk_call% DKBuilder/Target_Env		& goto :while_loop
		if NOT defined Target_Type		%dk_call% DKBuilder/Target_Type		& goto :while_loop
		if NOT defined Target_Tuple		%dk_call% DKBuilder/Target_Tuple
		
		::###### save selections to DKBuilder.cache file ######
		::%dk_call% dk_echo "creating DKBuilder.cache..."
		%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
		if defined Target_App	(%dk_call% dk_fileWrite		"%DKCACHE_DIR%/DKBuilder.cache" "Target_App_Cache=%Target_App%")
		if defined Target_Os	(%dk_call% dk_fileAppend	"%DKCACHE_DIR%/DKBuilder.cache" "Target_Os_Cache=%Target_Os%")
		if defined Target_Arch	(%dk_call% dk_fileAppend	"%DKCACHE_DIR%/DKBuilder.cache" "Target_Arch_Cache=%Target_Arch%")
		if defined Target_Env	(%dk_call% dk_fileAppend	"%DKCACHE_DIR%/DKBuilder.cache" "Target_Env_Cache=%Target_Env%")
		if defined Target_Type	(%dk_call% dk_fileAppend	"%DKCACHE_DIR%/DKBuilder.cache" "Target_Type_Cache=%Target_Type%")
		
		::### TODO: handle disabled tuples
		::# Android 		Arm32			Clang		Debug
		::# Android 		Arm32			Clang		Release
		::# Android 		Arm64 			Clang		Debug
		::# Android 		Arm64 			Clang		Release
		::# Android 		X86 			Clang		Debug
		::# Android 		X86 			Clang		Release
		::# Android 		X86_64 			Clang		Debug
		::# Android 		X86_64 			Clang		Release
		::# Cosmo			Cosmo			Cosmo		Debug
		::# Cosmo			Cosmo			Cosmo		Release
		::# Emscripten 		X86 			Clang		Debug
		::# Emscripten 		X86 			Clang		Release
		::# Ios 			Arm32 			Clang		Debug
		::# Ios 			Arm32 			Clang		Release
		::# Ios 			Arm64 			Clang		Debug
		::# Ios 			Arm64 			Clang		Release
		::# Ios 			X86 			Clang		Debug
		::# Ios 			X86 			Clang		Release
		::# Ios 			X86_64 			Clang		Debug
		::# Ios 			X86_64 			Clang		Release
		::# Iossim 			Arm32 			Clang		Debug
		::# Iossim 			Arm32 			Clang		Release
		::# Iossim 			Arm64 			Clang		Debug
		::# Iossim 			Arm64 			Clang		Release
		::# Iossim 			X86 			Clang		Debug
		::# Iossim 			X86 			Clang		Release
		::# Iossim 			X86 			Clang		Debug
		::# Iossim 			X86 			Clang		Release
		::# Linux 			Arm32 			Clang		Debug
		::# Linux 			Arm32 			Clang		Release
		::# Linux 			Arm32 			Gcc			Debug
		::# Linux 			Arm32 			Gcc			Release
		::# Linux 			Arm64 			Clang		Debug
		::# Linux 			Arm64 			Clang		Release
		::# Linux 			Arm64 			Gcc			Debug
		::# Linux 			Arm64 			Gcc			Release
		::# Linux 			X86 			Clang		Debug
		::# Linux 			X86 			Clang		Release
		::# Linux 			X86 			Gcc			Debug
		::# Linux 			X86 			Gcc			Release
		::# Linux 			X86_64 			Clang		Debug
		::# Linux 			X86_64 			Clang		Release
		::# Linux 			X86_64 			Gcc			Debug
		::# Linux 			X86_64 			Gcc			Release
		::# Mac 			Arm32 			Clang		Debug
		::# Mac 			Arm32 			Clang		Release
		::# Mac 			Arm64 			Clang		Debug
		::# Mac 			Arm64 			Clang		Release
		::# Mac 			X86 			Clang		Debug
		::# Mac 			X86 			Clang		Release
		::# Mac 			X86_64 			Clang		Debug
		::# Mac 			X86_64 			Clang		Release
		::# Raspberry 		Arm32 			Clang		Debug
		::# Raspberry 		Arm32 			Clang		Release
		::# Raspberry 		Arm32 			Gcc			Debug
		::# Raspberry 		Arm32 			Gcc			Release
		::# Raspberry 		Arm64 			Clang		Debug
		::# Raspberry 		Arm64 			Clang		Release
		::# Raspberry 		Arm64 			Gcc			Debug
		::# Raspberry 		Arm64 			Gcc			Release
		::# Windows 		Arm32 			Clang		Debug
		::# Windows 		Arm32 			Clang		Release
		::# Windows 		Arm32 			Gcc			Debug
		::# Windows 		Arm32 			Gcc			Release
		::# Windows 		Arm32 			Msvc		Debug
		::# Windows 		Arm32 			Msvc		Release
		::# Windows 		Arm64 			Clang		Debug
		::# Windows 		Arm64 			Clang		Release
		::# Windows 		Arm64 			Gcc			Debug
		::# Windows 		Arm64 			Gcc			Release
		::# Windows 		Arm64 			Msvc		Debug
		::# Windows 		Arm64 			Msvc		Release
		::# Windows 		X86 			Clang		Debug
		::# Windows 		X86 			Clang		Release
		::# Windows 		X86 			Gcc			Debug
		::# Windows 		X86 			Gcc			Release
		::# Windows 		X86 			Msvc		Debug
		::# Windows 		X86 			Msvc		Release
		::# Windows 		X86_64 			Clang		Debug
		::# Windows 		X86_64 			Clang		Release
		::# Windows 		X86_64 			Gcc			Debug
		::# Windows 		X86_64 			Gcc			Release
		::# Windows 		X86_64 			Msvc		Debug
		::# Windows 		X86_64 			Msvc		Release
		::# Windows 		X86_64 			Ucrt		Debug
		::# Windows 		X86_64 			Ucrt		Release
		
		::### On Windows_Host, we can build linux through WSL (Windows Subsystem fo Linux)
		if /i "%Target_Os%" equ "Linux" (
			set "wsl_exe=%windir:\=/%/System32/wsl.exe"
			rem set "DKBASH_APPS_DIR=/mnt/c/Users/Administrator/DigitalKnob/Development/DKBash/apps"
			set "DKBuilder_sh=/mnt/c/Users/Administrator/DigitalKnob/Development/DKBash/apps/DKBuilder/DKBuilder.sh"
			set "pickUpdate=1"
set WSLENV=%WSLENV%:^
USERPROFILE/p:^
SystemDrive/p:^
SystemRoot/p:^
windir/p:^
wsl_exe/p:^
pickUpdate:^
Target_App:^
Target_Os:^
Target_Arch:^
Target_Env:^
Target_Type:^
Target_Tuple
			rem %wsl_exe% /bin/bash -c "%DKBASH_APPS_DIR%/DKBuilder/DKBuilder.sh"
			%wsl_exe% /bin/bash -c "%DKBuilder_sh%"
			goto while_loop
		)
		
		::### Pass the Target variables to CMake to take over
		::########### cmake Command ###################
		%dk_call% dk_validate DKCPP_APPS_DIR "%dk_call% dk_DKBRANCH_DIR"
		%dk_call% dk_chdir "%DKCPP_APPS_DIR%/%Target_App%"
		%dk_call% dk_validate cmake_exe "%dk_call% dk_depend cmake"
		%cmake_exe% -P "%DKCPP_APPS_DIR%/%Target_App%/DKINSTALL.cmake"
		
		::%dk_call% DKBuilder/generate
		::%dk_call% DKBuilder/buildApp

		%dk_call% dk_unset pickUpdate
		%dk_call% dk_unset Target_App
		%dk_call% dk_unset Target_Os
		%dk_call% dk_unset Target_Arch
		%dk_call% dk_unset Target_Env
		%dk_call% dk_unset Target_Type
		%dk_call% dk_unset Target_Tuple
		
	goto while_loop
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% main
%endfunction%
