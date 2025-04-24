<<<<<<< HEAD
@echo off
::if defined dk_loadAll (goto:eof) else (set dk_loadAll=1)
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::####################################################################
::# dk_loadAll()
::#
::#
:dk_loadAll()
<<<<<<< HEAD
 setlocal
    call dk_debugFunc 0
    
    :: if we are working from a local repository, all function files should be there. No need to loadAll
    if exist "%DKBATCH_FUNCTIONS_DIR_%..\..\.git" %return%
=======
setlocal
    %dk_call% dk_debugFunc 0
    
    :: if we are working from a local repository, all function files should be there. No need to loadAll
    if exist "%DKBATCH_FUNCTIONS_DIR_%../../.git" %return%
>>>>>>> Development
    
    :: download _functionList_ and load each function in the list"
    if not exist "%DKBATCH_FUNCTIONS_DIR_%_functionList_" %dk_call% dk_download "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/_functionList_" "%DKBATCH_FUNCTIONS_DIR_%_functionList_"

    if not exist "%DKBATCH_FUNCTIONS_DIR_%_functionList_" %dk_call% dk_error "failed to download %DKBATCH_FUNCTIONS_DIR_%_functionList_"
    
    for /F "usebackq delims=" %%a in ("%DKBATCH_FUNCTIONS_DIR_%_functionList_") do (
        %dk_call% dk_load %%a
    )
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
    %dk_call% dk_loadAll
%endfunction%
