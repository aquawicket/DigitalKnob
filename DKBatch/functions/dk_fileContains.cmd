@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::##################################################################################
::# dk_fileContains(file, string)
::#
::#
:dk_fileContains
	call dk_debugFunc 2
		
	>nul findstr /c:"%~2" "%~1" &&  (
		if defined "%~3" (endlocal & set "%3=true")
		(call )
		goto:eof
	)
	
	if defined "%~3" (endlocal & set "%3=false")
    (call)
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0

	call dk_fileAppend fileContains_TEST.txt "find the needle in the haystack"
	
	call dk_echo
	call dk_set substring needle
	call dk_fileContains fileContains_TEST.txt "%substring%" && (echo file contains substring) || (echo file does NOT contain substring)
	
	call dk_echo
	call dk_set substring "not_in_file"
	call dk_fileContains fileContains_TEST.txt "%substring%" && (echo file contains substring) || (echo file does NOT contain substring)
goto:eof
