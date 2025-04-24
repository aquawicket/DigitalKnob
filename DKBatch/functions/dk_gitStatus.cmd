<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::################################################################################
::# dk_gitStatus()
::#
::#
:dk_gitStatus
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
=======
setlocal
	%dk_call% dk_debugFunc 0

>>>>>>> Development
    %dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
    "%GIT_EXE%" -C %DKBRANCH_DIR% status
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
    %dk_call% dk_gitStatus
%endfunction%
