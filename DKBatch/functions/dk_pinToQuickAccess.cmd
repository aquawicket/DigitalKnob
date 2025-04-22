@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_pinToQuickAccess(path)
::#
::#
:dk_pinToQuickAccess
setlocal
    %dk_call% dk_debugFunc 1
	
	:: METHOD 1:  call the dk_callDKPowershell function
    %dk_call% dk_callDKPowershell dk_pinToQuickAccess "%~1"
	
	:: METHOD 2:  use dk_powershell
	::%dk_call" dk_powershell "if(-not ($(New-Object -ComObject:Shell.Application).Namespace('shell:::{679f85cb-0220-4080-b29b-5540cc05aab6}').Items() | ? {$_.Path -eq '%~1'})){$(New-Object -ComObject:Shell.Application).Namespace('%~1').Self.InvokeVerb('pintohome')}"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_pinToQuickAccess "C:/Users/Administrator/digitalknob"
%endfunction%
