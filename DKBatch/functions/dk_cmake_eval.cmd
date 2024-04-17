::dk_include_guard()

::################################################################################
::# dk_cmake_eval(<cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>)
::#
::#
:dk_cmake_eval () {
	call:dk_verbose "dk_cmake_eval(%*)"
	
    echo.
    echo  $ dk_cmake_eval (%*)
    echo.
    
    if [%1] == [] (
        echo "ERROR: dk_cmake_eval() parameter1 is invalid"
        goto:eof
    )
    if not exist "%CMAKE_EXE%" ( 
        echo "ERROR: Could not locate CMAKE_EXE" 
        goto:eof
    )
    if not exist "%DKCMAKE_DIR%" ( 
        echo "ERROR: Could not locate DKCMAKE_DIR" 
        goto:eof
    )

    set commands=%1
    set variables=%2

    call set commands=%%commands:"=%%
    set "DKCOMMAND=%commands%"
    call set DKCOMMAND=%%DKCOMMAND:^\=^/%%
    ::#call:dk_debug DKCOMMAND

    set "EVAL_VARS=%DKCMAKE_DIR%\cmake_vars.cmd"
    call set DKCMAKE_DIR=%%DKCMAKE_DIR:^\=^/%%
        
    ::echo "%CMAKE_EXE%" "-DDKCMAKE_DIR=%DKCMAKE_DIR%" "-DDKCOMMAND=%DKCOMMAND%" -P "%DKCMAKE_DIR%/dev/cmake_eval.cmake" --log-level=TRACE >cmake_eval.out 2>cmake_eval.err

    if [%2] == [] goto no_return_values
    goto with_return_values

    :no_return_values
        "%CMAKE_EXE%" "-DDKCMAKE_DIR=%DKCMAKE_DIR%" "-DDKCOMMAND=%DKCOMMAND%" -P "%DKCMAKE_DIR%/dev/cmake_eval.cmake"
    goto:eof

    :with_return_values
        "%CMAKE_EXE%" "-DDKCMAKE_DIR=%DKCMAKE_DIR%" "-DDKCOMMAND=%DKCOMMAND%" "-DDKRETURN=%~2" %~3 -P %DKCMAKE_DIR%/dev/cmake_eval.cmake
        if not exist %DKCMAKE_DIR%/cmake_vars.cmd goto:eof
        call %EVAL_VARS%
        ::del %EVAL_VARS%
    goto:eof

    ::call:dk_debug ERRORLEVEL

    :::: work with cmake return code files ::::
    :: std::out
    set out=
    if exist "cmake_eval.out" (
        for /f "Tokens=* Delims=" %%x in (cmake_eval.out) do (
            set out=!out!%%x
            echo %%x
        )
    )
    ::out contains all of the lines
    ::del cmake_eval.out
    ::echo %out%    

    :: std::err
    set err=
    if exist "cmake_eval.err" (
        for /f "Tokens=* Delims=" %%x in (cmake_eval.err) do (
            set err=!err!%%x
            echo [91m %%x [0m
        )
    )
    ::del cmake_eval.out
    ::err contains all of the lines
    ::echo %err%

    call:dk_check_error
goto:eof