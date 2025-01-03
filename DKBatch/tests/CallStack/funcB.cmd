@echo off

:funcB
setlocal enableDelayedExpansion
	
	set "LOCAL_VAR=local B"
	%dk_call% :setGlobal globalVarA "GLOBAL A CHANGED"
	
	%dk_call% C:\Users\Administrator\digitalknob\Development\DKBatch\tests\VariableScope\funcC.cmd C C C

exit /b 0