<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::################################################################################
::# dk_callDKCmake(function, arguments..., rtn_var)
::#
::#
:dk_callDKCmake
<<<<<<< HEAD
    call dk_debugFunc 1 4
 setlocal

    %dk_call% dk_validate DKIMPORTS_DIR         "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_validate CMAKE_EXE             "call %DKIMPORTS_DIR%\cmake\dk_installCmake.cmd"
	%dk_call% dk_validate DKCMAKE_DIR "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	set "DKCMAKE_FUNCTIONS_DIR=%DKCMAKE_FUNCTIONS_DIR:\=/%"
	set "DKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_FUNCTIONS_DIR%/"
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"
    
    :: get ALL_BUT_FIRST_ARGS
	for /f "tokens=1,* delims= " %%a in ("%*") do set ALL_BUT_FIRST_ARGS=%%b
    set "ALL_BUT_FIRST_ARGS=%ALL_BUT_FIRST_ARGS:"='%"
    
    :: get LAST_ARG
	for %%a in (%*) do set LAST_ARG=%%a
    
    ::Create Run function Script
    set "DKCOMMAND=%~1(%ALL_BUT_FIRST_ARGS%)"

    :: Call DKCmake function
    set "DKCMAKE_COMMAND=%CMAKE_EXE% "-DDKCOMMAND=%DKCOMMAND%" "-DDKSCRIPT_PATH=%DKSCRIPT_PATH%" "-DQUEUE_BUILD=ON" "-DDKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_FUNCTIONS_DIR_%" -P %DKCMAKE_DIR%/DKEval.cmake"
    ::echo %DKCMAKE_COMMAND%    
    for /f "delims=" %%Z in ('%DKCMAKE_COMMAND%') do (
        echo %%Z                &rem  Display the other shell's stdout
        set "rtn_value=%%Z"     &rem  Set the return value to the last line of output
    )
    ::echo rtn_value = !rtn_value!
    
	if "%LAST_ARG%" == "rtn_var" endlocal & set "%LAST_ARG%=%rtn_value%"
=======
setlocal
	%dk_call% dk_debugFunc 1 4


	%dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"

	::### Get DKHTTP_DKCMAKE_FUNCTIONS_DIR
	if not defined DKHTTP_DKCMAKE_DIR					(set "DKHTTP_DKCMAKE_DIR=%DKHTTP_DKBRANCH_DIR%/DKCMake")
	if not defined DKHTTP_DKCMAKE_FUNCTIONS_DIR			(set "DKHTTP_DKCMAKE_FUNCTIONS_DIR=%DKHTTP_DKCMAKE_DIR%/functions")

	::### Download files if missing
	if not exist "%DKCMAKE_FUNCTIONS_DIR%/DK.cmake"		(%dk_call% dk_download "%DKHTTP_DKCMAKE_FUNCTIONS_DIR%/DK.cmake" "%DKCMAKE_FUNCTIONS_DIR%/DK.cmake")
	::if not exist "%DKCMAKE_FUNCTIONS_DIR%/%~1.cmake"	(%dk_call% dk_download "%DKHTTP_DKCMAKE_FUNCTIONS_DIR%/%~1.cmake" "%DKCMAKE_FUNCTIONS_DIR%/%~1.cmake")

	%dk_call% dk_validate DKIMPORTS_DIR				"%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate CMAKE_EXE					"%dk_call% %DKIMPORTS_DIR%/cmake/DKINSTALL.cmd"

	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"

	::Create Run function Script
	::set "DKCOMMAND=%~1(%ALL_BUT_FIRST%)"
	set DKCOMMAND=%~1
	::set "DKCOMMAND=%DKCOMMAND:"='%"

	:: Call DKCmake function
	set DKCMAKE_COMMAND=%CMAKE_EXE% "-DDKCOMMAND=%DKCOMMAND%" "-DDKSCRIPT_PATH=%DKSCRIPT_PATH%" "-DQUEUE_BUILD=ON" "-DDKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_FUNCTIONS_DIR_%" "-P" "%DKCMAKE_DIR%/DKEval.cmake"
	%dk_call% dk_exec %DKCMAKE_COMMAND%
	endlocal & (
		set "dk_callDKCmake=%dk_exec%"
	)

>>>>>>> Development
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_callDKCmake dk_test "FROM DKBatch" "dk_callDKCmake.cmd" rtn_var
	%dk_call% dk_echo
    %dk_call% dk_echo "rtn_var = %rtn_var%"
=======
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKCmake "dk_test('arg 1' 'arg 2' 'arg 3')"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKCmake = %dk_callDKCmake%"
>>>>>>> Development
%endfunction%
