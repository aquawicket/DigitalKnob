@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKUNINSTALL
::#
::#
:DKUNINSTALL
::%setlocal%
    %dk_call% dk_debugFunc 0

	echo:
	echo ### Uninstalling python ###
	MsiExec.exe /uninstall {A5F504DF-2ED9-4A2D-A2F3-9D2750DD42D6} /quiet
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
    %dk_call% DKUNINSTALL
%endfunction%
