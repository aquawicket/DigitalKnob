::dk_includeGuard()

::####################################################################
::# dk_call()
::#
::#
:dk_call () {
	call dk_debugFunc
	
    ::TODO
    :: Here we try to use DK_call to pass on a call while echoing the call passed
    :: This works in bash script, yet we have issues with this in cmd
    echo %*
    %*
goto:eof