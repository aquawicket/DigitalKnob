@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_createSoftlink(softlink_path, pointed_to_path)
::#
::#
:dk_createSoftlink
    call dk_debugFunc 2
 setlocal
 
    %dk_call% dk_todo "dk_createSoftlink not implemented"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_createSoftlink "C:\Users\Administrator\Desktop\digitalknob" "C:\Users\Administrator\digitalknob"
%endfunction%
