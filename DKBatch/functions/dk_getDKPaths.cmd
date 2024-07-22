@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

call dk_source dk_set
call dk_source dk_makeDirectory
::####################################################################
::# dk_getDKPaths()
::#
::#
:dk_getDKPaths
    call dk_debugFunc
    if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
    set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
    if not exist "%DIGITALKNOB_DIR%" call dk_makeDirectory "%DIGITALKNOB_DIR%"

    set "DKTOOLS_DIR=%DIGITALKNOB_DIR%\DKTools"
    if not exist "%DKTOOLS_DIR%" call dk_makeDirectory "%DKTOOLS_DIR%"
        
    set "DKDOWNLOAD_DIR=%DIGITALKNOB_DIR%\download"
    if not exist "%DKDOWNLOAD_DIR%" call dk_makeDirectory "%DKDOWNLOAD_DIR%"
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_getDKPaths
goto:eof
