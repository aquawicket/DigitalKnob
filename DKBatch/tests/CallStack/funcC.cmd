@echo off

:funcC
setlocal enableDelayedExpansion
	
	::set "LOCAL_VAR=local C"
	%dkcall% funcC2 C2 C2
	%dkcall% funcD D D D D

exit /b 0