@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_deleteArray(array)
::#
::#
:dk_deleteArray
 ::setlocal
	%dk_call% dk_debugFunc 1

	set /a "n=0"
	:loop1 
	if defined %~1[%n%] (
		set "%~1[%n%]="
		set /a n+=1
		goto loop1
	)

	if defined %~1[0] (%dk_call% dk_error "%__FUNCTION__%: failed to delete array")
	:: DOSTIPS version
	:: :remove_array
	:: for /f "delims==" %%a in ('"set %~1[ 2>NUL"') do set "%%a="
	:: EXIT /b
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	set "myArrayA[0]=a b c"
	set "myArrayA[1]=1 2 3"
	set "myArrayA[2]=d e f"
	set "myArrayA[3]=4 5 6"
	set "myArrayA[4]=h i j"
	%dk_call% dk_printVar myArrayA

	%dk_call% dk_deleteArray myArrayA

	echo:
	%dk_call% dk_printVar myArrayA
%endfunction%
