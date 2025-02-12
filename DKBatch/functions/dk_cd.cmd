@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_cd(directory)
::#
::#
:dk_cd
setlocal
    %dk_call% dk_debugFunc 0 1

	set "_directory_=%~1"
	set "_directory_=%_directory_:/=\%"
	
	title %_directory_%
    cd "%_directory_%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    ::%dk_call% dk_cd %DIGITALKNOB_DIR%
	%dk_call% dk_cd C:/Windows
%endfunction%
