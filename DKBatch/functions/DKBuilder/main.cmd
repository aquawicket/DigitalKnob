@rem shebang
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


rem ####################################################################
rem # main()
rem #
rem #
:main
%setlocal%
	rem ############ Host_Os ############
	%dk_call% dk_validate Host_Os 			%dk_call% dk_Host_Os
	%dk_call% dk_validate DKDESKTOP_DIR		%dk_call% dk_DKDESKTOP_DIR
	%dk_call% dk_validate DIGITALKNOB_DIR	%dk_call% dk_DIGITALKNOB_DIR
	%dk_call% dk_validate DKBRANCH_DIR		%dk_call% dk_DKBRANCH_DIR
	
	if NOT EXIST "%DKDESKTOP_DIR%/DigitalKnob.lnk" (
		%dk_call% dk_createShortcut "%DIGITALKNOB_DIR%" "%DKDESKTOP_DIR%/DigitalKnob.lnk"
	)
	
	if NOT EXIST "%DKDESKTOP_DIR%/DKBuilder.lnk" (
		%dk_call% dk_createShortcut "%DKBATCH_FUNCTIONS_DIR_%/DKBuilder/DKBuilder.cmd" "%DKDESKTOP_DIR%/DKBuilder.lnk"
	)
	
rem	%dk_call% dk_quickAccessPin "%DIGITALKNOB_DIR%"

rem	if NOT EXIST "%DKBRANCH_DIR%/DKBatch/functions/DKBuilder/DKBuilder.cmd" (
rem		%dk_call% dk_download "%DKHTTP_DKBRANCH_DIR%/DKBatch/functions/DKBuilder/DKBuilder.cmd" "%DKBRANCH_DIR%/DKBatch/functions/DKBuilder/DKBuilder.cmd"
rem	)
rem	%dk_call% dk_copy "%DKBRANCH_DIR%/DKBatch/functions/DKBuilder/DKBuilder.cmd" "%DKStorage_Dir%/DKBuilder.cmd" OVERWRITE
	
