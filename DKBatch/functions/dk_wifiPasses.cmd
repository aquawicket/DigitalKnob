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


rem ################################################################################
rem # dk_wifiPasses()
rem #
:dk_wifiPasses
rem !setlocal!
setlocal enableDelayedExpansion

    set "tempfile=%DKCACHE_DIR%\dk_wifiPasses.tmp"
	
    if EXIST "%tempfile%" (%dk_call% dk_delete "%tempfile%")
	%dk_call% dk_validate netsh.exe %dk_call% dk_findFile netsh.exe
	
    "%netsh.exe%" wlan show profile | findstr All>> "%tempfile%"

    for /f "tokens=2 delims=:" %%i in (%tempfile%) do (
        set /a count+=1
        set "dk_wifiPasses!count!=%%i"
    )
    %dk_call% dk_delete "%tempfile%"

    for /l %%i in (1,1,%count%) do (
        set dk_wifiPasses%%i=!dk_wifiPasses%%i:~1!
    )

	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
    for /l %%i in (1,1,!count!) do (
        echo      Wi-Fi Name            : !dk_wifiPasses%%i!
        "%netsh.exe%" wlan show profile name="!dk_wifiPasses%%i!" key=clear | %findstr.exe% Content
        echo.
    )
	
	:return
	endlocal & (
		set "netsh.exe=%netsh.exe%"
		set "findstr.exe=%findstr.exe%"
	)
!endfunction!








rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_wifiPasses
	%dk_call% dk_wifiPasses
%endfunction%