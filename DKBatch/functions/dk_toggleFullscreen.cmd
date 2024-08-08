@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_fullscreen()
::#
::#
:dk_toggleFullscreen
	call dk_debugFunc 0
	
	(title batchfs) ^& Mshta.exe vbscript:Execute("Set Ss=CreateObject(""WScript.Shell""):Ss.AppActivate ""batchfs"":Ss.SendKeys ""{F11}"":close") ^& !@getdim!"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_toggleFullscreen
	call dk_sleep 3
	call dk_toggleFullscreen
goto:eof
