::dk_include_guard()

::################################################################################
::# dk_command_exists(<command> <result>)
::#
::#
:dk_command_exists () {
	call dk_verbose "dk_command_exists(%*)"
	
    set "command=%1"
    cmd /c "(help %command% > nul || exit 0) && where %command% > nul 2> nul"
    if %ERRORLEVEL% EQU 0 echo "%command% found" & goto:eof
    echo "%command% NOT found"
goto:eof