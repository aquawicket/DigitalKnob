@echo off

:funcB
setlocal enableDelayedExpansion
	
	echo inside funcB
	set "LOCAL_VAR=local B"
	%dk_call% setGlobal globalVarA "GLOBAL A CHANGED"
	%dk_call% %USERPROFILE%/digitalknob/Development/DKBatch/tests/CallStack/funcC.cmd C C C

%endfunction%