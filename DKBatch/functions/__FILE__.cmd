@echo off
call DK.cmd

::##################################################################################
::# __FILE__(frame)
::#
:__FILE__() {
	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
	::set /A _FRAME_+=1
	
::	#echo "$(basename %BATCH_SOURCE[%_FRAME_%]%"
::	call dk_return "$(basename %BATCH_SOURCE[%_FRAME_%]%"
goto:eof



:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	
	echo "$(__FILE__)"
