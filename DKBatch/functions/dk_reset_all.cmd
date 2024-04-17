::dk_include_guard()

::####################################################################
::# dk_reset_all()
::#
::#
:dk_reset_all () {
	call dk_verbose "dk_reset_all(%*)"
	
    if "%1" EQU "wipe" goto:wipe
        
    cls
    echo.
    echo.
    echo  Do you want to reset the entire local repository . . .?
    echo. This will delete digitalknob, everything will be reset,
    echo. and the repository will be re-cloned. All libraries and tools
    echo. will be redownloaded and rebuild from start. Save any changes 
    echo. you wish to commit or save beforehand.
    echo. 
        
    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" NEQ "Y" goto:eof
        
    :: first we need to relocate this file up one directory
    :: make sure script is running from DKBRANCH_DIR
    if not "%SCRIPT_DIR%" == "%DKBRANCH_DIR%" (
        echo WARNING: this file isn't running from the branch directory
        echo Is must be in the branch directory to continue.
        call dk_debug SCRIPT_DIR
        call dk_debug DKBRANCH_DIR
        goto:eof
    )
    
    call dk_kill_process java.exe
    call dk_kill_process adb.exe
    
    echo "RELOCATING SCRIPT TO -> %DIGITALKNOB_DIR%\%SCRIPT_NAME%"
    copy /Y %SCRIPT_DIR%\%SCRIPT_NAME% %DIGITALKNOB_DIR%\%SCRIPT_NAME%
    start "" "%DIGITALKNOB_DIR%\%SCRIPT_NAME%" :dk_reset_all wipe
    exit    
        
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :wipe   
    ::do we need admin rights?
    ::runas /user:Administrator cmd
    ::do we need to uninstall any apps?
    ::do we need to remove any environment variables?
      
    :: TODO: kill java.exe processes
    :: TODO: kill adb.exe process
      
    cd %DIGITALKNOB_DIR%

    echo.
    echo DELETING %DKBRANCH_DIR% . . . .
    call rmdir %DKBRANCH_DIR% /s /q
    echo done.
        
    :: wait for the folders to get deleted
    ping 127.0.0.1 -n 6 >nul
    ping 127.0.0.1 -n 6 >nul
        
    if exist %DKBRANCH_DIR% echo "Oh no, the BRANCH folder is still there! :( "
        
    call dk_git_update NO_CONFIRM
        
    start "" "%DKBRANCH_DIR%\%SCRIPT_NAME%" & del /f %DIGITALKNOB_DIR%\%SCRIPT_NAME% & exit
goto:eof