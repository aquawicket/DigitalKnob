@echo off
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_getFileLine(filepath, match_string)
::#
::#
:dk_getFileLine
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2 
 
	set "_filepath_=%~f1"
	set "_filepath_=%_filepath_:/=\%"
	%dk_call% dk_assertPath "%_filepath_%"
    
    for /f "delims=:" %%a in ('findstr /n /c:"%~2" "%_filepath_%"') do (
		if "!line!"=="" (
			set "line=%%a"
		) else (
			set "line=!line!;%%a"
		)
	)
 
	endlocal & set "dk_getFileLine=%line%"
:: DEBUG 
::	echo %line%: '%~2'
%endfunction%


:: FIND THIS LINE

::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
    %dk_call% dk_debugFunc 0

::    %dk_call% dk_getFileLine "../../README.md" "How to build"
	%dk_call% dk_getFileLine "%~0" ":: FIND THIS LINE"
	echo dk_getFileLine = %dk_getFileLine%
%endfunction%
