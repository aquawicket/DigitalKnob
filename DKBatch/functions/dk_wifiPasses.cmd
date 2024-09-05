@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_wifiPass()
::#
:dk_wifiPass
 setlocal
    call dk_debugFunc 0

    set "tempfile=%DKTEMP_DIR%temp.txt"
    if exist !tempfile! call dk_delete !tempfile!
    netsh wlan show profile | findstr All>> "!tempfile!"

    for /f "tokens=2 delims=:" %%i in (!tempfile!) do (
        set /a count+=1
        set "list_!count!=%%i"
    )
    call dk_delete !tempfile!

    for /l %%i in (1,1,!count!) do (
        set list_%%i=!list_%%i:~1!
    )

    for /l %%i in (1,1,!count!) do (
        echo      Wi-Fi Name            : !list_%%i!
        netsh wlan show profile name="!list_%%i!" key=clear | findstr Content
        echo:
    )
%endfunction%