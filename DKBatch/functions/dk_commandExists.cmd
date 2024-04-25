::dk_includeGuard()

::################################################################################
::# dk_commandExists(<command> <result>)
::#
::#
:dk_commandExists () {
	call dk_debugFunc
	
    set "command=%1"
    cmd /c "(help %command% > nul || exit 0) && where %command% > nul 2> nul"
    if %ERRORLEVEL% EQU 0 echo "%command% found" & goto:eof
    echo "%command% NOT found"
goto:eof