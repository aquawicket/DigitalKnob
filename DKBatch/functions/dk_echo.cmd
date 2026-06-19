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


rem set "dk_echo_NONEWLINE=1"
rem ################################################################################
rem # dk_echo.message)
rem #
rem #		Print a message to the console
rem #
rem #		@msg - The message to print
rem #
:dk_echo
rem setlocal disableDelayedExpansion
	
    if "%~1" equ "" (echo. & exit /b 0)  	
	set message=%*
	
rem ### convert \n to new lines
rem #### Create newlines ##########
rem if not defined \n (set \n=^
rem %=DO NOT ALTER THIS=%
rem )
rem set message=%message:\n=^!\n^!%
rem ###############################

	for /f "tokens=1* delims==" %%G in ('set message')  do (
		(echo.%%~H)
	)

%endfunction%

rem	:DeEscape
rem	echo %message% | %findstr.exe% /c:"^^" >nul && (
rem		set message=%message:^^=^%
rem		goto :DeEscape
rem	) || cmd /c "exit /b 0"
	
rem	set "message=%message:""="%" && echo.%message%
rem	for /f %%G in (%message%) do (echo.%%~G)
rem	for /f "tokens=*" %%G in (%message%) do (echo.%%~G)
rem	for /f "delims=" %%G in (%message%) do (echo.%%~G)
rem	for /f "tokens=1* delims==" %%G in ('set message') do (echo.%%~H)
rem	for /f "usebackq delims=" %%G in (`echo.%message%`) do (echo.%%~G)

