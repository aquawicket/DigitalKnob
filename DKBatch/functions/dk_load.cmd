@echo off
if exist "%DKBATCH_FUNCTIONS_DIR%\%~n1.cmd" (goto:eof)
if exist "%~1" (goto:eof)
::if defined include_guard_dk_load ( goto:eof ) else set include_guard_dk_load=1
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::####################################################################
::# dk_load(funcName OR funcPath)
::#
::# Source a DKBatch function. Download it if needed then parse it and source all of it's content DKBatch functions recursivley.
::#
::# @funcName OR funcPath  - The name of an existing "functions/funcname.cmd" file, or a full filepath to a .cmd file.
::#
:dk_load
    ::call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_notice "dk_load is temporarily disabled. Use dk_call and dk_source to download, load and run functions."
    goto:eof
    ::call dk_debugFunc
    
    call dk_source dk_echo
    call dk_source dk_info
    call dk_source dk_error
    call dk_source dk_debugFunc
    call dk_debugFunc 1
    
    if exist "%~1" (
        set "funcPath=%~1"
        for %%Z in ("%funcPath%") do set "funcName=%%~nZ"
    ) else (
        set "funcName=%~n1"
        set "funcPath=%DKBATCH_FUNCTIONS_DIR%\%~n1.cmd"
    )

    if not exist "%funcPath%" echo Downloading %funcName%
    call dk_source dk_set
    call dk_source dk_getFullPath
    call dk_source dk_download
    if not exist "%funcPath%" call dk_download "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%funcName%.cmd" "%funcPath%"
    if not exist "%funcPath%" call dk_error "ERROR: %funcPath%: file not found"
    
    goto:eof
    :: TODO
    
    :: Convert to windows line endings if only CR found
    
    :: TODO
    if exist "%funcPath%" (set "%funcName%=%funcPath%") else call dk_error "%funcPath%: file not found")
    
    echo %DKFUNCTIONS_LIST% | findstr ";%funcName%;" && goto:eof
    set "DKFUNCTIONS_LIST=%DKFUNCTIONS_LIST%;%funcName%;"           &:: Add to list
    echo added %funcName% to DKFUNCTIONS_LIST
    
    :: read file line by line and store matching lines in array
    for /F "usebackq delims=" %%a in ("%funcPath%") do (
        echo %%a | findstr "\<dk_*" >nul && (
            set "temp=%%a"
            
            &:: FIXME: remove the need for calls here
            call set "temp=%%temp:*dk_=dk_%%"
            call set "temp=%%temp:*dk_load =%%"
            call set "temp=%%temp:"= %%"
            call set "temp=%%temp:(= %%"
            call set "temp=%%temp:)= %%"
            call set "temp=%%temp:#= %%"
            call set "temp=%%temp:$= %%"
            call set "temp=%%temp:{= %%"
            call set "temp=%%temp:}= %%"
            call set "temp=%%temp:$= %%"
            call set "temp=%%temp:,= %%"
            call set "temp=%%temp: = %%"
            setlocal enableDelayedExpansion
            for %%i in (!temp!) do (
                call set "temp=%%i"
                goto done
            )
            :done
            set "DKFUNCTIONS_LIST=%DKFUNCTIONS_LIST%;%temp%;"           &:: Add to list

            echo %temp% | findstr "\<dk_" >nul && (
                call echo [32m temp = %temp% [0m
                call dk_load %temp%
            )
            endlocal
        ) || echo:
    )
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc
    
    call dk_load dk_printVar
%endfunction%
