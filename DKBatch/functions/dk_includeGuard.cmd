if [%include_guard_dk_includeGuard%] == [1] ( goto:eof ) else set include_guard_dk_includeGuard=1

::##################################################################################
::# dk_includeGuard()
::#
::#
:dk_includeGuard () {
	call dk_debugFunc
	
	::call dk_todo
	echo TODO: dk_includeGuard
goto:eof