@echo off

:funcA
setlocal enableDelayedExpansion

	%dkcall% funcB.cmd B

exit /b 0