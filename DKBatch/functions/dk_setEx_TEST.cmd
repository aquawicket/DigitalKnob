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
rem # dk_setEx_TEST()
rem #
rem #
:dk_setEx_TEST

%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
rem setlocal
endlocal
rem 								  ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
     %dk_call% dk_setEx %0 dec33  
	echo dk_setEx = %dk_setEx%
	
rem     %dk_call% dk_setEx %0 dec34  ! " 
rem	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec35  !   #
	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec36  !   # $  
	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec37  !   # $ %
	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec38  !   # $ % &
	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec39  !   # $ % & '
	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec40  !   # $ % & ' (
	echo dk_setEx = %dk_setEx%
	
rem   %dk_call% dk_setEx %0 dec41  ! " # $ % & ' ( )
rem	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec42  !   # $ % & ' (   *
	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec43  !   # $ % & ' (   * +
	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec44  !   # $ % & ' (   * + ,
	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec45  !   # $ %   ' (   * + , -
	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec46  !   # $ %   ' (   * + , - .
	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec47  !   # $ %   ' (   * + , - . /
	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec58  !   # $ %   ' (   * + , - . / :
	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec59  !   # $ %   ' (   * + , - . / : ;
	echo dk_setEx = %dk_setEx%
	
rem   %dk_call% dk_setEx %0 dec60  ! " # $ % & ' ( ) * + , - . / : ; <
rem	echo dk_setEx = %dk_setEx%

     %dk_call% dk_setEx %0 dec61  !   # $ %   ' (   * + , - . / : ;   =
	echo dk_setEx = %dk_setEx%

rem   %dk_call% dk_setEx %0  dec62 ! " # $ % & ' ( ) * + , - . / : ; < = >
rem	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec63  !   # $ %   ' (   * + , - . / : ;   =   ?
	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec64  !   # $ %   ' (   * + , - . / : ;   =   ? @
	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec91  !   # $ %   ' (   * + , - . / : ;   =   ? @ [
	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec92  !   # $ %   ' (   * + , - . / : ;   =   ? @ [ \
	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec93  !   # $ %   ' (   * + , - . / : ;   =   ? @ [ \ ]
	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec94  !   # $ %   ' (   * + , - . / : ;   =   ? @ [ \ ] ^
	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec95  !   # $ %   ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _
	echo dk_setEx = %dk_setEx%
	
     %dk_call% dk_setEx %0 dec96  !   # $ %   ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ `
	echo dk_setEx = %dk_setEx%

	%dk_call% dk_setEx %0 dec123  !   # $ %   ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ ` {
rem	echo dk_setEx = %dk_setEx%

rem	%dk_call% dk_setEx %0 dec124  ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { |
	echo dk_setEx = %dk_setEx%
	
	%dk_call% dk_setEx %0 dec125  !   # $ %   ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ ` {   }
	echo dk_setEx = %dk_setEx%
	
	%dk_call% dk_setEx %0 dec126  !   # $ %   ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ ` {   } ~
	echo dk_setEx = %dk_setEx%

rem 								  ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
	pause
%endfunction%

