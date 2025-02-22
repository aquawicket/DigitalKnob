@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_fileToVariable(<path>, optional:<rtn_var>)
::#
::#  Read lines of a file into an array and echo them back
::#
::#  reference: https://stackoverflow.com/a/49042678
::#
:dk_fileToVariable
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2

    set "_file_=%~1"
	set "_file_=%_file_:/=\%"
	
	set /a _row_=0
	for /F "usebackq delims=" %%r in ("%_file_%") do (
		set "%~2[!_row_!]=%%r"
		set /a _row_+=1
    )
	
    :: Return the array to the calling scope
    set "currentScope=1"
    for /F "delims=" %%a in ('set %~2[') do (
       if defined currentScope endlocal
       set "%%a"
    )
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_fileToVariable "%DKBRANCH_DIR%\build_list.txt" myVar
	::%dk_call% dk_fileToVariable "%DKBRANCH_DIR%\Readme.md" myVar      FIXME
    %dk_call% dk_printVar myVar
%endfunction%
