@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_source dk_printVar
::#####################################################################
::# dk_getHostTriple()
::#
::#
:dk_getHostTriple
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	set "HOST_OS=win"
    ::call dk_printVar HOST_OS
	
	if "%PROCESSOR_ARCHITECTURE%"=="x86"   set "HOST_ARCH=x86"
    if "%PROCESSOR_ARCHITECTURE%"=="AMD64" set "HOST_ARCH=x86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="IA64"  set "HOST_ARCH=x86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="EM64T" set "HOST_ARCH=x86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="ARM64" set "HOST_ARCH=arm64"
    ::call dk_printVar HOST_ARCH
	
	set "HOST_TRIPLE=%HOST_OS%_%HOST_ARCH%"
    ::call dk_printVar HOST_TRIPLE
    
    set "HOST_ENV=clang"
    set "HOST_TRIPLE=%HOST_TRIPLE%_%HOST_ENV%"
	::call dk_printVar HOST_TRIPLE
	::echo %HOST_TRIPLE%
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_getHostTriple
goto:eof