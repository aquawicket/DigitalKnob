@echo off
call DK

::##################################################################################
::# __CALLER__(<frame>)
::#
:__CALLER__() {
	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
	set /A _FRAME_+=1

::	call dk_return "%FUNCNAME[%_FRAME_%]%()"
goto:eof



:DKTEST ########################################################################
	
	echo "$(__CALLER__)"