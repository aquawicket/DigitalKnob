@echo off

:funcC
setlocal enableDelayedExpansion
	call debugFunc

	call dumpStackLine
	
	call funcD D
	
	call dumpvariables
	
exit /b 0