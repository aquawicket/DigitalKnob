@echo off

:funcD
setlocal enableDelayedExpansion
%dk_call% :PrintCallStack

	%dk_call% :PrintCallStack
	set "LOCAL_VAR=local D"
	%dk_call% :PrintCallStack

%dk_call% :PrintCallStack
%endfunction%