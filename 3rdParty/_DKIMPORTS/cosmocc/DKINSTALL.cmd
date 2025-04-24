@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
    %dk_call% dk_cmakeEval "dk_load(%DKIMPORTS_DIR%/cosmocc/DKINSTALL.cmake)" "COSMOCC_C_COMPILER;COSMOCC_CXX_COMPILER"
	%dk_call% dk_assertVar COSMOCC_C_COMPILER
	%dk_call% dk_assertVar COSMOCC_CXX_COMPILER
	
	endlocal & (
		set "COSMOCC_C_COMPILER=%COSMOCC_C_COMPILER%"
		set "COSMOCC_CXX_COMPILER=%COSMOCC_CXX_COMPILER%"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%
