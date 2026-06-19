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


rem ##################################################################################
rem # dk_echoAlign(align text)
rem #
rem #
:dk_echoAlign
%setlocal%

    if "!!" neq "" %dk_call% dk_error "%__FUNCTION__% requires delayed expansion"
    (set^ tmp=%~2)
    if defined tmp (
        set "len=1"
        for %%p in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
            if "!!" equ "" if "!tmp:~%%p,1!" neq "" (
                set /a "len+=%%p"
                set "tmp=!tmp:~%%p!"
            )
            if "!!" neq "" if "%tmp:~%%p,1%" neq "" (
                set /a "len+=%%p"
                call set "tmp=%%tmp:~%%p%%" &rem FIXME: remove the need for call here
            )
        )
    ) else (
	    set len=0
	)

    for /f "skip=4 tokens=2 delims=:" %%i in ('mode con') do (
        set /a cols=%%i
        goto loop_end
    )
    :loop_end

    if /i "%1" equ "center" (
        set /a offsetnum=^(%cols% / 2^) - ^(%len% / 2^)
        set "offset="
        if "!!" equ "" for /l %%i in (1 1 !offsetnum!) do set "offset=!offset! "
        if "!!" neq "" for /l %%i in (1 1 %offsetnum%) do call set "offset=%%offset%% "
    ) else if /i "%1" equ "right" (
        set /a offsetnum=^(%cols% - %len%^)
        set "offset="
        if "!!" equ "" for /l %%i in (1 1 !offsetnum!) do set "offset=!offset! "
        if "!!" neq "" for /l %%i in (1 1 %offsetnum%) do call set "offset=%%offset%% "
    )

    echo.%offset%%~2
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_echoAlign center "centered text"
    %dk_call% dk_echoAlign right "right aligned text"
    %dk_call% dk_echo "text on the left side"
    set "prep_text="

    for /l %%Z in (1 1 7) do (
        if "!!" equ "" set "prep_text=!prep_text!aR"
        if "!!" equ "" %dk_call% dk_echoAlign center "!prep_text!"
       
        if "!!" neq "" call set "prep_text=%%prep_text%%aR"
        if "!!" neq "" %dk_call% dk_echoAlign center "%%prep_text%%"
    )
    echo.
%endfunction%
