@echo off
call DK

::################################################################################
::# dk_end()
::#
::#
:dk_end () {
	call dk_debugFunc
	
    call dk_error "reached the end of the script"
    call dk_pause
    call dk_exit
goto:eof