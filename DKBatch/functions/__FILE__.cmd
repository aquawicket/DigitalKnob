@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::##################################################################################
::# __FILE__(frame)
::#
:__FILE__
 setlocal
	::call dk_debugFunc
	
	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
	::set /A _FRAME_+=1
	
::	#echo "$(basename %BATCH_SOURCE[%_FRAME_%]%"
::	call dk_return "$(basename %BATCH_SOURCE[%_FRAME_%]%"
 endlocal
goto:eof



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	::call dk_debugFunc
	
	echo %__FILE__%
 endlocal
goto:eof
