@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::############################################################################
::# __CALLER__(frame)
::#
:__CALLER__
setlocal
	%dk_call% dk_debugFunc 0 1
 
	if "%~1" == "" (set "_FRAME_=0") else (set "_FRAME_=%1")
	set /A _FRAME_+=1
	::echo FAME = %_FRAME_%
	::call dk_set __CALER__ "!FUNCNAME[%_FRAME_%]!()"
	
	call dk_set __CALLER__ !DKSTACK[%_FRAME_%].__FUNCTION__!
	echo __CALLER__ = %__CALLER__%
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0
 setlocal
 
	call __CALLER__
	echo __CALLER__ = %__CALLER__%
%endfunction%
