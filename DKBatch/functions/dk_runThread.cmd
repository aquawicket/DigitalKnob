@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

if "%~1" equ "dk_runThread.LoopFunc" goto %1


::################################################################################
::# dk_runThread()
::#
::#
:dk_runThread
    call dk_debugFunc 0 99
 setlocal
 
	echo dk_runThread
 
    :: Start dk_runThread.Loop in a parallel process
    start "" /B %ComSpec% /C call :dk_runThread.LoopFunc
    ::call :dk_runThread.LoopFunc
	pause
%endfunction%

:dk_runThread.LoopFunc
	:loop
		::%dk_call% dk_echoReplace %TIME%
		title %TIME%
	goto :loop
%endfunction%	
	



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
	echo DKTEST
 
	%dk_call% dk_runThread
	
%endfunction%