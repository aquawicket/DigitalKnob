::call dk_includeGuard


::################################################################################
::# dk_convertToLowercase(<in> <out>)
::#
::#
:dk_convertToLowercase () {
	call dk_debugFunc
	
	setlocal EnableDelayedExpansion
    set "_input=%1"
	::call dk_debug _input
	
    set "_UCASE=ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    set "_LCASE=abcdefghijklmnopqrstuvwxyz"
    
    for /l %%a in (0,1,25) do (
        call set "_FROM=%%_UCASE:~%%a,1%%
        call set "_TO=%%_LCASE:~%%a,1%%
        call set "_input=%%_input:!_FROM!=!_TO!%%
		call set "_output=!_input!"
    )
    ::call dk_debug _output
	
	endlocal & set "%2=%_output%"	
goto:eof