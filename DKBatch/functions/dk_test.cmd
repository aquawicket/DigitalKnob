@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_test(args)
::#
::#
:dk_test
 setlocal
    call dk_debugFunc 2
    
	%dk_call% dk_echo "1 = %~1"
    
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_test "test argument"

%endfunction%
