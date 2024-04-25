::dk_includeGuard()

::################################################################################
::# dk_getFilename(<path> <output_variable>)
::#
::#
:dk_getFilename () {
	call dk_debugFunc
	
	set _input=%1
	set _input=%_input:"=%
	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "OUT=%%~nxZ"
	endlocal & set %2=%OUT%
	::pause
	
    ::if [%1] == [] (
    ::    echo "ERROR: dk_getFilename() parameter 1 is invalid"
    ::    goto:eof
    ::)
    ::if [%2] == [] (
    ::    echo "ERROR: dk_getFilename() parameter 2 is invalid"
    ::    goto:eof
    ::)
    
    ::for %%F in ("%1") do (
    ::    set %2=%%~nxF
    ::    set val=%%~nxF
    ::)
    
    ::echo dk_getFilename(%*) -^> %2 = %val%
    ::call dk_checkError
goto:eof