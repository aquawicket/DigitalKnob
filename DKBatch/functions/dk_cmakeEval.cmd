::dk_include_guard()
::@echo on
::################################################################################
::# dk_cmakeEval(<cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>)
::#
::#
:dk_cmakeEval () {
	call dk_verbose "dk_cmakeEval(%*)"
	
    if [%1]==[]                  call dk_error "dk_cmakeEval() parameter1 is invalid"
	if [%CMAKE_EXE%]==[]         call dk_validateCmake
    if not exist "%CMAKE_EXE%"   call dk_error "Could not locate CMAKE_EXE" 
	if [%DKCMAKE_DIR%]==[]       call dk_validateBranch
    if not exist "%DKCMAKE_DIR%" call dk_error "Could not locate DKCMAKE_DIR" 

    set DKCOMMAND=%1
    set DKRETURN=%2
	set DKVARS=%3
	:: remove double quotes
    ::if [%DKCOMMAND%] NEQ [] call set DKCOMMAND=%%DKCOMMAND:"=%%
	if [%DKCOMMAND%] NEQ [] call set DKCOMMAND=%%DKCOMMAND:^\=^/%%
	::if [%DKRETURN%] NEQ []  call set DKRETURN=%%DKRETURN:"=%%
	::if [%DKVARS%] NEQ []    call set DKVARS=%%DKVARS:"=%%
	
	::echo DKCOMMAND = %DKCOMMAND%
	::echo DKRETURN = %DKRETURN%
	::echo DKVARS = %DKVARS%
	
	set "DK_EVAL=%DKCMAKE_DIR%\DKEval.cmake"
	call set DK_EVAL=%%DK_EVAL:^\=^/%%
	::echo DK_EVAL = %DK_EVAL%
	
	::### build cmake command ###
	set "CMAKE_ARGS="
	if %DKCOMMAND% NEQ ""  call set CMAKE_ARGS=%CMAKE_ARGS%"-DDKCOMMAND=%%DKCOMMAND:"=%%"
	if "%DKRETURN%" NEQ "" call set CMAKE_ARGS=%CMAKE_ARGS% "-DDKRETURN=%%DKRETURN:"=%%"
	if "%DKVARS%" NEQ ""   call set CMAKE_ARGS=%CMAKE_ARGS% "%%DKVARS:"=%%"
	set CMAKE_ARGS=%CMAKE_ARGS% "-P"
	set CMAKE_ARGS=%CMAKE_ARGS% "%DK_EVAL%"
    ::echo "%CMAKE_EXE%" "-DDKCOMMAND=%DKCOMMAND%" -P "%DKCMAKE_DIR%/DKEval.cmake" --log-level=TRACE >cmake_eval.out 2>cmake_eval.err

	::### call the cmake command
	::echo "%CMAKE_EXE%" %CMAKE_ARGS%
	"%CMAKE_EXE%" %CMAKE_ARGS%
	
	if "%DKRETURN%" == "" goto:eof
	if not exist %DKCMAKE_DIR%\cmake_vars.cmd goto:eof
    call %DKCMAKE_DIR%\cmake_vars.cmd
	del %DKCMAKE_DIR%\cmake_vars.cmd

    ::if [%2] == [] goto no_return_values
    ::goto with_return_values

::    :no_return_values
::		"%CMAKE_EXE%" "-DDKCOMMAND=%DKCOMMAND%" "-P" "%DKCMAKE_DIR%/DKEval.cmake"
::  goto:eof
::
::    :with_return_values
::		"%CMAKE_EXE%" "-DDKCOMMAND=%DKCOMMAND%" "-DDKRETURN=%~2" "%~3" "-P" "%DKCMAKE_DIR%/DKEval.cmake"
::        ::if not exist %DKCMAKE_DIR%/cmake_vars.cmd goto:eof
::        call %EVAL_VARS%
::        ::del %EVAL_VARS%
::    goto:eof

    ::call dk_debug ERRORLEVEL

    :::: work with cmake return code files ::::
    :: std::out
::    set out=
::    if exist "cmake_eval.out" (
::        for /f "Tokens=* Delims=" %%x in (cmake_eval.out) do (
::            set out=!out!%%x
::            echo %%x
::        )
::    )
    ::out contains all of the lines
    ::del cmake_eval.out
    ::echo %out%    

    :: std::err
::    set err=
::    if exist "cmake_eval.err" (
::        for /f "Tokens=* Delims=" %%x in (cmake_eval.err) do (
::            set err=!err!%%x
::            echo [91m %%x [0m
::        )
::    )
    ::del cmake_eval.out
    ::err contains all of the lines
    ::echo %err%

    call dk_checkError
goto:eof