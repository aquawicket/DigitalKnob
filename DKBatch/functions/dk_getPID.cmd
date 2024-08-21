@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_getPID(rtn_var)
::#
::#    https://stackoverflow.com/questions/28861972/getting-pid-of-cmd-while-running-batch-script
::#
::#   Store the Process ID (PID) of the currently running script in environment variable
::#   RtnVar. If called without any argument, then simply write the PID to stdout.
::#
:dk_getPID  [RtnVar]

	
::	title mycmd
::	tasklist /fo csv | findstr /i "mycmd"
	
	::for /F "tokens=* USEBACKQ" %%F IN (`tasklist /fo csv | findstr /i "mycmd"`) do set "LINE=%%F"
	::echo LINE = %LINE%
	
	for /f "tokens=1* delims=	: " %%a in ('powershell.exe -c "Get-WmiObject Win32_Process | Where-Object ProcessId -EQ "$PID""') do (
			echo %%a, %%b
			if /I "%%a"=="ProcessId"       set "%%a=%%b"
			if /I "%%a"=="ParentProcessId" set "%%a=%%b"
			if /I "%%a"=="ExecutablePath"  set "%%a=%%b"
	)
	echo ProcessId = %ProcessId%
	echo ParentProcessId = %ParentProcessId%
	echo ExecutablePath = %ExecutablePath%
	pause

	for /f "tokens=1* delims=	: " %%a in ('powershell.exe -c "Get-WmiObject Win32_Process | Where-Object ParentProcessId -EQ "%ParentProcessId%""') do (
			echo %%a, %%b
			if /I "%%a"=="ProcessId"       set "%%a=%%b"
			if /I "%%a"=="ParentProcessId" set "%%a=%%b"
			if /I "%%a"=="ExecutablePath"  set "%%a=%%b"
	)
	echo ProcessId = %ProcessId%
	echo ParentProcessId = %ParentProcessId%
	echo ExecutablePath = %ExecutablePath%
	pause
	
	
	FOR /F "tokens=* USEBACKQ" %%F IN (`powershell -c "Get-WmiObject Win32_Process -Filter ProcessId=$PID | Select-Object -Property ProcessId, ParentProcessId"`) DO (
		set "PID=%%F"
	) 
	echo PID = %PID%

::	FOR /F "tokens=* USEBACKQ" %%F IN (`powershell -c "(Get-WmiObject Win32_Process -Filter ProcessId=$PID | Select-Object -Property ProcessId, ParentProcessId"`) DO (
::		set "PPID=%%F"
::	) 
::	echo PPID = %PPID%
	
	FOR /F "tokens=* USEBACKQ" %%F IN (`powershell  -c "(gwmi win32_process | ? processid -eq ((gwmi win32_process | ? processid -eq  $PID).parentprocessid)).parentprocessid"`) DO (
		echo %%a, %%b
		SET PPPID=%%F
	)
	ECHO PS sent %PPPID%
	tasklist /fi "pid eq %PPPID%" 

	setlocal disableDelayedExpansion
	:getLock
	set "lock=%temp%\%~nx0.%time::=.%.lock"
	set "uid=%lock:\=:b%"
	set "uid=%uid:,=:c%"
	set "uid=%uid:'=:q%"
	set "uid=%uid:_=:u%"
	setlocal enableDelayedExpansion
	set "uid=!uid:%%=:p!"
	endlocal & set "uid=%uid%"
	2>nul ( 9>"%lock%" (
	  for /f "skip=1" %%A in (
		'wmic process where "name='cmd.exe' and CommandLine like '%%<%uid%>%%'" get ParentProcessID'
	  ) do for %%B in (%%A) do set "PID=%%B"
	  (call )
	))||goto :getLock
	del "%lock%" 2>nul
	endlocal & if "%~1" equ "" (echo(%PID%) else set "%~1=%PID%"
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_getPID PID
	%dk_call% dk_printVar PID
	
	tasklist /fi "pid eq %PID%" 
goto:eof

