call dk_includeGuard

::################################################################################
::# dk_getDirectory(<path>)
::#
::#
:dk_getDirectory () {
	call dk_debugFunc
	
	set _input=%1
	set _input=%_input:"=%
	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "OUT=%%~dpZ"
	endlocal & set %2=%OUT:~0,-1%
goto:eof