@echo off

:funcC
setlocal enableDelayedExpansion
	call dumpvariables
	%dkcall% funcD D
	call dumpvariables
exit /b 0