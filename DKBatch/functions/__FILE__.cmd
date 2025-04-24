<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::############################################################################
::# __FILE__(frame)
::#
:__FILE__
<<<<<<< HEAD
	call dk_debugFunc
 setlocal
 
	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
	::set /A _FRAME_+=1
=======
setlocal
	%dk_call% dk_debugFunc
 
	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
	::set /a _FRAME_+=1
>>>>>>> Development
	
	::echo "$(basename %BATCH_SOURCE[%_FRAME_%]%"
	::call dk_return "$(basename %BATCH_SOURCE[%_FRAME_%]%"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
	call dk_debugFunc 0
 setlocal
=======
setlocal
	%dk_call% dk_debugFunc 0
>>>>>>> Development
 
	echo __FILE__ = %__FILE__%
%endfunction%
