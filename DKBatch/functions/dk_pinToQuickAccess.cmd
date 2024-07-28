@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_pinToQuickAccess(path)
::#
::#
:dk_pinToQuickAccess
	call dk_debugFunc
	if %__ARGC__% lss 1 call dk_error "%__FUNCTION__%:%__ARGV__% not enough arguments"
	if %__ARGC__% gtr 1 call dk_error "%__FUNCTION__%:%__ARGV__% too many arguments"
	
	:: METHOD 1:  call the DKPowershell function
	:: call dk_callPowershell dk_pinToQuickAccess "%~1"
	
	:: METHOD 2:  use dk_powershellEval
	:: call dk_powershellEval "$(New-Object -ComObject:Shell.Application).Namespace('%~1').Self.InvokeVerb('pintohome')"
	
	:: METHOD 3:  use powershell directly
	powershell /? 1>nul || call dk_error "dk_createShortcut requires powershell"
	powershell -command "$(New-Object -ComObject:Shell.Application).Namespace('%~1').Self.InvokeVerb('pintohome')"
goto:eof



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST 
	call dk_debugFunc
	
	call dk_pinToQuickAccess "C:\Users\Administrator\digitalknob"
goto:eof
