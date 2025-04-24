<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::################################################################################
::# dk_killProcess(process)
::#     Kill a process by process name
::#
::#     process:  the name of the task to kill.  I.E. cale.exe
::#
<<<<<<< HEAD
::#     Example:  call dk_endProcess iexplore.exe
::#    
:dk_killProcess
    call dk_debugFunc 1
 setlocal
 
    set "process=%~1"

=======
::#     Example:  %dk_call% dk_killProcess iexplore.exe
::#    
:dk_killProcess
setlocal
	%dk_call% dk_debugFunc 1
    set "process=%~1"

    %dk_call% dk_processIsRunning %process% || %return%

>>>>>>> Development
    tasklist /fi "imagename eq %process%" |find ":" >nul
    if errorlevel 1 taskkill /f /im "%process%
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
    
=======
setlocal
	%dk_call% dk_debugFunc 0
   
>>>>>>> Development
    start mspaint.exe
    %dk_call% dk_sleep 3
    %dk_call% dk_killProcess mspaint.exe
%endfunction%
