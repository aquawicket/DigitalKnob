@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_getDirectories(path rtn_var)
::#
::#   reference: https://stackoverflow.com/a/138581
::#
:dk_getDirectories
	call dk_debugFunc 2
	
	call dk_replaceAll "%~1" "/" "\" _path_
	::set "folders="
	set /A i=0
	setlocal
	for /d %%a in ("%_path_%\*") do (
		if "!!" equ "" set "%~2[!i!]=%%a"
		if "!!" neq "" call set "%~2[%%i%%]=%%a"
		set /A i+=1
	) 

	:: Return the array to the calling scope
	set "currentScope=1"
	for /F "delims=" %%a in ('set %~2[') do (
	   if defined currentScope endlocal
	   set "%%a"
	)
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_set myPath "C:\Windows"
	call dk_getDirectories "%myPath%" directories
	call dk_printVar directories
goto:eof
	