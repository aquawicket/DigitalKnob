@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################



::####################################################################
::# dk_setVar()
::#
::#  Search the own batch file for <searchName> in a line with "call dk_setVar "
::#
:dk_setVar <var> <value>
	setLocal DisableDelayedExpansion
	::echo dk_setVar "%~1" = "%~2"
	
	set "prefix= dk_setVar %~1 "
	for /f "usebackq tokens=* delims=" %%G in (`findstr /C:" dk_setVar %~1 " "%~f0"`) do (
		set str1=%%G
	)
	
	::echo str1 = %str1%
	
	set str1=%str1:^=^^%
	set str1=%str1:!=^!%
	
	endlocal & (
		
		set str1=%str1::=^:%
		set %~1=%str1%
		rem setlocal enableDelayedExpansion
	)

%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
SetLocal EnableDelayedExpansion
	%dk_call% dk_debugFunc 0
	
::	%dk_call% dk_setVar VAR   "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ "
::	echo VAR = %VAR%
::	echo VAR = !VAR!
::	echo "VAR = %VAR%"
::	echo "VAR = !VAR!"
	
	
	
::  All_Chars                 "   ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ "
	%dk_call% dk_setVar VAR1  "                                                                   "
	echo  VAR1 = '!VAR1!'
	%dk_call% dk_setVar VAR2  "   !                                                               "
	echo  VAR2 = '!VAR2!'
	%dk_call% dk_setVar VAR3  "   !                                                               "
	echo  VAR3 = '!VAR3!'
	%dk_call% dk_setVar VAR4  "   !   #                                                           "
	echo  VAR4 = '!VAR4!'
	%dk_call% dk_setVar VAR5  "   !   # $                                                         "
	echo  VAR5 = '!VAR5!'
	%dk_call% dk_setVar VAR6  "   !   # $ %                                                       "
	echo  VAR6 = '!VAR6!'
	%dk_call% dk_setVar VAR7  "   !   # $ % &                                                     "
	echo  VAR7 = '!VAR7!'
	%dk_call% dk_setVar VAR8  "   !   # $ % & '                                                   "
	echo  VAR8 = '!VAR8!'
	%dk_call% dk_setVar VAR9  "   !   # $ % & ' (                                                 "
	echo  VAR9 = '!VAR9!'
	%dk_call% dk_setVar VAR10 "   !   # $ % & ' ( )                                               "
	echo VAR10 = '!VAR10!'
	%dk_call% dk_setVar VAR11 "   !   # $ % & ' ( ) *                                             "
	echo VAR11 = '!VAR11!'
	%dk_call% dk_setVar VAR12 "   !   # $ % & ' ( ) * +                                           "
	echo VAR12 = '!VAR12!'
	%dk_call% dk_setVar VAR13 "   !   # $ % & ' ( ) * + ,                                         "
	echo VAR13 = '!VAR13!'
	%dk_call% dk_setVar VAR14 "   !   # $ % & ' ( ) * + , -                                       "
	echo VAR14 = '!VAR14!'
	%dk_call% dk_setVar VAR15 "   !   # $ % & ' ( ) * + , - .                                     "
	echo VAR15 = '!VAR15!'
	%dk_call% dk_setVar VAR16 "   !   # $ % & ' ( ) * + , - . /                                   "
	echo VAR16 = '!VAR16!'
	%dk_call% dk_setVar VAR17 "   !   # $ % & ' ( ) * + , - . / :                                 "
	echo VAR17 = '!VAR17!'
	%dk_call% dk_setVar VAR18 "   !   # $ % & ' ( ) * + , - . / : ;                               "
	echo VAR18 = '!VAR18!'
	%dk_call% dk_setVar VAR19 "   !   # $ % & ' ( ) * + , - . / : ; <                             "
	echo VAR19 = '!VAR19!'
	%dk_call% dk_setVar VAR20 "   !   # $ % & ' ( ) * + , - . / : ; < =                           "
	echo VAR20 = '!VAR20!'
	%dk_call% dk_setVar VAR21 "   !   # $ % & ' ( ) * + , - . / : ; < = >                         "
	echo VAR21 = '!VAR21!'
	%dk_call% dk_setVar VAR22 "   !   # $ % & ' ( ) * + , - . / : ; < = > ?                       "
	echo VAR22 = '!VAR22!'
	%dk_call% dk_setVar VAR23 "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @                     "
	echo VAR23 = '!VAR23!'
	%dk_call% dk_setVar VAR24 "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [                   "
	echo VAR24 = '!VAR24!'
	%dk_call% dk_setVar VAR25 "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [                   "
	echo VAR25 = '!VAR25!'
	%dk_call% dk_setVar VAR26 "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ]               "
	echo VAR26 = '!VAR26!'
	%dk_call% dk_setVar VAR27 "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^             "
	echo VAR27 = '!VAR27!'
	%dk_call% dk_setVar VAR28 "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _           "
	echo VAR28 = '!VAR28!'
	%dk_call% dk_setVar VAR29 "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ `         "
	echo VAR29 = '!VAR29!'
	%dk_call% dk_setVar VAR30 "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` {       "
	echo VAR30 = '!VAR30!'
	%dk_call% dk_setVar VAR31 "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { |     "
	echo VAR31 = '!VAR31!'
	%dk_call% dk_setVar VAR32 "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | }   "
	echo VAR32 = '!VAR32!'
	%dk_call% dk_setVar VAR33 "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ "
	echo VAR33 = '!VAR33!'
	
	%dk_call% dk_setVar VAR   "   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ "
	echo   VAR = '!VAR!'
    ::                        "   ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
	
	
%endfunction%