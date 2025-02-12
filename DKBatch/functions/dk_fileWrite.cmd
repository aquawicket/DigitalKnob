@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::##################################################################################
::# dk_fileWrite(file, string)
::#
::#
:dk_fileWrite
setlocal
	%dk_call% dk_debugFunc 2

	set "_file_=%~1"
	set "_file_=%_file_:/=\%"
	
    echo %~2 > "%_file_%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_fileWrite "dk_fileWrite_TEST.txt" "string written by dk_fileWrite"
%endfunction%
