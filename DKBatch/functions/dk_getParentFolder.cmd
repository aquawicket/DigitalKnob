@echo off
call DK

::####################################################################
::# dk_getParentFolder(<input> <output>)
::#
::#
:dk_getParentFolder () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
    for %%a in ("%1") do for %%b in ("%%~dpa\.") do set "parent=%%~nxb"
    set "%2=%parent%"
goto:eof




:DKTEST ########################################################################
