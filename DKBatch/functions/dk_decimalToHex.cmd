call dk_includeGuard

::####################################################################
::# dk_decimalToHex(<decimal> hex)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_decimalToHex () {
	call dk_debugFunc
	
	::cmd /C exit %~1
	::set "hex="
	::set "hex=%=ExitCode%"
	::set "hex=0x%hex:~-2%"

	setlocal EnableExtensions EnableDelayedExpansion
	set LOOKUP=0123456789abcdef & set HEXSTR= & set PREFIX=
	if "%~1"=="" set HEXSTR=00 & goto :endlookup
	set /a A=%~1
	if !A! LSS 0 set /a A=0xfffffff + !A! + 1 & set PREFIX=f
	:loop
	    set /a B=!A! %% 16 & set /a A=!A! / 16
	    set HEXSTR=!LOOKUP:~%B%,1!%HEXSTR%
	    if %A% GTR 0 goto :loop
	:endlookup
	endlocal & set hex=0x%PREFIX%%HEXSTR%

	::echo     dk_decimalToHex %~1 = %hex%
	endlocal & set %2=%hex%

goto:eof


