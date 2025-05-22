@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_fileToCRLF(file)
::#
::#
:dk_fileToCRLF
%setlocal%
	%dk_call% dk_debugFunc 1
	
	set "_file_=%~1"
    set "_file_=%_file_:/=\%"
	
    %dk_call% dk_isCRLF "%_file_%" && %dk_call% dk_notice "%_file_% is already CRLF" && %return%
    %dk_call% dk_rename "%_file_%" "%_file_%_toCRLF" OVERWRITE
    if not exist "%_file_%_toCRLF" %dk_call% dk_error "failed to rename %_file_%"
    if exist "%_file_%" %dk_call% dk_echo "cannot rename file, destination already exists"
   
    %dk_call% dk_echo "Converting %_file_% to CRLF line endings"
    type "%_file_%_toCRLF" | find /V "" > "%_file_%"
    if not exist "%_file_%" %dk_call% dk_error "failed to convert file to CRLF"
   
    %dk_call% dk_delete "%_file_%_toCRLF"
    if exist "%_file_%_toCRLF" %dk_call% dk_error "failed to delete temporary file: %_file_%_toCRLF"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_fileToCRLF "%DKBRANCH_DIR%/README.md"
%endfunction%
