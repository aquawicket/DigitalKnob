@echo off
call dk_includeGuard
call DK

::####################################################################
::# dk_resetAll()
::#
::#
:dk_resetAll () {
	call dk_debugFunc
	
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
    if not "%DKSCRIPT_DIR%" == "%DKBRANCH_DIR%" (
        echo WARNING: this file isn't running from the branch directory
        echo Is must be in the branch directory to continue.
        call dk_debug DKSCRIPT_DIR
        call dk_debug DKBRANCH_DIR
        goto:eof
    )
    
    call dk_killProcess java.exe
    call dk_killProcess adb.exe
    
    echo "RELOCATING SCRIPT TO -> %DIGITALKNOB_DIR%\%DKSCRIPT_NAME%"
	xcopy /s /e /Y %DKBRANCH_DIR%\DKBatch %DIGITALKNOB_DIR%\DKBatch\
    copy /Y %DKSCRIPT_PATH% %DIGITALKNOB_DIR%\%DKSCRIPT_NAME%
	set "PATH=%DIGITALKNOB_DIR%\DKBatch\functions;%PATH%"
    start "" "%DIGITALKNOB_DIR%\%DKSCRIPT_NAME%" dk_resetAll wipe
    exit
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
        
    call dk_gitUpdate NO_CONFIRM
        
    start "" "%DKBRANCH_DIR%\%DKSCRIPT_NAME%" & del /f %DIGITALKNOB_DIR%\%DKSCRIPT_NAME% & exit
goto:eof