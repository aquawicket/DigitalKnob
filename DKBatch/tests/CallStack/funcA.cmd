@echo off

:funcA
setlocal enableDelayedExpansion

	echo inside funcA
	set "LOCAL_VAR=local A"
	%dk_call% funcB.cmd B B

%endfunction%
