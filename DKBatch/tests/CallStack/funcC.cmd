@echo off

:funcC
setlocal enableDelayedExpansion

	echo inside funcC
	::set "LOCAL_VAR=local C"
	%dk_call% funcC2 C2 C2
	%dk_call% funcD D D D D

%endfunction%