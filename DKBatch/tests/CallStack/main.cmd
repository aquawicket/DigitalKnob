@echo off
setlocal enableDelayedExpansion
call dk_call %0

:main

	%dk_call% setGlobal globalVarA GLOBALA
	%dk_call% setGlobal globalVarB GLOBALB
	%dk_call% funcA A
	
pause
%endfunction%








