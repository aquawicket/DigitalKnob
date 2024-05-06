@echo off
call DK

::####################################################################
::# dk_getParentFolder(<input> <output>)
::#
::#
:dk_getParentFolder () {
	call dk_debugFunc
	
    for %%a in ("%1") do for %%b in ("%%~dpa\.") do set "parent=%%~nxb"
    set "%2=%parent%"
goto:eof