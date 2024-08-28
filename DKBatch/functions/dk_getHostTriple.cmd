@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::#####################################################################
::# dk_getHostTriple()
::#
::#
:dk_getHostTriple
 setlocal
	call dk_debugFunc 0
	
	set "DK_HOST_OS=win"
    ::%dk_call% dk_printVar DK_HOST_OS
	
	if "%PROCESSOR_ARCHITECTURE%"=="x86"   set "DK_HOST_ARCH=x86"
    if "%PROCESSOR_ARCHITECTURE%"=="AMD64" set "DK_HOST_ARCH=x86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="IA64"  set "DK_HOST_ARCH=x86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="EM64T" set "DK_HOST_ARCH=x86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="ARM64" set "DK_HOST_ARCH=arm64"
    ::%dk_call% dk_printVar DK_HOST_ARCH
	
	set "DK_HOST_TRIPLE=%DK_HOST_OS%_%DK_HOST_ARCH%"
    ::%dk_call% dk_printVar DK_HOST_TRIPLE
    
    set "DK_HOST_ENV=clang"
    set "DK_HOST_TRIPLE=%DK_HOST_TRIPLE%_%DK_HOST_ENV%"
	::set "DK_HOST_TRIPLE=%DK_HOST_ARCH%-%DK_HOST_VENDOR%-%DK_HOST_OS%
	::%dk_call% dk_printVar DK_HOST_TRIPLE
	::echo %DK_HOST_TRIPLE%
 endlocal
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_getHostTriple
	%dk_call% dk_printVar DK_HOST_TRIPLE
 endlocal
goto:eof