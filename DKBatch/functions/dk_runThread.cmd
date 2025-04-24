@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

if "%~1" equ "dk_runThread.LoopFunc" goto %1


::################################################################################
::# dk_runThread()
::#
::#
:dk_runThread
setlocal
	%dk_call% dk_debugFunc 0 99
 
	echo dk_runThread
 
    :: Start dk_timeLoop in a parallel process
    start "" /B %ComSpec% /C call dk_timeLoop
	echo Time is displayed in the titlebar in a seperate process
%endfunction%


	



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_runThread
%endfunction%
