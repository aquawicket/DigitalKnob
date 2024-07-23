@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_readlink(path "-f" rtn_var)
::#
::#    read the contents of a symbolic link
::#
::#    SHELL: https://man7.org/linux/man-pages/man1/realpath.1.html
::#    C:     https://pubs.opengroup.org/onlinepubs/9699919799/functions/readlink.html
::#
:dk_readlink
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal
	set _input=%1
	set _input=%_input:"=%
	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
	endlocal & for %%Z in ("%_input%") do set "%2=%%~fZ"
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_set myPath "DK.cmd"
	call dk_readlink "%myPath%" realpath
	call dk_printVar realpath
goto:eof