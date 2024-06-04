@echo off
call DK

::####################################################################
::# dk_getDKPaths()
::#
::#
:dk_getDKPaths () {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	::call dk_load dk_makeDirectory
	
	call dk_set DIGITALKNOB_DIR %HOMEDRIVE%%HOMEPATH%\digitalknob
    call dk_makeDirectory "%DIGITALKNOB_DIR%"


    call dk_set DKTOOLS_DIR %DIGITALKNOB_DIR%\DKTools
    call dk_makeDirectory "%DKTOOLS_DIR%"
        
    call dk_set DKDOWNLOAD_DIR %DIGITALKNOB_DIR%\download
    call dk_makeDirectory "%DKDOWNLOAD_DIR%"
goto:eof



:DKTEST ########################################################################

	call dk_getDKPaths