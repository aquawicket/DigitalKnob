@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ####################################################################
rem # dk_resetAll()
rem #
:dk_resetAll
%setlocal%

    if /i "%1" equ "wipe" goto wipe
       
    %dk_call% dk_clearScreen
    %dk_call% dk_echo
    %dk_call% dk_echo
    %dk_call% dk_info "Do you want to reset the entire local repository . . . ?"
    %dk_call% dk_info "This will delete DigitalKnob, everything will be reset,"
    %dk_call% dk_info "and the repository will be re-cloned. All libraries and tools"
    %dk_call% dk_info "will be re-downloaded and rebuild from start. Save any changes"
    %dk_call% dk_info "you wish to commit or save beforehand."
    %dk_call% dk_echo
       
    %dk_call% dk_confirm || %return%
   
    rem first we need to relocate this file up one directory
    rem make sure script is running from DKBRANCH_DIR
    if "%DKSCRIPT_DIR%" neq "%DKBRANCH_DIR%" (
        %dk_call% dk_echo "%yellow%"
        %dk_call% dk_echo "WARNING: this file isn't running from the branch directory"
        %dk_call% dk_echo "Is must be in the branch directory to continue."
        %dk_call% dk_echo "%clr%"
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
       
    rem ############################################################
    :wipe  
    rem do we need admin rights?
    rem runas /user:Administrator %ComSpec%
    rem do we need to uninstall any apps?
    rem do we need to remove any environment variables?
     
    %dk_call% dk_chdir %DIGITALKNOB_DIR%

    %dk_call% dk_echo
    %dk_call% dk_info DELETING %DKBRANCH_DIR% . . . .
    rmdir %DKBRANCH_DIR% /s /q
    %dk_call% dk_info done.
       
    rem wait for the folders to get deleted
    %dk_call% dk_sleep 3
       
    if EXIST "%DKBRANCH_DIR%" echo "Oh no, the BRANCH folder is still there! :( "
       
    %dk_call% dk_gitUpdate
       
    start "" "%DKBRANCH_DIR%\%DKSCRIPT_NAME%" & del /f %DIGITALKNOB_DIR%\%DKSCRIPT_NAME% & exit
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_resetAll
%endfunction%
