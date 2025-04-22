@echo off 
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*) 
 
::############################################################################ 
::# dk_trim() 
::# 
::#		Reference: https://stackoverflow.com/a/26079981
::#
:dk_trim 
setlocal enableDelayedExpansion 
	%dk_call% dk_debugFunc 0 
 
	set Params=dummy %*
	for /f "tokens=1*" %%a in ("!Params!") do endlocal & set dk_trim=%%b
 
%endfunction% 
 
 
 
 
 
 
 
 
 
 
 
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
:DKTEST 
setlocal enableDelayedExpansion 
	%dk_call% dk_debugFunc 0 
  
	set myValue=   a b c  
	%dk_call% dk_trim %myValue%
	%dk_call% dk_echo "myValue = '%myValue%'"
	%dk_call% dk_echo "dk_trim = '%dk_trim%'"
	
	set myValue=   a \ / : * ? " ' < > | ` ~ @ # $ [ ] & ( ) + - _ = z    
	call dk_trim %myValue%
	echo myValue = '%myValue%'
	echo dk_trim = '%dk_trim%'
%endfunction% 
 
