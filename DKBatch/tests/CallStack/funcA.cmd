@echo off

:funcA
setlocal enableDelayedExpansion
	
	set "LOCAL_VAR=local A"
	%dk_call% funcB.cmd B B

exit /b 0