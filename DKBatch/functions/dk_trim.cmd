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
rem # dk_trim()
rem #
rem #		Reference: https://stackoverflow.com/a/26079981
rem #				 : https://stackoverflow.com/a/26079981/688352
rem #
:dk_trim
	(set dk_trim=%*)
%endfunction%

rem dk_trim	
	rem %setlocal%
 	rem endLocal & set dk_trim=%*
rem %endfunction%	

rem dk_trim	
	rem echo before trim='%*'
	rem endlocal & set dk_trim=%*
	rem for /f "tokens=*" %%a in ("!dk_trim!") do endlocal & set "dk_trim=%%~a"
	rem for /f "tokens=1*" %%a in ("!Params!") do EndLocal & set dk_trim=%%b
rem %endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
 	
	echo.
	echo ###### Variable with quotes / arg without quotes ######
	set "myValue=   a  b  c   "   
	echo myValue='%myValue%'
	%dk_call% dk_trim %myValue%
	echo dk_trim='%dk_trim%'
	
	
	echo.
	echo ###### Variable without quotes / arg without quotes ############
	set myValue=   1  2  3      
	echo myValue='%myValue%'
	%dk_call% dk_trim %myValue%
	echo dk_trim='%dk_trim%'
	
	rem # NOTE: ONLY TRIMS THE FRONT
	echo.
	echo ###### Variable with quotes / arg with quotes ############
	set "myValue=   d  e  f    "
	echo myValue='%myValue%'
	%dk_call% dk_trim "%myValue%"
	echo dk_trim='%dk_trim%'
	
	
	rem # NOTE: ONLY TRIMS THE FRONT
	echo.
	echo ###### Variable without quotes / arg with quotes ############
	set myValue=   4  5  6    
	echo myValue='%myValue%'
	%dk_call% dk_trim "%myValue%"
	echo dk_trim='%dk_trim%'

	echo.
	echo ###### special character Variable with quotes / arg without quotes ############
          rem ALL:    ! " #  $  % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
        rem VALID:        #  $    & ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ ` {   } ~
      rem INVALID:    ! "       % &     )                 <   >           ^       |
	set "myValue=       #  $      ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ ` {   } ~     "      
	echo myValue = '%myValue%'
	%dk_call% dk_trim %myValue%
	echo dk_trim =        '%dk_trim%'
	
	echo.
	echo ###### special character Variable with quotes / arg with quotes ############
        rem ALL:    ! " #  $  % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
        rem VALID:      #  $    & ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ ` {   } ~
      rem INVALID:  ! "       % &     )                 <   >           ^       |
	set "myValue=       #  $      ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ ` {   } ~     "      
	echo myValue = '%myValue%'
	%dk_call% dk_trim "%myValue%"
	echo dk_trim =        '%dk_trim%'
	
	echo.
	echo ###### special character Variable with quotes / arg with quotes ############
          rem ALL:    ! " #  $  % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
        rem VALID:        #  $    & ' (   * + , - . / : ;   =   ? @ [ \ ] ^ _ ` {   } ~
      rem INVALID:    ! "       % &     )                 <   >           ^       |
	set "myValue=       #  $    & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~     "   
	echo "myValue = '%myValue%'"
	%dk_call% dk_trim "%myValue%"
	echo "dk_trim =        '%dk_trim%'"
	
	
rem	echo.						   
rem	set myValue=     #$ &'()*+,-./:;<=>?@[\]^_`{|}~
rem	echo "myValue = '%myValue%'"
rem	::for /f "delims=" %%G in ("myValue = '%myValue%'") do (echo.%%~G)
	
rem	call :dk_trim %myValue%
rem	echo dk_trim = '%dk_trim%'
rem	::for /f "delims=" %%G in ("dk_trim = '%dk_trim%'") do (echo.%%~G)
%endfunction%

