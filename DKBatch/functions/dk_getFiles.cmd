@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_getFiles(path rtn_var)
::#
::#   reference: https://stackoverflow.com/a/138581
::#
:dk_getFiles
	call dk_debugFunc 2
	
	set /a i=0
	setlocal
	for %%a in ("%~1\*") do (
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
	call dk_getFiles "%myPath%" files
	call dk_printVar files
goto:eof
