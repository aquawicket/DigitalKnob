@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

if not defined dk_eval_DEBUG (set "dk_eval_DEBUG=0")
::############################################################################ 
::# dk_eval() 
::# 
::# 
:dk_eval 
%setlocal% 
	%dk_call% dk_debugFunc 0 
 
	set "code=%*"
	
	if "%dk_eval_DEBUG%" equ "1" (
		%dk_call% dk_echo "%lblue%dk_eval> %lcyan%%code%%clr%"
	)
	%code%
	
::	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
::	echo @echo off > "%DKCACHE_DIR%/dk_eval_TEMP.cmd"
::	echo %~1 >> "%DKCACHE_DIR%/dk_eval_TEMP.cmd"
::	
::	::############ DKBatch function call ############
::	set DKCOMMAND=%ComSpec% /c "%DKCACHE_DIR%/dk_eval_TEMP.cmd";
::	%dk_call% dk_exec %DKCOMMAND%
::	endlocal & (
::		set "dk_eval=%dk_exec%"
::	)

%endfunction% 
 
 
 
 
 
 
 
 
 
 
 
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
:DKTEST 
%setlocal% 
	%dk_call% dk_debugFunc 0 
  
	%dk_call% dk_eval echo testing dk_eval
%endfunction% 
 
