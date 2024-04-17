::dk_include_guard()

::################################################################################
::# dk_convert_to_lowercase(<in> <out>)
::#
::#
:dk_convert_to_lowercase () {
	call:dk_verbose "dk_convert_to_lowercase(%*)"
	
    set _string=%1
    set "_UCASE=ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    set "_LCASE=abcdefghijklmnopqrstuvwxyz"
    
    for /l %%a in (0,1,25) do (
        call set "_FROM=%%_UCASE:~%%a,1%%
        call set "_TO=%%_LCASE:~%%a,1%%
        call set "_string=%%_string:!_FROM!=!_TO!%%
    )
    ::call:dk_debug _string
    set %2=%_string%
goto:eof