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



rem ####################################################################
rem # dk_setVar(var value)
rem #
rem #  Search the own batch file for <searchName> in a line with "call dk_setVar "
rem #
:dk_setVar
	setLocal DisableDelayedExpansion
	
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	for /f "usebackq tokens=* delims=" %%G in (`%findstr.exe% /C:" dk_setVar %~1 " "%~f0"`) do (
		set str1=%%~G
	)
	echo str1 = %str1%
	
	set prefix=%str1:>=#%
	set prefix=%prefix:&=#%
	set prefix=%prefix:)=#%
	set prefix=%prefix:|=#%
	call set "prefix=%%prefix:%~1=#%%"
	
	for /f "tokens=1 delims=#" %%A in ("%prefix%") do (set prefix=%%A%~1 )
	rem echo prefix = %prefix%

	set str1=%str1:^=^^%
	set str1=%str1:!=^!%
	rem set str1=%str1:""="%
	call set str1=%%str1:%prefix%=%%
	rem echo str1 = %str1%
	rem %dk_call% dk_trim %str1%
	rem echo dk_trim = %dk_trim%
	set dk_setVar=%str1%
	
	:return
	endlocal & (
		set dk_setVar=%dk_setVar%
		if "%~1" neq "" (
			set %~1=%dk_setVar%
		) else (
			echo %dk_setVar%
		)
	)

%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
SetLocal EnableDelayedExpansion
	
rem	%dk_call% dk_setVar VAR   "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ "
rem	echo VAR = %VAR%
rem	echo VAR = !VAR!
rem	echo "VAR = %VAR%"
rem	echo "VAR = !VAR!"
	
rem  All_Chars                  "   ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ "
    %dk_call% dk_setVar dec32  "                                                                   "
    echo dec32 = '%dec32%'
    %dk_call% dk_setVar dec33  "   !                                                               "
    echo dec33 = '!dec33!'
    %dk_call% dk_setVar dec34  "   !                                                               "
    echo dec34 = '%dec34%'
    %dk_call% dk_setVar dec35  "   !   #                                                           "
    echo dec35 = '!dec35!'
    %dk_call% dk_setVar dec36  "   !   # $                                                         "
    echo dec36 = '%dec36%'
    %dk_call% dk_setVar dec37  "   !   # $ %                                                       "
    echo dec37 = '!dec37!'
    %dk_call% dk_setVar dec38  "   !   # $ % &                                                     "
    echo dec38 = '%dec38%'
    %dk_call% dk_setVar dec39  "   !   # $ % & '                                                   "
    echo dec39 = '!dec39!'
    %dk_call% dk_setVar dec40  "   !   # $ % & ' (                                                 "
    echo dec40 = '%dec40%'
    %dk_call% dk_setVar dec41  "   !   # $ % & ' ( )                                               "
    echo dec41 = '!dec41!'
    %dk_call% dk_setVar dec42  "   !   # $ % & ' ( ) *                                             "
    echo dec42 = '%dec42%'
    %dk_call% dk_setVar dec43  "   !   # $ % & ' ( ) * +                                           "
    echo dec43 = '!dec43!'
    %dk_call% dk_setVar dec44  "   !   # $ % & ' ( ) * + ,                                         "
    echo dec44 = '%dec44%'
    %dk_call% dk_setVar dec45  "   !   # $ % & ' ( ) * + , -                                       "
    echo dec45 = '!dec45!'
    %dk_call% dk_setVar dec46  "   !   # $ % & ' ( ) * + , - .                                     "
    echo dec46 = '%dec46%'
    %dk_call% dk_setVar dec47  "   !   # $ % & ' ( ) * + , - . /                                   "
    echo dec47 = '!dec47!'
    %dk_call% dk_setVar dec58  "   !   # $ % & ' ( ) * + , - . / :                                 "
    echo dec58 = '%dec58%'
    %dk_call% dk_setVar dec59  "   !   # $ % & ' ( ) * + , - . / : ;                               "
    echo dec59 = '!dec59!'
    %dk_call% dk_setVar dec60  "   !   # $ % & ' ( ) * + , - . / : ; <                             "
    echo dec60 = '%dec60%'
    %dk_call% dk_setVar dec61  "   !   # $ % & ' ( ) * + , - . / : ; < =                           "
    echo dec61 = '!dec61!'
    %dk_call% dk_setVar dec62  "   !   # $ % & ' ( ) * + , - . / : ; < = >                         "
    echo dec62 = '%dec62%'
    %dk_call% dk_setVar dec63  "   !   # $ % & ' ( ) * + , - . / : ; < = > ?                       "
    echo dec63 = '!dec63!'
    %dk_call% dk_setVar dec64  "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @                     "
    echo dec64 = '%dec64%'
    %dk_call% dk_setVar dec91  "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [                   "
    echo dec91 = '!dec91!'
    %dk_call% dk_setVar dec92  "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [                   "
    echo dec92 = '%dec92%'
    %dk_call% dk_setVar dec93  "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ]               "
    echo dec93 = '!dec93!'
    %dk_call% dk_setVar dec94  "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^             "
    echo dec94 = '%dec94%'
    %dk_call% dk_setVar dec95  "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _           "
    echo dec95 = '!dec95!'
    %dk_call% dk_setVar dec96  "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ `         "
    echo dec96 = '%dec96%'
    %dk_call% dk_setVar dec123 "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` {       "
    echo dec123 = '!dec123!'
    %dk_call% dk_setVar dec124 "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { |     "
    echo dec124 = '%dec124%'
    %dk_call% dk_setVar dec125 "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | }   "
    echo dec125 = '!dec125!'
    %dk_call% dk_setVar dec126 "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ "
    echo dec126 = '%dec126%'
    
    %dk_call% dk_setVar myVar  "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ "
    echo   VAR = '!VAR!'
    rem                         "   ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ "
    
%endfunction%