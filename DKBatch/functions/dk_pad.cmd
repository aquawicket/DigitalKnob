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


rem ###############################################################################
rem # dk_pad(str padchar left right align rtn_var)
rem #
rem #	  Pad the end of a string to length with a given character
rem #
rem #   @str		- The string to pad
rem #   @padchar	- The fill character to use
rem #	  @left		- The number of left spaces to pad
rem #	  @right	- The number of right spaces to pad
rem #	  @align	- Align text to either side  (L) or (R)
rem #	  @rtn_var	- The returned string w/padding
rem #
:dk_pad
%setlocal%

	set "str=%~1"
	set "padchar=%~2"
	set "left=%~3"
	set "right=%~4"
	set "align=%~5"
	set "rtn_var=%~6"
	
	%dk_call% dk_strlen str strlen
	set /a right_len=right-strlen
	set /a left_len=left
	
	set "padL="
	for /L %%G IN (1,1,!left_len!) do (
		set "padL=!padL!!padchar!"
	)
	
    set "padR="
	for /L %%G IN (1,1,!right_len!) do (
		set "padR=!padR!!padchar!"
	)
	
	if /i "%align%" equ "L" (
		set "rtn_var=!padL!!str!!padR!"
	)
	if /i "%align%" equ "R" (
		set "rtn_var=!padR!!str!!padL!"
	)
	
    endlocal & set "%6=%rtn_var%"
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%


	%dk_call% dk_pad "padded string A" " " 3 18 L strA
	%dk_call% dk_echo "%strA%"

	%dk_call% dk_pad "string B" " " 3 18 L strB
	%dk_call% dk_echo "%strB%"
	
	%dk_call% dk_pad "str C" " " 3 18 L strC
	%dk_call% dk_echo "%strC%"
	
	%dk_call% dk_pad "padded string D" " " 3 18 R strD
	%dk_call% dk_echo "%strD%"

	%dk_call% dk_pad "string E" " " 3 18 R strE
	%dk_call% dk_echo "%strE%"
	
	%dk_call% dk_pad "str F" " " 3 18 R strF
	%dk_call% dk_echo "%strF%"
	
	
	%dk_call% dk_echo "%strA% %strD%"
	%dk_call% dk_echo "%strB% %strE%"
	%dk_call% dk_echo "%strC% %strF%"
%endfunction%
