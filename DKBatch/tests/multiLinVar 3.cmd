@echo off
:: https://stackoverflow.com/a/62008572

setlocal EnableDelayedExpansion

::######## Original variable content ########
set "MyVar="
::##### DO NOT ALTER #############
::(SET _NL=^
::%=this line is empty=%
::)
set NL=^



::##### DO NOT ALTER #############


::#### multiline var from file ###
::for /F "usebackq delims=" %%A in ("file.txt") do (
::  if defined MyVar set "MyVar=!MyVar!!NL!"
::    set "MyVar=!MyVar!%%A"
::)

::### multiline variable from single line
::set "MyVar=line1!NL!line2"

::FOR /F ["options"] %%parameter IN ("Text string to process") DO command
::for /F "delims=" %%i in (
::"line 1
::line 2
::line 3"
::) do (
::	if defined MyVar set "MyVar=!MyVar!!NL!"
::	set "MyVar=!MyVar!%%i"
::)

call :setMultiLine %0 MyVar
line 1
line 2
line 3
:endMultiLine


echo:
echo:
echo ###### Original variable content ######
set MyVar
::###########################################



::######## Modified variable content ########
set MyVar=!MyVar:^%NL%%NL%=^^^%NL%%NL%^%NL%%NL%!  &:: Replace every new-line by an escaped new-line
::echo:
::echo:
::echo ###### Modified variable content #####
::set MyVar
::###########################################


::######### Actual variable content #########
rem /* Use a `for` meta-variable rather than a normal environment variable to
rem    pass the variable value beyond the `endlocal` barrier;
rem    a standard `for` loop can be used here, because there are not going to be
rem    wildcards `?` and `*` in the variable value since they have already been
rem    resolved by `dir`; `for /F` cannot be used here due to the new-lines: */
for %%j in ("!MyVar!") do endlocal & set "data=%%~j"
::echo:
::echo:
::echo ###### Actual variable content ###### 
::set data    &:: Do not use `echo` to show true content of variable:
::###########################################


::######## Parsed variable content ##########
echo:
echo:
echo ###### Parsed variable content ######
echo %data%
::###########################################

pause
exit /b 0

goto:eof
:setMultiLine
	if not defined flag (set "flag=0")
	for /F "usebackq delims=" %%A in ("%~1") do (
		set "var=%%A"
		if !flag! equ 1 if "!var:endMultiLine=!" neq "!var!" (goto:endMultiLine)
		if !flag! equ 1 (
			rem echo %%A
			if defined MyVar set "MyVar=!MyVar!!NL!"
			set "MyVar=!MyVar!%%A"
		)
		if !flag! equ 0 if "!var:0 %~2=!" neq "!var!" (set "flag=1")
	)
exit /B 0
