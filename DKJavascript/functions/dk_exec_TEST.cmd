@echo off
::if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../../../DKBatch/functions/")
::if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
::if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

set /a "printErr = 0"
set /a "count=0"
:loop
	ping.exe 127.0.0.1 -n 2 -w 500 >nul

	set /a "count+=1"
	if %printErr% equ 1 (
		echo: stdout %count% %time%
		echo:     stderr %count% %time% 1>&2
		set /a "printErr = 0"
	) else (
		echo: stdout %count% %time%
		set /a "printErr = 1"
	)
	if %count% equ 10 (exit /b 0)
goto :loop
