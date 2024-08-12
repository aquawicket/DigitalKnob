@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_isDirectory(path rtn_var)
::#
::#
:dk_isDirectory
	call dk_debugFunc 1
	
	if exist %~1\* (
		if defined "%~2" (endlocal & set "%2=true")
        (call )
		goto:eof
	)
	
    if defined "%~2" (endlocal & set "%2=false")
	(call)
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_isDirectory "C:\Windows" && call dk_info "'C:\Windows' is a directory" || call dk_info "'C:\Windows' is NOT a directory"
	call dk_isDirectory "C:\NotADir" && call dk_info "'C:\NotADir' is a directory" || call dk_info "'C:\NotADir' is NOT a directory"
goto:eof
