@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_toLower(string rtn_var)
::#
::#
:dk_toLower
%setlocal%
	echo dk_toLower(%*)
	%dk_call% dk_debugFunc 1 2


	set "dk_toLower=%~1"
	for %%# in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do set "dk_toLower=!dk_toLower:%%#=%%#!")

		
    ::###### output ######
	endlocal & (
		set "dk_toLower=%dk_toLower%"
		if "%~2" neq "" (set "%~2=%dk_toLower%") else (echo %dk_toLower%)
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::### Special Characters ###
	::#     ALL:  ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
	::#   VALID:  !   # $ % &   ( ) * + , -     : ;   =     @       ^ _ ` { | } 
	::# INVALID:    "         '             . /     <   > ?   [ \ ]             ~
    set "myVar=a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0   !   # $ % &   ( ) * + , -     : ;   =     @       ^ _ ` { | }"
    %dk_call% dk_toLower "%myVar%" lowercase
   
    %dk_call% dk_printVar myVar
	%dk_call% dk_printVar dk_toLower
    %dk_call% dk_printVar lowercase
%endfunction%
