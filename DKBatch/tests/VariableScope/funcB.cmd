@echo off

:funcB
setlocal enableDelayedExpansion
	call printStack
	
	set "LOCAL_VAR=local B"
	call setGlobal globalVarA "GLOBAL A CHANGED"
	
	%dkcall% C:\Users\Administrator\digitalknob\Development\DKBatch\tests\VariableScope\funcC.cmd C

	call printStack
exit /b 0