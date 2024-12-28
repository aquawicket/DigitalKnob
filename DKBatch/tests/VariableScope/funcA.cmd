@echo off

:funcA
setlocal enableDelayedExpansion
	call debugFunc

	call dumpStackLine
	
	call funcB B
	
	call dumpvariables
	
exit /b 0