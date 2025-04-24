<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::############################################################################
::# __ARGC__(frame)
::#
:::__ARGC__
<<<<<<< HEAD
::	call dk_debugFunc 0 1
:: setlocal
:: 
::	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
::	::set /A _FRAME_+=2
::	::call dk_return "%BATCH_ARGC[%_FRAME_%]%"
=======
::	%dk_call% dk_debugFunc 0 1
::setlocal
:: 
::	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
::	::set /a _FRAME_+=2
::	::%dk_call% dk_return "%BATCH_ARGC[%_FRAME_%]%"
>>>>>>> Development
::%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
	call dk_debugFunc 0
 setlocal
=======
setlocal
	%dk_call% dk_debugFunc 0

>>>>>>> Development
 
	call :DKTEST_func abc 123
%endfunction%


:DKTEST_func
<<<<<<< HEAD
	call dk_debugFunc 2
 setlocal
=======
setlocal
	%dk_call% dk_debugFunc 2

>>>>>>> Development
 
	echo __ARGC__ = %__ARGC__%
%endfunction%
