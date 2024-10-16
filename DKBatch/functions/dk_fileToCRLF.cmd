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
    
    %dk_call% dk_isCRLF "%~1" && %dk_call% dk_echo "%~1 is already CRLF" && %return%
    %dk_call% dk_rename "%~1" "%~1_toCRLF" OVERWRITE
    if not exist "%~1_toCRLF" %dk_call% dk_error "failed to rename %~1"
    if exist "%~1" %dk_call% dk_echo "cannot rename file, destination already exists"
    
    %dk_call% dk_echo "Converting %~1 to CRLF line endings"
    type "%~1_toCRLF" | find /V "" > "%~1"
    if not exist "%~1" %dk_call% dk_error "failed to convert file to CRLF"
    
    %dk_call% dk_delete "%~1_toCRLF"
    if exist "%~1_toCRLF" %dk_call% dk_error "failed to delete temporary file: %~1_toCRLF"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_fileToCRLF dk_appendArgs.cmd
%endfunction%
