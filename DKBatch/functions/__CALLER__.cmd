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
::# __CALLER__(frame)
::#
:__CALLER__
<<<<<<< HEAD
	call dk_debugFunc 0 1
 setlocal
 
	if "%~1" == "" (set "_FRAME_=0") else (set "_FRAME_=%1")
	set /A _FRAME_+=1
=======
setlocal
	%dk_call% dk_debugFunc 0 1
 
	if "%~1" equ "" (set "_FRAME_=0") else (set "_FRAME_=%1")
	set /a _FRAME_+=1
>>>>>>> Development
	::echo FAME = %_FRAME_%
	::call dk_set __CALER__ "!FUNCNAME[%_FRAME_%]!()"
	
	call dk_set __CALLER__ !DKSTACK[%_FRAME_%].__FUNCTION__!
	echo __CALLER__ = %__CALLER__%
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
 
	call __CALLER__
	echo __CALLER__ = %__CALLER__%
%endfunction%
