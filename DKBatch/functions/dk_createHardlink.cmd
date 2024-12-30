@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_createHardlink(hardlink_path, pointed_to_path)
::#
::#
:dk_createHardlink
    call dk_debugFunc 2
 setlocal
	
	set "hardlink_path=%~1"
	set "hardlink_path=%hardlink_path:/=\%"
	set "pointed_to_path=%~2"
	set "pointed_to_path=%pointed_to_path:/=\%"
	
    %dk_call% dk_todo "dk_createHardlink not implemented"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_createHardlink "C:/Users/Administrator/Desktop/digitalknob" "C:/Users/Administrator/digitalknob"
%endfunction%
