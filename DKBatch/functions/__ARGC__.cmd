@echo off
call DK

::##################################################################################
::# __ARGC__(<frame>)
::#
:__ARGC__() {
	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
	::set /A _FRAME_+=2

::	call dk_return "%BATCH_ARGC[%_FRAME_%]%"
goto:eof



:DKTEST ########################################################################
	
	echo %__ARGC__%