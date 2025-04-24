@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::############################################################################
::# __FILE__(frame)
::#
:__FILE__
setlocal
	%dk_call% dk_debugFunc
 
	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
	::set /a _FRAME_+=1
	
	::echo "$(basename %BATCH_SOURCE[%_FRAME_%]%"
	::call dk_return "$(basename %BATCH_SOURCE[%_FRAME_%]%"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
 
	echo __FILE__ = %__FILE__%
%endfunction%
