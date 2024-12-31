@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_setGlobal(name, value)
::#
::#
:dk_setGlobal
 setlocal
    ::call dk_debugFunc 1 2

	:: prefix the variable name with GLOBAL_ and assign a value
	set "GLOBAL_%~1=%~2"
	
	:: place all vairable with a GLOBAL_ prefix into %GLOBAL_FILE%
	if defined GLOBAL_ set GLOBAL_ > "%GLOBAL_FILE%"
	set GLOBAL_ > "%GLOBAL_FILE%"

	endlocal & set %~1=%~2
	set %~1=%~2
%endfunction%


::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
::    %dk_call% dk_debugFunc 0
 setlocal enableDelayedExpansion
	
	set "myGlobalVar=init_value"
    %dk_call% dk_echo "initial value of myGlobalVar"
	%dk_call% dk_echo "myGlobalVar = %myGlobalVar%"
	
	echo:
	%dk_call% dk_echo "calling dk_setGlobal"
	%dk_call% dk_setGlobal myGlobalVar "test value in dk_setGlobal :DKTEST"
endlocal
	%dk_call% dk_echo "myGlobalVar = %myGlobalVar%"
%endfunction%
