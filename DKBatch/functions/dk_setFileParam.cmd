@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_setFileParam(<file> <param> <value>)
::#
::#
:dk_setFileParam
setlocal DisableDelayedExpansion

	set "file=%~1"
	set "varName=%~2"
	set "newValue=%~3"
	set "newValue=%newValue:^^=^%
	
	if not exist "%file%" (copy NUL "%file%" >nul)

	<"%file%" >"%file%.tmp~" (
		for /f "delims=" %%i in ('type "%file%"^|findstr "^"') do (
			set "line=%%i"
			setlocal EnableDelayedExpansion
			for /f "delims==" %%j in ("!line!") do if "%%j" equ "%varName%" (
				endlocal & set "found=1"
				setlocal EnableDelayedExpansion
				echo(%varName%=%newValue%
			) else (
				echo(!line!
			)
			endlocal
		)
		if not defined found echo(%varName%=%newValue%
	)
	move /y "%file%.tmp~" "%file%" >nul

%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	set "file=C:\Users\Administrator\Desktop\test.txt"
	%dk_call% dk_setFileParam "%file%" one "123"
	%dk_call% dk_setFileParam "%file%" two 234
	%dk_call% dk_setFileParam "%file%" three "34 5"
	%dk_call% dk_setFileParam "%file%" four "4 5 6"
	%dk_call% dk_setFileParam "%file%" five "5 6 7"
	
	%dk_call% dk_setFileParam "%file%" two "this value was changed"
	%dk_call% dk_setFileParam "%file%" four "this value was also changed"
	
	::########################################## Special Characters ##########################################
	::                                ALL: "  ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
	::                              VALID: "      # $     ' (   * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
	%dk_call% dk_setFileParam "%file%" six "      # $     ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ ` {   } ~"
	::                            INVALID: "  ! "     % &     )                 <   >                   |    "
%endfunction%

