@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#####################################################################
::# dk_HOST_TRIPLE()
::#
::#	  HOST_OS 				  = ANDROID, EMSCRIPTEN, IOS, IOSSIM, LINUX, MAC, RASPBERRY, WINDOWS
::#	  HOST_ARCH				  = ARM32, ARM64, X86, X86_64
::#	  HOST_ENV				  = CLANG, MINGW, MSVC, UCRT
::#	  <OS>_HOST 			  = ANDROID_HOST, EMSCRIPTEN_HOST, IOS_HOST, IOSSIM_HOST, LINUX_HOST, MAC_HOST, RASPBERRY_HOST, WINDOWS_HOST 
::#   <OS>_<ARCH>_HOST		  = ANDROID_ARM64_HOST, EMSCRIPTEN_ARM64_HOST, IOS_ARM64_HOST, IOSSIM_ARM64_HOST, LINUX_ARM64_HOST, MAC_ARM64_HOST, RASPBERRY_ARM64_HOST, WINDOWS_ARM64_HOST 
::#   <OS>_<ARCH>_<ENV>_HOST  = ANDROID_ARM64_CLANG_HOST, EMSCRIPTEN_ARM64_CLANG_HOST, IOS_ARM64_CLANG_HOST, IOSSIM_ARM64_CLANG_HOST, LINUX_ARM64_CLANG_HOST, MAC_ARM64_CLANG_HOST, RASPBERRY_ARM64_CLANG_HOST, WINDOWS_ARM64_CLANG_HOST 
::#
:dk_HOST_TRIPLE
    call dk_debugFunc 0
:: setlocal
 
	::###### HOST_OS and <OS>_HOST ######
	set "HOST_OS=WIN"
	set "%HOST_OS%_HOST=1"
	
	::###### HOST_ARCH and <ARCH>_HOST ######
	if "%PROCESSOR_ARCHITECTURE%"=="x86"   set "HOST_ARCH=X86"
    if "%PROCESSOR_ARCHITECTURE%"=="AMD64" set "HOST_ARCH=X86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="IA64"  set "HOST_ARCH=X86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="EM64T" set "HOST_ARCH=X86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="ARM64" set "HOST_ARCH=ARM64"
	set "%HOST_ARCH%_HOST=1"             
	
	::###### HOST_ENV and <ENV>_HOST ######
	set "HOST_ENV=CLANG"
	if not defined HOST_ENV goto:END_HOST_ENV
		set "%HOST_ENV%_HOST=1"
    :END_HOST_ENV
	
	::###### HOST_TRIPLE and <TRIPLE>_HOST ######
	if not defined HOST_ARCH goto:END_HOST_ARCH
		set "HOST_TRIPLE=%HOST_OS%_%HOST_ARCH%"
		set "%HOST_TRIPLE%_HOST=1"
	:END_HOST_ARCH
	
	if not defined HOST_ENV goto:END_HOST_ENV
		set "HOST_TRIPLE=%HOST_OS%_%HOST_ARCH%_%HOST_ENV%"
		set "%HOST_TRIPLE%_HOST=1"
	:END_HOST_ENV
    
::%DEBUG%
	%dk_call% dk_printVar HOST_OS
	%dk_call% dk_printVar %HOST_OS%_HOST
	%dk_call% dk_printVar HOST_ARCH 
	%dk_call% dk_printVar %HOST_ARCH%_HOST
	%dk_call% dk_printVar HOST_ENV
	%dk_call% dk_printVar %HOST_ENV%_HOST
	%dk_call% dk_printVar HOST_TRIPLE
	%dk_call% dk_printVar %HOST_TRIPLE%_HOST
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_HOST_TRIPLE
	%dk_call% dk_printVar HOST_TRIPLE
%endfunction%