@echo off
setlocal enableDelayedExpansion
::### https://stackoverflow.com/a/11685376/688352


::ALL:      ! " #  $  % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
::set str=  ! " #  $  % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
  set str=^^!                   *                 =

rem TODO: get strLen here
set /a "strLen=100"
for /l %%x in (0,1,%strLen%) do if not "!str:~%%x,1!"=="" (

	rem replace ! with [exclaimation]
	if "!str:~%%x,1!"=="^!" (
		set /a plusone=%%x+1
		for /l %%y in (!plusone!, 1, !plusone!) do (
			set str=!str:~0,%%x![exclaimation]!str:~%%y!
		)
	)
	rem replace " with [quote]
::	if "!str:~%%x,1!"==""" (
::		set /a plusone=%%x+1
::		for /l %%y in (!plusone!, 1, !plusone!) do (
::			set str=!str:~0,%%x![quote]!str:~%%y!
::		)
::	)
	rem replace * with [asterisk]
	if "!str:~%%x,1!"=="*" (
		set /a plusone=%%x+1
		for /l %%y in (!plusone!, 1, !plusone!) do (
			set str=!str:~0,%%x![asterisk]!str:~%%y!
		)
	)
	rem replace = with [equal]
	if "!str:~%%x,1!"=="=" (
		set /a plusone=%%x+1
		for /l %%y in (!plusone!, 1, !plusone!) do (
			set str=!str:~0,%%x![equal]!str:~%%y!
		)
	)
)


echo %str%

pause
exit /b 0