@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_basename(<pathname>, <rtn_var>:optional)
::#
::#    Strip directory and suffix from filenames
::#
::#    Reference: https://en.wikipedia.org/wiki/Basename
::#
:dk_basename
setlocal
	%dk_call% dk_debugFunc 1 2

    set "pathname=%1"
    set "pathname=%pathname:"=%"
	
	for %%Z in ("%pathname%") do set "dk_basename=%%~nxZ"
	
    endlocal & (
		set "dk_basename=%dk_basename%"
		if "%2" neq "" set "%2=%dk_basename%"
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_echo
	%dk_call% dk_set myPath "C:/Windows/System32/test.v123.zip" 
    %dk_call% dk_basename "%myPath%"
    %dk_call% dk_echo "%myPath%: basename = %dk_basename%"
    
	%dk_call% dk_echo
    %dk_call% dk_set myPath "TEST" 
    %dk_call% dk_basename "%myPath%"
    %dk_call% dk_echo "%myPath%: basename = %dk_basename%"
    
	%dk_call% dk_echo
    %dk_call% dk_set myPath "https://ia802200.us.archive.org/22/items/windows-7-pesuper-lite-50-mb/Windows7PESuper%20Lite50MB.iso"
    %dk_call% dk_basename "%myPath%"
    %dk_call% dk_echo "%myPath%: basename = %dk_basename%"
	
	%dk_call% dk_echo
    %dk_call% dk_set myPath "C:/Windows/System32/test.v123.zip" 
    %dk_call% dk_basename "%myPath%"
    %dk_call% dk_echo "%myPath%: basename = %dk_basename%"
    
	%dk_call% dk_echo
    %dk_call% dk_set myPath "TEST" 
    %dk_call% dk_basename "%myPath%"
    %dk_call% dk_echo "%myPath%: basename = %dk_basename%"
    
	%dk_call% dk_echo
    %dk_call% dk_set myPath "https://ia802200.us.archive.org/22/items/windows-7-pesuper-lite-50-mb/Windows7PESuper%20Lite50MB.iso"
    %dk_call% dk_basename "%myPath%"
    %dk_call% dk_echo "%myPath%: basename = %dk_basename%"
%endfunction%
