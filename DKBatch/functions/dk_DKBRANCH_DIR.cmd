@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_DKBRANCH_DIR()
::#
::#
:dk_DKBRANCH_DIR
    call dk_debugFunc 0
:: setlocal
  
    :: https://stackoverflow.com/a/33662275
    :: If the current folder matches the current branch set DKBRANCH. Otherwise, default to Development
    
    if not defined DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
    for %%I in (.) do set "FOLDER=%%~nxI"                          &:: get the current folder

    set "DKBRANCH=Development"                                     &:: set the default branch
    if not defined GIT_EXE %dk_call% dk_installGit
    if exist "%CD%\.git" (
        "%GIT_EXE%" branch | find "* %FOLDER%" > NUL & if ERRORLEVEL 0 (
            set "DKBRANCH=%FOLDER%"
        )
    )
    
    set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\%DKBRANCH%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_DKBRANCH_DIR
%endfunction%