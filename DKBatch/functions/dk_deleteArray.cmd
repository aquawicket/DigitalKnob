@echo off
call DK

::################################################################################
::# dk_deleteArray(<array>)
::#
::#
:dk_deleteArray () {
	call dk_debugFunc
	if %__ARGC__% NEQ 1 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	set /A "n=0"
	:loop1 
	if defined %~1[%n%] (
		set "%~1[%n%]="
	    set /A n+=1
	    goto :loop1 
	)

	if defined %~1[0] call dk_error "%__FUNCTION__%(%*): failed to delete array"
	:: DOSTIPS version
	:: :remove_array
	:: for /f "delims==" %%a in ('"set %~1[ 2>NUL"') do set "%%a="
	:: EXIT /b
goto:eof




:DKTEST ########################################################################