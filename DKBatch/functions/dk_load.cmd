@echo off
if exist "%DKBATCH_FUNCTIONS_DIR%\%~n1.cmd" (goto:eof)
if exist "%~1" (goto:eof)
::if defined include_guard_dk_load ( goto:eof ) else set include_guard_dk_load=1
call DK


::####################################################################
::# dk_load()
::#
::#
:dk_load() {
	if not exist "%DKBATCH_FUNCTIONS_DIR%\dk_echo.cmd"      powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_echo.cmd', '%DKBATCH_FUNCTIONS_DIR%\dk_echo.cmd')"
	if not exist "%DKBATCH_FUNCTIONS_DIR%\dk_info.cmd"      powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_info.cmd', '%DKBATCH_FUNCTIONS_DIR%\dk_info.cmd')"
	if not exist "%DKBATCH_FUNCTIONS_DIR%\dk_error.cmd"     powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_error.cmd', '%DKBATCH_FUNCTIONS_DIR%\dk_error.cmd')"
	if not exist "%DKBATCH_FUNCTIONS_DIR%\dk_debugFunc.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_debugFunc.cmd', '%DKBATCH_FUNCTIONS_DIR%\dk_debugFunc.cmd')"
	if "%~1" equ "" call dk_error "%__FUNCTION__%(): invalid arguments"
	if "%~2" neq "" call dk_error "%__FUNCTION__%(): too many arguments"
	call dk_debugFunc
	
	if exist "%~1" (
		set "fpath=%~1"
		for %%Z in ("%fpath%") do set "fn=%%~nZ"
	) else (
		set "fn=%~n1"
		set "fpath=%DKBATCH_FUNCTIONS_DIR%\%~n1.cmd"
	)

	if not exist "%fpath%" echo Downloading %fn%
	if not exist "%DKBATCH_FUNCTIONS_DIR%\dk_download.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_download.cmd', '%DKBATCH_FUNCTIONS_DIR%\dk_download.cmd')"
	if not exist "%fpath%" call dk_download "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%fn%.cmd" "%fpath%"
	if not exist "%fpath%" call dk_error "ERROR: %fpath%: file not found"
	
	:: Convert to windows line endings if only CR found
	
	:: TODO
	if exist "%fpath%" (set "%fn%=%fpath%") else (call dk_error "%fpath%: file not found")
	
	echo %dkload_list% | findstr ";%fn%;" && goto:eof
	set "dkload_list=%dkload_list%;%fn%;" 			&:: Add to list
	echo added %fn% to dkload_list
	
	:: read file line by line and store matching lines in array
	for /F "usebackq delims=" %%a in ("%fpath%") do (
	    echo %%a | findstr "\<dk_*" >nul && (
			set "temp=%%a"
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
				goto:done
			)
			:done
			set "dkload_list=%dkload_list%;%temp%;" 			&:: Add to list

			echo %temp% | findstr "\<dk_" >nul && (
				call echo [32m temp = %temp% [0m
				call dk_load %temp%
			)
			endlocal
		) || echo.
	)
goto:eof

