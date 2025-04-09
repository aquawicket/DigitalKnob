@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_getDate(day month year)
::#
::#	REFERENCE: https://ss64.com/nt/syntax-gettime.html
::#
:dk_getDate
setlocal
	%dk_call% dk_debugFunc 3
	set t=2&if "%date%z" LSS "A" set t=1
	for /f "skip=1 tokens=2-4 delims=(-)" %%a in ('echo/^|date') do (
		for /f "tokens=%t%-4 delims=.-/ " %%d in ('date/t') do (
			set %%a=%%d
			set %%b=%%e
			set %%c=%%f
		)
	)
	endlocal & set "%1=%dd%" & set "%2=%mm%" & set "%3=%yy%"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_echo "date = %date%"
	%dk_call% dk_getDate day month year
	%dk_call% dk_echo "date = %month%/%day%/%year%"
%endfunction%   