@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_decimalToHex(decimal)
::#
::#	reference: https://www.ascii-code.com
::#
:dk_decimalToHex
%setlocal%
	%dk_call% dk_debugFunc 1

	set "_LOOKUP_=0123456789abcdef"
	set "_hex_="
	set "_prefix_="
	if "%~1" equ "" set "_hex_=00" & goto endlookup
	set /a A=%~1
	if %A% lss 0 set /a A=0xfffffff + %A% + 1 & set "_prefix_=f"
	:loop
		set /a B=%A% %% 16 & set /a A=%A% / 16
		set "_hex_=!_LOOKUP_:~%B%,1!%_hex_%"
		if %A% gtr 0 goto loop
	:endlookup
	endlocal & set "dk_decimalToHex=0x%_prefix_%%_hex_%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_set myDecimal 45
	%dk_call% dk_decimalToHex "%myDecimal%"
	%dk_call% dk_printVar dk_decimalToHex
%endfunction%
