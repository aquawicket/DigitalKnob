<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::####################################################################
::# dk_resetPlugins()
::#
::#
:dk_resetPlugins
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    echo Resetting DKPlugins . . .

    %dk_call% dk_confirm || %return%
    
    %dk_call% dk_cd %DKPLUGINS_DIR%
=======
setlocal
	%dk_call% dk_debugFunc 0

    echo Resetting DKCpp/plugins . . .

    %dk_call% dk_confirm || %return%
    
    %dk_call% dk_chdir %DKCPP_PLUGINS_DIR%
>>>>>>> Development
    "%GIT_EXE%" -C %DKBRANCH_DIR% clean -f -d
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
    %dk_call% dk_resetPlugins
%endfunction%
