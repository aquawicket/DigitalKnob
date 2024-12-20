@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getGlobal(name)
::#
::#
:dkgetGlobal
    call dk_debugFunc 1
 setlocal
 
	for /F "tokens=1,2* skip=2" %%a in ('%SystemRoot%\System32\reg.exe QUERY HKCU\Environment /v %~1 2^>nul') do if /I "%%a" == "%~1" endlocal & set "%1=%%c"
	
::debug
::    %dk_call% dk_printVar %1
%endfunction%


::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST 
    call dk_debugFunc 0
 setlocal
	
	%dk_call% dk_echo "initial value of myGlobalVar"
	%dk_call% dk_echo "myGlobalVar = %myGlobalVar%"
	
	echo:
	%dk_call% dk_echo "calling dk_getGlobal"
	%dk_call% dk_getGlobal myGlobalVar
	%dk_call% dk_echo "myGlobalVar = %myGlobalVar%"

%endfunction%
