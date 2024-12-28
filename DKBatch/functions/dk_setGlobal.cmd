@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_setGlobal(name, value)
::#
::#
:dk_setGlobal
    call dk_debugFunc 1 2
 setlocal
 
    ::%SystemRoot%\System32\reg.exe ADD HKCU\Environment /f /v %~1 /d "%~2" >nul
	::setx %~1 "%~2" >nul
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	echo %~2 > %DKCACHE_DIR%\%~1.var
	endlocal & set "%~1=%~2"
	
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
	%dk_call% dk_echo "calling dk_setGlobal"
	%dk_call% dk_setGlobal myGlobalVar "test value in dk_setGlobal :DKTEST"
	%dk_call% dk_echo "myGlobalVar = %myGlobalVar%"
%endfunction%
