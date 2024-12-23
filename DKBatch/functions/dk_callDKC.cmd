@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_callDKC(function, arguments..., rtn_var)
::#
::#
:dk_callDKC
    call dk_debugFunc 1 99
 setlocal

	
	%dk_call% dk_validate DKC_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"
	if not exist "%DKC_FUNCTIONS_DIR%"       set "DKC_FUNCTIONS_DIR=%CD%\DKBash\functions"
	if not exist "%DKC_FUNCTIONS_DIR%"       mkdir "%DKC_FUNCTIONS_DIR%"
	if not defined DKHTTP_DKBASH_DIR         set "DKHTTP_DKBASH_DIR=%DKHTTP_DKBRANCH_DIR%/DKBash"
	if not defined DKHTTP_DKC_FUNCTIONS_DIR  set "DKHTTP_DKC_FUNCTIONS_DIR=%DKHTTP_DKBASH_DIR%/functions"
	if not exist %DKC_FUNCTIONS_DIR%\DK.h    %dk_call% dk_download "%DKHTTP_DKC_FUNCTIONS_DIR%/DK.h" "%DKC_FUNCTIONS_DIR%/DK.h"
	if not exist %DKC_FUNCTIONS_DIR%\%~1.c   %dk_call% dk_download "%DKHTTP_DKC_FUNCTIONS_DIR%/%~1.c" "%DKC_FUNCTIONS_DIR%/%~1.c"

	%dk_call% dk_BASH_EXE

	:: get ALL_BUT_FIRST_ARGS
	for /f "tokens=1,* delims= " %%a in ("%*") do set ALL_BUT_FIRST_ARGS=%%b

    :: get LAST_ARG
	for %%a in (%*) do set LAST_ARG=%%a
    
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"
    set "DKSCRIPT_PATH=%DKSCRIPT_PATH:C:=/c%"
	
	set "DKC_FUNCTIONS_DIR=%DKC_FUNCTIONS_DIR:\=/%"
    set "DKC_FUNCTIONS_DIR=%DKC_FUNCTIONS_DIR:C:=/c%"

    set "DKC_FUNCTIONS_DIR_=%DKC_FUNCTIONS_DIR_:\=/%"
    set "DKC_FUNCTIONS_DIR_=%DKC_FUNCTIONS_DIR_:C:=/c%"
	
    set "DKINIT="

	
    :: Call DKBash function
    if not defined USE_WSL set DKC_COMMAND="%BASH_EXE% -c '. %DKC_FUNCTIONS_DIR%/%~1.c ^&^& %~1 %ALL_BUT_FIRST_ARGS%'"
	if defined USE_WSL set DKC_COMMAND="%WSL_EXE% bash -c '. %DKC_FUNCTIONS_DIR%/%~1.c ^&^& %~1 %ALL_BUT_FIRST_ARGS%'"

    ::echo %DKBASH_COMMAND%
	for /f "delims=" %%Z in ('%DKC_COMMAND%') do (
        echo %%Z                &rem  Display the other shell's stdout
        set "rtn_value=%%Z"     &rem  Set the return value to the last line of output
	)
    ::echo rtn_value = !rtn_value!
    
	if "%LAST_ARG%" == "rtn_var" endlocal & set "%LAST_ARG%=%rtn_value%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_callDKBash dk_test "FROM DKBatch" "dk_callDKBash.cmd" rtn_var
    %dk_call% dk_echo
	if defined rtn_var  %dk_call% dk_echo "rtn_var = %rtn_var%"
%endfunction%
