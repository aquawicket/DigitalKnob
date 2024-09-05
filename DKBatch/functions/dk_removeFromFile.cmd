@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::##################################################################################
::# dk_removeFromFile(string file)
::#
::#
:dk_removeFromFile
 setlocal
    call dk_debugFunc 2

    sed -i -e "/$1/d" $2
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_removeFromFile
%endfunction%
