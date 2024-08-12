@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::#####################################################################
::# dk_getParentDir(<input> rtn_var)
::#
::#
:dk_getParentDir
	call dk_debugFunc 2
	
	setlocal
	for %%A in (%1.) do set "parent=%%~dpA"
    endlocal & set "%2=%parent:~0,-1%"
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0

	call dk_set myPath "C:\Windows\System32"
	call dk_getParentDir "%myPath%" parent
	call dk_printVar parent
goto:eof
