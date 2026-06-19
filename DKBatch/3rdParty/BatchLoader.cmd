@echo off
REM IMPORT - a .cmd utility for importing subroutines into the main script

REM !!! IN ORDER TO FUNCTION CORRECTLY:                                                       !!!
REM !!! IMPORT MUST BE CALLED INSIDE A DISABLED DELAYED EXPANSION BLOCK/ENVIRONMENT (DEFAULT) !!!


    rem \\// Define import file mask here:
    rem If mask is not defined outside "import.cmd":
    if not defined mask (
        set "mask=*.cmd; *.bat"
    )
    rem //\\ Define import file mask here:

    rem Detect if script was started from command line:
    call :DetectCommandLine _not_started_from_command_line

    if "%~1" == "/install" (
        set "import_path=%~dp0"
        call :EscapePathString import_path import_path_escaped
    )

    if not "%~1" == "" (
        if /i not "%~1" == "end" (
            if "%~1" == "/?" (
                call :DisplayHelp
            ) else (
                if "%~1" == "/install" (
                    echo Installing
                    set "_first_time="

                    rem This should get into the Autorun registry key: path %path%;"...\import.cmd"
                    rem     If you want, other commands can be added to the left or to the right of this command, unified as a block with a "&" command operator
                    REG ADD "HKCU\Software\Microsoft\Command Processor" /v AutoRun /t REG_SZ /d "path %%path%%;"""%import_path_escaped%""||(
                        echo ERROR: Cannot install import: cannot write to the registry^!
                        echo You can try to manually add the "import.cmd" path in the "PATH" variable or use pushd ^(see help^).
                        if not "%_not_started_from_command_line%" == "0" (
                            call :PressAnyKey Press any key to exit...
                            echo.
                        )
                        exit /b 1
                    )

                    echo.
                    echo Done. The install directory was set to: 
                    echo "%import_path%"
                    echo and was added to the PATH environment variable. You can add other desired programs into this directory.
                    echo.
                    echo Please note that the console needs to be closed and reopened in order for the changes to take effect^!
                    echo.
                ) else (
                    if not defined _first_time (
                        set _first_time=defined
                        set /a count=0
                        if "%_DISPLAY_WARNING%" == "true" (
                            echo.
                            echo WARNING: CMD_LIBRARY was reset to "", because previously it gave an error^!
                            echo.
                        )
                        echo Loading list to import...
                    )
                    REM build import files list 

                    set /a count+=1
                    call set "_import_list_%%count%%=%%~1"
                )
            )
        )
    ) else (
        call :DisplayHelp
    )

    if /i "%~1" == "end" (

        set "_first_time="

        echo Done.
        echo Analyzing...

        rem set "_main_program=%~dpnx2"

        if not exist "%~dpnx2" (
            echo ERROR: Second parameter, after "import end", must be a valid file path - see help^!>>&2

            rem Clean up
            call :CleanUp

            if not "%_not_started_from_command_line%" == "0" (
                call :PressAnyKey Press any key to exit...
                echo.
            )
            exit /b 1
        )
    )

    if /i "%~1" == "end" (
        set "_main_batch_script=%~dpnx2"

        rem \\// Define output filename here:
        rem set "_output_filename=tmp0001_%~n2.cmd"
        set "_output_filename=tmp0001.cmd"
        rem //\\ Define output filename here:
    )

    if /i "%~1" == "end" (
        rem Check all paths not to be UNC:
        setlocal EnableDelayedExpansion
            set "_error=false"

            call :TestIfPathIsUNC _main_batch_script _result
            if "!_result!" == "true" (
                set "_error=true"
                echo. 
                echo ERROR: UNC paths are not allowed: Second parameter, after "import end", must not be a UNC path^^^! Currently it is: "!_main_batch_script!">>&2
            )

            set "_CMD_LIBRARY_error=false"
            call :TestIfPathIsUNC CMD_LIBRARY _result
            if "!_result!" == "true" (
                set "_error=true"
                set "_CMD_LIBRARY_error=true"
                echo.
                echo ERROR: UNC paths are not allowed: CMD_LIBRARY variable must not contain a UNC path^^^! Currently, it is set to: "!CMD_LIBRARY!".>>&2
            )

            for /l %%i in (1,1,!count!) do (
                call :TestIfPathIsUNC _import_list_%%i _result
                if "!_result!" == "true" (
                    set "_error=true"
                    echo.
                    echo ERROR: UNC paths are not allowed: The import path: "!_import_list_%%i!" is a UNC path^^^!>>&2
                )
            )

            if "!_error!" == "true" (
                echo.
                echo Errors were encountered^^^!

                if "!_CMD_LIBRARY_error!" == "true" (
                    endlocal
                    set "_CMD_LIBRARY_error=true"
                ) else (
                    endlocal
                    set "_CMD_LIBRARY_error=false"
                )

                rem Clean up
                call :CleanUp

                if not "%_not_started_from_command_line%" == "0" (
                    call :PressAnyKey Press any key to exit...
                    echo.
                )
                exit /b 1
            ) else (
                endlocal
                set "_CMD_LIBRARY_error=false"
            )
    )

    if /i "%~1" == "end" (
        rem Check all paths not to contain "*" and "?" wildcards:
        set "_asterisk=*"
        set "_qm=?"

        setlocal EnableDelayedExpansion
            set "_error=false"

            call :TestIfStringContains _main_batch_script _asterisk _result1
            call :TestIfStringContains _main_batch_script _qm _result2
            if "!_result1!" == "true" (
                set "_error=true"
            )
            if "!_result2!" == "true" (
                set "_error=true"
            )
            if "!_error!" == "true" (
                echo. 
                echo ERROR: The use of "*" or "?" wildcards is not supported by import: Second parameter, after "import end", must not contain "*" or "?" wildcards^^^! Currently it is: "!_main_batch_script!". Instead, you can set the mask with a set of name and extension masks separated by semicolon, like: set mask="*.cmd; *.bat">>&2
            )

            set "_CMD_LIBRARY_error=false"
            call :TestIfStringContains CMD_LIBRARY _asterisk _result1
            call :TestIfStringContains CMD_LIBRARY _qm _result2
            if "!_result1!" == "true" (
                set "_error=true"
            )
            if "!_result2!" == "true" (
                set "_error=true"
            )
            if "!_error!" == "true" (
                set "_error=true"
                set "_CMD_LIBRARY_error=true"
                echo.
                echo ERROR: The use of "*" or "?" wildcards is not supported by import: CMD_LIBRARY variable must not contain "*" or "?" wildcards^^^! Currently, it is set to: "!CMD_LIBRARY!". Instead, you can set the mask with a set of name and extension masks separated by semicolon, like: set mask="*.cmd; *.bat">>&2
            )

            for /l %%i in (1,1,!count!) do (
                call :TestIfStringContains _import_list_%%i _asterisk _result1
                call :TestIfStringContains _import_list_%%i _qm _result2
                if "!_result1!" == "true" (
                    set "_error=true"
                )
                if "!_result2!" == "true" (
                    set "_error=true"
                )
                if "!_error!" == "true" (
                    set "_error=true"
                    echo.
                    echo ERROR: The use of "*" or "?" wildcards is not supported by import: The import path: "!_import_list_%%i!" must not contain "*" or "?" wildcards^^^! Instead, you can set the mask with a set of name and extension masks separated by semicolon, like: set mask="*.cmd; *.bat">>&2
                )
            )

            if "!_error!" == "true" (
                echo.
                echo Errors were ecountered^^^!

                if "!_CMD_LIBRARY_error!" == "true" (
                    endlocal
                    set "_CMD_LIBRARY_error=true"
                ) else (
                    endlocal
                    set "_CMD_LIBRARY_error=false"
                )

                rem Clean up
                call :CleanUp

                if not "%_not_started_from_command_line%" == "0" (
                    call :PressAnyKey Press any key to exit...
                    echo.
                )
                exit /b 1
            ) else (
                endlocal
                set "_CMD_LIBRARY_error=false"
            )
    )

    if /i "%~1" == "end" (
        pushd "%~dp2"
            call set "_output_dir=%%CD%%"
        popd
    )

    if /i "%~1" == "end" (

        if not defined CMD_LIBRARY (

            set CMD_LIBRARY_CASE=IMPORT.CMD

            set "BASE=%~dpnx0\.."

            pushd "%~dpnx0"\..\

                REM \\// Define CMD LIBRARY here ("." is relative to "import.cmd" parent directory):
                REM if CMD_LIBRARY is not defined outside import.cmd, "." (used here) is related to import.cmd parent directory:
                set "CMD_LIBRARY=."
                REM //\\ Define CMD LIBRARY here ("." is relative to "import.cmd" parent directory):

        ) else (

            set CMD_LIBRARY_CASE=MAIN.CMD

            set "BASE=%~dpnx2\.."

            REM if CMD_LIBRARY is defined outside the "import.cmd" script, "." (used in CMD_LIBRARY) is related to "main program" parent directory
            pushd "%~dpnx2"\..

        )
    )

    if /i "%~1" == "end" (

        call :DeQuoteOnce CMD_LIBRARY CMD_LIBRARY
        call set "CMD_LIBRARY_ORIGINAL=%%CMD_LIBRARY%%"

        call :TestIfPathIsUNC CMD_LIBRARY_ORIGINAL _result
        setlocal EnableDelayedExpansion
            if "!_result!" == "true" (
                set "_error=true"

                echo.
                echo ERROR: UNC paths are not allowed: CMD_LIBRARY variable must not contain a UNC path^^^! Currently, it is set to: "!CMD_LIBRARY_ORIGINAL!".>>&2

                echo.
                echo Errors were ecountered^^^!

                endlocal
                set "_CMD_LIBRARY_error=true"

                rem Clean up
                call :CleanUp

                if not "%_not_started_from_command_line%" == "0" (
                    call :PressAnyKey Press any key to exit...
                    echo.
                )
                exit /b 1
            ) else (
                endlocal
                set "_CMD_LIBRARY_error=false"
            )

        call pushd "%%CMD_LIBRARY%%" >nul 2>nul&&(
            call set "CMD_LIBRARY=%%CD%%"
        )||(
            call echo ERROR: Could not access directory CMD_LIBRARY=^"%%CMD_LIBRARY%%^"^!>>&2

            call :CleanUp

            if not "%_not_started_from_command_line%" == "0" (
                call :PressAnyKey Press any key to exit...
                echo.
            )
            popd
            exit /b 1
        )

    )

    if /i "%~1" == "end" (
        setlocal EnableDelayedExpansion
            set _error=false
            pushd "!BASE!"
            echo.
            if "!CMD_LIBRARY_CASE!" == "IMPORT.CMD" (
                echo CMD_LIBRARY was defined as: "!CMD_LIBRARY_ORIGINAL!" in the file "import.cmd" and was expanded to: "!CMD_LIBRARY!"
            ) else (
                if "!CMD_LIBRARY_CASE!" == "MAIN.CMD" (
                    echo CMD_LIBRARY was defined as: "!CMD_LIBRARY_ORIGINAL!" outside "import.cmd" file "%~nx2" and was expanded to: "!CMD_LIBRARY!"
                ) 
            )
                for /l %%i in (1,1,!count!) do (
                    if not exist "!_import_list_%%i!" (
                        if not exist "!CMD_LIBRARY!\!_import_list_%%i!" (
                            rem if first time:
                            if not "!_error!" == "true" (
                                echo.
                                echo Directory of "!CMD_LIBRARY!":
                            )

                            echo.
                            echo ERROR: element "!_import_list_%%i!" does not exist or is not accessible as a standalone file/dir or as a file/dir in the directory contained by "CMD_LIBRARY" variable^^^!>>&2
                            set _error=true
                        )
                    )
                )
            popd
            if "!_error!" == "true" (
                endlocal

                rem Clean up
                call :CleanUp

                if not "%_not_started_from_command_line%" == "0" (
                    call :PressAnyKey Press any key to exit...
                    echo.
                )
                exit /b 1
            ) else (
                endlocal
            )
        echo OK
        echo.

    )

    set "_error=false"
    if /i "%~1" == "end" (

        echo Output file is: "%_output_dir%\%_output_filename%"
        echo.
        echo Importing...
        echo.
        (
            type nul>"%_output_dir%\%_output_filename%"
        ) 2>nul||(
            echo ERROR: Could not write to file: "%_output_dir%\%_output_filename%"^!>>&2

            rem Clean up
            call :CleanUp

            if not "%_not_started_from_command_line%" == "0" (
                call :PressAnyKey Press any key to exit...
                echo.
            )
            exit /b 1
        )

        echo Importing main script "%_main_batch_script%"
        (
            echo @set _import=defined
            echo @REM Timestamp %date% %time%

            echo.
        )>>"%_output_dir%\%_output_filename%"
        (
            (
                type "%_main_batch_script%"
            )>>"%_output_dir%\%_output_filename%"
        ) 2>nul||(echo  ERROR: Could not read file^!&set "_error=true">>&2)
        (
            echo.
            echo.
        )>>"%_output_dir%\%_output_filename%"
        echo.

        echo Directory of "%CMD_LIBRARY%":
        if not "%CMD_LIBRARY_CASE%" == "MAIN.CMD" (
            pushd "%BASE%"
        )
        if not defined mask (
            rem If mask is not defined, import all file types:
            set "mask=*"
        )
        for /l %%i in (1,1,%count%) do (
            call set "_import_list_i=%%_import_list_%%i%%"
            call :ProcedureImportCurrentFile
        )
        if not "%CMD_LIBRARY_CASE%" == "MAIN.CMD" (
            popd
        )
    )

    if "%~1" == "end" (
        if "%_error%" == "true" (
            echo.
            echo Errors were ecountered^!

            rem Clean up
            call :CleanUp

            if not "%_not_started_from_command_line%" == "0" (
                call :PressAnyKey Press any key to exit...
                echo.
            )
            exit /b 1
        ) else (
            echo Done^!
        )

        call popd
        popd

        rem Clean up
        call :CleanUp

        rem Detect if script was started from command line:
        call :DetectCommandLine _not_started_from_command_line
    )
    if "%~1" == "end" (
        if "%_not_started_from_command_line%" == "0" (
            set "_import="
        ) else (
            echo.
            echo Starting program...
            echo.
            rem Start "resulting" program:
            "%_output_dir%\%_output_filename%"
        )
    )

