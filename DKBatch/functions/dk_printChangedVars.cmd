@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_printChangedVars()
::#
::#    https://stackoverflow.com/a/41872317/688352
::#
:dk_printChangedVars
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	
	if not exist %DKCACHE_DIR%/vars.tmp (
		set > %DKCACHE_DIR%\vars.tmp
	)
	
	echo:
	echo ################## Variable Changes ##################

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
            for /f "usebackq delims= eol==" %%o in ("%DKCACHE_DIR%\vars.tmp") do (

                rem If variables match, flag it, else check for variable 
                rem deletion is this is the first loop over the original file
                if %%a==%%o ( set "%%e=1" ) else if not defined %%d (
                    for /f "delims==" %%V in ("%%~o") do if not defined %%V (echo(  DELETED: %%V)
                )
            )

            rem If no match found, output changed value
            if not defined %%e (echo(MODIFIED: %%a)

        rem Now all the variable deletion has been checked.
        ) & if not defined %%d set "%%d=1"

    rem Cleanup flag variables
    ) & set "%%d=" & set "%%e="

    rem Cleanup temporary file
)

	set > %DKCACHE_DIR%\vars.tmp
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_delete "%DKCACHE_DIR%/vars.tmp"
	%dk_call% dk_printChangedVars
	
	set "TestVar=abc"
	%dk_call% dk_printChangedVars
	
	
	set "TestVar="
	%dk_call% dk_printChangedVars
	
%endfunction%
