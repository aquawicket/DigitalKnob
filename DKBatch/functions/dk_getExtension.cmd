@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getExtension(path rtn_var)
::#
::#
:dk_getExtension
    call dk_debugFunc 2
 setlocal

	:: array of acceptable multi dot extensions
	set "ext[1]=7z.exe"
	set "ext[2]=tar.gz"
	set "ext[3]=tar.xz"
	
	set "_input_=%~nx1"
	set "_input_=%_input_:"=%"
    if [%_input_:~-1%] == [\] set "_input_=%_input_:~0,-1%"
    if [%_input_:~-1%] == [/] set "_input_=%_input_:~0,-1%"
	
	for /L %%i in (1,1,10) do (
		set "_input_=!_input_:*.=!"
		for /L %%i in (1,1,3) do if /I "!_input_!" equ "!ext[%%i]!" (
			set "_extension_=.!ext[%%i]!"
			goto:endloop
		)
	)
	:endloop
	:: If a multi-dot extension was not found, just return the single dot extension
	if not defined _extension_ set "_extension_=.!_input_!"
    endlocal & set "%2=%_extension_%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
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
