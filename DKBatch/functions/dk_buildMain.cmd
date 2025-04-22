@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)


::####################################################################
::# dk_buildMain()
::#
::#
:dk_buildMain
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKDESKTOP_DIR		"%dk_call% dk_DKDESKTOP_DIR"
	%dk_call% dk_validate DIGITALKNOB_DIR	"%dk_call% dk_DIGITALKNOB_DIR"
	%dk_call% dk_validate DKBRANCH_DIR		"%dk_call% dk_DKBRANCH_DIR"
	
	if not exist "%DKDESKTOP_DIR%/digitalknob.lnk" (
		%dk_call% dk_createShortcut "%DIGITALKNOB_DIR%" "%DKDESKTOP_DIR%/digitalknob.lnk"
	)
	
	%dk_call% dk_pinToQuickAccess "%DIGITALKNOB_DIR%"
	
	if not exist "%DKBRANCH_DIR%/DKBatch/apps/DKBuilder/DKBuilder.cmd" (
		%dk_call% dk_download "%DKHTTP_DKBRANCH_DIR%/DKBatch/apps/DKBuilder/DKBuilder.cmd" "%DKBRANCH_DIR%/DKBatch/apps/DKBuilder/DKBuilder.cmd"
	)
	
	if not exist "%DKDESKTOP_DIR%/DKBuilder.cmd" (
		%dk_call% dk_createSymlink "%DKBRANCH_DIR%/DKBatch/apps/DKBuilder/DKBuilder.cmd" "%DKDESKTOP_DIR%/DKBuilder.cmd"
	)

	::%dk_call% dk_assertPath DKSCRIPT_DIR
	
	%dk_call% dk_unset UPDATE
	%dk_call% dk_unset target_app
	%dk_call% dk_unset target_triple
	%dk_call% dk_unset target_type

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
			rem Each host_arch will have a list of compatible triples
			rem The the current host_arch doesn't have the target_tripple in it's allowed list
			rem We goto skipTarget, we could also have a disabled list for each host_arch to do the same:
			rem A block list could be good, because everything will be attempted by default instead of enabled.
			rem Example win_x86 mac ios iossim	=	win_x86_host's will skip all instaces of mac, ios and iossim


			if defined BUILD_LIST[!_line_!][2] (
				set "UPDATE=1"
				call set "target_app=%%BUILD_LIST[!_line_!][0]%%"
				call set "target_triple=%%BUILD_LIST[!_line_!][1]%%"
				call set "target_type=%%BUILD_LIST[!_line_!][2]%%"
				set /a _line_+=1
			) else (
				set "BUILD_LIST_FILE="
			)
		)

		if not defined UPDATE			%dk_call% dk_pickUpdate UPDATE			& goto :while_loop
		if not defined target_app		%dk_call% dk_target_app target_app		& goto :while_loop
		if not defined target_triple	%dk_call% dk_target_triple_SET			& goto :while_loop
		if not defined target_type		%dk_call% dk_target_type target_type	& goto :while_loop

		:: save selections to DKBuilder.cache file
		%dk_call% dk_echo "creating DKBuilder.cache..."
		%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
		%dk_call% dk_fileWrite "%DKCACHE_DIR%/DKBuilder.cache" "%target_app% %target_triple% %target_type%"

		%dk_call% dk_generate
		%dk_call% dk_buildApp

		%dk_call% dk_unset UPDATE
		%dk_call% dk_unset target_app
		%dk_call% dk_unset target_triple
		%dk_call% dk_unset target_type
	goto while_loop
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 0

	%dk_call% dk_buildMain
%endfunction%
