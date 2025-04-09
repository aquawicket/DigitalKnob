@echo off
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_makeDirectory(path)
::#
::#
:dk_makeDirectory
setlocal
    %dk_call% dk_debugFunc 1

	set "_path_=%~1"
    if exist "%_path_%" (
		%dk_call% dk_warning "%_path_% already exists"
		%return%
	)
	
    mkdir "%_path_:/=\%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_makeDirectory "CreatedDirectory"
%endfunction%
