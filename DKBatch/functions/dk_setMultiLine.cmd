@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################
 
 
::############################################################################ 
::# dk_setMultiLine() 
::# 
::# 
:dk_setMultiLine 
setlocal enableDelayedExpansion 
	%dk_call% dk_debugFunc 0 
 
	::##### DO NOT ALTER #############
	set NL=^


	::##### DO NOT ALTER #############

	if not defined flag (set "flag=0")
	for /F "usebackq delims=" %%A in ("%~1") do (
		set "var=%%A"
		if !flag! equ 1 if "!var:endMultiLine=!" neq "!var!" (
		
			rem Replace every new-line by an escaped new-line
			set MyVar=!MyVar:^%NL%%NL%=^^^%NL%%NL%^%NL%%NL%!
			
			rem /* Use a `for` meta-variable rather than a normal environment variable to
			rem    pass the variable value beyond the `endlocal` barrier;
			rem    a standard `for` loop can be used here, because there are not going to be
			rem    wildcards `?` and `*` in the variable value since they have already been
			rem    resolved by `dir`; `for /F` cannot be used here due to the new-lines: */
			for %%G in ("!MyVar!") do endlocal & set MyVar=%%~G
			
			goto:endMultiLine
		)
		if !flag! equ 1 (
			rem echo %%A
			if defined MyVar set "MyVar=!MyVar!!NL!"
			set "MyVar=!MyVar!%%A"
		)
		if !flag! equ 0 if "!var:setMultiLine %%0 %~2=!" neq "!var!" (set "flag=1")
	)
 
%endfunction% 
 
 
 
 
 
 
 
 
 
 
 
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
:DKTEST 
setlocal enableDelayedExpansion 
	%dk_call% dk_debugFunc 0 
  

	%dk_call% dk_setMultiLine %0 MyVar & exit /b 0
line1
line2
line3
	:endMultiLine

	echo %MyVar%

%endfunction% 
 
