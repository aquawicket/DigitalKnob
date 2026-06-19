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


rem ################################################################################
rem # dk_toLower(string rtn_var)
rem #
rem #		Convert a string to lowercase
rem #
:dk_toLower
%setlocal%
	
	set "dk_toLower=%~1"
	for %%# in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do (
		set "dk_toLower=!dk_toLower:%%#=%%#!"
	)
	
   :return
	endlocal & (
		set "dk_toLower=%dk_toLower%"
		if "%~2" neq "" (set "%~2=%dk_toLower%")
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem ### Special Characters ###
	rem #     ALL:  ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
	rem #   VALID:  !   # $ % &   ( ) * + , -     : ;   =     @       ^ _ ` { | } 
	rem # INVALID:    "         '             . /     <   > ?   [ \ ]             ~
    set "myVar=a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0   !   # $ % &   ( ) * + , -     : ;   =     @       ^ _ ` { | }"
    
	%dk_call% dk_debug "myVar = %myVar%"
	%dk_call% dk_toLower "%myVar%" myVar
	%dk_call% dk_debug "dk_toLower = %dk_toLower%"
    %dk_call% dk_debug "myVar = %myVar%"
%endfunction%
