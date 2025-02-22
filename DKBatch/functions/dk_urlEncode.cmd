@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_urlEncode(url rtn_var)
::#
::#		%1=VARNAME
::#
:dk_urlEncode
setlocal EnableDelayedExpansion
	%dk_call% dk_debugFunc 1 2
 
	set "STRING=!%~1:%%=%%25!"
	set "STRING=!STRING: =%%20!"
	set ^"STRING=!STRING:"=%%22!"
	for %%x in ("# 23" "$ 24" "& 26" "+ 2B" ", 2C" "/ 2F" ": 3A"
			"; 3B" "< 3C" "> 3E" "? 3F" "@ 40" "\ 5C" "^ 5E"
		) do for /f "tokens=1,2" %%a in (%%x) do (
        set "STRING=!STRING:%%a=%%%%b!"
    )
	:# Special case for the ! character, which can only be replaced in a set %STRING%
	set "STRING=%STRING:!= %" & set "STRING=!STRING: =%%21!" &:# Prerequisite: No more " and ^
	:# Special case for the = character, which cannot be replaced by any set command
	::set "REPL=%%3D" & %dk_call% :ReplaceEquals STRING REPL
	endlocal & set "%~1=%STRING%"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	set "url=https://example.com/api?query=test^&test=test"
	echo url = %url%
    %dk_call% dk_urlEncode url
	echo url = %url%
%endfunction%
