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


rem #################################################################################
rem # dk_keyboardInputTimeout(<default>, <timeout>, <ret>:OPTIONAL)
rem #
rem # reference: https://stackoverflow.com/a/7703584/688352
rem #            https://stackoverflow.com/a/33206814/688352
rem #
:dk_keyboardInputTimeout
%setlocal%
   
    set "default=%~1"
    set /a "timeout=%~2"
   
	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
    set "cache_file=%DKCACHE_DIR%/keyboardInputTimeout_cache.tmp"
    set "thread_file=%DKCACHE_DIR%/keyboardInputTimeout_thread.cmd"
    %dk_call% dk_delete "%cache_file%" 1>nul 2>nul
   
    >"%thread_file%" (
		echo ^@echo off
		echo set /p var=
		echo ^> "%cache_file:/=\%" echo %%var%%
	)
	
    start "" /b "%ComSpec:/=\%" /c "%thread_file:/=\%"
   
    set "ESC="
    for /f %%a in ('copy /Z "%~dpf0" nul') do set "ASCII_13=%%a"
   
    :keyboard_input_timeout_loop
		set /a "timeout-=1"
		%dk_call% dk_title %timeout%
		rem <nul set /p "=.!ASCII_13!     %timeout%" <NUL
		rem <nul set /p "="<NUL

		rem ping -n 2 localhost 1>nul 2>nul
		%dk_call% dk_sleep 1
		if !timeout! GTR 0 (
			if NOT EXIST "%cache_file%" goto keyboard_input_timeout_loop
		)
   
    :keyboard_input_timeout_result
    del "%thread_file:/=\%" 1>nul 2>nul
    if EXIST "%cache_file%" (
        set /p dk_keyboardInputTimeout=<"%cache_file%"
        del "%cache_file:/=\%" 1>nul 2>nul
    ) else (
        set "dk_keyboardInputTimeout=%default%"
    )

    endlocal & (
		set "dk_keyboardInputTimeout=%dk_keyboardInputTimeout%"
		if "%~3" neq "" (set "%~3=%dk_keyboardInputTimeout%")
	)
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_echo "Type some input and press enter, this will time out in 10 seconds"
    %dk_call% dk_keyboardInputTimeout "default" 10
    %dk_call% dk_printVar dk_keyboardInputTimeout
%endfunction%

