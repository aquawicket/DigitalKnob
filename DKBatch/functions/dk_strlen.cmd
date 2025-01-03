@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_strlen(string_var rtn_var)
::#
::#
:dk_strlen
setlocal
	%dk_call% dk_debugFunc 2

    set "s=#!%~1!"
    set "len=0"
    for %%N in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
        if "!s:~%%N,1!" neq "" (
            set /a "len+=%%N"
            set "s=!s:~%%N!"
        )
    )
    endlocal & set "%2=%len%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_set str "some example string"
    %dk_call% dk_strlen str length
	%dk_call% dk_echo "%str%"
    %dk_call% dk_echo "str is %length% characters long"
%endfunction%
