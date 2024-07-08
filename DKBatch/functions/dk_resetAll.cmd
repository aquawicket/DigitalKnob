@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_resetAll()
::#
:dk_resetAll
	call dk_debugFunc
	
    if "%1" equ "wipe" goto:wipe
        
    call dk_clearScreen
	call dk_echo
	call dk_echo
	call dk_info "Do you want to reset the entire local repository . . . ?"
	call dk_info "This will delete digitalknob, everything will be reset,"
	call dk_info "and the repository will be re-cloned. All libraries and tools"
	call dk_info "will be re-downloaded and rebuild from start. Save any changes"
	call dk_info "you wish to commit or save beforehand."
	call dk_echo
        
    call dk_confirm || goto:eof
    
    :: first we need to relocate this file up one directory
    :: make sure script is running from DKBRANCH_DIR
    if not "%DKSCRIPT_DIR%" == "%DKBRANCH_DIR%" (
        call dk_echo "%yellow%"
		call dk_echo "WARNING: this file isn't running from the branch directory"
		call dk_echo "Is must be in the branch directory to continue."
		call dk_echo "%clr%"
        call dk_printVar DKSCRIPT_DIR
        call dk_printVar DKBRANCH_DIR
        goto:eof
    )
    
    call dk_killProcess java.exe
    call dk_killProcess adb.exe
    
    call dk_info "RELOCATING SCRIPT TO -> %DIGITALKNOB_DIR%\%DKSCRIPT_NAME%"
	call dk_copy %DKBRANCH_DIR%\DKBatch %DIGITALKNOB_DIR%\DKBatch OVERWRITE
    call dk_copy %DKSCRIPT_PATH% %DIGITALKNOB_DIR%\%DKSCRIPT_NAME% OVERWRITE
	set "PATH=%DIGITALKNOB_DIR%\DKBatch\functions;%PATH%"
    start "" "%DIGITALKNOB_DIR%\%DKSCRIPT_NAME%" dk_resetAll wipe
    call dk_exit
    call dk_exit    
        
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :wipe   
    ::do we need admin rights?
    ::runas /user:Administrator cmd
    ::do we need to uninstall any apps?
    ::do we need to remove any environment variables?
      
    cd %DIGITALKNOB_DIR%

    call dk_echo
    call dk_info DELETING %DKBRANCH_DIR% . . . .
    call rmdir %DKBRANCH_DIR% /s /q
    call dk_info done.
        
    :: wait for the folders to get deleted
    call dk_sleep 3
        
    if exist %DKBRANCH_DIR% echo "Oh no, the BRANCH folder is still there! :( "
        
    call dk_gitUpdate NO_CONFIRM
        
    start "" "%DKBRANCH_DIR%\%DKSCRIPT_NAME%" & del /f %DIGITALKNOB_DIR%\%DKSCRIPT_NAME% & exit
goto:eof



::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc

	call dk_resetAll
goto:eof
