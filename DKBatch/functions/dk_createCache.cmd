@echo off
call DK

::################################################################################
::# dk_createCache()
::#
::#
:dk_createCache () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
    echo creating cache...
    ::call dk_printVar APP
    ::call dk_printVar TARGET_OS
    ::call dk_printVar TYPE
    ::call dk_printVar LEVEL
        
    :: https://stackoverflow.com/a/5143293/688352
    echo %APP%>"%DKBRANCH_DIR%\cache"
    echo %TARGET_OS%>>"%DKBRANCH_DIR%\cache"
    echo %TYPE%>>"%DKBRANCH_DIR%\cache"
    ::echo %LEVEL%>>"%DKBRANCH_DIR%\cache"
goto:eof



:DKTEST ########################################################################
