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


rem ################################################################################
rem # dk_getAttributes(<pathname>, <rtn_var>:optional)
rem #
rem #		Reference: https://ss64.com/nt/syntax-args.html#attributes
rem #
rem #		 Attribute                    Expansion
rem #		 FILE_ATTRIBUTE_DIRECTORY     d--------
rem #		 FILE_ATTRIBUTE_READONLY      -r-------
rem #		 FILE_ATTRIBUTE_ARCHIVE       --a------
rem #		 FILE_ATTRIBUTE_HIDDEN        ---h-----
rem #		 FILE_ATTRIBUTE_SYSTEM        ----s----
rem #		 FILE_ATTRIBUTE_COMPRESSED    -----c---
rem #		 FILE_ATTRIBUTE_OFFLINE       ------o--
rem #		 FILE_ATTRIBUTE_TEMPORARY     -------t-
rem #		 FILE_ATTRIBUTE_REPARSE_POINT --------l
rem #		 FILE_ATTRIBUTE_NORMAL        ---------
rem #
:dk_getAttributes
rem :dk_fileAttributes
%setlocal%

	set "pathname=%1"
	set "pathname=%pathname:"=%"
	set "pathname=%pathname:/=\%"
	if "%pathname:~-1%" equ "\"   set "pathname=%pathname:~0,-1%"

	for %%Z in ("%pathname%") do set "dk_getAttributes=%%~aZ"

	endlocal & (
		set "dk_getAttributes=%dk_getAttributes%"
		if "%~2" neq "" (set "%~2=%dk_getAttributes%")
	)	
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	set "myPath=%USERPROFILE:\=/%/Desktop/DigitalKnob"
	%dk_call% dk_getAttributes "%myPath%" attributes
	%dk_call% dk_echo "dk_getAttributes = %dk_getAttributes%"
	%dk_call% dk_echo "attributes = %attributes%"
%endfunction%
