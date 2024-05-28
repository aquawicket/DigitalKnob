@echo off
call DK

::##################################################################################
::# __LINE__(<frame>)
::#
:__LINE__() {
	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
	::set /A _FRAME_+=1

::	call dk_return "%BATCH_LINENO[%_FRAME_%]%"
goto:eof



:DKTEST ########################################################################
	
	echo "$(__LINE__)"

