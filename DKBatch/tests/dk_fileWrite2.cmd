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


rem ##################################################################################
::# dk_fileWrite2(file, id, "string")
::#
::#		Write string to file.
::#  
::#	CHARACTERS: ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~    ^  "  &  <  >  |   !  %
::#
:dk_fileWrite2
::%setlocal%
::	
::	echo random = %random%
::	echo 1 = %1
::	echo 2 = %2
::	echo 3 = %3
::	echo.
	
::	set "_file_=%1"
::	set "_id_=%2"
::	set _args_=%3
::	echo _file_ = %_file_%
::	echo _id_ = %_id_%
::	echo _args_ = %_args_%
::	echo.
	
::	set allargs=%*
	
::	for /f "tokens=1*" %%a in ("!allargs!") do (
::		echo.a = %%a
::		echo.b = %%b
::		echo.c = %%c
::		echo.~a = %%~a
::		echo.~b = %%~b
::		echo.~c = %%~c	
::	)
::	echo.
	
	setlocal disableDelayedExpansion	
::	for /f "usebackq tokens=1* delims=" %%a in (`call echo %allargs%`) do (
::		echo a = %%a
::		echo b = %%b
::		echo c = %%c
::		echo ~a = "%%~a"
::		echo ~b = "%%~b"
::		echo ~c = "%%~c"
::	)
::	echo. 

	for /f "usebackq tokens=1* delims=" %%a in (`findstr /C:"dk_call%% dk_fileWrite2 " %0`) do (
		rem call :getArgsA %%~a
		set string=%%a
		call :getArgsA %%string%%
		rem call :getArgsB %%string%%
	)
	
	pause
	
%endfunction%


:getArgsA
	echo       * = %*
	echo       0 = %0
	echo      ~0 =%invisible%"%clr%%~0%invisible%"%clr%
	echo       1 = %1
	echo      ~1 =%invisible%"%clr%%~1%invisible%"%clr%
	echo       2 = %2
	echo      ~2 =%invisible%"%clr%%~2%invisible%"%clr%
	echo       3 = %3
	echo      ~3 =%invisible%"%clr%%~3%invisible%"%clr%
	echo       4 = %4
	echo      ~4 =%invisible%"%clr%%~4%invisible%"%clr%
	echo       5 = %5
	echo      ~5 =%invisible%"%clr%%~5%invisible%"%clr%
	echo       6 = %6
	echo      ~6 =%invisible%"%clr%%~6%invisible%"%clr%
	
::	set  argv5=%5
::	set "argv5=%argv5:""="%"
::	echo   argv5 = %argv5%
	
::	set "argv~5=%~5"
::	set argv~5=%argv~5:""="%
::	echo argv~5 = %argv~5%
::	echo argv~5 =%lblack%"%clr%%argv~5%%lblack%"%clr%
	
::	set  argv6=%6
::	set "argv6=%argv6:""="%"
::	echo argv6 =%invisible%"%clr%%argv6%%invisible%"%clr%
	
::	set "argv~6=%~6"
::	set  argv~6=%argv~6:""="%
::	echo argv~6 =%invisible%"%clr%%argv~6%%invisible%"%clr%
	echo.
%endfunction%

:getArgsB
%setlocal%
	echo      * = %*
	echo      0 = %0
	echo     ~0 =%invisible%"%clr%%~0%invisible%"%clr%
	echo      1 = %1
	echo     ~1 =%invisible%"%clr%%~1%invisible%"%clr%
	echo      2 = %2
	echo     ~2 =%invisible%"%clr%%~2%invisible%"%clr%
	echo      3 = %3
	echo     ~3 =%invisible%"%clr%%~3%invisible%"%clr%
	echo      4 = %4
	echo     ~4 =%invisible%"%clr%%~4%invisible%"%clr%
	echo      5 = %5
	echo     ~5 =%invisible%"%clr%%~5%invisible%"%clr%
	echo      6 = %6
	echo     ~6 =%invisible%"%clr%%~6%invisible%"%clr%
	
	echo.
%endfunction%


rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	
	echo.
	echo ###### echo (EnableDelayedExpansion, no quotes) ######
	setlocal EnableDelayedExpansion
rem	  CHARACTERS:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~    ^  "  &  <  >  |   !  %
rem	       VALID:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~
	echo   VALID:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~
rem	     INVALID:                                                      ^  "  &  <  >  |   !  %
	echo INVALID:                                                   ^^^^ ^" ^& ^< ^> ^| ^^! %%
rem	         ALL:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~    ^  "  &  <  >  |   !  %
	echo     ALL:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^^^^ ^" ^& ^< ^> ^| ^^! %%
	echo   TWICE:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^^^^ ^" ^& ^< ^> ^| ^^! %% ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^^^^ ^" ^& ^< ^> ^| ^^! %%
	endlocal
pause


	echo.
	echo ###### echo (EnableDelayedExpansion, WITH QUOTES) ######
	setlocal EnableDelayedExpansion
rem	  CHARACTERS"   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~  ^  "  &  <  >  |   !  %
rem	       VALID"   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~
	echo   VALID"   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~
rem	     INVALID"                                                    ^  "  &  <  >  |   !  %
	echo INVALID"                                                   ^^ ^" ^& ^< ^> ^| ^^! %%
rem	         ALL"   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~  ^  "  &  <  >  |   !  %
	echo     ALL"   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^^ ^" ^& ^< ^> ^| ^^! %%
	echo   TWICE"   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^^ ^" ^& ^< ^> ^| ^^! %% ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^^ ^" ^& ^< ^> ^| ^^! %%
	endlocal
pause


	echo.
	echo ###### echo (DisableDelayedExpansion, no quotes) ######
	setlocal DisableDelayedExpansion
rem	  CHARACTERS:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~  ^  "  &  <  >  | !  %
rem	       VALID:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~
	echo   VALID:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~
rem	     INVALID:                                                    ^  "  &  <  >  | !  %
	echo INVALID:                                                   ^^ ^" ^& ^< ^> ^| ! %%
rem	         ALL:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~  ^  "  &  <  >  | !  %
	echo     ALL:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^^ ^" ^& ^< ^> ^| ! %%
	echo   TWICE:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^^ ^" ^& ^< ^> ^| ! %% ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^^ ^" ^& ^< ^> ^| ! %%
	endlocal
pause		
	
	
	echo.
	echo ###### echo (DisableDelayedExpansion, WITH QUOTES) ######
	setlocal DisableDelayedExpansion
rem	  CHARACTERS"   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^ "  &  <  >  | !  %
rem	       VALID"   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~
	echo   VALID"   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~
rem	     INVALID"                                                   ^ "  &  <  >  | !  %
	echo INVALID"                                                   ^ " ^& ^< ^> ^| ! %%
rem	         ALL"   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^ "  &  <  >  | !  %
	echo     ALL"   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^ " ^& ^< ^> ^| ! %%
	echo   TWICE"   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^ " ^& ^< ^> ^| ! %% ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ^^ ^" ^& ^< ^> ^| ! %%
	endlocal
pause
%endfunction%
