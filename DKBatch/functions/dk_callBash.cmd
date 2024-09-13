@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_callBash(function, arguments..., return_args...)
::#
::#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
::#
:dk_callBash
    call dk_debugFunc 1 99
 setlocal
	
	%dk_call% dk_validate DKBASH_FUNCTIONS_DIR "%dk_call% dk_validateBranch"
	if not exist "%DKBASH_FUNCTIONS_DIR%" set "DKBASH_FUNCTIONS_DIR=%CD%\DKBash\functions"
	if not exist "%DKBASH_FUNCTIONS_DIR%" mkdir "%DKBASH_FUNCTIONS_DIR%"
	if not defined DKHTTP_DKBASH_DIR            set "DKHTTP_DKBASH_DIR=%DKHTTP_DKBRANCH_DIR%/DKBash"
	if not defined DKHTTP_DKBASH_FUNCTIONS_DIR  set "DKHTTP_DKBASH_FUNCTIONS_DIR=%DKHTTP_DKBASH_DIR%/functions"
	if not exist %DKBASH_FUNCTIONS_DIR%\DK.sh %dk_call% dk_download "%DKHTTP_DKBASH_FUNCTIONS_DIR%/DK.sh" "%DKBASH_FUNCTIONS_DIR%/DK.sh"
	if not exist %DKBASH_FUNCTIONS_DIR%\%~1.sh %dk_call% dk_download "%DKHTTP_DKBASH_FUNCTIONS_DIR%/%~1.sh" "%DKBASH_FUNCTIONS_DIR%/%~1.sh"
	
	%dk_call% dk_validate BASH_EXE "%dk_call% dk_setBASH_EXE"

	:: get last argument
	for %%a in (%*) do set LAST_ARG=%%a
	
	:: get all but fisrt argument
	for /f "tokens=1,* delims= " %%a in ("%*") do set ALL_BUT_FIRST_ARGS=%%b
	
	set DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%
	set DKBASH_FUNCTIONS_DIR=%DKBASH_FUNCTIONS_DIR:\=/%
	for /f "delims=" %%Z in ('%BASH_EXE% -c "DKSCRIPT_PATH=%DKSCRIPT_PATH% & . %DKBASH_FUNCTIONS_DIR%/%~1.sh && %~1 %ALL_BUT_FIRST_ARGS%"') do (
		echo %%Z
		set "rtn_value=%%Z"
	)

	if "%LAST_ARG%" == "rtn_var" endlocal & set "%LAST_ARG%=%rtn_value%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_callBash dk_test "parameter1" "parameter2" rtn_var
	echo rtn_var = %rtn_var%
	::%dk_call% dk_callPowershell dk_confirm
    ::%dk_call% dk_callPowershell dk_debug "string from DKBatch"

%endfunction%
