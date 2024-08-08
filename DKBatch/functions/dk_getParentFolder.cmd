@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_getParentFolder(<input> rtn_var)
::#
::#
:dk_getParentFolder
	call dk_debugFunc 2
	
    for %%a in ("%1") do for %%b in ("%%~dpa\.") do set "parent=%%~nxb"
    set "%2=%parent%"
	call dk_printVar "%2"
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_getParentFolder
goto:eof
