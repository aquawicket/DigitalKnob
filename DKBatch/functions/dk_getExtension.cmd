@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_getExtension(<pathname>, <rtn_var>:optional)
::#
::#
:dk_getExtension
%setlocal%
	%dk_call% dk_debugFunc 1 2

	:: array of acceptable multi dot extensions
	set "ext[1]=7z.exe"
	set "ext[2]=tar.gz"
	set "ext[3]=tar.xz"

	set "pathname=%~nx1"
	set "pathname=%pathname:/=\%"
	set "pathname=%pathname:"=%"
	if "%pathname:~-1%" equ "\" set "pathname=%pathname:~0,-1%"
	if "%pathname:~-1%" equ "/" set "pathname=%pathname:~0,-1%"

	set "dk_getExtension="
	for /L %%i in (1,1,10) do (
		set "pathname=!pathname:*.=!"
		for /L %%i in (1,1,3) do if /I "!pathname!" equ "!ext[%%i]!" (
			set "dk_getExtension=.!ext[%%i]!"
			goto endloop
		)
	)
	:endloop

	:: If a multi-dot extension was not found, just return the single dot extension
	if not defined dk_getExtension set "dk_getExtension=.!pathname!"

	endlocal & (
		set "dk_getExtension=%dk_getExtension%"
		if "%~2" neq "" set "%~2=%dk_getExtension%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	echo:
	%dk_call% dk_set myPath "/test/test2/xfile.exten"
	%dk_call% dk_getExtension "%myPath%"
	%dk_call% dk_printVar dk_getExtension

	echo:
	%dk_call% dk_set myPath "test.zip"
	%dk_call% dk_getExtension "%myPath%"
	%dk_call% dk_printVar dk_getExtension

	echo:
	%dk_call% dk_set myPath "test.tar.gz"
	%dk_call% dk_getExtension "%myPath%"
	%dk_call% dk_printVar dk_getExtension

	echo:
	%dk_call% dk_set myPath "test.tar.xz.tar.gz.tar.xz"
	%dk_call% dk_getExtension "%myPath%"
	%dk_call% dk_printVar dk_getExtension

	echo:
	%dk_call% dk_set myPath "test.tar.x.gz"
	%dk_call% dk_getExtension "%myPath%"
	%dk_call% dk_printVar dk_getExtension

	echo:
	%dk_call% dk_set myPath "test.tar.xz"
	%dk_call% dk_getExtension "%myPath%"
	%dk_call% dk_printVar dk_getExtension

	echo:
	%dk_call% dk_set myPath "test.7z.exe.b"
	%dk_call% dk_getExtension "%myPath%"
	%dk_call% dk_printVar dk_getExtension

	echo:
	%dk_call% dk_set myPath "test.7z.exe"
	%dk_call% dk_getExtension "%myPath%"
	%dk_call% dk_printVar dk_getExtension
%endfunction%
