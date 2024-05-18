@echo off
call DK


::##################################################################################
::# dk_replaceAll("input" "searchValue" "newValue" <output_variable>)
::#
::#
:dk_replaceAll () {
	call dk_debugFunc
	if %__ARGC__% NEQ 4 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	::setlocal
	set "_input_=%~1"
	call set "_output_=%%_input_:%~2=%~3%%"
	
	endlocal & set "%4=%_output_%"
	dk_printVar %4
goto:eof



:DKTEST ###############################################################################

set "string_var=AZC AZC Zannana Zread"
call dk_printVar string_var
call dk_replaceAll "%string_var%" "Z" "B" string_var
call dk_printVar string_var

set "varB=C:\path\with\backslashes"
call dk_printVar varB
call dk_replaceAll "%varB%" "\" "/" varB
call dk_printVar varB