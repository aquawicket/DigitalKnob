@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::call dk_source dk_powershellEval
::################################################################################
::# dk_pinToQuickAccess(path)
::#
::#
:dk_pinToQuickAccess
	call dk_debugFunc 1
	
	:: METHOD 1:  call the DKPowershell function (FIXME: ERROR: runs twice)
	::%dk_call% dk_callPowershell dk_pinToQuickAccess "%~1"
	
	:: METHOD 2:  use dk_powershellEval
	%dk_call% dk_powershellEval "$(New-Object -ComObject:Shell.Application).Namespace('%~1').Self.InvokeVerb('pintohome')"
	
	:: METHOD 3:  use powershell directly (fastest)
	::powershell /? 1>nul || %dk_call% dk_error "dk_createShortcut requires powershell"
	::powershell -command "$(New-Object -ComObject:Shell.Application).Namespace('%~1').Self.InvokeVerb('pintohome')"
goto:eof



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST 
	call dk_debugFunc 0
	
	%dk_call% dk_pinToQuickAccess "C:\Users\Administrator\digitalknob"
goto:eof
