@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::##################################################################################
::# __ARGC__(frame)
::#
:__ARGC__
	::call dk_debugFunc
	
	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
	::set /A _FRAME_+=2
::	call dk_return "%BATCH_ARGC[%_FRAME_%]%"
goto:eof



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	::call dk_debugFunc
	
	echo %__ARGC__%
goto:eof
