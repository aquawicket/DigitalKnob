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
::# dk_reset3rdparty()
::#
::#
:dk_reset3rdparty
<<<<<<< HEAD
 setlocal
    call dk_debugFunc 0
=======
setlocal
    %dk_call% dk_debugFunc 0
>>>>>>> Development
    
    echo Resetting 3rdParty Libraries . . .
        
    %dk_call% dk_confirm || %return%
    
<<<<<<< HEAD
	%dk_call% dk_validate DK3RDPARTY_DIR "dk_DKBRANCH_DIR"
    %dk_call% dk_cd %DK3RDPARTY_DIR%
=======
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
    %dk_call% dk_chdir %DK3RDPARTY_DIR%
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
    %dk_call% dk_reset3rdparty
%endfunction%
