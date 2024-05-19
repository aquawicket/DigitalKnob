@echo off
call DK

::################################################################################
::# dk_deleteTempFiles()
::#
::#
:dk_deleteTempFiles () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
    call dk_echo "Deleteing .tmp files . . ."
	call dk_validate DIGITALKNOB_DIR dk_getDKPaths
    cd "%DIGITALKNOB_DIR%"
    for /r %%i in (*.tmp) do del "%%i"
    for /r %%i in (*.TMP) do del "%%i"
    call dk_checkError
goto:eof



:DKTEST ########################################################################

    call dk_deleteTempFiles