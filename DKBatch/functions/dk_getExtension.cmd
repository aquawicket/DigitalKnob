@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getExtension(<pathname>, <rtn_var>:optional)
::#
::#
:dk_getExtension
setlocal
	%dk_call% dk_debugFunc 2

	:: array of acceptable multi dot extensions
	set "ext[1]=7z.exe"
	set "ext[2]=tar.gz"
	set "ext[3]=tar.xz"
	
	set "pathname=%~nx1"
	set "pathname=%pathname:/=\%"
	set "pathname=%pathname:"=%"
    if "%pathname:~-1%"=="\" set "pathname=%pathname:~0,-1%"
    if "%pathname:~-1%"=="/" set "pathname=%pathname:~0,-1%"
	
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
		if "%2" neq "" set "%2=%dk_getExtension%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_set myPath "/test/test2/xfile.exten"
    %dk_call% dk_getExtension "%myPath%" extension
    %dk_call% dk_printVar extension
	
	%dk_call% dk_getExtension "test.zip" extension
    %dk_call% dk_printVar extension
	
	%dk_call% dk_getExtension "test.tar.gz" extension
    %dk_call% dk_printVar extension
	
	%dk_call% dk_getExtension "test.tar.xz.tar.gz.tar.xz" extension
    %dk_call% dk_printVar extension
	
	%dk_call% dk_getExtension "test.tar.x.gz" extension
    %dk_call% dk_printVar extension
	
	%dk_call% dk_getExtension "test.tar.xz" extension
    %dk_call% dk_printVar extension
	
	%dk_call% dk_getExtension "test.7z.exe.b" extension
    %dk_call% dk_printVar extension
	
	%dk_call% dk_getExtension "test.7z.exe" extension
    %dk_call% dk_printVar extension
%endfunction%
