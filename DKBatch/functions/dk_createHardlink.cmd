@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_createHardlink(hardlink_path, pointed_to_path)
::#
::#
:dk_createHardlink
setlocal
	%dk_call% dk_debugFunc 2
	
	set "hardlink_path=%~1"
	set "pointed_to_path=%~2"
	
    %dk_call% dk_todo "dk_createHardlink not implemented"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_createHardlink "C:/Users/Administrator/Desktop/digitalknob" "C:/Users/Administrator/digitalknob"
%endfunction%
