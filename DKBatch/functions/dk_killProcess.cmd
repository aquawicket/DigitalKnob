@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd


::################################################################################
::# dk_killProcess(process)
::#     Kill a process by process name
::#
::#     process:  the name of the task to kill.  I.E. cale.exe
::#
::#     Example:  call dk_endProcess iexplore.exe
::#    
:dk_killProcess
	call dk_debugFunc
	if %__ARGC__% neq 1 call dk_error "%__FUNCTION__%:%__ARGV__%: too many arguments")
		
		
	set "process=%~1"

	tasklist /fi "imagename eq %process%" |find ":" >nul
	if errorlevel 1 taskkill /f /im "%process%
goto:eof





::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	start mspaint.exe
	call dk_sleep 3
	call dk_killProcess mspaint.exe
goto:eof
