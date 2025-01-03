@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_downloadDK()
::#
::#
:dk_downloadDK
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_download "https://github.com/aquawicket/DigitalKnob/archive/refs/heads/Development.zip"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_downloadDK
%endfunction%