%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	echo. 2>stdout.log
	echo. 2>stderr.log

	echo This is a normal echo commmand
	%dk_call% dk_echo
	%dk_call% dk_echo ""
	%dk_call% dk_echo "This is a dk_echo line to stdout"
	%dk_call% dk_echo This is a dk_echo line without quotes to stdout
	%dk_call% dk_echo "This is a dk_echo line \nwith a new line to stdout"
	%dk_call% dk_echo "%red%This is %white%dk_echo %blue%with color %clr% to stdout"
	%dk_call% dk_echo "This is a dk_echo line to stderr">&2
	>&2 (call :dk_echo This is a dk_echo line to stderr)
	
	rem ############### Special Characters ###############
	echo.
	echo ###### echo (DisableDelayedExpansion, no quotes) ######
	setlocal DisableDelayedExpansion
		rem	CHARACTERS:   # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ) (  ^  &  <  >  |     %
		rem	     VALID:   # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ) (
		echo     VALID:   # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ) (
		rem	   INVALID:                                                      ^  &  <  >  |  "  %
		echo   INVALID:                                                     ^^ ^& ^< ^> ^| ^" %%
		rem	       ALL:   # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ) (  ^  &  <  >  |  "  %
		echo       ALL:   # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ) ( ^^ ^& ^< ^> ^| ^" %%
		echo     TWICE:   # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ) ( ^^ ^& ^< ^> ^| ^" %%    # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ) ( ^^ ^& ^< ^> ^| ^" %%
		echo     THREE:   # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ) ( ^^ ^& ^< ^> ^| ^" %%    # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ) ( ^^ ^& ^< ^> ^| ^" %%    # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ) ( ^^ ^& ^< ^> ^| ^" %%
	endlocal
	
	echo.
	echo ###### echo (EnableDelayedExpansion, no quotes) ######
	setlocal EnableDelayedExpansion
		rem CHARACTERS:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~  ^  &  <  >  |  %
		rem      VALID:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~
		echo     VALID:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~
		rem	   INVALID:                                                     ^ &  <  >  |  %
		echo   INVALID:                                                   ^^ ^& ^< ^> ^| %%
		rem	       ALL:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~     &  <  >  |  %
		echo       ALL:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^^ ^& ^< ^> ^| %%
		echo     TWICE:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^^ ^& ^< ^> ^| %% ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^^ ^& ^< ^> ^| %%
	endlocal

	echo.
	echo ###### echo %%Variable%% (DisableDelayedExpansion, no quotes) ######
	setlocal DisableDelayedExpansion
		rem CHARACTERS:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ !    ^  "  &  <  >  |  %
		rem	     VALID:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ !
     set var=    VALID:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ !
		echo %var%
		rem	   INVALID:                                                        ^  "  &  <  >  |  %
     set var=  INVALID:                                                     ^^^^ ^" ^& ^< ^> ^| %%
		echo %var%
		rem	       ALL:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ !    ^  "  &  <  >  |  %
	 set var=      ALL:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ^^^^ ^" ^& ^< ^> ^| %%
		echo %var%
     set var=    TWICE:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ^^^^ ^" ^& ^< ^> ^| %% ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ^^ ^" ^^^& ^^^< ^^^> ^^^| %% 
	    echo %var%
	endlocal

		echo.
	echo ###### echo ^^!Variable^^!  (EnableDelayedExpansion, no quotes) ######
	setlocal EnableDelayedExpansion
		rem    CHARACTERS:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~  &  <  >  |  %
		rem	        VALID:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~
		set var=    VALID:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~
		echo !var!
		rem	      INVALID:                                                    &  <  >  |  %
		set var=  INVALID:                                                   ^& ^< ^> ^| %%
		echo !var!
		rem           ALL:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~  &  <  >  |  %
		set var=      ALL:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^& ^< ^> ^| %%
		echo !var!
		set var=    TWICE:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^& ^< ^> ^| %% ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^& ^< ^> ^| %%
	    echo !var!
	endlocal
	
	echo.
	echo ###### echo %%Variable%%  (EnableDelayedExpansion, no quotes) ######
	setlocal EnableDelayedExpansion
		rem CHARACTERS:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~           !                ^  "  &  <  >  |  %
		rem	     VALID:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~
     set var=    VALID:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~
		echo %var%
		rem	   INVALID:                                                             !                ^  "  &  <  >  |  %
	 set var=  INVALID:                                                   ^^^^^^^^^^! ^^^^^^^^^^^^^^^^ ^" ^& ^< ^> ^| %%
		echo %var%
		rem        ALL:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~           !                ^  "  &  <  >  |  %
	 set var=      ALL:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^^^^^^^^^^! ^^^^^^^^^^^^^^^^ ^" ^& ^< ^> ^| %%
		echo %var%
	 set var=    TWICE:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^^^^^^^^^^! ^^^^^^^^^^^^^^^^ ^" ^& ^< ^> ^| %% ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^^^^^^^! ^^^^^^^^ ^" ^^^^^& ^^^^^< ^^^^^> ^^^^^| %%
	    echo %var%
	endlocal

	echo.
	echo ###### echo (DisableDelayedExpansion, in for loop, noquotes) ######
	setlocal DisableDelayedExpansion
		rem                             CHARACTERS:   # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! (  )  ^  "  &  <  >  |  %
		rem                                  VALID:   # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! (
		for /f "usebackq delims=" %%G in ('  VALID:   # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ( ') 							do (echo.   %%~G)
		rem                                INVALID:                                                    )  ^  "  &  <  >  |  %
		for /f "usebackq delims=" %%G in ('INVALID:                                                   ^) ^^ ^" ^& ^< ^> ^| %%') 	do (echo.  %%~G)
		rem	                                   ALL:   # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! (  )  ^  "  &  <  >  |  %
		for /f "usebackq delims=" %%G in ('    ALL:   # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ( ^) ^^ ^" ^& ^< ^> ^| %%') 	do (echo.     %%~G)
		rem	                                 TWICE:   # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! (  )  ^  "  &  <  >  |  %
		for /f "usebackq delims=" %%G in ('  TWICE:   # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ( ^) ^^ ^" ^& ^< ^> ^| %%  # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ( ^) ^^ ^" ^& ^< ^> ^| %%') do (echo.   %%~G)
	endlocal
		
	echo.
	echo ###### echo %%Variable%% (DisableDelayedExpansion, in for loop, noquotes) ######
	setlocal disableDelayedExpansion	
		rem ### NOTE: The " character changes the mode,  when in " mode, most characters are printable as is.  But when not in " mode,  special characters need to be escaped with ^
		set "var= # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! %% (    ) & < > ^ | "    # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! %% (    ^) ^& ^< ^> ^^ ^| ^" "
		for /f "tokens=1* delims==" %%G in ('set var') do echo.%%~H
	endlocal

	echo.
	echo ###### dk_call dk_echo (EnableDelayedExpansion, quotes) ######
	setlocal EnableDelayedExpansion
		rem	              "CHARACTERS:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~   ^  "  &  <  >  |  %  "
		rem               "     VALID:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~                        "                                       
		%dk_call% dk_echo "     VALID:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~                        "
		rem	              "   INVALID:                                                    ! ^  "  &  <  >  |  % "
		%dk_call% dk_echo "   INVALID:                                                      ^     &  <  >  | %% "
	endlocal
	
	echo.
	echo ###### dk_call dk_echo (EnableDelayedExpansion, quotes) ######
	setlocal EnableDelayedExpansion
		%dk_call% dk_echo "     #$ &'()*+,-./:;<=>?@[\]^_`{|}~"
	endlocal

	echo.
	echo ###### dk_call dk_echo (EnableDelayedExpansion, quotes) ######
	setlocal EnableDelayedExpansion
		%dk_call% dk_echo "   ""#$ &'()*+,-./:;<=>?@[\]^_`{|}~"
	endlocal

	echo.
	echo ###### dk_call dk_echo (EnableDelayedExpansion, quotes) ######
	setlocal EnableDelayedExpansion
		%dk_call% dk_echo "     #$%%%%%%%%&'()*+,-./:;<=>?@[\]^_`{|}~"
	endlocal
			
%endfunction%
