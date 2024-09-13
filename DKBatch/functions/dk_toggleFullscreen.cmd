@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_fullscreen()
::#
::#
:dk_toggleFullscreen
    call dk_debugFunc 0
 setlocal
 
    (title batchfs) ^& Mshta.exe vbscript:Execute("Set Ss=CreateObject(""WScript.Shell""):Ss.AppActivate ""batchfs"":Ss.SendKeys ""{F11}"":close") ^& !@getdim!"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_toggleFullscreen
    %dk_call% dk_sleep 3
    %dk_call% dk_toggleFullscreen
%endfunction%
