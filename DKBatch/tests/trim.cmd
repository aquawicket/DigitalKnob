@echo off
rem  https://stackoverflow.com/a/26079981/688352

call :Test1
call :Test2
call :Test3
call :Test4
pause
exit /b

:dk_trim
	SetLocal EnableDelayedExpansion

	set args=%*
	set "args=!args:^^=^!"
	set args=!args:[caret][caret]=^^!
	set args=!args:[percent]=%%!
	set args=!args:[exclamation]=^^!!
	
	for /f "tokens=1*" %%a in ("!args!") do (
		echo       dk_trim: [%%~b]
		endlocal & (set "%~1=%%~b")
	)
exit /b

:Test1
	echo.
	set Value=   a b c   
	set Expected=a b c
	echo   Before: [%Value%]
	call :dk_trim Output %Value%
	echo    After: [%Output%]
	echo Expected: [%Expected%]
	if "%Output%" equ "%Expected%" (echo Test1 passed) else (echo Test1 failed)
exit /b

:Test2
	echo.
	SetLocal EnableDelayedExpansion
rem             ALL:     a ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
rem         INVALID:       !       %
rem           VALID:     a     # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
        set Value=     a   " # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~      
	      set Expected=a   " # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~

	echo   Before: [!Value!]
	call :dk_trim Output !Value!
	echo         After: [!Output!]
	echo      Expected: [!Expected!]
	if !Output! equ !Expected! (echo Test2 passed) else (echo Test2 failed)
exit /b

:Test3
	echo.
	SetLocal EnableDelayedExpansion
rem             ALL:     a ! " # $ %  & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
rem         INVALID:       !       %                           
rem           VALID:     a     # $    & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
		set Value=     a   " # $ %%%% & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~      
	      set Expected=a   " # $ %% & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~

	echo   Before: [!Value!]
	call :dk_trim Output !Value!
	echo         After: [!Output!]
	echo      Expected: [!Expected!]
	if !Output! equ !Expected! (echo Test3 passed) else (echo Test3 failed)
exit /b

:Test4
	echo.
	SetLocal EnableDelayedExpansion
rem             ALL:     a   ! " # $ %    & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
rem         INVALID:         !       %                           
rem           VALID:     a       # $      & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
		set Value=     a ^^! " # $ %%%% & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~      
	      set Expected=a ^^! " # $ %% & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~

	echo   Before: [!Value!]
	call :dk_trim Output !Value!
	echo         After: [!Output!]
	echo      Expected: [!Expected!]
	if !Output! equ !Expected! (echo Test4 passed) else (echo Test4 failed)
exit /b

:Test5
	echo.
	set /p Value="Enter string to trim: " %=%
	echo Before: [%Value%]
	call :dk_trim Output %Value%
	echo  After: [%Output%]
exit /b