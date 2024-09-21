@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#####################################################################
::# dk_getHostTriple()
::#
::#	  host_os 				  = android, emscripten, ios, iossim, linux, mac, raspberry, windows
::#	  HOST_OS 				  = ANDROID, EMSCRIPTEN, IOS, IOSSIM, LINUX, MAC, RASPBERRY, WINDOWS
::#	  host_arch				  = arm32, arm64, x86, x86_64
::#	  HOST_ARCH				  = ARM32, ARM64, X86, X86_64
::#	  host_env				  = clang, mingw, msvc, ucrt
::#	  HOST_ENV				  = CLANG, MINGW, MSVC, UCRT
::#	  <os>_host 			  = android_host, emscripten_host, ios_host, iossim_host, linux_host, mac_host, raspberry_host, windows_host 
::#	  <OS>_HOST 			  = ANDROID_HOST, EMSCRIPTEN_HOST, IOS_HOST, IOSSIM_HOST, LINUX_HOST, MAC_HOST, RASPBERRY_HOST, WINDOWS_HOST 
::#   <os>_<arch>_host		  = android_arm64_host, emscripten_arm64_host, ios_arm64_host, iossim_arm64_host, linux_arm64_host, mac_arm64_host, raspberry_arm64_host, windows_arm64_host
::#   <OS>_<ARCH>_HOST		  = ANDROID_ARM64_HOST, EMSCRIPTEN_ARM64_HOST, IOS_ARM64_HOST, IOSSIM_ARM64_HOST, LINUX_ARM64_HOST, MAC_ARM64_HOST, RASPBERRY_ARM64_HOST, WINDOWS_ARM64_HOST 
::#   <OS>_<ARCH>_<ENV>_HOST  = ANDROID_ARM64_CLANG_HOST, EMSCRIPTEN_ARM64_CLANG_HOST, IOS_ARM64_CLANG_HOST, IOSSIM_ARM64_CLANG_HOST, LINUX_ARM64_CLANG_HOST, MAC_ARM64_CLANG_HOST, RASPBERRY_ARM64_CLANG_HOST, WINDOWS_ARM64_CLANG_HOST 
::#
:dk_getHostTriple
    call dk_debugFunc 0
:: setlocal
 
	:: Variable names are not case sensitive in batch
	set "host_os=win"
	%dk_call% dk_assert host_os
::	set "%host_os%_host=1"
	%dk_call% dk_toUpper %host_os% HOST_OS
::	set "HOST_OS=%HOST_OS%"
	set "%HOST_OS%_HOST=1"
	
	if "%PROCESSOR_ARCHITECTURE%"=="x86"   set "host_arch=x86"
    if "%PROCESSOR_ARCHITECTURE%"=="AMD64" set "host_arch=x86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="IA64"  set "host_arch=x86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="EM64T" set "host_arch=x86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="ARM64" set "host_arch=arm64"
	%dk_call% dk_assert host_arch
::	set "%host_arch%_host=1"
	%dk_call% dk_toUpper %host_arch% HOST_ARCH
	set "HOST_ARCH=%HOST_ARCH%"
	set "%HOST_ARCH%_HOST=1"             
	
	set "host_env=clang"
	::%dk_call% dk_assert host_env
	if not defined host_env goto:end_host_env
		set "%host_env%_host=1"
		%dk_call% dk_toUpper %host_env% HOST_ENV
		set "HOST_ENV=%HOST_ENV%"
		set "%HOST_ENV%_HOST=1"
    :end_host_env
	
	::### set host_triple ###
	if not defined host_arch goto:end_host_arch
::		set "host_triple=%host_os%_%host_arch%"
		set "HOST_TRIPLE=%HOST_OS%_%HOST_ARCH%"
::		set "%host_triple%_host=1"
		set "%HOST_TRIPLE%_HOST=1"
	:end_host_arch
	
	if not defined host_env goto:end_host_env
::		set "host_triple=%host_os%_%host_arch%_%host_env%"
		set "HOST_TRIPLE=%HOST_OS%_%HOST_ARCH%_%HOST_ENV%"
::		set "%host_triple%_host=1"	
		set "%HOST_TRIPLE%_HOST=1"
	:end_host_env
	
    set "DK_HOST_OS=win"
    
    if "%PROCESSOR_ARCHITECTURE%"=="x86"   set "DK_HOST_ARCH=x86"
    if "%PROCESSOR_ARCHITECTURE%"=="AMD64" set "DK_HOST_ARCH=x86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="IA64"  set "DK_HOST_ARCH=x86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="EM64T" set "DK_HOST_ARCH=x86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="ARM64" set "DK_HOST_ARCH=arm64"
    set "DK_HOST_TRIPLE=%DK_HOST_OS%_%DK_HOST_ARCH%"
    
    set "DK_HOST_ENV=clang"
    set "DK_HOST_TRIPLE=%DK_HOST_TRIPLE%_%DK_HOST_ENV%"
    
%DEBUG%
	%dk_call% dk_printVar host_os
	%dk_call% dk_printVar HOST_OS
	%dk_call% dk_printVar %host_os%_host
	%dk_call% dk_printVar %HOST_OS%_HOST
	%dk_call% dk_printVar host_arch
	%dk_call% dk_printVar HOST_ARCH 
	%dk_call% dk_printVar %host_arch%_host 
	%dk_call% dk_printVar %HOST_ARCH%_HOST
	%dk_call% dk_printVar host_env
	%dk_call% dk_printVar HOST_ENV
	%dk_call% dk_printVar %host_env%_host
	%dk_call% dk_printVar %HOST_ENV%_HOST
	%dk_call% dk_printVar %host_triple%_host
	%dk_call% dk_printVar %HOST_TRIPLE%_HOST
	%dk_call% dk_printVar %host_triple%_host
	%dk_call% dk_printVar %HOST_TRIPLE%_HOST
	%dk_call% dk_printVar host_triple
	%dk_call% dk_printVar HOST_TRIPLE
	%dk_call% dk_printVar %host_triple%_host
	%dk_call% dk_printVar %HOST_TRIPLE%_HOST
	%dk_call% dk_printVar DK_HOST_OS
	%dk_call% dk_printVar DK_HOST_ARCH
	%dk_call% dk_printVar DK_HOST_TRIPLE
	%dk_call% dk_printVar DK_HOST_TRIPLE
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_getHostTriple
    %dk_call% dk_printVar DK_HOST_TRIPLE
%endfunction%