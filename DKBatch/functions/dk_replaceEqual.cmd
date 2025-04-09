@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::##################################################################################
::# dk_replaceEqual(input newValue rtn_var)
::#
::# Replace = characters
::# Advantage: No dependency on the :strlen routine
::# Drawback: Max 256 = characters
::# Drawback: Does not work on strings with LF or '!' characters
::#
:dk_replaceEqual
setlocal enableDelayedExpansion

    %dk_call% dk_debugFunc 4

	%dk_call% dk_fixme "TODO"
	for /F "delims==" %%v in ('set $_ 2^>NUL') do set "%%v=" 						&::# Clear existing $_XXX variables
																					::# $_=input  $f=Termination flag  $v=output value  $r=replacement var
	set "$_=!%~1!." & set "$f=1" & set "$v=" & set "$r=%~2"
::	if /i "!$_:%$_%=%$_%!" equ "!$_!" exit /b 0										&::# No = sign in $_. Return now to save time
	if defined $r if not "!$r:~0,1!"=="=" (set "$r=!%~2!") else set "$r=!$r:~1!" 	&::# $r=replacement value
	set "$o=%~3" & if not defined $o set "$o=%~1"
	for /L %%i in (0,1,256) do if defined $f (
		for /F "delims==" %%a in ('set $_') do (
			set "$a=%%a" & set "$b=!%%a!" 											&::# $a=$_variable name  $b=its value=all that followed the first =
			set "%%a=" & set "$_!$b!" 2>NUL || set "$f="
			if %%i gtr 0 set "$v=!$v!!$a:~2!!$r!"
		)
	)
	set "!$o!=!$v!!$b:~0,-1!"
	echo 0 = !0!																	&::# The complete result, with the tail . removed in the end
	endlocal & set %~1=!$o!
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ########
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	set "input=A=String=With=Equal=Signs"
	echo input = %input%
	%dk_call% dk_replaceEqual "%input%" "Z" output
	echo input = %input%
%endfunction%


