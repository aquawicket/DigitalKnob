@echo off
::https://stackoverflow.com/a/43123617/688352

::setlocal DisableDelayedExpansion
set "func=%~0"
for /F "delims=\" %%X in ("%func:*\=%") do set "func=%%X"
if ":" == "%func:~0,1%" ( goto %func% )

:: *** Get the caller of this script, needed for later restart
:Step1
(
    (goto) 2>nul
	
    rem setlocal DisableDelayedExpansion %= it could be reenabled by the GOTO =%
		call set "BATCH_SOURCE[0]=%%~f0"
		call set "FUNCNAME[0]=%%~n0"
		call set "BATCH_ARGV[0]=%%*"
		
		call set "is_batch=%%BATCH_SOURCE[0]:*%%~f0=%%"
		if defined is_batch (
			set "SOURCE_TYPE[0]=batch"
			call "%~d0\:Step2\..%~pnx0" %*
		) else (
			set "SOURCE_TYPE[0]=cmd-line"
			cmd /c "call "%~d0\:Step2\..%~pnx0" %*"
		)
	endlocal
)
goto:eof


:: *** Get the caller of the caller
:Step2
(
    (goto) 2>nul
    (goto) 2>nul
	
	rem setlocal DisableDelayedExpansion %= it could be reenabled by the GOTO =% 
		set "BATCH_SOURCE[0]=%BATCH_SOURCE[0]%"
		set "FUNCNAME[0]=%FUNCNAME[0]%"
		set "BATCH_ARGV[0]=%BATCH_ARGV[0]%"
		
		call set "BATCH_SOURCE[1]=%%~f0"
		call set "FUNCNAME[1]=%%~n0"
		call set "BATCH_ARGV[1]=%%*"
		
		call set "__FILE__=%%~nx0"
		rem call set "__LINE__=???"
		call set "__FUNCTION__=%%~n0"
		call set "__ARGS__=%%*"
		call set "ARGV[1]=%%~1"
		call set "ARGV[2]=%%~2"
		call set "ARGV[3]=%%~3"
		call set "ARGV[4]=%%~4"
		call set "ARGV[5]=%%~5"
		call set "ARGV[6]=%%~6"
		call set "ARGV[7]=%%~7"
		call set "ARGV[8]=%%~8"
		call set "ARGV[9]=%%~9"

		call set "is_batch=%%BATCH_SOURCE[1]:*%%~f0=%%"
		if defined is_batch (
			set "SOURCE_TYPE[1]=batch"
			call "%~d0\:Step3\..%~pnx0" %*
		) else (
			set "SOURCE_TYPE[1]=cmd-line"
			cmd /c "call "%~d0\:Step3\..%~pnx0" %*"
		)
    endlocal
)
goto:eof


:: *** STEP3 Restart the requester batch, but jump to the label :dk_caller
:Step3
	endlocal
	
	rem ##### Set BATCH_ARGC's ######
	set BATCH_ARGC[0]=0
	for %%x in (%BATCH_ARGV[0]%) do set /A BATCH_ARGC[0]+=1
	set BATCH_ARGC[1]=0
	for %%x in (%BATCH_ARGV[1]%) do set /A BATCH_ARGC[1]+=1
	
	rem ### Return to :dk_getCaller_return lable in calling function
	call :dk_caller_return
	:::dk_caller_return
	::%BATCH_SOURCE[0]% %BATCH_ARGV[0]%
goto:eof

:: *** This uses the trick, that starting a batch without CALL will jump to the last used label
:dk_caller_return
	endlocal
	%BATCH_SOURCE[0]% %BATCH_ARGV[0]%
goto:eof	