goto :eof

REM \\\/// Next subroutines use jeb's syntax for working with delayed expansion: \\\///

:CleanUp
(   
    setlocal EnableDelayedExpansion
)
(
    endlocal

    if "%_CMD_LIBRARY_error%" == "true" (
        set "CMD_LIBRARY="
        set "_DISPLAY_WARNING=true"
    ) else (
        set "_DISPLAY_WARNING=false"
    )
    set "_first_time="
    for /l %%i in (1,1,%count%) do (
        set "_import_list_%%i="
    )
    rem optional:
    set "count="
    set "import_path="
    rem set "_output_dir="
    set "_error="
    set "_main_batch_script="
    rem set "_output_filename="
    rem set "_import="
    set "mask="

    exit /b
)

:GetStrLen - by jeb - adaptation
(   
    setlocal EnableDelayedExpansion
        set "s=!%~1!#"
        set "len=0"
        for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
            if "!s:~%%P,1!" NEQ "" ( 
                set /a "len+=%%P"
                set "s=!s:~%%P!"
            )
        )
)
( 
    endlocal
    set "%~2=%len%"
    exit /b
)

:EscapePathString

(   
    setlocal EnableDelayedExpansion
        set "string=!%~1!"
        call :GetStrLen string string_len
        set /a string_len-=1

        for /l %%i in (0,1,!string_len!) do (
            rem escape "^", "(", ")", "!", "&"
            if "!string:~%%i,1!" == "^" (
                set "result=!result!^^^^"
            )  else (
                if "!string:~%%i,1!" == "(" (
                    set "result=!result!^^^("
                ) else (
                    if "!string:~%%i,1!" == ")" (
                        set "result=!result!^^^)"
                    ) else (
                        if "!string:~%%i,1!" == "^!" (
                            set "result=!result!^^^!"
                        ) else (
                            if "!string:~%%i,1!" == "&" (
                                set "result=!result!^^^&"
                            ) else (
                                if "!string:~%%i,1!" == "%%" (
                                    set "result=!result!%%"
                                ) else (
                                    set "result=!result!!string:~%%i,1!"
                                )
                            )
                        )
                    )
                )
            )
        )
)
(
    endlocal
    set "%~2=%result%"
    exit /b
)

