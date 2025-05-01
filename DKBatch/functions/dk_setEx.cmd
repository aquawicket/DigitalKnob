@echo off&::########################################## DigitalKnob DKBatch ######################################################################## 
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG") 
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::################################################################################################################################################# 
 
 
::############################################################################ 
::# dk_setEx() 
::# 
::# 
:dk_setEx 
setlocal disableDelayedExpansion
	::%dk_call% dk_debugFunc 0 
 
	::echo "%~2"
	set "temp=%~2"
	set "temp=%temp:^^=^%"
	set "%~1=%temp%"
	
	endlocal & (
		set "%~1=%temp%"
		setlocal enableDelayedExpansion
	)
	
%endfunction% 
 
 
 
 
 
 
 
 
 
 
 
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
:DKTEST 
setlocal enableDelayedExpansion 
	%dk_call% dk_debugFunc 0 
  
	%dk_call% dk_setEx myVar "     # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
	echo "%%myVar%%" = '"%myVar%"'
  echo  ^^!myVar^^!  =  '!myVar!'
	
%endfunction% 
 
