@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_callDKBash(function, arguments..., rtn_var)
::#
::#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
::#
:dk_callDKBash
setlocal
	%dk_call% dk_debugFunc 1 99

	::set "USE_WSL=1"
	if defined USE_WSL   (%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR")
	if defined USE_WSL   (%dk_call% dk_validate WSL_EXE "%dk_call% %DKIMPORTS_DIR%/wsl/DKINSTALL.cmd")

	::### Get DKBASH_FUNCTIONS_DIR
	%dk_call% dk_validate DKBASH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"

	::### Get DKHTTP_DKBASH_FUNCTIONS_DIR
	if not defined DKHTTP_DKBASH_DIR			(set "DKHTTP_DKBASH_DIR=%DKHTTP_DKBRANCH_DIR%/DKBash")
	if not defined DKHTTP_DKBASH_FUNCTIONS_DIR  (set "DKHTTP_DKBASH_FUNCTIONS_DIR=%DKHTTP_DKBASH_DIR%/functions")

	::### Download files if missing
	if not exist %DKBASH_FUNCTIONS_DIR%/DK.sh	(%dk_call% dk_download "%DKHTTP_DKBASH_FUNCTIONS_DIR%/DK.sh" "%DKBASH_FUNCTIONS_DIR%/DK.sh")
	if not exist %DKBASH_FUNCTIONS_DIR%/%~1.sh	(%dk_call% dk_download "%DKHTTP_DKBASH_FUNCTIONS_DIR%/%~1.sh" "%DKBASH_FUNCTIONS_DIR%/%~1.sh")

	%dk_call% dk_validate BASH_EXE "%dk_call% dk_BASH_EXE"

::	set ALL_BUT_FIRST=%*
::	if defined ALL_BUT_FIRST (set ALL_BUT_FIRST=!ALL_BUT_FIRST:*%1=!)

	:: get LAST_ARG
	for %%a in (%*) do set LAST_ARG=%%a

	::set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:C:=/c%"
	if defined USE_WSL (set "DKSCRIPT_PATH=%DKSCRIPT_PATH:/c/=/mnt/c/%")

	::set "DKBASH_FUNCTIONS_DIR=%DKBASH_FUNCTIONS_DIR:\=/%"
	set "DKBASH_FUNCTIONS_DIR=%DKBASH_FUNCTIONS_DIR:C:=/c%"
	if defined USE_WSL (set "DKBASH_FUNCTIONS_DIR=%DKBASH_FUNCTIONS_DIR:/c/=/mnt/c/%")	
	set "DKBASH_FUNCTIONS_DIR_=%DKBASH_FUNCTIONS_DIR%/"

::	set "RELOAD_WITH_BASH=0"
	if defined USE_WSL (set WSLENV=DKSCRIPT_PATH/u:DKINIT/u:RELOAD_WITH_BASH/u:DKBASH_FUNCTIONS_DIR_/u)

	:: Call DKBash function
::  if not defined USE_WSL set DKBASH_COMMAND=%BASH_EXE% -c '. %DKBASH_FUNCTIONS_DIR%/%~1.sh ^&^& %~1 %ALL_BUT_FIRST%'
::	if defined USE_WSL (set DKBASH_COMMAND="%WSL_EXE% bash -c '. %DKBASH_FUNCTIONS_DIR%/%~1.sh ^&^& %~1 %ALL_BUT_FIRST%'")


::	::echo %DKBASH_COMMAND%
::	for /f "delims=" %%Z in ('%DKBASH_COMMAND%') do (
::		echo %%Z				&rem  Display the other shell's stdout
::		set "rtn_value=%%Z"	 &rem  Set the return value to the last line of output
::	)
::	::echo rtn_value = !rtn_value!

::	endlocal & (
::		set "dk_callDKBash=%dk_callDKBash%""
::		if "%LAST_ARG%" == "rtn_var" (set "%LAST_ARG%=%dk_callDKBash%")
::	)

	set "test=DKBash"
	::###### run command ######
	set "bash_file=%DKBASH_FUNCTIONS_DIR:\=/%/%~1.sh"
	if defined USE_WSL (
		rem set DKBASH_COMMAND=%WSL_EXE% bash -c 'export RELOAD_WITH_BASH=; . %bash_file%; %1 %ALL_BUT_FIRST%'
		set DKBASH_COMMAND=%WSL_EXE% bash -c '. %bash_file%; %*'
	) else (
		rem set DKBASH_COMMAND=%BASH_EXE% -c 'export RELOAD_WITH_BASH=; . %bash_file%; %1 %ALL_BUT_FIRST%'
		set DKBASH_COMMAND=%BASH_EXE% -c '. %bash_file%; %*'
	)
	::echo DKBASH_COMMAND = %DKBASH_COMMAND%
	echo ############################################
	%dk_call% dk_commandToVariable "%DKBASH_COMMAND%"
	echo ############################################
	echo echo "errorlevel = %errorlevel%"

	endlocal & set "dk_callDKBash=%dk_commandToVariable%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKBash dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKBash = %dk_callDKBash%"
%endfunction%
