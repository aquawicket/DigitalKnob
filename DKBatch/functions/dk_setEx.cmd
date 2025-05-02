@echo off&::########################################## DigitalKnob DKBatch ######################################################################## 
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG") 
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::################################################################################################################################################# 
 
 
::############################################################################ 
::# dk_setEx() 
::# 
::# 
:dk_setEx 
::setlocal disableDelayedExpansion
::setlocal EnableDelayedExpansion
	::%dk_call% dk_debugFunc 0 
	echo %*
	
	set "Params=%*"
	for /f "tokens=*" %%G IN ("%Params%") do (
		echo * = "%%~G"
		rem endlocal & (set %~1=%%G)
	)
	

	
::	:UnEscape
::	echo "%_args_%" | findstr /c:"^^" >nul && (
::		set "_args_=%_args_:^^=^%"
::		goto :UnEscape
::	)
::	
::	endlocal & (
::		set "%~1=%_args_%"
::	)
%endfunction% 
 
 
 
 
 
 
 
 
 
 
 
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### 
:DKTEST 
setlocal enableDelayedExpansion 


@echo off
setlocal disableDelayedExpansion
for /f "useback delims=" %%_ in (%0) do (
  if "%%_"=="___ATAD___" set $=
  if defined $ echo(%%_
  if "%%_"=="___DATA___" set $=1
)
endlocal
pause
goto :eof

___DATA___
!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
___ATAD___


rem # 
rem # 


	%dk_call% dk_debugFunc 0 
  
	::	                 ALL: "  ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
	::                 VALID: "      # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
	%dk_call% dk_setEx myVar1 "      # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
	::	             INVALID: "  ! "     %                                                      "
	%dk_call% dk_echo "%%myVar1%% = %myVar1%"
	%dk_call% dk_echo "^^!myVar1^^! = !myVar1!"
	
	::	                 ALL: " !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~"
	::                 VALID: 
	%dk_call% dk_setEx myVar2 "   #$ &'()*+,-./:;<=>?@[\]^_`{|}~"
	::	             INVALID: " !"  %                           "
	echo "%%myVar2%%" = "%myVar2%"
	echo   ^^!myVar2^^! = '!myVar2!'
	
%endfunction% 
 
