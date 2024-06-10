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
	
    rem setlocal DisableDelayedExpansion
	call set "FUNCNAME_A=%%~n0"
	rem call echo FUNCNAME_A = %%FUNCNAME_A%%
	call set "BATCH_SOURCE_A=%%~f0"
	call set "BATCH_ARGV_A=%%*"
		
	call set "is_batch=%%BATCH_SOURCE_A:*%%~f0=%%"
	if defined is_batch (
		set "SOURCE_TYPE_A=batch"
		call "%~d0\:Step2\..%~pnx0" %*
	) else (
		set "SOURCE_TYPE_A=cmd-line"
		pause
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
	
	rem setlocal DisableDelayedExpansion
	set "FUNCNAME_A=%FUNCNAME_A%"
	set "BATCH_SOURCE_A=%BATCH_SOURCE_A%"
	set "BATCH_ARGV_A=%BATCH_ARGV_A%"
		
	call set "FUNCNAME_B=%%~n0"
	rem call echo FUNCNAME_B = %%FUNCNAME_B%%
	call set "BATCH_SOURCE_B=%%~f0"
	call set "BATCH_ARGV_B=%%*"
		
	call set "__FILE__=%%~f0"
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

	call set "is_batch=%%BATCH_SOURCE_B:*%%~f0=%%"
	if defined is_batch (
		set "SOURCE_TYPE_B=batch"
		call "%~d0\:Step4\..%~pnx0" %*
	) else (
		set "SOURCE_TYPE_B=cmd-line"
		cmd /c "call "%~d0\:Step4\..%~pnx0" %*"
	)
    endlocal
)
goto:eof


:: *** Get the caller of the caller of the caller
:Step3
(
   rem (goto) 2>nul
    (goto) 2>nul
    (goto) 2>nul
	
	rem setlocal DisableDelayedExpansion
	set "FUNCNAME_A=%FUNCNAME_A%"
	set "BATCH_SOURCE_A=%BATCH_SOURCE_A%"
	set "BATCH_ARGV_A=%BATCH_ARGV_A%"
	
	set "FUNCNAME_B=%FUNCNAME_B%"
	set "BATCH_SOURCE_B=%BATCH_SOURCE_B%"
	set "BATCH_ARGV_B=%BATCH_ARGV_B%"
		
	call set "FUNCNAME_C=%%~n0"
	call echo FUNCNAME_C = %%FUNCNAME_C%%
	call set "BATCH_SOURCE_C=%%~f0"
	call set "BATCH_ARGV_C=%%*"
		
rem	call set "__FILE__=%%~nx0"
rem	rem call set "__LINE__=???"
rem	call set "__FUNCTION__=%%~n0"
rem	call set "__ARGS__=%%*"
rem	call set "ARGV[1]=%%~1"
rem	call set "ARGV[2]=%%~2"
rem	call set "ARGV[3]=%%~3"
rem	call set "ARGV[4]=%%~4"
rem	call set "ARGV[5]=%%~5"
rem	call set "ARGV[6]=%%~6"
rem	call set "ARGV[7]=%%~7"
rem	call set "ARGV[8]=%%~8"
rem	call set "ARGV[9]=%%~9"

	call set "is_batch=%%BATCH_SOURCE_C:*%%~f0=%%"
	if defined is_batch (
		set "SOURCE_TYPE_C=batch"
		call "%~d0\:Step4\..%~pnx0" %*
	) else (
		set "SOURCE_TYPE_C=cmd-line"
		pause
		cmd /c "call "%~d0\:Step4\..%~pnx0" %*"
	)
    endlocal
)
goto:eof


:::dkshiftArray
::	set FUNCNAME_size=0
::	:arrayCountLoop
::	if defined FUNCNAME[%FUNCNAME_size%] ( 
::	   set /a FUNCNAME_size+=1
::	   goto :arrayCountLoop 
::	)
::	echo FUNCNAME_size = %FUNCNAME_size%
::	
::	set /a count_down=FUNCNAME_size
::	:arrayShiftLoop
::	if %count_down% gtr 0 (
::		set /a previous=count_down-1
::		setlocal enableDelayedExpansion
::			set "FUNCNAME[%count_down%]=!FUNCNAME[%previous%]!"
::		    echo FUNCNAME[%count_down%] = !FUNCNAME[%count_down%]!
::		endlocal
::		set /a count_down-=1
::	)
::	
::	set count=0
::	:print_array
::	if defined FUNCNAME[%count%] (
::		setlocal enableDelayedExpansion
::		    echo FUNCNAME[%count%] = !FUNCNAME[%count%]!
::		endlocal
::	    set /a count+=1
::	    goto :print_array 
::	)
::goto:eof



:: *** STEP3 Restart the requester batch, but jump to the label :dk_callStackReturn
:Step4
	endlocal
	
	::call:dkshiftArray
	if not defined FUNCNAME[0]     call set "FUNCNAME[0]=%%FUNCNAME_B%%"
	if not defined BATCH_SOURCE[0] set "BATCH_SOURCE[0]=%BATCH_SOURCE_B%"
	if not defined BATCH_ARGV[0]   set "BATCH_ARGV[0]=%BATCH_ARGV_B%"
	if not defined BATCH_ARGC[0] (
		set "BATCH_ARGC[0]=0"
		for %%x in (%BATCH_ARGV[0]%) do set /A BATCH_ARGC[0]+=1
	)
	
	if not defined FUNCNAME[1]     call set "FUNCNAME[1]=%%FUNCNAME_A%%"
	if not defined BATCH_SOURCE[1] set "BATCH_SOURCE[1]=%BATCH_SOURCE_A%"
	if not defined BATCH_ARGV[1]   set "BATCH_ARGV[1]=%BATCH_ARGV_A%"
	if not defined BATCH_ARGC[1] (
		set "BATCH_ARGC[1]=0"
		for %%x in (%BATCH_ARGV[1]%) do set /A BATCH_ARGC[1]+=1
	)
	
	rem ### Return to :dk_caller_return lable in calling function
	call :dk_callStackReturn
goto:eof

:: *** This uses the trick, that starting a batch without CALL will jump to the last used label
:dk_callStackReturn
	endlocal
	%BATCH_SOURCE_A% %BATCH_ARGV_A%
goto:eof




