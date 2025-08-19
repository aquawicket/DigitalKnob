@echo off&::###### DK.cmd #########################################################################################################################
if NOT exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
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
	
	if NOT exist "%DKDESKTOP_DIR%/DigitalKnob.lnk" (
		%dk_call% dk_createShortcut "%DIGITALKNOB_DIR%" "%DKDESKTOP_DIR%/DigitalKnob.lnk"
	)
	
	%dk_call% dk_quickAccessPin "%DIGITALKNOB_DIR%"
	
	if NOT exist "%DKBRANCH_DIR%/DKBatch/functions/DKBuilder/DKBuilder.cmd" (
		%dk_call% dk_download "%DKHTTP_DKBRANCH_DIR%/DKBatch/functions/DKBuilder/DKBuilder.cmd" "%DKBRANCH_DIR%/DKBatch/functions/DKBuilder/DKBuilder.cmd"
	)
	
	if NOT exist "%DKDESKTOP_DIR%/DKBuilder.cmd" (
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
		if exist "%BUILD_LIST_FILE%" (
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
		
		
		::### If we are on windows, we can build linux through WSL (Windows Subsystem fo Linux)
		:: wslpath -u 
		if "%Target_Os%" equ "Linux" (
			set "WSL_EXE=C:/Windows/System32/wsl.exe"
			set "DKBASH_APPS_DIR=/mnt/c/Users/Administrator/DigitalKnob/Development/DKBash/apps"
			%WSL_EXE% %DKBASH_APPS_DIR%/DKBuilder/DKBuilder.sh
			goto while_loop
		)
		
		::### Pass the Target variables to CMake to take over
		::########### CMAKE Command ###################
		%dk_call% dk_validate DKCPP_APPS_DIR "%dk_call% dk_DKBRANCH_DIR"
		%dk_call% dk_chdir %DKCPP_APPS_DIR%/%Target_App%
		%dk_call% dk_validate CMAKE_EXE "%dk_call% dk_depend cmake"
		%CMAKE_EXE% -P "%DKCPP_APPS_DIR%/%Target_App%/DKINSTALL.cmake"
		
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
