@echo off
Chcp 65001>nul
setlocal enableDelayedExpansion
call dk_call %0

:main
%dk_call% :PrintCallStack

	%dk_call% :setGlobal globalVarA GLOBALA
	%dk_call% :setGlobal globalVarB GLOBALB
	%dk_call% funcA A
	
%dk_call% :PrintCallStack
pause
%endfunction%








