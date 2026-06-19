@echo off

:funcB
setlocal enableDelayedExpansion
	
	echo inside funcB
	set "LOCAL_VAR=local B"
	%dk_call% setGlobal globalVarA "GLOBAL A CHANGED"
	%dk_call% dk_validate DKBRANCH_DIR	%dk_call% dk_DKBRANCH_DIR
	%dk_call% %DKBRANCH_DIR%/DKBatch/tests/CallStack/funcC.cmd C C C

%endfunction%