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


if not defined fileWrite_PRINT (set "fileWrite_PRINT=0")
rem ##################################################################################
rem # dk_fileWrite(file, "string")
rem #
rem #		Write string to file.
rem #
rem #	Reference: https://ss64.com/nt/syntax-redirection.html
rem #
:dk_fileWrite
%setlocal%

	rem (echo.%~2> "%~1")
	rem NOTE: If the string ends in a single number, i.e. Set _message=Meet at 2
	rem echo %_message%>file.txt Will inadvertently interpret the “2” as part of the redirection operator.
	rem A Trick to fix this is to use redirection operator at the beginning i.e. >file.txt echo %_message%
	
	(>"%~1" echo.%~2)
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	%dk_call% dk_assertPath "%DKCACHE_DIR%"
	
	echo.
	echo.###### dk_fileWrite_TEST_blank ######
	(set "file=%DKCACHE_DIR%/dk_fileWrite_TEST_blank.txt")
	%dk_call% dk_fileWrite "%file%"
	type "%file:/=\%"
	
	echo.
	echo.###### dk_fileWrite_TEST_A ######
	(set "file=%DKCACHE_DIR%/dk_fileWrite_TEST_A.txt")
	%dk_call% dk_fileWrite "%file%" Simple_string_no_spaces_or_quotes
	type "%file:/=\%"
	
	echo.
	echo.###### dk_fileWrite_TEST_B ######
	(set "file=%DKCACHE_DIR%/dk_fileWrite_TEST_B.txt")
	%dk_call% dk_fileWrite "%file%" "Simple string quoted with spaces"
	type "%file:/=\%"
	
	echo.
	echo.###### dk_fileWrite_TEST_C ######
	(set "file=%DKCACHE_DIR%/dk_fileWrite_TEST_C.txt")
	%dk_call% dk_fileWrite "%file%" "   Quoted string  with    spaces  on ends   "
	type "%file:/=\%"
	
	echo.
	echo.###### dk_fileWrite_TEST_D ######
	(set "file=%DKCACHE_DIR%/dk_fileWrite_TEST_D.txt")
	rem	                        CHARACTERS:   ( # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~  ^ ! " & < > | % )
	%dk_call% dk_fileWrite "%file%" "VALID:   ( # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~                    "
	type "%file:/=\%"
	
	echo.
	echo.###### dk_fileWrite_TEST_E ######
	set "file=%DKCACHE_DIR%/dk_fileWrite_TEST_E.txt"
	rem	                        CHARACTERS:   ( # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~  ^ ! " & < > | % )
	%dk_call% dk_fileWrite "%file%" "VALID:   ( # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~                    "
	type "%file:/=\%"
exit /b 0

	
	
	rem ############### Special Characters ###############
	echo.
	echo ###### echo (DisableDelayedExpansion, no quotes) ######
	setlocal DisableDelayedExpansion
		rem	CHARACTERS:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ !  ^  "  &  <  >  |  %
		rem	     VALID:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ !
		echo     VALID:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ !
		rem	   INVALID:                                                      ^  "  &  <  >  |  %
		echo   INVALID:                                                     ^^ ^" ^& ^< ^> ^| %%
		rem	       ALL:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ !  ^  "  &  <  >  |  %
		echo       ALL:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ^^ ^" ^& ^< ^> ^| %%
		echo     TWICE:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ^^ ^" ^& ^< ^> ^| %% ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ^^ ^" ^& ^< ^> ^| %%
	endlocal
	
rem	                            ALL: "  ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
rem						    INVALID: "  ! "     %   
rem							  VALID: "      # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
    %dk_call% dk_fileWrite "%file%"  "      # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
	type "%file:/=\%"
%endfunction%
