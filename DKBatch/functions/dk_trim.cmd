@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_trim()
::#
::#		Reference: https://stackoverflow.com/a/26079981
::#				 : https://stackoverflow.com/a/26079981/688352
::#
:dk_trim
%setlocal%
::	%dk_call% dk_debugFunc 0
	::echo before trim='%*'
	::endlocal & set dk_trim=%*
	::for /f "tokens=*" %%a in ("!dk_trim!") do endlocal & set "dk_trim=%%~a"
	
	endLocal & set dk_trim=%*
	::for /f "tokens=1*" %%a in ("!Params!") do EndLocal & set dk_trim=%%b
%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
 	
	echo(
	echo ###### Variable with quotes / arg without quotes ######
	set "myValue=   a  b  c   "   
	echo myValue='%myValue%'
	%dk_call% dk_trim %myValue%
	echo dk_trim='%dk_trim%'
	
	
	echo(
	echo ###### Variable without quotes / arg without quotes ############
	set myValue=   1  2  3      
	echo myValue='%myValue%'
	%dk_call% dk_trim %myValue%
	echo dk_trim='%dk_trim%'
	
	::# NOTE: ONLY TRIMS THE FRONT
	echo(
	echo ###### Variable with quotes / arg with quotes ############
	set "myValue=   d  e  f    "
	echo myValue='%myValue%'
	%dk_call% dk_trim "%myValue%"
	echo dk_trim='%dk_trim%'
	
	
	::# NOTE: ONLY TRIMS THE FRONT
	echo(
	echo ###### Variable without quotes / arg with quotes ############
	set myValue=   4  5  6    
	echo myValue='%myValue%'
	%dk_call% dk_trim "%myValue%"
	echo dk_trim='%dk_trim%'

	echo(
	echo ###### special character Variable with quotes / arg without quotes ############
          ::ALL:    ! " #  $  % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
        ::VALID:        #  $    & ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ ` {   } ~
      ::INVALID:    ! "       % &     )                 <   >           ^       |
	set "myValue=       #  $      ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ ` {   } ~     "      
	echo myValue = '%myValue%'
	%dk_call% dk_trim %myValue%
	echo dk_trim =        '%dk_trim%'
	
	echo(
	echo ###### special character Variable with quotes / arg with quotes ############
        ::ALL:    ! " #  $  % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
        ::VALID:      #  $    & ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ ` {   } ~
      ::INVALID:  ! "       % &     )                 <   >           ^       |
	set "myValue=       #  $      ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ ` {   } ~     "      
	echo myValue = '%myValue%'
	%dk_call% dk_trim "%myValue%"
	echo dk_trim =        '%dk_trim%'
	
	echo(
	echo ###### special character Variable with quotes / arg with quotes ############
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

