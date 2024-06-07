@echo off
call DK

::##################################################################################
::# __FUNCTION__(frame)
::#
:__FUNCTION__() {
	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
	::set /A _FRAME_+=1

::	call dk_return "%FUNCNAME[%_FRAME_%]%"
goto:eof



:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	
	echo "$(__FUNCTION__)"
