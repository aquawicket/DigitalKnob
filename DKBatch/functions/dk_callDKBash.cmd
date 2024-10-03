@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_callDKBash(function, arguments..., rtn_var)
::#
::#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
::#
:dk_callDKBash
    call dk_debugFunc 1 99
 setlocal

	%dk_call% dk_validate DKBASH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	if not exist "%DKBASH_FUNCTIONS_DIR%" set "DKBASH_FUNCTIONS_DIR=%CD%\DKBash\functions"
	if not exist "%DKBASH_FUNCTIONS_DIR%" mkdir "%DKBASH_FUNCTIONS_DIR%"
	if not defined DKHTTP_DKBASH_DIR            set "DKHTTP_DKBASH_DIR=%DKHTTP_DKBRANCH_DIR%/DKBash"
	if not defined DKHTTP_DKBASH_FUNCTIONS_DIR  set "DKHTTP_DKBASH_FUNCTIONS_DIR=%DKHTTP_DKBASH_DIR%/functions"
	if not exist %DKBASH_FUNCTIONS_DIR%\DK.sh %dk_call% dk_download "%DKHTTP_DKBASH_FUNCTIONS_DIR%/DK.sh" "%DKBASH_FUNCTIONS_DIR%/DK.sh"
	if not exist %DKBASH_FUNCTIONS_DIR%\%~1.sh %dk_call% dk_download "%DKHTTP_DKBASH_FUNCTIONS_DIR%/%~1.sh" "%DKBASH_FUNCTIONS_DIR%/%~1.sh"

	%dk_call% dk_validate BASH_EXE "%dk_call% dk_BASH_EXE"
	
	:: get ALL_BUT_FIRST_ARGS
	for /f "tokens=1,* delims= " %%a in ("%*") do set ALL_BUT_FIRST_ARGS=%%b
	
    :: get LAST_ARG
	for %%a in (%*) do set LAST_ARG=%%a
    
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"
    set "DKSCRIPT_PATH=%DKSCRIPT_PATH:C:=/c%"
    set "DKSCRIPT_DIR=%DKSCRIPT_DIR:\=/%"
    set "DKSCRIPT_DIR=%DKSCRIPT_DIR:C:=/c%"
    set "DKSCRIPT_ARGS=%DKSCRIPT_ARGS:\=/%"
    set "DKSCRIPT_ARGS=%DKSCRIPT_ARGS:C:=/c%"
    set "DKHOME_DIR=%DKHOME_DIR:\=/%"
    set "DKHOME_DIR=%DKHOME_DIR:C:=/c%"
    set "DKCACHE_DIR=%DKCACHE_DIR:\=/%"
    set "DKCACHE_DIR=%DKCACHE_DIR:C:=/c%"
    set "DKDESKTOP_DIR=%DKDESKTOP_DIR:\=/%"
    set "DKDESKTOP_DIR=%DKDESKTOP_DIR:C:=/c%"
    set "DIGITALKNOB_DIR=%DIGITALKNOB_DIR:\=/%"
    set "DIGITALKNOB_DIR=%DIGITALKNOB_DIR:C:=/c%"
    set "DKDOWNLOAD_DIR=%DKDOWNLOAD_DIR:\=/%"
    set "DKDOWNLOAD_DIR=%DKDOWNLOAD_DIR:C:=/c%"
    set "DKTOOLS_DIR=%DKTOOLS_DIR:\=/%"
    set "DKTOOLS_DIR=%DKTOOLS_DIR:C:=/c%"
    set "DKBRANCH_DIR=%DKBRANCH_DIR:\=/%"
    set "DKBRANCH_DIR=%DKBRANCH_DIR:C:=/c%"
    set "DK3RDPARTY_DIR=%DK3RDPARTY_DIR:\=/%"
    set "DK3RDPARTY_DIR=%DK3RDPARTY_DIR:C:=/c%"
    set "DKAPPS_DIR=%DKAPPS_DIR:\=/%"
    set "DKAPPS_DIR=%DKAPPS_DIR:C:=/c%"
    set "DKBASH_DIR=%DKBASH_DIR:\=/%"
    set "DKBASH_DIR=%DKBASH_DIR:C:=/c%"
	set "DKBASH_FUNCTIONS_DIR=%DKBASH_FUNCTIONS_DIR:\=/%"
    set "DKBASH_FUNCTIONS_DIR=%DKBASH_FUNCTIONS_DIR:C:=/c%"
    set "DKBASH_FUNCTIONS_DIR_=%DKBASH_FUNCTIONS_DIR_:\=/%"
    set "DKBASH_FUNCTIONS_DIR_=%DKBASH_FUNCTIONS_DIR_:C:=/c%"
    
    set "DKINIT="
    set "RELOAD_WITH_BASH=0"
    ::set "DKSCRIPT_PATH=%DKBASH_FUNCTIONS_DIR%/%~1.sh"
    ::set "DKSCRIPT_DIR=%DKBASH_FUNCTIONS_DIR%"
    ::set "DKSCRIPT_NAME=%~1"
    ::set "DKSCRIPT_EXT=.sh"
    ::set "DKSCRIPT_ARGS=%ALL_BUT_FIRST_ARGS%"
    
    
    set DKBASH_COMMAND="%BASH_EXE% -c '. %DKBASH_FUNCTIONS_DIR%/%~1.sh ^&^& %~1 %ALL_BUT_FIRST_ARGS%'"
	for /f "delims=" %%Z in ('%DKBASH_COMMAND%') do (
		echo %%Z
		set "rtn_value=%%Z"
	)

	if "%LAST_ARG%" == "rtn_var" endlocal & set "%LAST_ARG%=%rtn_value%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
	call dk_callDKBash dk_test "arg 1" "arg 2" rtn_var
	echo rtn_var = %rtn_var%

%endfunction%
