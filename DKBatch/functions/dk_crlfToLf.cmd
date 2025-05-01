@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::###############################################################################
::# dk_crlfToLf(input_file, output_file)
::#
::#
:dk_crlfToLf
%setlocal%
	%dk_call% dk_debugFunc 2
	
	set "_file_=%~1"
	echo _file_ = %_file_%

	set "_file_=%_file_:\=/%"
	set "_file_=%_file_:C:=/c%"
	%dk_call% dk_callDKBash dk_crlfToLf "%_file_%"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_selectFile
	%dk_call% dk_crlfToLf "%dk_selectFile%"
	
%endfunction%
