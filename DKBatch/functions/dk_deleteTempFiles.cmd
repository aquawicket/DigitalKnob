@echo off
call dk_includeGuard
call DK

::################################################################################
::# dk_deleteTempFiles()
::#
::#
:dk_deleteTempFiles () {
	call dk_debugFunc
	
    ::call dk_cmakeEval "dk_deleteTempFiles()"
    echo Deleteing .tmp files . . .
    cd "%DIGITALKNOB_DIR%"
    for /r %%i in (*.tmp) do del "%%i"
    for /r %%i in (*.TMP) do del "%%i"
    call dk_checkError
goto:eof