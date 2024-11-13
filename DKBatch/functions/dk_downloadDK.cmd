@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_downloadDK()
::#
::#
:dk_downloadDK
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_download "https://github.com/aquawicket/DigitalKnob/archive/refs/heads/Development.zip"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_downloadDK
%endfunction%
