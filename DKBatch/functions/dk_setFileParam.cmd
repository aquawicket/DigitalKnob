@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ############################################################################
rem # dk_setFileParam(<file> <param> <value>)
rem #
rem #
:dk_setFileParam
setlocal DisableDelayedExpansion

	set "file=%~1"
	set "varName=%~2"
	set "newValue=%~3"
	set "newValue=%newValue:^^=^%
	
	if NOT EXIST "%file%" (copy NUL "%file%" >nul)
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	
	<"%file%" >"%file%.tmp~" (
		for /f "delims=" %%i in ('type "%file%"^|%findstr_str% "^"') do (
			set "line=%%i"
			setlocal EnableDelayedExpansion
			for /f "delims==" %%j in ("!line!") do if "%%j" equ "%varName%" (
				endlocal & set "found=1"
				setlocal EnableDelayedExpansion
				echo.%varName%=%newValue%
			) else (
				echo.!line!
			)
			endlocal
		)
		if NOT defined found echo.%varName%=%newValue%
	)
	move /y "%file%.tmp~" "%file%" >nul

%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	set "file=%USERPROFILE:\=/%/Desktop/test.txt"
	%dk_call% dk_setFileParam "%file%" one "123"
	%dk_call% dk_setFileParam "%file%" two 234
	%dk_call% dk_setFileParam "%file%" three "34 5"
	%dk_call% dk_setFileParam "%file%" four "4 5 6"
	%dk_call% dk_setFileParam "%file%" five "5 6 7"
	
	%dk_call% dk_setFileParam "%file%" two "this value was changed"
	%dk_call% dk_setFileParam "%file%" four "this value was also changed"
	
	rem ########################################## Special Characters ##########################################
	rem                                ALL: "  ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
	rem                              VALID: "      # $     ' (   * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
	%dk_call% dk_setFileParam "%file%" six "      # $     ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ ` {   } ~"
	rem                            INVALID: "  ! "     % &     )                 <   >                   |    "
%endfunction%

