@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_decimalToHex(<decimal> hex)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_decimalToHex
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal
		set "_LOOKUP_=0123456789abcdef"
		set "_hex_="
		set "_prefix_="
		if "%~1"=="" set "_hex_=00" & goto :endlookup
		set /a A=%~1
		if %A% lss 0 set /a A=0xfffffff + %A% + 1 & set "_prefix_=f"
		:loop
			set /a B=%A% %% 16 & set /a A=%A% / 16
			
			%if_NDE% call set "_hex_=%%_LOOKUP_:~%B%,1%%%_hex_%"
			%if_DE%       set "_hex_=!_LOOKUP_:~%B%,1!%_hex_%"
			
			if %A% gtr 0 goto :loop
		:endlookup
	endlocal & set "%2=0x%_prefix_%%_hex_%"
goto:eof






::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_set myDecimal 45
	call dk_decimalToHex "%myDecimal%" myHex
	call dk_printVar myHex
goto:eof
