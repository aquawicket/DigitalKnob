@echo off

:funcC2
setlocal enableDelayedExpansion
%dk_call% :PrintCallStack

	echo inside funcC2
	set "LOCAL_VAR=local C2"

%dk_call% :PrintCallStack
%endfunction%