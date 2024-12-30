@echo off

:funcA
setlocal enableDelayedExpansion
	::call printStack
	
	set "LOCAL_VAR=local A"
	%dkcall% funcB.cmd B

	::call printStack
exit /b 0