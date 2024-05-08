@echo off
call DK

::####################################################################
::# dk_fileExists()
::#
:dk_fileExists () {
	call dk_debugFunc
    ::call dk_todo
	if "%~1" equ "" call dk_error "dk_fileExists() argument 1 is invalid"
	
	if exist "%~1" (call ) else (call)
::	#if [ -e "$1" ]; then
::	#	dk_debug "dk_fileExists($*): FOUND"
::	#else
::	#	dk_warning "dk_fileExists($*): NOT FOUND!" 
::	#fi
::	[ -e "$1" ]
goto:eof


:DKTEST

::	set "file=C:\Windows"	
::	call dk_fileExists "%file%" && (echo Success) || (echo Failed)

