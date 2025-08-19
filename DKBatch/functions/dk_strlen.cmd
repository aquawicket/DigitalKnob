@echo off&::###### DK.cmd #########################################################################################################################
if NOT exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_strlen(string_var)
::#
::#
:dk_strlen
%setlocal%
	%dk_call% dk_debugFunc 1 2

    set "s=#!%~1!"
    set "dk_strlen=0"
    for %%N in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
        if "!s:~%%N,1!" neq "" (
            set /a "dk_strlen+=%%N"
            set "s=!s:~%%N!"
        )
    )
    endlocal & (
		set "dk_strlen=%dk_strlen%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    set "str=some example string"
    %dk_call% dk_strlen str
	%dk_call% dk_echo "dk_strlen = %dk_strlen%"
%endfunction%
