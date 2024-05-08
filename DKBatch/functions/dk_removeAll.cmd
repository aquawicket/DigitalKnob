@echo off
call DK

::####################################################################
::# dk_removeAll()
::#
::#
:dk_removeAll () {
	call dk_debugFunc
	
    if "%1" EQU "wipe" goto:wipe
        
    call dk_clearScreen
	call dk_echo
	call dk_echo
	call dk_info "Do you want to delete the entire local repository . . . ?"
	call dk_info "This will delete the local digitalknob branch repository"
	call dk_info "Save any un-commited changes first."
	call dk_echo
        
    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" NEQ "Y" goto:eof
        
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
    copy /Y %DKSCRIPT_DIR%\%DKSCRIPT_NAME% %DIGITALKNOB_DIR%\%DKSCRIPT_NAME%
    start "" "%DIGITALKNOB_DIR%\%DKSCRIPT_NAME%" :dk_removeAll wipe
    call dk_exit    
        
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :wipe   
    ::do we need admin rights?
    ::runas /user:Administrator cmd   
    ::do we need to kill any processes? 
    ::do we need to uninstall any apps?  
    ::do we need to remove any environment variables?
        
    cd %DIGITALKNOB_DIR%
    call dk_echo
    call dk_info "DELETING %DKBRANCH_DIR% . . . ."
    call rmdir %DKBRANCH_DIR% /s /q
    call dk_info "done."
        
    :: wait for the folders to get deleted
    call dk_sleep 5
        
    if exist %DKBRANCH_DIR% echo "Oh no, the BRANCH folder is still there! :( "
goto:eof



:DKTEST ########################################################################

