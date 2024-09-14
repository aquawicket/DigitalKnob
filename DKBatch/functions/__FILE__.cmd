@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*

::##################################################################################
::# __FILE__(frame)
::#
:__FILE__
	::call dk_debugFunc
 setlocal
 
	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
	::set /A _FRAME_+=1
	
::	#echo "$(basename %BATCH_SOURCE[%_FRAME_%]%"
::	call dk_return "$(basename %BATCH_SOURCE[%_FRAME_%]%"
 endlocal
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	::call dk_debugFunc
 setlocal
 
	echo %__FILE__%
 endlocal
%endfunction%
