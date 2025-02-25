@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%F IN ('where /r %USERPROFILE% DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpF")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::############################################################################
::# dk_registrySearch(haystack, needle)
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
	%dk_call% dk_debugFunc 2

	set "_haystack_=%~1"
    set "_needle_=%~2"
	if not defined _needle_ (%dk_call% dk_warning "search is empty" & %return%)
	
	%dk_call% dk_validate REG_EXE "%dk_call% dk_REG_EXE"
	set /a i=0
	for /f "tokens=1,2,3" %%a in ('!REG_EXE! query !_haystack_! /s /f "!_needle_!" /k /v /d') do (
		set "LINE=%%a"
		set "LINE=!LINE:~,4!"
		rem echo LINE = !LINE!
		if "!LINE!"=="HKEY" (
			set "regpath=%%a"
			set "value_name="
			set "value_type="
			set "value_data="
		) else (
			set "value_name=%%a"
			set "value_type=%%b"
			set "value_data=%%c"
		)
		
		set "dk_registrySearch[!i!]=!regpath!;!value_name!;!value_type!;!value_data!"
		set /a i+=1
	)
	(call )
	
	:: Return the array to the calling scope
    set "currentScope=1"
    for /F "delims=" %%a in ('set dk_registrySearch[') do (
       if defined currentScope endlocal
       set "%%a"
    )
%endfunction%

::EXAMPLE:  HKEY_CURRENT_USER\Control Panel\Desktop\Colors   ButtonFace  REG_SZ   "212 208 200"
:: 	HIVE				HKEY_CURRENT_USER
:: 		Key					Control Pane
:: 			SubKey			    Desktop
:: 				SubKey				Colors
:: 					VALUE				ButtonFace  REG_SZ   "212 208 200"
::					VALUE_NAME			ButtonFace
::					VALUE_TYPE			REG_SZ
::					VALUE_DATA			"212 208 200"
::
::	Path =  HKEY_CURRENT_USER\Control Panel\Desktop\Colors
::  Value = ButtonFace  REG_SZ   "212 208 200"


::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 0

	%dk_call% dk_inputBox
    %dk_call% dk_registrySearch "HKCR" %dk_inputBox%
	%dk_call% dk_printVar dk_registrySearch
	%dk_call% dk_registrySearch "HKCU" %dk_inputBox%
	%dk_call% dk_printVar dk_registrySearch
	%dk_call% dk_registrySearch "HKLM" %dk_inputBox%
	%dk_call% dk_printVar dk_registrySearch
	%dk_call% dk_registrySearch "HKU"  %dk_inputBox%
	%dk_call% dk_printVar dk_registrySearch
	%dk_call% dk_registrySearch "HKCC" %dk_inputBox%
	%dk_call% dk_printVar dk_registrySearch
%endfunction%
