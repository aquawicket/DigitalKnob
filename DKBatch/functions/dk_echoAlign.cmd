@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::##################################################################################
::# dk_echoAlign(align text)
::#
::#
:dk_echoAlign
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2  

    if "!DE!" neq "" %dk_call% dk_error "%__FUNCTION__% requires delayed expansion"
    (set^ tmp=%~2)
    if defined tmp (
        set "len=1"
        for %%p in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
            if "!DE!" equ "" if "!tmp:~%%p,1!" neq "" (
                set /a "len+=%%p"
                set "tmp=!tmp:~%%p!"
            )
            if "!DE!" neq "" if "%tmp:~%%p,1%" neq "" (
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
        if "!DE!" equ "" for /l %%i in (1 1 !offsetnum!) do set "offset=!offset! "
        if "!DE!" neq "" for /l %%i in (1 1 %offsetnum%) do call set "offset=%%offset%% "
    ) else if /i "%1" equ "right" (
        set /a offsetnum=^(%cols% - %len%^)
        set "offset="
        if "!DE!" equ "" for /l %%i in (1 1 !offsetnum!) do set "offset=!offset! "
        if "!DE!" neq "" for /l %%i in (1 1 %offsetnum%) do call set "offset=%%offset%% "
    )

    echo %offset%%~2
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_echoAlign center "centered text"
    %dk_call% dk_echoAlign right "right aligned text"
    %dk_call% dk_echo "text on the left side"
    set "prep_text="

    for /l %%Z in (1 1 7) do (
        if "!DE!" equ "" set "prep_text=!prep_text!aR"
        if "!DE!" equ "" %dk_call% dk_echoAlign center "!prep_text!"
        
        if "!DE!" neq "" call set "prep_text=%%prep_text%%aR"
        if "!DE!" neq "" %dk_call% dk_echoAlign center "%%prep_text%%"
    )
    echo:
%endfunction%
