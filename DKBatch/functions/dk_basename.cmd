@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_basename(path rtn_var)
::#
::#    https://en.wikipedia.org/wiki/Basename
::#
:dk_basename
 setlocal
    call dk_debugFunc 2
    
    set "_input_=%1"
    set "_input_=%_input_:"=%"
    if [%_input_:~-1,1%] == [\] set "_input=%_input_:~0,-1%"
    if [%_input_:~-1,1%] == [/] set "_input=%_input_:~0,-1%"
    endlocal & for %%Z in ("%_input_%") do set "%2=%%~nxZ"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_set myPath "C:\Windows\System32\test.v123.zip" 
    %dk_call% dk_basename "%myPath%" basename
    %dk_call% dk_printVar basename
    
    %dk_call% dk_set myPathB "TEST" 
    %dk_call% dk_basename "%myPathB%" basenameB
    %dk_call% dk_printVar basenameB
    
    set "myPathC=https://ia802200.us.archive.org/22/items/windows-7-pesuper-lite-50-mb/Windows7PESuper%20Lite50MB.iso"
    %dk_call% dk_basename "%myPathC%" basenameC
    %dk_call% dk_printVar basenameC
%endfunction%
