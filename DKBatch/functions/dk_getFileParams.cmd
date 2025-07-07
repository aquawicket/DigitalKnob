@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

::############ dk_getFileParams settings #########################################
::if not defined dk_getAllFileParams_PRINT_VARIABLES (set "dk_getFileParams_PRINT_VARIABLES=1")
::################################################################################
::# dk_getFileParams(<file>)
::#
:dk_getFileParams
::%setlocal%
	%dk_call% dk_debugFunc 1

	set "_file_=%~1"

	if "%dk_getFileParams_PRINT_VARIABLES%" equ "1" (
		%dk_call% dk_debug "### %_file_% Parameters ###"
	)
	
	::### Remove comments from line
	set "line=todo"
	for /f "tokens=*" %%G in (%_file_:/=\%) do (
		set "line= %%G"
		for /f "delims=#" %%i in ("!line!") do (set "line=%%i")
		set line=!line:~1!
		rem echo line = !line!
		for /f "delims== tokens=1,2" %%A in ("!line!") do (
			set "var=%%~A"
			%dk_call% dk_trim !var!
			set "var=!dk_trim!"
			
			set "value=%%~B"
			%dk_call% dk_trim !value!
			set "value=!dk_trim!"
			set "value=!Value:${=%%!"
			set "value=!Value:}=%%!"
			
			set "!var!=!value!"
			
			if "%dk_getFileParams_PRINT_VARIABLES%" equ "1" (
				%dk_call% dk_debug "'!var!' = '%%!var!%%'"
			)
		)
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	%dk_call% dk_fileWrite	"%DKCACHE_DIR%/dk_getFileParams_TEST.txt"		"Testing=dk_getFileParams.cmd"
	%dk_call% dk_fileAppend	"%DKCACHE_DIR%/dk_getFileParams_TEST.txt"		"varA=ValueOfA"
	%dk_call% dk_fileAppend	"%DKCACHE_DIR%/dk_getFileParams_TEST.txt"		"varB=ValueOfB 	# with trailing comment"
	%dk_call% dk_fileAppend	"%DKCACHE_DIR%/dk_getFileParams_TEST.txt"		" varC=ValueOfC "
	%dk_call% dk_fileAppend	"%DKCACHE_DIR%/dk_getFileParams_TEST.txt"		"varD = ValueOfD"
	%dk_call% dk_fileAppend	"%DKCACHE_DIR%/dk_getFileParams_TEST.txt"		"#varNONE=ValueOfNONE"
	
	set "dk_getFileParams_PRINT_VARIABLES=1"
	%dk_call% dk_getFileParams "%DKCACHE_DIR%/dk_getFileParams_TEST.txt"
%endfunction%
