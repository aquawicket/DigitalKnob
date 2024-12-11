@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

if "%~1" equ ":dk_runThread.Loop" goto %1


::################################################################################
::# dk_runThread()
::#
::#
:dk_runThread
    call dk_debugFunc 0 99
 setlocal
 
	echo dk_runThread
 
    :: Start dk_runThread.Loop in a parallel process
    ::start "" /B %ComSpec% /C "call :dk_runThread.LoopFunc" || echo dk_runThread.Loop returned error

    ::call :dk_runThread.LoopFunc
%endfunction%

:dk_runThread.LoopFunc
	:loop
		call :echoInPlace %TIME%
	goto :loop
%endfunction%	
	

:echoInPlace
	if not defined CR  for /f %%a in ('copy /Z "%~dpf0" nul') do set "CR=%%a"
	set /P "=%~1                                                                        " <nul
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
	echo DKTEST
 
	%dk_call% dk_runThread
	
%endfunction%