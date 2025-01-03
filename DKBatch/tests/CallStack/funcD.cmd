@echo off

:funcD
setlocal enableDelayedExpansion
%dk_call% :PrintCallStack

	echo inside funcD
	set "LOCAL_VAR=local D"

%dk_call% :PrintCallStack
%endfunction%