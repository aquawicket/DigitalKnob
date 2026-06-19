@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ############################################################################
rem # dk_registrySearch(haystack, needle)
rem #
rem #   haystack - the registry path to search
rem #		i.e.  HKLM/Software
rem #
rem #   needle - the string to look for
rem #
rem #		rem find all registry KEYS containing "DKCMake" in HKCU
rem #		REG QUERY HKCU /s /f "DKCMake" /k
rem #
rem #		rem find all registry VALUES containing "DKCMake" in HKCU
rem #		REG QUERY HKCU /s /f "DKCMake" /v
rem #
rem #		rem find all registry DATAs containing "DKCMake" in HKCU
rem #		REG QUERY HKCU /s /f "DKCMake" /d
rem #
:dk_registrySearch
%setlocal%

	set "_haystack_=%~1"
    set "_needle_=%~2"
	if NOT defined _needle_ (%dk_call% dk_warning "search is empty" & %return%)
	
	%dk_call% dk_validate reg.exe %dk_call% dk_depend reg.exe
	set /a i=0
	for /f "usebackq tokens=1,2,3" %%a in (`""%reg.exe:/=\%" query !_haystack_! /s /f "!_needle_!" /k /v /d"`) do (
		echo %%a %%b %%c
		set "LINE=%%a"
		set "LINE=!LINE:~,4!"
		rem echo LINE = !LINE!
		if /i "!LINE!" equ "HKEY" (
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
	%clearerror%
	
	rem Return the array to the calling scope
    set "_SCOPE_=%~n0"
    for /F "delims=" %%a in ('set dk_registrySearch[') do (
       if "%_SCOPE_%" equ "%~n0" endlocal
       set "%%a"
    )
%endfunction%

rem EXAMPLE:  HKEY_CURRENT_USER/Control Panel/Desktop/Colors   ButtonFace  REG_SZ   "212 208 200"
rem 	HIVE				HKEY_CURRENT_USER
rem 		Key					Control Pane
rem 			SubKey			    Desktop
rem 				SubKey				Colors
rem 					VALUE				ButtonFace  REG_SZ   "212 208 200"
rem					VALUE_NAME			ButtonFace
rem					VALUE_TYPE			REG_SZ
rem					VALUE_DATA			"212 208 200"
rem 
rem	Path =  HKEY_CURRENT_USER/Control Panel/Desktop/Colors
rem  Value = ButtonFace  REG_SZ   "212 208 200"


rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_inputBox
    %dk_call% dk_registrySearch "HKCR" "%dk_inputBox%"
	%dk_call% dk_printVar dk_registrySearch
	%dk_call% dk_registrySearch "HKCU" "%dk_inputBox%"
	%dk_call% dk_printVar dk_registrySearch
	%dk_call% dk_registrySearch "HKLM" "%dk_inputBox%"
	%dk_call% dk_printVar dk_registrySearch
	%dk_call% dk_registrySearch "HKU"  "%dk_inputBox%"
	%dk_call% dk_printVar dk_registrySearch
	%dk_call% dk_registrySearch "HKCC" "%dk_inputBox%"
	%dk_call% dk_printVar dk_registrySearch
%endfunction%
