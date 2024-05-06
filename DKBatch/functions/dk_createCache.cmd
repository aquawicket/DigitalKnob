@echo off
call DK

::################################################################################
::# dk_createCache()
::#
::#
:dk_createCache () {
	call dk_debugFunc
	
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