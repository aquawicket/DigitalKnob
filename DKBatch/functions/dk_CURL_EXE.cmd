@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_CURL_EXE()
::#
::#
:dk_CURL_EXE
::setlocal
	%dk_call% dk_debugFunc 0
   
    if defined CURL_EXE (%return%)
    
	%dk_call% dk_findProgram CURL_EXE "curl.exe" "%WINDIR%\system32"

%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_CURL_EXE
    %dk_call% dk_printVar CURL_EXE
%endfunction%
