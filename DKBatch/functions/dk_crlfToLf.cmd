@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::###############################################################################
::# dk_crlfToLf(input_file, output_file)
::#
::#
:dk_crlfToLf
setlocal
	%dk_call% dk_debugFunc 2
	
	set "_file_=%~1"
	echo _file_ = %_file_%

	set "_file_=%_file_:\=/%"
	set "_file_=%_file_:C:=/c%"
	%dk_call% dk_callDKBash dk_crlfToLf "%_file_%"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_selectFile _file_
	%dk_call% dk_crlfToLf "%_file_%"
	
%endfunction%
