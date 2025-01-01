@echo off

:funcB
setlocal enableDelayedExpansion
	
	set "LOCAL_VAR=local B"
	call setGlobal globalVarA "GLOBAL A CHANGED"
	
	%dkcall% C:\Users\Administrator\digitalknob\Development\DKBatch\tests\VariableScope\funcC.cmd C C C

exit /b 0