@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=../../functions/")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)



:setVariable name value
	
	echo setVariable INPUT: %*
	set args=%*
	::set args=%args:<=^<%
	::set args=%args:<=^^<%
	for %%x in (%args%) do (
		echo %~1 %%~x
		call :setargs %1 %%x
	)
	endlocal & %PRINT_DE_STATUS%
	pause
	goto :end
	:setargs
		echo %~1 %~2
		if not "%~1" equ "%~2" set args=%args% %~2
		goto:eof
	:end
	echo %args%
	
	
	
	call set args=%%args:%~1 =%%
	set args=%args:^^=^%
	
	
	::if %args:~0,1%%args:~-1%=="" (set "%~1=%args:~1,-1%")
	

	setlocal enableDelayedExpansion
	echo setVariable OUTPUT: %~1 = '!%~1!'
%endfunction%
