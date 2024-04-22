:: dk_include_guard()

::################################################################################
::# dk_stringContains(<haystack> <needle> <result>)
::#
::#
:dk_stringContains () {
	call dk_verbose "dk_stringContains(%*)"
	
    call set "haystack=%1"
    call set "needle=%2"
    if not "x!haystack:%needle%=!"=="x%haystack%" set "%3=1"
    ::set "%3=0"
goto:eof