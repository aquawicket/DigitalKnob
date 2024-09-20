@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::############################################################################
::# __ARGC__(frame)
::#
:__ARGC__
	call dk_debugFunc 0 1
 setlocal
 
	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
	::set /A _FRAME_+=2
	::call dk_return "%BATCH_ARGC[%_FRAME_%]%"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
 setlocal
 
	call :DKTEST_func abc 123
%endfunction%


:DKTEST_func
	call dk_debugFunc 2
 setlocal
 
	echo __ARGC__ = %__ARGC__%
%endfunction%
