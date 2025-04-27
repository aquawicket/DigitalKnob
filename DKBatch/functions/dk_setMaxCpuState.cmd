@echo off 
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*) 
 
::############################################################################ 
::# dk_setMaxCpuState(<percent>) 
::# 
::# 
:dk_setMaxCpuState 
setlocal enableDelayedExpansion 
	%dk_call% dk_debugFunc 0 
 
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\bc5038f7-23e0-4960-96da-33abaf5935ec" "ValueMax" "REG_DWORD" "%~1"
%endfunction% 
 
 
 
 
 
 
 
 
 
 
 
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
:DKTEST 
setlocal enableDelayedExpansion 
	%dk_call% dk_debugFunc 0 
  
	%dk_call% dk_setMaxCpuState 90
%endfunction% 
 
