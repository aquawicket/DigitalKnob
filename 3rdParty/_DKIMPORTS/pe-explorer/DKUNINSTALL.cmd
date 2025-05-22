@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKUNINSTALL()
::#
:DKUNINSTALL
%%setlocal%%
	%dk_call% dk_debugFunc 0
	
	"C:/Program Files (x86)/PE Explorer/unins000.exe"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%%setlocal%%
	%dk_call% dk_debugFunc 0

	%dk_call% DKUNINSTALL
%endfunction%