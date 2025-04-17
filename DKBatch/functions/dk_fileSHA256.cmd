@echo off 
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*) 
 
::############################################################################ 
::# dk_fileSHA256(filepath) 
::# 
::# 
:dk_fileSHA256 
setlocal enableDelayedExpansion 
	%dk_call% dk_debugFunc 1 
 
	set /a count=1 
	for /f "skip=1 delims=:" %%a in ('CertUtil -hashfile "%~1" SHA256') do (
	  if !count! equ 1 set "md5=%%a"
	  set/a count+=1
	)
	set "md5=%md5: =%
	
	endlocal & (
		set "dk_fileSHA256=%md5%"
	) 
%endfunction% 
 
 
 
 
 
 
 
 
 
 
 
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
:DKTEST 
setlocal enableDelayedExpansion 
	%dk_call% dk_debugFunc 0 
  
	%dk_call% dk_fileSHA256 "DK.cmd"
	%dk_call% dk_printVar dk_fileSHA256
%endfunction% 
 