:PressAnyKey
    set /p=%*<nul
    pause>nul
goto :eof

:DeQuoteOnce
(
    setlocal EnableDelayedExpansion
        set "string=!%~1!"
        if "!string!" == """" (
            endlocal
            set "%~2=%string%"
            exit /b
        )
        rem In order to work with " we replace it with a special character like < > | that is not allowed in file paths:
        set "string=!string:"=^<!"

        if "!string:~0,1!" == "<" (
            if "!string:~-1,1!" == "<" (
                set "string=!string:~1,-1!"
            )
        )
        rem restore " in string (replace < with "):
        set "string=!string:<="!"
)
(
    endlocal
    set "%~2=%string%"
    exit /b
)

:TestIfPathIsUNC

(
    setlocal EnableDelayedExpansion
        set "_current_path=!%~1!"
        set "_is_unc_path=true"
        if defined _current_path (
            if "!_current_path:\\=!" == "!_current_path!" (
                set "_is_unc_path=false"
            )
        ) else (
            set "_is_unc_path=false"
        )
)
(
    endlocal
    set "%~2=%_is_unc_path%"
    exit /b
)

:TestIfStringContains

(
    setlocal EnableDelayedExpansion
        echo "!%~1!"|find "!%~2!">nul 2>nul
        set "_error_code=!ERRORLEVEL!"
)
(
    endlocal
    if "%_error_code%" == "0" (
        set "%~3=true"
    ) else (
        set "%~3=false"
    )
    exit /b
)

REM ///\\\ The subroutines above use jeb's syntax for working with delayed expansion: ///\\\

:DetectCommandLine

setlocal
    rem Windows: XP, 7
    for /f "tokens=*" %%c in ('echo "%CMDCMDLINE%"^|find "cmd /c """ /c') do (
        set "_not_started_from_command_line=%%~c"
    )
    if "%_not_started_from_command_line%" == "0" (
        rem Windows: 10
        for /f "tokens=*" %%c in ('echo "%CMDCMDLINE%"^|find "cmd.exe /c """ /c') do (
            set "_not_started_from_command_line=%%~c"
        )
    )
