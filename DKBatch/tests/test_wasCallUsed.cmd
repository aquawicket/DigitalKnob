@echo off
rem Check if this is the initial invocation or we have already determined 
rem how the batch file was started

    rem If already tested save method, remove test variable and goto main
    if defined __callTest__ (
        set "startMethod=%__callTest__%" 
        set "__callTest__=" 
        goto :main
    )

rem Initial invocation - Test routine 

    rem Cancel current batch context and check if the new context is 
    rem   - batch (there was a call somewhere) 
    rem   - command line (no call)
    rem Once the invocation method is determined, restart the current batch

    setlocal enableextensions disabledelayedexpansion
    call :getCurrentFile _f0
    (
        rem Cancel context
        2>nul (goto)

        rem The context cancel operation interferes with echo logic. Restore
        echo on

        rem We try to read a non existing variable and see if we could. 
        rem   - In command line context, the reading of a non existing variable
        rem     returns the name of the variable, setting our test var
        rem   - In batch context, reading a non existing variable does not 
        rem     return anything, and the test variable is undefined

        call set "__callTest__=%%{[%random%""%random%]}%%"
        if defined __callTest__ (
            set "__callTest__=direct"
            "%_f0%" %*
        ) else (
            set "__callTest__=call"
            call "%_f0%" %*
        )
    )
    :getCurrentFile returnVar
        set "%~1=%~f0"
        goto :eof

rem Main batch code
:main
    setlocal enableextensions disabledelayedexpansion
    echo Method invocation is [ %startMethod% ]
    goto :eof