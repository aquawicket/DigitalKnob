@echo off

:funcA
setlocal enableDelayedExpansion
	call dumpvariables
	%dkcall% funcB.cmd B
	call dumpvariables
exit /b 0