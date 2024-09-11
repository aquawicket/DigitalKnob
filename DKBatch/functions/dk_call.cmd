@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0


::####################################################################
::# dk_call(command args)
::#
::#
:dk_call
    ::if exist "%DKBATCH_FUNCTIONS_DIR%\dk_debugFunc.cmd" call dk_debugFunc 1 99
 ::setlocal
    
    if "%~1"=="dk_debugFunc" echo [31m ERROR: dk_call cannot be used with dk_debugFunc [0m & goto:eof

    set "arg=%1"
    if "%arg:dk_=%"=="%arg%"  echo [31m ERROR: dk_call[%arg%]: dk_call can only be used with dk_ functions [0m & goto:eof

    if not exist "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd" (
        call dk_source "%~1"
        if not exist "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd" echo [31m ERROR: failed to dowload %~1.cmd [0m & goto:eof
        if not exist "%DKBATCH_FUNCTIONS_DIR%\dk_isCRLF.cmd" call dk_source dk_isCRLF
        if not exist "%DKBATCH_FUNCTIONS_DIR%\dk_fileToCRLF.cmd" call dk_source dk_fileToCRLF
        rem if exist "%DKBATCH_FUNCTIONS_DIR%\dk_isCRLF.cmd" call dk_isCRLF "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd" || if exist "%DKBATCH_FUNCTIONS_DIR%\dk_fileToCRLF.cmd" call dk_fileToCRLF "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd"
    )
	
	set /a "frame=%DKSTACK_length%-1"
	call set "THIS=%%DKSTACK[%frame%].__FILE__%% %*"
	::echo %THIS%
	if ERRORLEVEL 1 %dk_call% set "EXIT_CODE=%ERRORLEVEL%"
    if not defined EXIT_CODE (
		set "buffer9=%buffer8%"
		set "buffer8=%buffer7%"
		set "buffer7=%buffer6%"
		set "buffer6=%buffer5%"
		set "buffer5=%buffer4%"
		set "buffer4=%buffer3%"
		set "buffer3=%buffer2%"
		set "buffer2=%buffer1%"
		set "buffer1=%buffer0%"
		set "buffer0=%THIS%"
		title %buffer%
	)
	if defined EXIT_CODE (
		title %buffer0%
		
		echo:
		echo ### LAST 10 CALLS - oldest first ###
		echo %buffer9%
		echo %buffer8%
		echo %buffer7%
		echo %buffer6%
		echo %buffer5%
		echo %buffer4%
		echo %buffer3%
		echo %buffer2%
		echo %buffer1%
		echo %buffer0%
		exit %EXIT_CODE%
	)
	::if defined EXIT_CODE (echo ERROR ERROR ERROR ERROR ERROR)
	::if not defined EXIT_CODE (title "%DKSTACK[0].__FILE__%")
    call %*
    exit /b %errorlevel%

%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    ::if exist "%DKBATCH_FUNCTIONS_DIR%\dk_debugFunc.cmd" call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_color
    call dk_call dk_color
    %dk_call% dk_color
    call dk_call dk_color
    %dk_call% dk_color
%endfunction%
