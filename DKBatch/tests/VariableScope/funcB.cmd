@echo off

:funcB
setlocal enableDelayedExpansion

	%dkcall% C:\Users\Administrator\digitalknob\Development\DKBatch\tests\VariableScope\funcC.cmd C

exit /b 0