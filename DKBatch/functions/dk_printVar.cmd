::call dk_includeGuard

::################################################################################
::# dk_printVar(<variable>)
::#
::#
:dk_printVar () {
	call dk_debugFunc
	
    set "var=%1"
    call set "value=%%%var%%%"
	if "%value%" == "" echo %var%
    if "%value%" NEQ "" echo %var%: %value%
	
    ::echo %1 = !!!INVALID!!!
goto:eof