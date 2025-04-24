<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_wifiPass()
::#
:dk_wifiPass
    call dk_debugFunc 0
 setlocal
 
    set "tempfile=%DKCACHE_DIR%\temp.txt"
    if exist !tempfile! call dk_delete !tempfile!
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_wifiPasses()
::#
:dk_wifiPasses
setlocal
	%dk_call% dk_debugFunc 0

    set "tempfile=%DKCACHE_DIR%\temp.txt"
    if exist !tempfile! %dk_call% dk_delete !tempfile!
>>>>>>> Development
    netsh wlan show profile | findstr All>> "!tempfile!"

    for /f "tokens=2 delims=:" %%i in (!tempfile!) do (
        set /a count+=1
        set "list_!count!=%%i"
    )
<<<<<<< HEAD
    call dk_delete !tempfile!
=======
    %dk_call% dk_delete !tempfile!
>>>>>>> Development

    for /l %%i in (1,1,!count!) do (
        set list_%%i=!list_%%i:~1!
    )

    for /l %%i in (1,1,!count!) do (
        echo      Wi-Fi Name            : !list_%%i!
        netsh wlan show profile name="!list_%%i!" key=clear | findstr Content
        echo:
    )
%endfunction%








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_wifiPass
=======
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_wifiPasses
>>>>>>> Development
%endfunction%