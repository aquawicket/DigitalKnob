@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"


::################################################################################
::# dk_killProcess(process)
::#     Kill a process by process name
::#
::#     process:  the name of the task to kill.  I.E. cale.exe
::#
::#     Example:  call dk_endProcess iexplore.exe
::#    
:dk_killProcess
	call dk_debugFunc 1
		
		
	set "process=%~1"

	tasklist /fi "imagename eq %process%" |find ":" >nul
	if errorlevel 1 taskkill /f /im "%process%
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	start mspaint.exe
	call dk_sleep 3
	call dk_killProcess mspaint.exe
goto:eof
