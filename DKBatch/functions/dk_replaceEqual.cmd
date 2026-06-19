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
rem # dk_replaceEqual(input replace rtn_var:OPTIONAL)
rem #
:dk_replaceEqual
%setlocal%

	if DEFINED %1 (set _input_=!%~1!) else (set _input_=%~1)
	set "_replace_=%~2"
	set "maxStrLen=1000"
	
	set "dk_replaceEqual=%_input_%"
	set $_=%_input_%.
	if /i "!$_:%$_%=%$_%!" neq "!$_!" (
		set "$f=1"
		set "$v="
		for /L %%i in (0,1,%maxStrLen%) do if defined $f (
			for /F "delims==" %%a in ('set $_') do (
				set "$a=%%a" & set "$b=!%%a!"
				set "%%a=" & set "$_!$b!" 2>NUL || set "$f="
				if %%i gtr 0 set "$v=!$v!!$a:~2!!_replace_!"
			)
		)
		set "dk_replaceEqual=!$v!!$b:~0,-1!"
	)
	
	endlocal & (
		set dk_replaceEqual=%dk_replaceEqual%
		if "%~3" neq "" (set "%~3=%dk_replaceEqual%")
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ########
:DKTEST
%setlocal%

	set input=#$'*+,-./0123456789:=?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]_`abcdefghiklmnopqrstuvwxyz{}~
	echo           input = %input%
	
	%dk_call% dk_replaceEqual "%input%" "%green%=%clr%" output
	echo dk_replaceEqual = %dk_replaceEqual%
	echo output = %output%
%endfunction%

rem ########################## ASCII #########################################################
 	

 !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghiklmnopqrstuvwxyz{|}~
rem ##########################################################################################
