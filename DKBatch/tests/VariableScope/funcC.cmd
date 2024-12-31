@echo off

:funcC
setlocal enableDelayedExpansion
	::call printStack
	
	set "LOCAL_VAR=local C"
	%dkcall% funcC2 C2 C2
	%dkcall% funcD D D D D

	::call printStack
exit /b 0