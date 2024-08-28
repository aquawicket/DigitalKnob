@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::##################################################################################
::# __CALLER__(frame)
::#
:__CALLER__
 setlocal
	::call dk_debugFunc
	
	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
	set /A _FRAME_+=1
::	call dk_return "%FUNCNAME[%_FRAME_%]%()"
 endlocal
goto:eof



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	::call dk_debugFunc
	
	echo %__CALLER__%
 endlocal
goto:eof
