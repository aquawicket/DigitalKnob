@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::##################################################################################
::# __CALLER__(frame)
::#
:__CALLER__
	::call dk_debugFunc
	
	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
	set /A _FRAME_+=1
::	call dk_return "%FUNCNAME[%_FRAME_%]%()"
goto:eof



::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	::call dk_debugFunc
	
	echo "$(__CALLER__)"
goto:eof
