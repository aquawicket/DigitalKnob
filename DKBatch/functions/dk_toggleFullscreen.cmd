@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_fullscreen()
::#
::#
:dk_toggleFullscreen
 setlocal
	call dk_debugFunc 0
	
	(title batchfs) ^& Mshta.exe vbscript:Execute("Set Ss=CreateObject(""WScript.Shell""):Ss.AppActivate ""batchfs"":Ss.SendKeys ""{F11}"":close") ^& !@getdim!"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_toggleFullscreen
	%dk_call% dk_sleep 3
	%dk_call% dk_toggleFullscreen
goto:eof
