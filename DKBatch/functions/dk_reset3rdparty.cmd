@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_reset3rdparty()
::#
::#
:dk_reset3rdparty
setlocal
    %dk_call% dk_debugFunc 0
    
    echo Resetting 3rdParty Libraries . . .
        
    %dk_call% dk_confirm || %return%
    
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
    %dk_call% dk_chdir %DK3RDPARTY_DIR%
    "%GIT_EXE%" -C %DKBRANCH_DIR% clean -f -d
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_reset3rdparty
%endfunction%
