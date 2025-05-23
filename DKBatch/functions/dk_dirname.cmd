@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_dirname(<pathname>, <rtn_var>:optional)
::#
::#   Returns a parent directory's path
::#
::#   Reference: https://en.wikipedia.org/wiki/Dirname
::#
:dk_dirname
%setlocal%
	%dk_call% dk_debugFunc 1 2

    set "pathname=%1"
    set "pathname=%pathname:"=%"
	
    for %%Z in ("%pathname%") do set "dk_dirname=%%~dpZ"
	if "%dk_dirname:~-1%" equ "/" set "dk_dirname=%dk_dirname:~0,-1%"
	
    endlocal & (
		set "dk_dirname=%dk_dirname:\=/%"
		if "%~2" neq "" set "%~2=%dk_dirname:\=/%"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% dk_set myPath "%windir:\=/%/System32"
    %dk_call% dk_dirname "%myPath%"
    %dk_call% dk_echo "%myPath%: dirname = %dk_dirname%"
	
	%dk_call% dk_set myPath "%windir:\=/%/System32/"
    %dk_call% dk_dirname "%myPath%"
    %dk_call% dk_echo "%myPath%: dirname = %dk_dirname%"
	
	%dk_call% dk_set myPath "%windir:\=/%/System32"
    %dk_call% dk_dirname "%myPath%"
    %dk_call% dk_echo "%myPath%: dirname = %dk_dirname%"
	
	%dk_call% dk_set myPath "%windir:\=/%/System32/"
    %dk_call% dk_dirname "%myPath%"
    %dk_call% dk_echo "%myPath%: dirname = %dk_dirname%"
	
	:: FIXME
	%dk_call% dk_set myPath "/home/aquawicket/docs/."
    %dk_call% dk_dirname "%myPath%"
    %dk_call% dk_echo "%myPath%: dirname = %dk_dirname%"
	
	%dk_call% dk_set myPath "/home/aquawicket/docs/"
    %dk_call% dk_dirname "%myPath%"
    %dk_call% dk_echo "%myPath%: dirname = %dk_dirname%"
	
	%dk_call% dk_set myPath "base.wiki"
    %dk_call% dk_dirname "%myPath%"
    %dk_call% dk_echo "%myPath%: dirname = %dk_dirname%"
	
	:: FIXME
	::%dk_call% dk_set myPath "/"
    ::%dk_call% dk_dirname "%myPath%"
    ::%dk_call% dk_echo "%myPath%: dirname = %dk_dirname%"
%endfunction%