endlocal & (
    set "%~1=%_not_started_from_command_line%"
)
goto :eof

:ProcedureImportCurrentFile

setlocal
    set "cc="

    if not exist "%_import_list_i%" (
        set "_not_a_dir=false"
        pushd "%CMD_LIBRARY%\%_import_list_i%\" 1>nul 2>&1||set "_not_a_dir=true"
        call :GetStrLen CD _CD_len
    )
    if "%_not_a_dir%" == "false" (
        setlocal EnableDelayedExpansion
            if not "!CD:~-1,1!" == "\" (
                endlocal
                set /a _CD_len+=1
            ) else (
                endlocal
            )
        popd
    )

    if not exist "%_import_list_i%" (
        if "%_not_a_dir%" == "true" (
            echo Importing file "%CMD_LIBRARY%\%_import_list_i%"
            (
                type "%CMD_LIBRARY%\%_import_list_i%">>"%_output_dir%\%_output_filename%"
            ) 2>nul||(
                echo  ERROR:   Could not read file^!>>&2
                set "_error=true"
            )
            (
                if not "%%i" == "%count%" (
                    echo.
                    echo.
                ) else (
                    echo.
                )
            )>>"%_output_dir%\%_output_filename%"
        ) else (
            echo Importing dir "%_import_list_i%"
            rem
            pushd "%CMD_LIBRARY%\%_import_list_i%\"

                set /a cc=0
                for /r %%f in (%mask%); do (
                    set "_current_file=%%~dpnxf"
                    call set "r=%%_current_file:~%_CD_len%%%"
                    call echo   Importing subfile "%%_import_list_i%%\%%r%%"
                    (
                        (
                            call type "%%_current_file%%"
                        )>>"%_output_dir%\%_output_filename%"
                    ) 2>nul||(
                        echo     ERROR: Could not read file^!>>&2
                        set "_error=true"
                    )
                    (
                        echo. 
                        echo. 
                    )>>"%_output_dir%\%_output_filename%"
                    set /a cc+=1
                )
                popd
        )
    ) else (
        set "_not_a_dir=false"
        pushd "%_import_list_i%\" 1>nul 2>&1||set "_not_a_dir=true"
        call :GetStrLen CD _CD_len
    )
    if "%_not_a_dir%" == "false" (
        setlocal EnableDelayedExpansion
            if not "!CD:~-1,1!" == "\" (
                endlocal
                set /a _CD_len+=1
            ) else (
                endlocal
            )
        popd
    )

    if exist "%_import_list_i%" (
        if "%_not_a_dir%" == "true" (
            echo Importing file "%_import_list_i%"
            (
                type "%_import_list_i%">>"%_output_dir%\%_output_filename%"
            ) 2>nul||(
                echo    ERROR: Could not read file^!>>&2
                set "_error=true"
            )
            (
                if not "%%i" == "%count%" (
                    echo.
                    echo.
                ) else (
                    echo.
                )
            )>>"%_output_dir%\%_output_filename%"
        ) else (
            rem
            echo Importing dir "%_import_list_i%"
            pushd "%_import_list_i%\"

            set /a cc=0
            for /r %%f in (%mask%); do (
                set "_current_file=%%~dpnxf"
                call set "r=%%_current_file:~%_CD_len%%%"
                call echo   Importing subfile "%%_import_list_i%%\%%r%%"
                (
                    (
                        call type "%%_current_file%%"
                    )>>"%_output_dir%\%_output_filename%"
                ) 2>nul||(
                    echo     ERROR: Could not read file^!>>&2
                    set "_error=true"
                )
                (
                    echo. 
                    echo. 
                )>>"%_output_dir%\%_output_filename%"
                set /a cc+=1
            )
            popd
        )
    )
    if "%cc%" == "0" (
        echo   No match^!
    )
