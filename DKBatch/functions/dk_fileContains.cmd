@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::##################################################################################
::# dk_fileContains(file, string)
::#
::#
:dk_fileContains
 setlocal
	call dk_debugFunc 2
		
	>nul findstr /c:"%~2" "%~1" &&  (
		if defined "%~3" (endlocal & set "%3=true")
		(call ) %NO_STD%
		goto:eof
	)
	
	if defined "%~3" (endlocal & set "%3=false")
    (call) %NO_STD%
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0

	%dk_call% dk_fileAppend fileContains_TEST.txt "find the needle in the haystack"
	
	%dk_call% dk_echo
	%dk_call% dk_set substring needle
	%dk_call% dk_fileContains fileContains_TEST.txt "%substring%" && (echo file contains substring) || (echo file does NOT contain substring)
	
	%dk_call% dk_echo
	%dk_call% dk_set substring "not_in_file"
	%dk_call% dk_fileContains fileContains_TEST.txt "%substring%" && (echo file contains substring) || (echo file does NOT contain substring)
%endfunction%
