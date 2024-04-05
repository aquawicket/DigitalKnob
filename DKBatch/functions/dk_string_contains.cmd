:: dk_include_guard()

::#################################################################################
:: dk_string_contains() <haystack> <needle> <result>
::
::
:dk_string_contains () {
	call dk_verbose "%0(%*)"
	
    call set "haystack=%1"
    call set "needle=%2"
    if not "x!haystack:%needle%=!"=="x%haystack%" set "%3=1"
    ::set "%3=0"
goto:eof