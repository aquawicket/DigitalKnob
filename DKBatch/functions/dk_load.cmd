@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


if EXIST "%DKBATCH_FUNCTIONS_DIR_%%~n1.cmd" (goto:eof)
if EXIST "%~1" (goto:eof)
rem if defined include_guard_dk_load ( goto:eof ) else set include_guard_dk_load=1

rem ####################################################################
rem # dk_load(funcName OR funcPath)
rem #
rem # Source a DKBatch function. Download it if needed then parse it and source all of it's content DKBatch functions recursivley.
rem #
rem # @funcName OR funcPath  - The name of an existing "functions/funcname.cmd" file, or a full filepath to a .cmd file.
rem #
:dk_load
%setlocal%

    %dk_call% dk_notice "dk_load is temporarily disabled. Use dk_call and dk_source to download, load and run functions."
    goto:eof
   
    %dk_call% dk_source dk_echo
    %dk_call% dk_source dk_info
    %dk_call% dk_source dk_error
   
    if EXIST "%~1" (
        set "funcPath=%~1"
        for %%Z in ("%funcPath%") do set "funcName=%%~nZ"
    ) else (
        set "funcName=%~n1"
        set "funcPath=%DKBATCH_FUNCTIONS_DIR_%%~n1.cmd"
    )

    if NOT EXIST "%funcPath%" echo Downloading %funcName%
    call dk_source dk_set
    call dk_source dk_realpath
    call dk_source dk_download
    if NOT EXIST "%funcPath%" %dk_call% dk_download "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%funcName:.cmd=%.cmd" "%funcPath%"
    if NOT EXIST "%funcPath%" %dk_call% dk_error "ERROR: %funcPath%: file NOT found"
   
    goto:eof
    rem TODO
   
    rem Convert to windows line endings if only CR found
   
    rem TODO
    if EXIST "%funcPath%" (set "%funcName%=%funcPath%") else call dk_error "%funcPath%: file NOT found")
   
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
    echo %DKFUNCTIONS_LIST% | %findstr.exe% ";%funcName%;" && goto:eof
    set "DKFUNCTIONS_LIST=%DKFUNCTIONS_LIST%;%funcName%;"           &rem Add to list
    echo added %funcName% to DKFUNCTIONS_LIST
   
    rem read file line by line and store matching lines in array
    %dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	for /F "usebackq delims=" %%a in ("%funcPath%") do (
        echo %%a | %findstr.exe% "\<dk_*" >nul && (
            set "temp=%%a"
           
            &rem FIXME: remove the need for calls here
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
            %setlocal%
            for %%i in (!temp!) do (
                call set "temp=%%i"
                goto done
            )
            :done
            set "DKFUNCTIONS_LIST=%DKFUNCTIONS_LIST%;%temp%;"           &rem Add to list

			%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
            echo %temp% | !findstr.exe! "\<dk_" >nul && (
                call echo [32m temp = %temp% [0m
                call dk_load %temp%
            )
            endlocal
        ) || echo.
    )
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
    call dk_load dk_printVar

%endfunction%