endlocal & (
    set "_error=%_error%"
)
goto :eof

:DisplayHelp
    echo IMPORT - a .cmd utility for importing subroutines into the main script
    echo.
    echo NOTES: 1. This utility assumes that command extensions are enabled (default) and that delayed expansion can be enabled;
    echo           ALSO IMPORT MUST BE CALLED INSIDE A DISABLED DELAYED EXPANSION BLOCK/ENVIRONMENT (DEFAULT);
    echo           These are necessary in order for it to function correctly.
    echo        2. The use of UNC paths is not supported by import. As a workarround, you can mount a UNC path to a temporary drive using "pushd".
    echo           The use of "*" or "?" wildcards is not supported by import. Instead, you can set the mask with a set of name and extension masks separated by semicolon, like: set mask="*.cmd; *.bat"
    echo           When the "mask" variable is set, only the filenames having the extensions contained by it are matched at import.
    echo.
    echo Description:
    echo    import organizes your batch programs on common libraries of subroutines, that you can use in the future for other programs that you build; it also makes code editing and debugging easier. 
    echo.
    echo Usage [1]:
    echo    import [flags]
    echo.
    echo    [flags] can be:
    echo            /install - installs import into the registry, in the Command Processor AutoRun registry key ^(adds the current location of import into the PATH variable^).
    echo            /? - displays help ^(how to use import^)
    echo.
    echo Usage [2]:
    echo    What it does:
    echo            Con