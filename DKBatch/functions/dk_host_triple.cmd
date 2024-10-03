@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
::if not defined dk_host_triple (set "dk_host_triple=1") else (goto:eof)

::#####################################################################
::# dk_host_triple()
::#
::#	  host_os 				  = android, emscripten, ios, iossim, linux, mac, raspberry, windows
::#	  host_arch				  = arm32, arm64, x86, x86_64
::#	  host_env				  = clang, mingw, msvc, ucrt
::#	  <os>_host 			  = android_host, emscripten_host, ios_host, iossim_host, linux_host, mac_host, raspberry_host, windows_host 
::#   <os>_<arch>_host		  = android_arm64_host, emscripten_arm64_host, ios_arm64_host, iossim_arm64_host, linux_arm64_host, mac_arm64_host, raspberry_arm64_host, windows_arm64_host 
::#   <os>_<arch>_<env>_host  = android_arm64_clang_host, emscripten_arm64_clang_host, ios_arm64_clang_host, iossim_arm64_clang_host, linux_arm64_clang_host, mac_arm64_clang_host, raspberry_arm64_clang_host, windows_arm64_clang_host 
::#
:dk_host_triple
    call dk_debugFunc 0
:: setlocal
 
	::###### host_os and <os>_host ######
	set "host_os=win"
	set "%host_os%_host=1"
	
	::###### host_arch and <arch>_host ######
	if "%PROCESSOR_ARCHITECTURE%"=="x86"   set "host_arch=x86"
    if "%PROCESSOR_ARCHITECTURE%"=="AMD64" set "host_arch=x86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="IA64"  set "host_arch=x86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="EM64T" set "host_arch=x86_64"
    if "%PROCESSOR_ARCHITECTURE%"=="ARM64" set "host_arch=arm64"
	set "%host_arch%_host=1"             
	
	::###### host_env and <env>_host ######
	set "host_env=clang"
	if not defined host_env goto end_host_env
		set "%host_env%_host=1"
    :end_host_env
	
	::###### host_triple and <triple>_host ######
	if not defined host_arch goto end_host_arch
		set "host_triple=%host_os%_%host_arch%"
		set "%host_triple%_host=1"
	:end_host_arch
	
	if not defined host_env goto end_host_env
		set "host_triple=%host_os%_%host_arch%_%host_env%"
		set "%host_triple%_host=1"
	:end_host_env
    
::%DEBUG%
::	%dk_call% dk_printVar host_os
::	%dk_call% dk_printVar %host_os%_host
::	
::	%dk_call% dk_printVar host_arch 
::	%dk_call% dk_printVar %host_arch%_host
::	%dk_call% dk_printVar %host_os%_%host_arch%_host
::	
::	%dk_call% dk_printVar host_env
::	%dk_call% dk_printVar %host_env%_host
::	%dk_call% dk_printVar %host_os%_%host_arch%_%host_env%_host
::	
::	%dk_call% dk_printVar host_triple
::	%dk_call% dk_printVar %host_triple%_host
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_host_triple
	
	%dk_call% dk_printVar host_os
	%dk_call% dk_printVar %host_os%_host
	
	%dk_call% dk_printVar host_arch 
	%dk_call% dk_printVar %host_arch%_host
	%dk_call% dk_printVar %host_os%_%host_arch%_host
	
	%dk_call% dk_printVar host_env
	%dk_call% dk_printVar %host_env%_host
	%dk_call% dk_printVar %host_os%_%host_arch%_%host_env%_host
	
	%dk_call% dk_printVar host_triple
	%dk_call% dk_printVar %host_triple%_host
%endfunction%