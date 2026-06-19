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
rem # dk_replace(input findCh replaceCh output)
rem #
rem # Replace = characters
rem # Advantage: No dependency on the :strlen routine
rem # Drawback: Max 256 = characters
rem # Drawback: Does NOT work on strings with LF or '!' characters
rem #
:dk_replace
%setlocal%

	if DEFINED %1 (set _input_=!%~1!) else (set _input_=%~1)
	if DEFINED %2 (set _find_=!%~2!) else (set _find_=%~2)
	set "_replace_=%~3"
	
	set "maxStrLen=1000"
	
	set $_=%_input_%.
	if /i "!$_:%$_%=%$_%!" neq "!$_!" (
		set "$f=1"
		set "$v="
		for /L %%i in (0,1,%maxStrLen%) do if defined $f (
			for /F "delims==" %%a in ('set $_') do (
				set "$a=%%a" & set "$b=!%%a!"
				set "%%a=" & set "$_!$b!" 2>NUL || set "$f="
				if %%i gtr 0 set "$v=!$v!!$a:~2!{EQUAL}"
			)
		)
		set "_input_=!$v!!$b:~0,-1!"
	)
	
	set $_=%_find_%.
	if /i "!$_:%$_%=%$_%!" neq "!$_!" (
		set "$f=1"
		set "$v="
		for /L %%i in (0,1,%maxStrLen%) do if defined $f (
			for /F "delims==" %%a in ('set $_') do (
				set "$a=%%a" & set "$b=!%%a!"
				set "%%a=" & set "$_!$b!" 2>NUL || set "$f="
				if %%i gtr 0 set "$v=!$v!!$a:~2!{EQUAL}"
			)
		)
		set "_find_=!$v!!$b:~0,-1!"
	)

	set "dk_replace=!_input_:%_find_%=%_replace_%!
	set "dk_replace=!dk_replace:{EQUAL}==!
	
	rem echo input:%_input_%
	rem echo find:%_find_%, replace:%_replace_%
	rem echo result:%dk_replace%
	
	endlocal & (
		set dk_replace=%dk_replace%
		if "%~4" neq "" (set "%~4=%dk_replace%")
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ########
:DKTEST
%setlocal%



	
	set input=#$'*+,-./0123456789:=?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]_`abcdefghiklmnopqrstuvwxyz{}~
	echo      input = %input%
	
	%dk_call% dk_replace "%input%" "#$'*+,-./0123456789:=?@" "%green%#$'*+,-./0123456789:=?@%clr%"
	echo dk_replace = %dk_replace%
	
	%dk_call% dk_replace input "ABCDEFGHIJKLMNOPQRSTUVWXYZ" "%green%ABCDEFGHIJKLMNOPQRSTUVWXYZ%clr%"
	echo dk_replace = %dk_replace%
	
	%dk_call% dk_replace input "[\]_`" "%green%[\]_`%clr%"
	echo dk_replace = %dk_replace%
	
	%dk_call% dk_replace input "abcdefghiklmnopqrstuvwxyz" "%green%abcdefghiklmnopqrstuvwxyz%clr%"
	echo dk_replace = %dk_replace%
	
	%dk_call% dk_replace input "{}~" "%green%{}~%clr%"
	echo dk_replace = %dk_replace%
%endfunction%

rem ########################## ASCII #########################################################
 	

 !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghiklmnopqrstuvwxyz{|}~
rem ##########################################################################################