rem	if NOT EXIST "%DKDESKTOP_DIR%/DKBuilder.cmd" (
rem		%dk_call% dk_createSymlink "%DKBRANCH_DIR%/DKBatch/functions/DKBuilder/DKBuilder.cmd" "%DKDESKTOP_DIR%/DKBuilder.cmd"
rem	)

	rem	:restart_loop
	call :clear_vars

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
		if "%RESUME%" equ "1" (
			if "%Target_App%" 	equ "%Target_App_Cache%" (
			if "%Target_Os%" 	equ "%Target_Os_Cache%" (
			if "%Target_Arch%" 	equ "%Target_Arch_Cache%" (
			if "%Target_Env%" 	equ "%Target_Env_Cache%" (
			if "%Target_Type%" 	equ "%Target_Type_Cache%" (
				%dk_call% dk_unset RESUME
			))))) else (
				goto :while_loop
			)
		)
		if NOT defined pickUpdate		(%dk_call% DKBuilder/pickUpdate		&& goto :while_loop) else (echo pickUpdate   = %pickUpdate%)
		if NOT defined Target_App		(%dk_call% DKBuilder/Target_App		&& goto :while_loop) else (echo Target_App   = %Target_App%)
		if NOT defined Target_Os		(%dk_call% DKBuilder/Target_Os		&& goto :while_loop) else (echo Target_Os    = %Target_Os%)
		if NOT defined Target_Arch		(%dk_call% DKBuilder/Target_Arch	&& goto :while_loop) else (echo Target_Arch  = %Target_Arch%)
		if NOT defined Target_Env		(%dk_call% DKBuilder/Target_Env		&& goto :while_loop) else (echo Target_Env   = %Target_Env%)
		if NOT defined Target_Type		(%dk_call% DKBuilder/Target_Type	&& goto :while_loop) else (echo Target_Type  = %Target_Type%)
		if NOT defined Target_Tuple		(%dk_call% DKBuilder/Target_Tuple	&& goto :while_loop) else (echo Target_Tuple = %Target_Tuple%)
		
		rem ###### save selections to DKBuilder.cache file ######
		rem %dk_call% dk_echo "creating DKBuilder.cache..."
		%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
		set "DKBuilder_cache=%DKCACHE_DIR%/DKBuilder.cache"
		if defined Target_App	(%dk_call% dk_fileVariable  "%DKBuilder_cache%" Target_App_Cache	"%Target_App%")
		if defined Target_Os	(%dk_call% dk_fileVariable	"%DKBuilder_cache%" Target_Os_Cache		"%Target_Os%")
		if defined Target_Arch	(%dk_call% dk_fileVariable	"%DKBuilder_cache%" Target_Arch_Cache	"%Target_Arch%")
		if defined Target_Env	(%dk_call% dk_fileVariable	"%DKBuilder_cache%" Target_Env_Cache	"%Target_Env%")
		if defined Target_Type	(%dk_call% dk_fileVariable	"%DKBuilder_cache%" Target_Type_Cache	"%Target_Type%")
		
		rem ### TODO: handle disabled tuples
		rem # Android 		Arm32			Clang		Debug
		rem # Android 		Arm32			Clang		Release
		rem # Android 		Arm64 			Clang		Debug
		rem # Android 		Arm64 			Clang		Release
		rem # Android 		X86 			Clang		Debug
		rem # Android 		X86 			Clang		Release
		rem # Android 		X86_64 			Clang		Debug
		rem # Android 		X86_64 			Clang		Release
		rem # Cosmo			Cosmo			Cosmo		Debug
		rem # Cosmo			Cosmo			Cosmo		Release
		rem # Emscripten 		X86 			Clang		Debug
		rem # Emscripten 		X86 			Clang		Release
		rem # Ios 			Arm32 			Clang		Debug
		rem # Ios 			Arm32 			Clang		Release
		rem # Ios 			Arm64 			Clang		Debug
		rem # Ios 			Arm64 			Clang		Release
		rem # Ios 			X86 			Clang		Debug
		rem # Ios 			X86 			Clang		Release
		rem # Ios 			X86_64 			Clang		Debug
		rem # Ios 			X86_64 			Clang		Release
		rem # Iossim 			Arm32 			Clang		Debug
		rem # Iossim 			Arm32 			Clang		Release
		rem # Iossim 			Arm64 			Clang		Debug
		rem # Iossim 			Arm64 			Clang		Release
		rem # Iossim 			X86 			Clang		Debug
		rem # Iossim 			X86 			Clang		Release
		rem # Iossim 			X86 			Clang		Debug
		rem # Iossim 			X86 			Clang		Release
		rem # Linux 			Arm32 			Clang		Debug
		rem # Linux 			Arm32 			Clang		Release
		rem # Linux 			Arm32 			Gcc			Debug
		rem # Linux 			Arm32 			Gcc			Release
		rem # Linux 			Arm64 			Clang		Debug
		rem # Linux 			Arm64 			Clang		Release
		rem # Linux 			Arm64 			Gcc			Debug
		rem # Linux 			Arm64 			Gcc			Release
		rem # Linux 			X86 			Clang		Debug
		rem # Linux 			X86 			Clang		Release
		rem # Linux 			X86 			Gcc			Debug
		rem # Linux 			X86 			Gcc			Release
		rem # Linux 			X86_64 			Clang		Debug
		rem # Linux 			X86_64 			Clang		Release
		rem # Linux 			X86_64 			Gcc			Debug
		rem # Linux 			X86_64 			Gcc			Release
		rem # Mac 			Arm32 			Clang		Debug
		rem # Mac 			Arm32 			Clang		Release
		rem # Mac 			Arm64 			Clang		Debug
		rem # Mac 			Arm64 			Clang		Release
		rem # Mac 			X86 			Clang		Debug
		rem # Mac 			X86 			Clang		Release
		rem # Mac 			X86_64 			Clang		Debug
		rem # Mac 			X86_64 			Clang		Release
		rem # Raspberry 		Arm32 			Clang		Debug
		rem # Raspberry 		Arm32 			Clang		Release
		rem # Raspberry 		Arm32 			Gcc			Debug
		rem # Raspberry 		Arm32 			Gcc			Release
		rem # Raspberry 		Arm64 			Clang		Debug
		rem # Raspberry 		Arm64 			Clang		Release
		rem # Raspberry 		Arm64 			Gcc			Debug
		rem # Raspberry 		Arm64 			Gcc			Release
		rem # Windows 		Arm32 			Clang		Debug
		rem # Windows 		Arm32 			Clang		Release
		rem # Windows 		Arm32 			Gcc			Debug
		rem # Windows 		Arm32 			Gcc			Release
		rem # Windows 		Arm32 			Msvc		Debug
		rem # Windows 		Arm32 			Msvc		Release
		rem # Windows 		Arm64 			Clang		Debug
		rem # Windows 		Arm64 			Clang		Release
		rem # Windows 		Arm64 			Gcc			Debug
		rem # Windows 		Arm64 			Gcc			Release
		rem # Windows 		Arm64 			Msvc		Debug
		rem # Windows 		Arm64 			Msvc		Release
		rem # Windows 		X86 			Clang		Debug
		rem # Windows 		X86 			Clang		Release
		rem # Windows 		X86 			Gcc			Debug
		rem # Windows 		X86 			Gcc			Release
		rem # Windows 		X86 			Msvc		Debug
		rem # Windows 		X86 			Msvc		Release
		rem # Windows 		X86_64 			Clang		Debug
		rem # Windows 		X86_64 			Clang		Release
		rem # Windows 		X86_64 			Gcc			Debug
		rem # Windows 		X86_64 			Gcc			Release
		rem # Windows 		X86_64 			Msvc		Debug
		rem # Windows 		X86_64 			Msvc		Release
		rem # Windows 		X86_64 			Ucrt		Debug
		rem # Windows 		X86_64 			Ucrt		Release
		if "!DISABLE_%Target_App%!" equ "1" (
			%dk_call% dk_notice "%Target_App% is Disabled"
			call :clear_vars
			goto :while_loop
		)
		
		if "!DISABLE_%Target_Os%!" equ "1" (
			%dk_call% dk_notice "%Target_Os% is Disabled"
			call :clear_vars
			goto :while_loop
		)
		
		if "!DISABLE_%Target_Arch%!" equ "1" (
			%dk_call% dk_notice "%Target_Arch% is Disabled"
			call :clear_vars
			goto :while_loop
		)
		
		if "!DISABLE_%Target_Os%_%Target_Arch%!" equ "1" (
			%dk_call% dk_notice "%Target_Os%_%Target_Arch% is Disabled"
			call :clear_vars
			goto :while_loop
		)
		
		if "!DISABLE_%Target_Env%!" equ "1" (
			%dk_call% dk_notice "%Target_Env% is Disabled"
			call :clear_vars
			goto :while_loop
		)
		
		if "!DISABLE_%Target_Type%!" equ "1" (
			%dk_call% dk_notice "%Target_Type% is Disabled"
			call :clear_vars
			goto :while_loop
		)
		
		if "!DISABLE_%Target_Tuple%!" equ "1" (
			%dk_call% dk_notice "%Target_Tuple% is Disabled"
			call :clear_vars
			goto :while_loop
		)
		
		
		rem ### On Windows_Host, we can build linux through WSL (Windows Subsystem for Linux)
		if /i "%Target_Os%" equ "Linux" (
			%dk_call% dk_validate wsl.exe %dk_call% dk_depend wsl.exe
			set "DKBuilder_sh=/mnt/c/Users/Administrator/Digital Knob/Development/DKBash/apps/DKBuilder/DKBuilder.sh"
			set "pickUpdate=1"
			set "ReturnControl=1"
set WSLENV=%WSLENV%:^
USERPROFILE/p:^
SystemDrive/p:^
SystemRoot/p:^
wsl.exe/p:^
pickUpdate:^
Target_App:^
Target_Os:^
Target_Arch:^
Target_Env:^
Target_Type:^
Target_Tuple:^
ReturnControl

			echo !wsl.exe:/=\! /bin/bash -c "!DKBuilder_sh!"
			!wsl.exe:/=\! /bin/bash -c "!DKBuilder_sh!"

			call :clear_vars
			goto :while_loop
		) 
		
		rem ### Pass the Target variables to CMake to take over
		rem ########### cmake Command ###################
		%dk_call% dk_validate DKCPP_APPS_DIR %dk_call% dk_DKBRANCH_DIR
		echo.
		echo.
		echo.
		echo %dk_call% cmake.exe -P "%DKCPP_APPS_DIR%/%Target_App%/DKINSTALL.cmake"
		%dk_call% cmake.exe -P "%DKCPP_APPS_DIR%/%Target_App%/DKINSTALL.cmake"
			
		rem %dk_call% DKBuilder/generate
		rem %dk_call% DKBuilder/buildApp

	call :clear_vars	
	goto :while_loop
%endfunction%


:clear_vars
	%dk_call% dk_unset pickUpdate
	%dk_call% dk_unset Target_App
	%dk_call% dk_unset Target_Os
	%dk_call% dk_unset Target_Arch
	%dk_call% dk_unset Target_Env
	%dk_call% dk_unset Target_Tuple
	%dk_call% dk_unset Target_Type
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% DKBuilder/main
%endfunction%
