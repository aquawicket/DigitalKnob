@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::#####################################################################
::# dk_getHostTriple()
::#
::#
:dk_getHostTriple
	call dk_debugFunc 0
	
	set "HOST_OS=win"
    ::%dk_call% dk_printVar HOST_OS
	
	if "%PROCESSOR_ARCHITECTURE%"=="x86"   set "HOST_ARCH=x86"
    if "%PROCESSOR_ARCHITECTURE%"=="AMD64" set "HOST_ARCH=x86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="IA64"  set "HOST_ARCH=x86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="EM64T" set "HOST_ARCH=x86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="ARM64" set "HOST_ARCH=arm64"
    ::%dk_call% dk_printVar HOST_ARCH
	
	set "HOST_TRIPLE=%HOST_OS%_%HOST_ARCH%"
    ::%dk_call% dk_printVar HOST_TRIPLE
    
    set "HOST_ENV=clang"
    set "HOST_TRIPLE=%HOST_TRIPLE%_%HOST_ENV%"
	::set "HOST_TRIPLE=%HOST_ARCH%-%HOST_VENDOR%-%HOST_OS%
	::%dk_call% dk_printVar HOST_TRIPLE
	::echo %HOST_TRIPLE%
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_getHostTriple
	%dk_call% dk_printVar HOST_TRIPLE
goto:eof