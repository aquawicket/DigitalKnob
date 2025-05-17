@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_buildMain()
::#
::#
:dk_buildMain
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKDESKTOP_DIR		"%dk_call% dk_DKDESKTOP_DIR"
	%dk_call% dk_validate DIGITALKNOB_DIR	"%dk_call% dk_DIGITALKNOB_DIR"
	%dk_call% dk_validate DKBRANCH_DIR		"%dk_call% dk_DKBRANCH_DIR"
	
	if not exist "%DKDESKTOP_DIR%/digitalknob.lnk" (
		%dk_call% dk_createShortcut "%DIGITALKNOB_DIR%" "%DKDESKTOP_DIR%/digitalknob.lnk"
	)
	
	%dk_call% dk_quickAccessPin "%DIGITALKNOB_DIR%"
	
	if not exist "%DKBRANCH_DIR%/DKBatch/apps/DKBuilder/DKBuilder.cmd" (
		%dk_call% dk_download "%DKHTTP_DKBRANCH_DIR%/DKBatch/apps/DKBuilder/DKBuilder.cmd" "%DKBRANCH_DIR%/DKBatch/apps/DKBuilder/DKBuilder.cmd"
	)
	
	if not exist "%DKDESKTOP_DIR%/DKBuilder.cmd" (
		%dk_call% dk_createSymlink "%DKBRANCH_DIR%/DKBatch/apps/DKBuilder/DKBuilder.cmd" "%DKDESKTOP_DIR%/DKBuilder.cmd"
	)

	::%dk_call% dk_assertPath DKSCRIPT_DIR
	
	%dk_call% dk_unset UPDATE
	%dk_call% dk_unset Target_App
	%dk_call% dk_unset Target_Tuple
	%dk_call% dk_unset Target_Type

	::set "BUILD_LIST_FILE=%DKCACHE_DIR%/build_list.txt"
	:while_loop
		if exist "%BUILD_LIST_FILE%" (
			%dk_call% dk_fileToGrid "%BUILD_LIST_FILE%" BUILD_LIST
			if not defined _line_ (set /a _line_=0)
			:skipTarget
			call set "comment_check=%%BUILD_LIST[!_line_!][0]%%"
			if "!comment_check:~0,1!" equ "#" (
				rem echo skipping _line_ . . .
				set /a _line_+=1
				goto :skipTarget
			)
			rem Each Host_Arch will have a list of compatible tuples
			rem The the current Host_Arch doesn't have the Target_Tuple in it's allowed list
			rem We goto skipTarget, we could also have a disabled list for each Host_Arch to do the same:
			rem A block list could be good, because everything will be attempted by default instead of enabled.
			rem Example win_x86 mac ios iossim	=	Windows_X86_Host's will skip all instaces of mac, ios and iossim


			if defined BUILD_LIST[!_line_!][2] (
				set "UPDATE=1"
				call set "Target_App=%%BUILD_LIST[!_line_!][0]%%"
				call set "Target_Tuple=%%BUILD_LIST[!_line_!][1]%%"
				call set "Target_Type=%%BUILD_LIST[!_line_!][2]%%"
				set /a _line_+=1
			) else (
				set "BUILD_LIST_FILE="
			)
		)

		if not defined UPDATE			%dk_call% dk_pickUpdate UPDATE	& goto :while_loop
		if not defined Target_App		%dk_call% dk_Target_App			& goto :while_loop
		if not defined Target_Os		%dk_call% dk_Target_Os			& goto :while_loop
		if not defined Target_Arch		%dk_call% dk_Target_Arch		& goto :while_loop
		if not defined Target_Env		%dk_call% dk_Target_Env			& goto :while_loop
		if not defined Target_Type		%dk_call% dk_Target_Type		& goto :while_loop
		if not defined Target_Tuple		%dk_call% dk_Target_Tuple

		:: save selections to DKBuilder.cache file
		%dk_call% dk_echo "creating DKBuilder.cache..."
		%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
		if defined Target_App	(%dk_call% dk_fileWrite		"%DKCACHE_DIR%/DKBuilder.cache" "Target_App_Cache=%Target_App%")
		if defined Target_Os	(%dk_call% dk_fileAppend	"%DKCACHE_DIR%/DKBuilder.cache" "Target_Os_Cache=%Target_Os%")
		if defined Target_Arch	(%dk_call% dk_fileAppend	"%DKCACHE_DIR%/DKBuilder.cache" "Target_Arch_Cache=%Target_Arch%")
		if defined Target_Env	(%dk_call% dk_fileAppend	"%DKCACHE_DIR%/DKBuilder.cache" "Target_Env_Cache=%Target_Env%")
		if defined Target_Type	(%dk_call% dk_fileAppend	"%DKCACHE_DIR%/DKBuilder.cache" "Target_Type_Cache=%Target_Type%")
		if defined Target_Tuple	(%dk_call% dk_fileAppend	"%DKCACHE_DIR%/DKBuilder.cache" "Target_Tuple_Cache=%Target_Tuple%")
		
		%dk_call% dk_generate
		%dk_call% dk_buildApp

		%dk_call% dk_unset UPDATE
		%dk_call% dk_unset Target_App
		%dk_call% dk_unset Target_Tuple
		%dk_call% dk_unset Target_Type
	goto while_loop
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_buildMain
%endfunction%
