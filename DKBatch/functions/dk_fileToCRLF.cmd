@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_fileToCRLF(file)
::#
::#
:dk_fileToCRLF
    call dk_debugFunc 1
 setlocal
 
    if "%~n1" equ "dk_echo" %return%
    if "%~n1" equ "dk_log" %return%
    if "%~n1" equ "dk_info" %return%
	
	set "_file_=%~1"
    set "_file_=%_file_:/=\%"
	
    %dk_call% dk_isCRLF "%_file_%" && %dk_call% dk_echo "%_file_% is already CRLF" && %return%
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
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_fileToCRLF dk_appendArgs.cmd
%endfunction%
