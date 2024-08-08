@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_createCache()
::#
::#
:dk_createCache
	call dk_debugFunc 0
	
	setlocal
    echo creating cache...
    ::call dk_printVar APP
    ::call dk_printVar TARGET_OS
    ::call dk_printVar TYPE
    ::call dk_printVar LEVEL
        
    :: https://stackoverflow.com/a/5143293/688352
    call dk_fileWrite "%DKBRANCH_DIR%\cache" %APP%
    call dk_fileAppend "%DKBRANCH_DIR%\cache" %TARGET_OS%
    call dk_fileAppend "%DKBRANCH_DIR%\cache" %TYPE%
    ::call dk_fileAppend "%DKBRANCH_DIR%\cache" %LEVEL%
	endlocal
goto:eof



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_createCache
goto:eof
