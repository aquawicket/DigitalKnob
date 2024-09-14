@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_test(args)
::#
::#
:dk_test
    call dk_debugFunc 2
 setlocal
 
	%dk_call% dk_echo "1 = %~1"
    
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_test "test argument"

%endfunction%
