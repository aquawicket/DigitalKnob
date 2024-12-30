@echo off

:funcC
setlocal enableDelayedExpansion
	call printStack
	
	set "LOCAL_VAR=local C"
	%dkcall% funcD D

	call printStack
exit /b 0