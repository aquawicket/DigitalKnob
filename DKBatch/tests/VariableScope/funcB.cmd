@echo off

:funcB
setlocal enableDelayedExpansion
	call dumpvariables
	%dkcall% C:\Users\Administrator\digitalknob\Development\DKBatch\tests\VariableScope\funcC.cmd C
	call dumpvariables
exit /b 0