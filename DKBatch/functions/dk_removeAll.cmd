@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_removeAll()
::#
:dk_removeAll
setlocal
    %dk_call% dk_debugFunc 0
    
    if "%1" equ "wipe" goto wipe
        
    %dk_call% dk_clearScreen
    %dk_call% dk_echo
    %dk_call% dk_echo
    %dk_call% dk_info "Do you want to reset the entire local repository . . . ?"
    %dk_call% dk_info "This will delete digitalknob, everything will be reset,"
    %dk_call% dk_info "and the repository will be re-cloned. All libraries and tools"
    %dk_call% dk_info "will be re-downloaded and rebuild from start. Save any changes"
    %dk_call% dk_info "you wish to commit or save beforehand."
    %dk_call% dk_echo
        
    %dk_call% dk_confirm || %return%
    
    :: first we need to relocate this file up one directory
    :: make sure script is running from DKBRANCH_DIR
    if not "%DKSCRIPT_DIR%" == "%DKBRANCH_DIR%" (
        %dk_call% dk_echo "%yellow%"
        %dk_call% dk_echo "WARNING: this file isn't running from the branch directory"
        %dk_call% dk_echo "Is must be in the branch directory to continue."
        %dk_call% dk_echo "%clr%"
        %dk_call% dk_printVar DKSCRIPT_DIR
        %dk_call% dk_printVar DKBRANCH_DIR
        %return%
    )
    
    %dk_call% dk_killProcess java.exe
    %dk_call% dk_killProcess adb.exe
    
    %dk_call% dk_info "RELOCATING SCRIPT TO -> %DIGITALKNOB_DIR%\%DKSCRIPT_NAME%"
    %dk_call% dk_copy %DKBRANCH_DIR%\DKBatch %DIGITALKNOB_DIR%\DKBatch OVERWRITE
    %dk_call% dk_copy %DKSCRIPT_PATH% %DIGITALKNOB_DIR%\%DKSCRIPT_NAME% OVERWRITE
    set "PATH=%DIGITALKNOB_DIR%\DKBatch\functions;%PATH%"
    start "" "%DIGITALKNOB_DIR%\%DKSCRIPT_NAME%" dk_resetAll wipe
    %dk_call% dk_exit
    %dk_call% dk_exit    
        
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :wipe   
    ::do we need admin rights?
    ::runas /user:Administrator cmd
    ::do we need to uninstall any apps?
    ::do we need to remove any environment variables?
      
    %dk_call% dk_cd %DIGITALKNOB_DIR%

    %dk_call% dk_echo
    %dk_call% dk_info DELETING %DKBRANCH_DIR% . . . .
    rmdir %DKBRANCH_DIR% /s /q
    %dk_call% dk_info done.
        
    :: wait for the folders to get deleted
    %dk_call% dk_sleep 3
        
    if exist %DKBRANCH_DIR% echo "Oh no, the BRANCH folder is still there! :( "
        
    ::%dk_call% dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development NO_CONFIRM
        
    ::start "" "%DKBRANCH_DIR%\%DKSCRIPT_NAME%" & del /f %DIGITALKNOB_DIR%\%DKSCRIPT_NAME% & exit
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_removeAll
%endfunction%
