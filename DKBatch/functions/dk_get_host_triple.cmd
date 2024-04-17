::dk_include_guard()

::#####################################################################
::# dk_get_host_triple()
::#
::#
:dk_get_host_triple () {
	call:dk_verbose "dk_get_host_triple(%*)"
	
	set HOST_OS=win
    call:dk_debug HOST_OS
	
	if %PROCESSOR_ARCHITECTURE%==x86 set HOST_ARCH=x86
    if %PROCESSOR_ARCHITECTURE%==AMD64 set HOST_ARCH=x86_64
    if %PROCESSOR_ARCHITECTURE%==IA64  set HOST_ARCH=x86_64
    if %PROCESSOR_ARCHITECTURE%==EM64T set HOST_ARCH=x86_64
    if %PROCESSOR_ARCHITECTURE%==ARM64  set HOST_ARCH=arm64
    call:dk_debug HOST_ARCH
	
	set HOST_TRIPLE=%HOST_OS%_%HOST_ARCH%
    call:dk_debug HOST_TRIPLE
    
    set HOST_ENV=clang
    set HOST_TRIPLE=%HOST_TRIPLE%_%HOST_ENV%
	call:dk_debug HOST_TRIPLE
goto:eof