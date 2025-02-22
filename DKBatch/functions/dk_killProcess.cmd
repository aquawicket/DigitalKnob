@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_killProcess(process)
::#     Kill a process by process name
::#
::#     process:  the name of the task to kill.  I.E. cale.exe
::#
::#     Example:  %dk_call% dk_killProcess iexplore.exe
::#    
:dk_killProcess
setlocal
	%dk_call% dk_debugFunc 1
    set "process=%~1"

    tasklist /fi "imagename eq %process%" |find ":" >nul
    if errorlevel 1 taskkill /f /im "%process%
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    start mspaint.exe
    %dk_call% dk_sleep 3
    %dk_call% dk_killProcess mspaint.exe
%endfunction%
