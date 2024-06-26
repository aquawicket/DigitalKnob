@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::##################################################################################
::# dk_printVariables(msg)
::#
::#    reference: https://stackoverflow.com/a/41872317/688352
::#
:dk_printVariables () {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")

	setlocal enableextensions disabledelayedexpansion

    rem We need a temporary file to store the original environment
    for %%f in ("original_%random%%random%%random%.tmp") do (

        rem Retrieve the original environment to the temporary file
        start /i /wait /min "" "%comspec%" /c">""%%~ff"" set "

        rem We need two flag variables. Prepare two names that "should" not collide
        for /f "tokens=1,2" %%d in ("_&d&%random%%random%_ _&m&%random%%random%_") do (

            rem %%d will be used to determine if we will check for variable deletion 
            rem     on the first inner pass
            rem %%e will be used for matching variables between existing/original variables
            set "%%d="

            rem Retrieve the current environment contents
            for /f "delims= eol==" %%a in ('set') do (

                rem We have not found matching variables
                set "%%e="

                rem Search a match in original set of variables 
                for /f "usebackq delims= eol==" %%o in ("%%~ff") do (

                    rem If variables match, flag it, else check for variable 
                    rem deletion is this is the first loop over the original file
                    if %%a==%%o ( set "%%e=1" ) else if not defined %%d (
                        for /f "delims==" %%V in ("%%~o") do if not defined %%V (echo(%%V=)
                    )
                )

                rem If no match found, output changed value
                if not defined %%e (echo(%%a)

            rem Now all the variable deletion has been checked.
            ) & if not defined %%d set "%%d=1"

        rem Cleanup flag variables
        ) & set "%%d=" & set "%%e="

    rem Cleanup temporary file
    ) & del "%%~ff"
	
goto:eof