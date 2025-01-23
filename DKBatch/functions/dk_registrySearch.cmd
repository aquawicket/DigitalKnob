@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%F IN ('where /r %USERPROFILE% DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpF")
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::############################################################################
::# dk_registrySearch(haystack, needle, rtn_var)
::#
::#   haystack - the registry path to search 
::#		i.e.  HKLM\Software
::#
::#   needle - the string to look for
::#
::#		:: find all registry KEYS containing "DKCMake" in HKCU
::#		REG QUERY HKCU /s /f "DKCMake" /k
::#
::#		:: find all registry VALUES containing "DKCMake" in HKCU
::#		REG QUERY HKCU /s /f "DKCMake" /v
::#
::#		:: find all registry DATAs containing "DKCMake" in HKCU
::#		REG QUERY HKCU /s /f "DKCMake" /d
::#
:dk_registrySearch
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2 3

	set "_haystack_=%~1"
    set "_needle_=%~2"
	
	reg query %_haystack_% /s /f "%_needle_%" /k /v /d 
    
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_registrySearch "HKCU" ".cmd"
%endfunction%
