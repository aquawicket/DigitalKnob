@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

 
::############################################################################ 
::# dk_evalDKBatch() 
::# 
::# 
:dk_evalDKBatch 
setlocal enableDelayedExpansion 
	%dk_call% dk_debugFunc 0 
 
	%dk_validate% DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	echo @echo off > "%DKCACHE_DIR%/dk_evalDKBatch_TEMP.cmd"
	echo %~1 >> "%DKCACHE_DIR%/dk_evalDKBatch_TEMP.cmd"
	
	::############ DKJavascript function call ############
	set DKCOMMAND=%ComSpec% /c "%DKCACHE_DIR%/dk_evalDKBatch_TEMP.cmd";
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_evalDKBatch=%dk_exec%"
	)

%endfunction% 
 
 
 
 
 
 
 
 
 
 
 
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
:DKTEST 
setlocal enableDelayedExpansion 
	%dk_call% dk_debugFunc 0 
  
	%dk_call% dk_evalDKBatch "echo 'testing dk_evalDKJavascript'"
%endfunction% 
 
