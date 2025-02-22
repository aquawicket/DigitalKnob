@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::############################################################################
::# __ARGC__(frame)
::#
:::__ARGC__
::	%dk_call% dk_debugFunc 0 1
::setlocal
:: 
::	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
::	::set /a _FRAME_+=2
::	::%dk_call% dk_return "%BATCH_ARGC[%_FRAME_%]%"
::%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

 
	call :DKTEST_func abc 123
%endfunction%


:DKTEST_func
setlocal
	%dk_call% dk_debugFunc 2

 
	echo __ARGC__ = %__ARGC__%
%endfunction%
