@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::##################################################################################
::# __CALLER__(frame)
::#
:__CALLER__
	::call dk_debugFunc
 setlocal
 
	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
	set /A _FRAME_+=1
::	call dk_return "%FUNCNAME[%_FRAME_%]%()"
 endlocal
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	::call dk_debugFunc
 setlocal
 
	echo %__CALLER__%
 endlocal
%endfunction%
