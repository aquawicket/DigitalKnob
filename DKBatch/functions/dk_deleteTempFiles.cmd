@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_deleteTempFiles()
::#
::#
:dk_deleteTempFiles
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
    call dk_info "Deleteing .tmp files . . ."
	call dk_validate DIGITALKNOB_DIR "call dk_getDKPaths"
    cd "%DIGITALKNOB_DIR%"
    for /r %%i in (*.tmp) do del "%%i"
    for /r %%i in (*.TMP) do del "%%i"
    ::call dk_checkError
goto:eof



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
    call dk_deleteTempFiles
goto:eof
