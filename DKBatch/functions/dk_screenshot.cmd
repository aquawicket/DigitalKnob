@echo off 
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*) 
 
::############################################################################ 
::# dk_screenshot() 
::# 
::# 
:dk_screenshot 
setlocal enableDelayedExpansion 
	%dk_call% dk_debugFunc 0 
 
	%dk_call% dk_callDKPowershell dk_screenshot
%endfunction% 
 
 
 
 
 
 
 
 
 
 
 
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
:DKTEST 
setlocal enableDelayedExpansion 
	%dk_call% dk_debugFunc 0 
  
	%dk_call% dk_screenshot 
%endfunction% 
 
