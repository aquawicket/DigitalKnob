@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_getDate(day month year)
::#
::#    REFERENCE: https://ss64.com/nt/syntax-gettime.html
::#
:dk_getDate
	call dk_debugFunc
	call dk_minMaxArgs 3
	
	setlocal
	set t=2&if "%date%z" LSS "A" set t=1
	for /f "skip=1 tokens=2-4 delims=(-)" %%a in ('echo/^|date') do (
		for /f "tokens=%t%-4 delims=.-/ " %%d in ('date/t') do (
			set %%a=%%d
			set %%b=%%e
			set %%c=%%f
		)
	)
	endlocal & set "%1=%dd%" & set "%2=%mm%" & set "%3=%yy%"
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	call dk_minMaxArgs 0
	
	echo date = %date%
	call dk_getDate day month year
	echo date = %month%/%day%/%year%
goto:eof	