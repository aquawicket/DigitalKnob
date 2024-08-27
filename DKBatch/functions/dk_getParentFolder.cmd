@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_getParentFolder(<input> rtn_var)
::#
::#
:dk_getParentFolder
 setlocal
	call dk_debugFunc 2
	
    for %%a in ("%1") do for %%b in ("%%~dpa\.") do set "parent=%%~nxb"
    set "%2=%parent%"
	%dk_call% dk_printVar "%2"
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_getParentFolder
goto:eof
