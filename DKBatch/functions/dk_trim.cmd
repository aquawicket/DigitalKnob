@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_trim()
::#
::#		Reference: https://stackoverflow.com/a/26079981
::#
:dk_trim
%setlocal%
::	%dk_call% dk_debugFunc 0
	
::	set dk_trim=%*
	if "%~2" equ "" (
		set "dk_trim=%~1"
	) else (
		set dk_trim=%*
	)
	
::	echo dk_trim = %dk_trim%

	for /f "tokens=*" %%a in ("!dk_trim!") do endlocal & set "dk_trim=%%~a"

%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
 
	::###### Variable set with quotes ######
	echo(
	set "myValue=   a  b  c   "   
	echo myValue = '%myValue%'
	%dk_call% dk_trim %myValue%
	echo dk_trim =    '%dk_trim%'
	
	::###### Variable set with without quotes ######
	echo(
	set myValue=   1  2  3      
	echo myValue = '%myValue%'
	%dk_call% dk_trim %myValue%
	echo dk_trim =    '%dk_trim%'
	
	::###### Variable set with without quotes ######
	echo(
	set "myValue=   d  e  f    "
	echo myValue = '%myValue%'
	%dk_call% dk_trim "%myValue%"
	echo dk_trim =   '%dk_trim%'
	
	::###### Variable set with without quotes ######
	echo(
	set myValue=   4  5  6    
	echo myValue = '%myValue%'
	%dk_call% dk_trim "%myValue%"
	echo dk_trim =   '%dk_trim%'
	
	::###### Variable with unspecial characters and quotes ######
	echo(
          ::ALL:    ! " #  $  % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
        ::VALID:        #  $    & ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ ` {   } ~
      ::INVALID:    ! "       % &     )                 <   >           ^       |
	set "myValue=       #  $      ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ ` {   } ~     "      
	echo myValue = '%myValue%'
	%dk_call% dk_trim %myValue%
	echo dk_trim =        '%dk_trim%'
	
	::###### Variable with unspecial characters and quotes ######
	echo(
        ::ALL:    ! " #  $  % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
        ::VALID:      #  $    & ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ ` {   } ~
      ::INVALID:  ! "       % &     )                 <   >           ^       |
	set "myValue=       #  $      ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ ` {   } ~     "      
	echo myValue = '%myValue%'
	%dk_call% dk_trim "%myValue%"
	echo dk_trim =        '%dk_trim%'
	
	::###### Variable with unspecial characters and quotes ######
	echo(
          ::ALL:    ! " #  $  % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
        ::VALID:        #  $    & ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ ` {   } ~
      ::INVALID:    ! "       % &     )                 <   >           ^       |
	set "myValue=       #  $    & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~     "   
	echo "myValue = '%myValue%'"
	%dk_call% dk_trim "%myValue%"
	echo "dk_trim =        '%dk_trim%'"
	
	
::	echo(						   
::	set myValue=     #$ &'()*+,-./:;<=>?@[\]^_`{|}~
::	echo "myValue = '%myValue%'"
::	::for /f "delims=" %%G in ("myValue = '%myValue%'") do (echo(%%~G)
	
::	call :dk_trim %myValue%
::	echo dk_trim = '%dk_trim%'
::	::for /f "delims=" %%G in ("dk_trim = '%dk_trim%'") do (echo(%%~G)
%endfunction%

