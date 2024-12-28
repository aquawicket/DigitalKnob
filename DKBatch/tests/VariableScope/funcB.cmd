@echo off

:funcB
setlocal enableDelayedExpansion
	call debugFunc

	call dumpStackLine
	
	call funcC C
	
	call dumpvariables
	
exit /b 0