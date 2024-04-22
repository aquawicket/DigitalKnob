::dk_includeGuard()

::################################################################################
::# dk_end()
::#
::#
:dk_end () {
	call dk_verbose "dk_end(%*)"
	
    call dk_error "reached the end of the script"
    pause
    exit
goto:eof