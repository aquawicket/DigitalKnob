@echo off
call DK

::################################################################################
::# dk_killProcess(<name>)
::#
::#
:dk_killProcess () {
	call dk_debugFunc
	
    taskkill /IM "%1" /F > nul
goto:eof