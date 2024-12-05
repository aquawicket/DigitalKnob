@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_urlEncode(url rtn_var)
::#
::#
:dk_urlEncode
    call dk_debugFunc 1 2
 setlocal
 
    %dk_call% dk_todo "dk_urlEncode"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_urlEncode https%3A%2F%2Ftwitter.com%2FSomeProfile%2Fstatus%2F1234567890
%endfunction%
