@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

 
::############################################################################ 
::# dk_tee() 
::# 
::# 
:dk_tee 
setlocal enableDelayedExpansion 
	%dk_call% dk_debugFunc 2
 
	set "command=%~1"
	set "fileout=%~2"
	
	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
	%POWERSHELL_EXE% "%command% 2>&1 | tee %fileout%"
	
%endfunction% 
 
 
 
 
 
 
 
 
 
 
 
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
:DKTEST 
setlocal enableDelayedExpansion 
	%dk_call% dk_debugFunc 0 
  
	%dk_call% dk_tee "cmd /c dir nonexisent" "C:\TEE.txt"
%endfunction% 
 
