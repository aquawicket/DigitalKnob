@echo off

:funcA
setlocal enableDelayedExpansion
%dk_call% :PrintCallStack	

	set "LOCAL_VAR=local A"
	%dk_call% funcB.cmd B B

%dk_call% :PrintCallStack
%endfunction%